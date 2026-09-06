---
name: shopify-page-dev
description: 'Use when: building Shopify theme pages from Figma designs, creating template JSON files, writing page CSS/SCSS, matching design sections to existing theme sections, creating new section liquid files. Triggers: page development, Figma to Shopify, template creation, section matching, responsive CSS.'
---

# Shopify Page Development from Figma Design

## Project Conventions (applies to any Shopify theme using `scss-kit`)

> Each project may also keep a `.github/copilot-instructions.md` with brand/theme-specific overrides (store name, theme-specific section list, etc.). The conventions below are theme-agnostic.

### Architecture assumption

A Shopify theme built with Liquid templates that compiles SCSS to CSS via the `scss-kit` toolchain and syncs to Shopify via ThemeKit.

### Code Principles

- **Never modify existing section, snippet, or template files** — only create new ones or use existing as-is
- **One CSS/SCSS file per page** — all page styles in a single file loaded via `common-settings.page_css`
- **Responsive by default** — use `r.resp()`, `r.vw()`, `r.re()` for all values; never write raw px values in SCSS

### Design Specs

- **Default PC width**: 2560px — varies per page, check design spec
- **Default Mobile width**: 390px — varies per page (375 / 390 / 750)
- **Breakpoint**: 850px (mobile ↔ desktop)

### Template Structure

- Templates are JSON files in `templates/`
- First section must be `common-settings` with `page_css` pointing to the CSS file
- Section IDs: `{type_underscored}_{6charRandomId}` (e.g., `common_media_r9zCV9`)
- Block IDs: `{type}_{6charRandomId}` (e.g., `image_qDW9gq`)

### Build & Dev (typical)

- `npm run dev:theme:auto` — full auto dev (SCSS compile + responsive generation + ThemeKit sync)
- `npm run css:watch` — SCSS watch only
- New page SCSS must be registered in `scss-kit.config.json` → `autofill.entries`

### File Locations

| Type         | Path                         |
| ------------ | ---------------------------- |
| Templates    | `templates/page.{name}.json` |
| Sections     | `sections/{name}.liquid`     |
| Snippets     | `snippets/{name}.liquid`     |
| SCSS source  | `src/styles/{name}.scss`     |
| CSS output   | `assets/{name}.css`          |
| Build config | `scss-kit.config.json`       |

---

## When to Use

- Building a new page from a Figma design
- Creating or editing template JSON files
- Writing page-specific CSS/SCSS
- Matching design areas to existing reusable sections
- Creating new section `.liquid` files when no existing section fits

## Task Input Format

Provide this at the start of every page development task:

```
页面名: {page-name}
Figma PC URL: https://www.figma.com/design/{FILE_KEY}/...?node-id={PC_NODE_ID}
Figma MB URL: https://www.figma.com/design/{FILE_KEY}/...?node-id={MB_NODE_ID}
设计稿宽度: PC {width}px / MB {width}px
Section 清单:
  1. {section-name} → {recommended-section-type}
  2. {section-name} × {count} → {recommended-section-type} (批量)
```

If a section list is provided, **skip Step 2** and use it directly. If multiple sections use the same type, **develop them all at once** in a single JSON + SCSS pass.

## Core Principles

1. **NEVER modify existing section/snippet files** — only use them or create new ones
2. **Reuse first** — match against the Quick Reference table in this file; only read `section-reference.md` if the user explicitly requests
3. **One CSS file per page** — all page styles go in a single SCSS/CSS file
4. **Responsive by default** — use `r.resp()`, `r.vw()`, `r.re()` for all values
5. **One section at a time** — develop JSON + SCSS for one section, verify, then continue to the next

## Procedure

### Step 0: Fetch & Cache Figma Data → Generate Design Analysis

**This step runs ONCE per page. After it completes, ALL subsequent steps read from `docs/design-analysis/{page-name}.md` only — never call the Figma API again.**

#### Step 0.1 — Fetch & save Figma JSON per section

For each section in the section list, fetch PC + MB frame data (depth=4) and save locally:

**Method 1 — Figma REST API:**

```powershell
# Run once per section frame (replace all placeholders)
$figmaToken = "{FIGMA_API_KEY}"
$fileKey = "{FILE_KEY}"
$nodeId = "{NODE_ID}"  # from Figma URL ?node-id=0-1889 → convert to 0:1889
$headers = @{ "X-Figma-Token" = $figmaToken }
$resp = Invoke-RestMethod -Uri "https://api.figma.com/v1/files/$fileKey/nodes?ids=$nodeId&depth=4" -Headers $headers
$resp | ConvertTo-Json -Depth 20 | Out-File "docs/figma/{page-name}/{section-name}-pc.json" -Encoding utf8
```

- Save PC and MB frames as separate files: `{section-name}-pc.json` / `{section-name}-mb.json`
- `depth=4` covers container structure, text styles, colors, and spacing in one call

**Method 2 — Figma MCP (alternate):**
If `figma-developer-mcp` is available, use it to fetch each section node and write results to the same file paths.

#### Step 0.2 — Generate Design Analysis document

After fetching all sections, create `docs/design-analysis/{page-name}.md`:

```markdown
# Design Analysis: {page-name}

PC width: {width}px | MB width: {width}px

## Section Map

| #   | Section名 | PC尺寸   | MB尺寸  | layoutMode | 推荐 section | 主要内容         |
| --- | --------- | -------- | ------- | ---------- | ------------ | ---------------- |
| 1   | hero      | 1920×800 | 390×600 | VERTICAL   | common-media | 背景图+标题+按钮 |

## Section Details

### {section-name}

- **Colors**: primary `#xxx`, text `#xxx`, bg `#xxx`
- **Typography**: title `{size}px`, subtitle `{size}px`, body `{size}px`
- **Spacing**: padding `{top} {right} {bottom} {left}` px, gap `{size}px`
- **JSON key**: `{section_type}_{6charId}`
- **SCSS selector**: `.{page-class} .{section-css-class}`
- **Data source**: `docs/figma/{page-name}/{section-name}-pc.json`
```

**After this step is complete: do NOT re-open any Figma JSON file. All design values are in the Design Analysis document.**

### Step 1: Analyze the Design

> **If Step 0 is complete**: read `docs/design-analysis/{page-name}.md` directly — do not re-read Figma JSON.

- Confirm the Section Map covers all visible sections top to bottom
- Note the PC/MB widths from the document header for CSS variable setup
- Confirm each section has a mapped recommended section type before proceeding

### Step 2: Match Sections

> **If the user provided a Section 清单 in the Task Input: skip this step entirely** and proceed to Step 3.

For each design area, follow this **priority-based matching** process:

**Priority 1 — Check [Pattern Learnings](./references/pattern-learnings.md)**
Search for previously verified design pattern → section mappings. If a matching record exists with ✅ status, use that section directly with the documented configuration.

**Priority 2 — Match against high-priority sections** ([Section Reference Part 1](./references/section-reference.md#part-1-高优先级--通用-section))

| Design Pattern                                         | Recommended Section                                        |
| ------------------------------------------------------ | ---------------------------------------------------------- |
| Hero banner with background image/video + overlay text | `common-media` or `new-common-media`                       |
| Alternating image+text rows (left/right)               | `common-image_with_text`                                   |
| Product card carousel / horizontal slider              | `common-product-swiper` or `new-common-product-swiper`     |
| Product grid with hero image                           | `common-product-showcase`                                  |
| Sticky tab navigation bar                              | `common-tabbar` or `new-common-tabbar`                     |
| FAQ accordion                                          | `common-product-faq`                                       |
| Scroll-triggered video reveal                          | `common-scroll-video` (requires GSAP)                      |
| Product specifications with image                      | `common-spec` or `new-common-spec`                         |
| Two-column split image layout                          | `common-bgz` or `common-bgz-short`                         |
| Feature grid with sidebar                              | `common-product-item`                                      |
| Customer review carousel                               | `common-review-swiper`                                     |
| Side-by-side product comparison                        | `common-product-compare`                                   |
| Completely custom HTML block                           | `custom-html`                                              |
| Rich text content block                                | `include-rich-text`                                        |
| Homepage hero slideshow                                | `new-slideshow`                                            |
| Image grid / multi-column layout                       | `new-common-image-layout`                                  |
| Scroll-driven text/number animation                    | `new-common-scroll-text`                                   |
| Product countdown timer                                | `common-product-countdown`                                 |
| In-the-box / package contents                          | `common-in-the-box`                                        |
| Left-right sliding layout                              | `common-left-right-slide`                                  |
| Product featured highlight                             | `common-product-featured` or `new-common-product-featured` |
| Product popup / modal                                  | `common-product-popup`                                     |
| Navigation bar (non-tab)                               | `common-nav`                                               |

**Priority 3 — Create a new section** (Step 8)
If no section in the Quick Reference table above matches the design. Do **NOT** read `section-reference.md Part 2` unless the user explicitly asks.

### Step 3: Create Template JSON

Create `templates/page.{page-name}.json` following this structure:

```json
{
  "sections": {
    "common_settings_{randomId}": {
      "type": "common-settings",
      "settings": {
        "page_css": "{page-name}",
        "import_gsap": false,
        "change_text_settings": true,
        "pc_banner_title": "60",
        "pc_common_title": "40",
        "pc_common_subtitle": "22",
        "mb_banner_title": "28",
        "mb_common_title": "24",
        "mb_common_subtitle": "14",
        "current_product": "default",
        "common_max_width": 1200,
        "common_section_pbottom": 120,
        "common_section_pbottom_mb": 60
      }
    },
    "{section_type}_{randomId}": {
      "type": "{section-type}",
      "blocks": {
        "{block_type}_{randomId}": {
          "type": "{block-type}",
          "settings": {}
        }
      },
      "block_order": ["{block_type}_{randomId}"],
      "settings": {}
    }
  },
  "order": ["common_settings_{randomId}", "{section_type}_{randomId}"]
}
```

**Template rules:**

- `common-settings` MUST be the first section in `order`
- Section keys use format: `{type_with_underscores}_{6charAlphanumId}` (e.g., `common_media_r9zCV9`)
- Block keys use format: `{block_type}_{6charAlphanumId}` (e.g., `image_qDW9gq`)
- Generate random 6-char IDs using alphanumeric characters (mixed case)
- `page_css` value must match the CSS filename (without `.css` extension)
- Multiple CSS files: separate with semicolons: `"page_css": "file1;file2"`
- Set `import_gsap: true` only if using scroll-video or GSAP animations
- `common_section_pbottom`: controls spacing between sections (vw-based)

**Declare before writing**: Before writing to the template JSON, state:

> Writing to `templates/page.{name}.json` — adding `{section_type}_{id}` to `sections` and `order`.

### Step 4: Create Page SCSS/CSS

Create `src/styles/{page-name}.scss` with:

```scss
@use "./responsive" as r;
@use "./_responsive-autofill.{page-name}.generated" as auto;

// ① PC styles only — NO @media queries inside this block
.{page-name} {
  // Section styles here using r.resp(), r.vw(), r.re()
}

// ② Scanner reads all r.resp/r.vw/r.re second args above and auto-generates
//    mobile overrides here. MUST be placed after the main container.
@include auto.responsive_autofill_overrides();

// ③ Manual mobile overrides — ONLY write here when auto-generated code must
//    be explicitly beaten (specificity, tool limitations, edge cases, etc.)
//    These run last and always win.
// @media screen and (max-width: 850px) { ... }
```

**SCSS file structure rules (strictly follow this order):**

| Zone                                               | What goes here                                                                                                           |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| ① Inside `.{page-class} { }`                       | **PC styles only** — `r.resp()`, `r.vw()`, `r.re()` calls. Absolutely **no `@media` queries** inside this block.         |
| ② `@include auto.responsive_autofill_overrides();` | Scanner auto-generates mobile overrides from `r.*` second arguments. Place immediately after the main container.         |
| ③ Manual `@media` after the `@include`             | Only for mobile styles that **must** override auto-generated code (when auto-gen specificity can't be beaten otherwise). |

**Then register as entry** in `scss-kit.config.json` → `autofill.entries`:

```json
{ "file": "src/styles/{page-name}.scss", "varScope": ".{page-name}" }
```

If an entry is registered before its SCSS source exists, keep the registration and start `npm run dev:theme:auto`. The responsive generator reports the entry as `pending` instead of failing. When the empty file is created, the watcher bootstraps the responsive imports, the per-entry generated import, the shared font-face boilerplate, and `@include auto.responsive_autofill_overrides();`; it then generates the real override file. Existing non-empty SCSS files are not overwritten.

For a page whose desktop core is fixed above a breakpoint, add `fixedCore` to `scss-kit.config.json`:

```json
{
  "fixedCore": { "breakpoint": 1500, "width": 1200 },
  "coefficients": {
    "readable": { "min": 0.625, "max": 1.5 },
    "dense": { "min": 0.5, "max": 1.5 }
  }
}
```

At `1500px` and above, the generated rule sets `--px-to-vw: 1px`, so dimensional `r.*` output returns to design values. `fixedCore.width` records the core width; it does not create the layout wrapper for you.

**Design width handling:** If this page's design spec differs from the default (PC 2560 / Mobile 390), override CSS variables at the top of the SCSS:

```scss
.{page-name} {
  --px-to-vw: calc(100vw / {actual-pc-width});   // e.g., 1920
}
@media screen and (max-width: 850px) {
  .{page-name} {
    --px-to-vw-mb: calc(100vw / {actual-mobile-width}); // e.g., 375
  }
}
```

**Declare before writing**: Before inserting any SCSS block, state:

> Writing to `src/styles/{page-name}.scss` — inserting `.{page-class} .{section-class}` block. Values sourced from `docs/design-analysis/{page-name}.md`.

### Step 5: Write Responsive CSS

**Responsive functions — always use these, never write raw px:**

### Primary Business Functions (use these 3 in daily development)

| Function                                        | Output                                                                                | When to Use                                                                                                     |
| ----------------------------------------------- | ------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `r.resp(pc, mobile[, profile[, mobileProfile]])` | PC: profile-bounded `clamp()`; Mobile: overridden by scanner via `resp_mb()` | **Font sizes and other bounded dimensions** — omitted profile defaults to `readable`; the third/fourth arguments may be `readable`, `dense`, a number, or a Sass map. |
| `r.vw(pc, mobile)`                              | PC: `min(vw, px)`; Mobile: scanner generates pure `vw` override                       | **Spacing & dimensions** — padding, margin, gap, width, height                                                  |
| `r.re(pc-val, mobile-val)`                      | PC: returns first arg as-is; Mobile: scanner writes second arg directly (no wrapping) | **Non-numeric properties** — color, display, background, grid-template-columns, etc.                            |

**`r.re` shorthand mapping** (use in either argument):

| Shorthand                | Output           |
| ------------------------ | ---------------- |
| `grid-cols-N` / `cols-N` | `repeat(N, 1fr)` |
| `span-N`                 | `span N`         |
| `order-N` / `z-N`        | number `N`       |
| `gap-N`                  | `Npx`            |
| `opacity-N`              | `N/100`          |

Example: `grid-template-columns: r.re(grid-cols-4, grid-cols-2);` → PC: `repeat(4, 1fr)`, Mobile: `repeat(2, 1fr)`

### Profiles and low-level helpers

`r.resp()` no longer accepts semantic element types such as `h1`, `h2`, or `body`. Use the two shared profiles, or a numeric/Sass-map override:

| Profile | Default min | Default max | Use for |
| ------- | -----------: | ----------: | ------- |
| `readable` | `0.625` | `1.5` | Titles, paragraphs, and content with comfortable reading space |
| `dense` | `0.5` | `1.5` | Product cards, prices, tags, badges, and other space-constrained content |

Bounds are always calculated directly as `design value * coefficient`; there are no semantic coefficient tables, absolute floors/ceilings, or fallback comparisons.

| Function | Description |
| -------- | ----------- |
| `r.vw_pc(pc)` | PC vw with the design value as an upper cap |
| `r.vw_pc_raw(pc)` | PC vw without an upper cap |
| `r.vw_mb(mobile)` | Mobile pure vw |
| `r.clamp_pc(pc, min[, max])` | Manual PC clamp |
| `r.clamp_mb(mobile, min[, max])` | Manual mobile clamp |
| `r.resp_mb(mobile[, profile])` | Mobile strategy entry selected by `responsive.mobileClampMode` |
| `r.min_px(value[, profile])` | Returns `value * profile.min` |
| `r.max_px(value[, profile])` | Returns `value * profile.max` |
| `r.profile_min(profile)` | Reads a profile minimum coefficient |
| `r.profile_max(profile)` | Reads a profile maximum coefficient |

`r.mode(readable|dense)` is an inherited mode declaration. Use it on a parent selector when a whole component should share one profile; an explicit child profile overrides it.

**CSS class conventions in this theme:**

- `.common-wrapper` — max-width content wrapper
- `.common-section-container` — section outer wrapper
- `.common-banner-title` — banner-level heading (uses `pc_banner_title` size)
- `.common-title` — section-level heading (uses `pc_common_title` size)
- `.common-subtitle` — subtitle text (uses `pc_common_subtitle` size)
- `.common-pc--hide` / `.common-small--hide` — responsive show/hide
- `.animate-js` — triggers scroll animation (with delay classes `d0-1`, `d0-2`, etc.)

**Common Pattern Snippets — copy and fill values from Design Analysis doc:**

```scss
// Font sizes
font-size: r.resp(48px, 28px);                         // readable by default
font-size: r.resp(40px, 24px, readable);                // section title
font-size: r.resp(22px, 16px, dense);                   // compact sub-heading
font-size: r.resp(18px, 14px, (min: 0.55, max: 1.3));   // explicit bounds

// Spacing & dimensions
padding: r.vw(80px, 40px) r.vw(40px, 20px);
margin-bottom: r.vw(24px, 16px);
gap: r.vw(24px, 16px);
width: r.vw(600px, 100%);

// Image fixed width (use actual px from Design Analysis)
flex: 0 0 r.vw({figma-width}px, 100%);

// Color / display toggle (non-size values)
color: r.re(#ffffff, #000000);
display: r.re(flex, block);
background-color: r.re(#f5f5f5, #ffffff);

// Mobile override block
// IMPORTANT: selector depth MUST match PC selector to avoid specificity issues
@media screen and (max-width: 850px) {
  .{page} .{section} .{element} {
    width: min({val}px * var(--px-to-vw-mb), {val}px);
    flex-direction: column;
  }
}
```

### Step 6: Handle Images

- Leave image fields empty (`""`) or use placeholder Shopify URLs
- Add a comment `<!-- TODO: Replace image -->` in template for each placeholder
- Use naming convention for planned images: `{page-name}-{section}-{nn}-{pc|mb}.webp`

### Step 7: Handle Complex Interactions

- **Hover effects**: Write in CSS
- **Carousels**: Use built-in swiper sections (common-product-swiper, etc.)
- **GSAP scroll animations**: Set `import_gsap: true`, use common-scroll-video or write custom ScrollTrigger
- **Video playback**: Use common-media (supports YouTube, HTML5 video, autoplay)
- **Highly complex interactions**: Create a new section with custom JS, mark as `<!-- TODO: Implement interaction -->`

#### Global Plugin Availability in Section Files

> The following plugins are already loaded globally in `theme.liquid` — **do NOT re-import them** in section files.

| Plugin | 引入方式 | 注意事项 |
| --- | --- | --- |
| **GSAP** (`gsap` + `ScrollTrigger` + `ScrollToPlugin`) | `defer` 脚本，全局引入 | ① 因为是 `defer` 加载，section 内的 JS 必须包在 `DOMContentLoaded` 中；② `ScrollTrigger` **未全局注册**，每个需要用它的 section 必须自己调用一次 `gsap.registerPlugin(ScrollTrigger)` |
| **Swiper** | 同步脚本，全局引入（CSS + JS） | 版本为 **4.5**，与 Swiper 8/9 的 API 有差异，编写时注意使用 v4.5 的 API 写法 |
| **Plyr** | 同步脚本，全局引入（CSS + JS） | 可直接 `new Plyr('#video-id', { ... })` 使用 |

**GSAP 在 section 中的标准用法：**

```html
<script>
  document.addEventListener('DOMContentLoaded', function () {
    gsap.registerPlugin(ScrollTrigger); // 必须手动注册
    gsap.to('.my-el', {
      scrollTrigger: { trigger: '.my-el', start: 'top 80%' },
      opacity: 1,
      y: 0,
    });
  });
</script>
```

### Step 8: Create New Section (only when needed)

**Before creating a new section**, confirm:

1. No high-priority section in [Part 1](./references/section-reference.md#part-1-高优先级--通用-section) matches
2. No extended section in [Part 2](./references/section-reference.md#part-2-扩展-section-目录) can be reused
3. No pattern in [Pattern Learnings](./references/pattern-learnings.md) suggests an existing solution

If confirmed, create `sections/{page-name}-{feature}.liquid`:

```liquid
<section class="common-section-container {{ section.settings.section_css }}">
  <div class="common-wrapper">
    <!-- Section content -->
  </div>
</section>

{% schema %}
{
  "name": "Section Display Name",
  "settings": [
    {
      "type": "text",
      "id": "section_css",
      "label": "Section css"
    }
  ],
  "blocks": [],
  "presets": [
    {
      "name": "Section Display Name"
    }
  ]
}
{% endschema %}
```

### Step 9: Update Knowledge Base

After completing a page, **always** update the learning files:

**9.1 Append to [Pattern Learnings](./references/pattern-learnings.md):**

For each section used in this page, add a record:

```markdown
### {date} | {page-name} — {design-pattern-short-description}

- **设计模式**：{detailed description of what the design looks like}
- **使用 Section**：`{section-type}`
- **关键配置**：{key settings that made it work}
- **参考模板**：`{template-filename}`
- **效果**：✅ 正常 / ⚠️ 有注意事项 / ❌ 不推荐
```

Skip patterns that already have identical records in pattern-learnings.md.

**9.2 Fix section-reference.md if needed:**

- If a section's block type, setting name, or behavior differs from what's documented, correct it
- If a section was used for a design pattern not mentioned in its "Purpose", add it
- If a low-priority section proved highly reusable, consider adding more detail to its entry

**9.3 Update the "Used in" field:**

Add the new template filename to the section's "Used in" list in section-reference.md.

## Section Quick Reference

See [Section Reference](./references/section-reference.md) for complete documentation:

- **Part 1** — 70 high-priority common sections (full schema)
- **Part 2** — 380+ extended sections (categorized index)
- **[Pattern Learnings](./references/pattern-learnings.md)** — Verified design pattern → section mappings

### Most Used Sections Summary

**common-settings** — Page configuration (REQUIRED first section)

- Key settings: `page_css`, `import_gsap`, `change_text_settings`, `pc_banner_title`, `pc_common_title`, `pc_common_subtitle`, `mb_*` variants, `common_max_width`, `common_section_pbottom`

**common-media / new-common-media** — Versatile media blocks (banner, hero, video)

- Section settings: `show_section`, `section_css`
- Block settings: `is_page_banner`, `media_type` (image/video/youtube_video), `image`, `image_mb`, `video_url`, `video_mobile_url`, `title`, `text`, `text_alignment`, `text_width`, `block_css`, `custom_html_css`
- New version adds: `enable_text_align`, `enable_media_fullWidth`, `float_image_content`, per-breakpoint color controls

**common-image_with_text** — Image + text alternating layout

- Section: `section_title`, `bg_color`, `padding_top/bottom`, `show_animated`
- Blocks (type: `block`): `layout` (left/right), `media_type`, `image`, `image_mb`, `video_url`, `title`, `subtitle`, `second_text`, `block_css`, `custom_html_css`

**common-product-swiper / new-common-product-swiper** — Product carousel

- Section: `enable_swiper`, `enable_pin`, `enable_arrow`, `enable_scrollbar`, `enable_pagination`, `swiper_inital_num`, `swiper_pc_num`, `swiper_mb_num`, `title`, `subtitle`
- Blocks: `image`, `image_mb`, `title`, `subtitle`, `video_url`, `custom_html`, `additional_content`, `bg_image`

**common-tabbar** — Sticky navigation tabs

- Section: `enable_sticky`, `product`, `another_btn_text`, `bg_color`, `item_color`, `f_size`, `mb_f_size`, `max_width`, `enable_switch`, `enable_new_monitoring`
- Blocks: `tabs_id` (must be unique, lowercase), `title`

**common-product-faq** — Accordion FAQ

- Section: `title`, `subtitle`, `section_css`
- Blocks: `text` (question header), `title` (question), `subtitle` (answer HTML)

**common-scroll-video** — GSAP scroll-driven video reveal

- Requires `import_gsap: true` in common-settings
- Section: `section_css`, `banner_title`, `title`, `subtitle`
- Blocks: `image`, `image_mb`, `video_url`, `video_url_mb`, `banner_title`, `title`, `subtitle`, `block_css`

**custom-html** — Free-form HTML/Liquid block

- Section: `enable_full_width`, `section_css`, `custom_html`, `custom_liquid`, padding controls

**common-spec** — Product specifications

- Section: `layout` (left/right), `image`, `image_mb`, `section_title`, `product_title`, `content`, `show_first_content`, `show_more_content`, `tips`

**common-bgz** — Two-column split image

- Section: `image`/`image2` (long/short), `left_proportion`, `sidecheck`, `video_url`, `long_title`, `title`

**common-review-swiper** — Review/testimonial carousel

- Section: `layout` (two_line/three_line), `title`, `text`
- Blocks: `image`, `subtitle`, `link`

**common-product-compare** — Product comparison

- Section: `title`, `subtitle`
- Blocks: `image_left`/`image_right`, `area` (e.g., "40%-60%"), `title_left`/`title_right`, `compare_table_content`, product selectors

### Additional Notable Sections

**new-common-scroll-text** — GSAP parallax scroll with synced media+text (requires `import_gsap: true`)

- Section: `enable_scroll`, `section_css`, `video_url/video_url_mb`, `image/image_mb`
- Blocks (type: `text`): `enable_scrolltop_text`, `enable_media_fullWidth`, `enable_text`, `banner_title`, `title`, `subtitle`

**common-product-countdown** — Real-time countdown timer

- Section: `countdown_time` (format: "2023/8/22 00:00:00"), `days/hours/minutes/seconds` labels, color settings

**common-product-featured / new-common-product-featured** — Feature card grid

- Section: `section_css`, `row_num`, `enable_hover_image`, `enabled_swiper_mb`
- Blocks (type: `block`): `image`, `image_mb`, `title`, `subtitle`, `video_url`

**new-common-tabbar / new-common-tabbar-fix / new-common-tabbar-with-btn** — Modern tabbar variants

- Fix version: buffer-based scroll highlight (prevents jitter)
- With-btn version: adds custom tab colors, button type selection, GA tracking
- Block type: `text` (not `html` like base `common-tabbar`)

**common-product-popup** — Modal popup triggered by CSS class

- Section: `section_css_1` (trigger class), `title`, `subtitle`
- Blocks: `image`, `image_mb`, `title`, `subtitle`

**common-nav** — Fixed icon navigation bar with scroll anchor

- Block type: `nav_item` — `icon` (SVG), `title`, `target_id`

**common-in-the-box** — Package contents display

- Section: `section_css`, `section_width`, `title`, `text`, `content` (HTML)

**common-video-settings** — Multi-format video player (YouTube/MP4/Vimeo/iframe)

- Block type: `text` — `video`, `youtube_video`, `iframe_video_url`, `enable_video_controls`

## Output Checklist

After generating all files, verify:

- [ ] Template JSON has `common-settings` as first section with correct `page_css`
- [ ] All section IDs follow `{type}_{6charId}` pattern
- [ ] SCSS file uses `@use "./responsive" as r;` and includes autofill overrides
- [ ] All font sizes use `r.resp()`, all spacing uses `r.vw()`, all non-size differences use `r.re()`
- [ ] Images are marked as placeholders
- [ ] Complex interactions are marked with TODO comments
- [ ] `scss-kit.config.json` has new entry registered
- [ ] Design width CSS variables are set correctly if non-default
- [ ] Pattern Learnings updated with new design pattern → section mappings (Step 9)
- [ ] Section Reference "Used in" fields updated for all sections used

## Common CSS Mistakes & Rules

### 1. 图文布局：不要对图片和文字区域同时使用 `flex: 1`

**错误做法：**

```scss
.common-iwt-image-box {
  flex: 1;
}
.common-iwt-text-box {
  flex: 1;
}
```

**正确做法：** 从 Figma layout 数据中读取图片容器的实际宽度（`dimensions.width`），用 `r.vw()` 转换后设为固定值，文字区域用 `flex: 1` 自动填满剩余空间：

```scss
.common-iwt-image-box {
  flex: 0 0 r.vw({figma图片宽度}px, 100%);
}
.common-iwt-text-box {
  flex: 1;
}
```

### 2. `r.vw()` 仅适用于 PC 端 `--px-to-vw`，移动端必须单独覆盖

`r.vw(pc, mb)` 生成的 CSS 值（如 `min(40px * var(--px-to-vw), 40px)`）使用的是 `--px-to-vw`（PC 变量）。

**在移动端 `@media` 块内**，需要手动使用 `--px-to-vw-mb` 覆盖：

```scss
@media screen and (max-width: 850px) {
  .icon-img {
    // 不能用 r.vw()，要手写 --px-to-vw-mb：
    width: min(40px * var(--px-to-vw-mb), 40px);
    height: min(40px * var(--px-to-vw-mb), 40px);
  }
}
```

或者直接用 `r.vw_mb(40px)` 函数。

### 3. 移动端 flex 方向要从设计稿中重新核对，不能继承 PC 值

PC 端的 `flex-direction: row` 在移动端并不会自动变为 `column`。**每一个 flex 容器在移动端的排列方式都必须在 `@media` 块中显式写出**，不能只靠继承或省略。

### 4. `common-image_with_text` section：block 的上下 padding 分属不同 block

该 section 的两个 block 上下各有独立的 padding 要求（来自 Figma layout 的 `padding-top`/`padding-bottom`）。务必用 `:first-child` / `:last-child` 分别设置，不要对 `.common-iwt-content-item` 统一设置同一 padding。

### 5. 移动端文字对齐方式必须显式声明

主题的全局样式可能会让文字居中（`text-align: center`）。即使 Figma 设计稿上移动端为左对齐，也必须在移动端 `@media` 块中**显式写 `text-align: left`**，不能依赖继承。

### 6. `common-image_with_text` section 中禁用 `:first-child` 选择器

**原因：** `common-image_with_text.liquid` 在 `.common-image_with_text` 容器内会先输出 `{% style %}...{% endstyle %}` 的 `<style>` 元素，导致第一个 `.common-iwt-content-item` div 实际是第二个子元素。`:first-child` 无法命中，但 `:last-child` 可以正常命中（因为循环最后一个 div 确实是最后一个子元素）。

**错误做法：**

```scss
.common-iwt-content-item {
  &:first-child {
    padding: ...;
  }
  &:last-child {
    padding: ...;
  }
}
```

**正确做法：** 使用 `block_css` 字段的类名替代 `:first-child`，`:last-child` 可继续使用：

```scss
.h16-pro-steam-section-block1 {
  // 值来自 block_css 配置
  padding: r.vw(140px, 80px) 0 r.vw(60px, 24px);
}
.common-iwt-content-item:last-child {
  padding: r.vw(60px, 24px) 0 r.vw(140px, 80px);
}
```

### 7. 移动端 `@media` 块内选择器深度必须与 PC 端保持一致

**原因：** CSS 特异性（specificity）与媒体查询无关。若移动端选择器比 PC 端少一级，即使在 `@media` 块内，特异性仍低于 PC 端，PC 样式会获胜。

**典型错误：**

```scss
// PC 端（特异性: 6个class = 0,6,0）
.page .section .common-iwt-text-box .text-box .common-content .icon-item { ... }

// 移动端（特异性: 4个class = 0,4,0）— 被 PC 端覆盖！
@media (max-width: 850px) {
  .page .section .common-content .icon-item { ... }
}
```

**正确做法：** 移动端选择器路径必须与 PC 端完全等深：

```scss
@media (max-width: 850px) {
  .page .section .common-iwt-text-box .text-box .common-content .icon-item { ... }
}
```

实操规则：编写移动端样式前，先确认对应的 PC 端选择器完整路径，照抄该路径写进 `@media` 块。

### 8. 元素宽高非必要不写死

页面元素的 `width`、`height`、`max-width`、`max-height` 非必要时**不要写死固定值**，尽量让元素的宽高由内容自然撑开。只有在需要明确限制尺寸（如图片容器、固定宽度卡片）时才写固定值，并用 `r.vw()` 或 `r.resp()` 转换为响应式值而非 raw px。

### 9. 外部静态资源的引入规范

在 section 文件中引入外部静态资源时，必须遵守以下规范：

**引入 CSS 文件：**

```liquid
{{ 'XXX.css' | asset_url | stylesheet_tag }}
```

**引入 JS 文件：**

```html
<script src="{{ 'XXX.js' | asset_url }}" defer="defer"></script>
```

> 注意：JS 文件引入需要加 `defer="defer"`，避免阻塞页面渲染。较简单的样式或脚本（不超过 50 行、无需复用）在 section 文件内直接用 `<style>` / `<script>` 块完成即可，无需单独提取为 asset 文件。

### 10. Section 的 JS 代码应包在 `DOMContentLoaded` 中

一般情况下，section 内的 `<script>` 代码应包裹在 `DOMContentLoaded` 事件中，确保 DOM 节点已就绪后再执行：

```html
<script>
  document.addEventListener('DOMContentLoaded', function () {
    // section 逻辑
  });
</script>
```

**例外情况**（不需要包在 `DOMContentLoaded` 中）：

- 仅声明变量或配置对象，不操作 DOM
- 使用了 `defer` 属性的外部脚本（浏览器保证在 DOM 解析完成后才执行）
- 有明确的执行时机要求（如需要在某个第三方库回调中执行）
