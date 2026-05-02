# Section Reference — Complete Settings & Blocks

This document contains the schema for all sections in the theme, organized by priority level.

- **Part 1** — High-priority common sections with full schema documentation. Always check these first.
- **Part 2** — Extended section catalog (product/page-specific sections) with lightweight index. Search here only when Part 1 doesn't fit.

---

# Part 1: 高优先级 — 通用 Section

> Complete settings & blocks documentation for all `common-*`, `new-common-*`, `custom-html`, `include-rich-text`, and `new-slideshow` sections.

---

## common-settings

**Purpose:** Page-level configuration. Loads CSS, sets typography sizes, controls GSAP/animation.
**MUST be the first section in every template.**

**Used in:** Nearly all templates — `index.json`, `page.about-us.json`, `product.d10-plus-gen2.json`, etc.

| Setting                     | Type     | Default   | Description                                                                |
| --------------------------- | -------- | --------- | -------------------------------------------------------------------------- |
| `page_css`                  | text     | —         | CSS filename(s) to load. Semicolon-separated for multiple: `"file1;file2"` |
| `page_settings`             | html     | —         | Arbitrary HTML/CSS injected into page head                                 |
| `import_gsap`               | checkbox | false     | Load GSAP + ScrollTrigger library                                          |
| `show_snow`                 | checkbox | false     | Snow particle effect                                                       |
| `monitor_video`             | checkbox | false     | Auto-pause videos when off-screen                                          |
| `change_text_settings`      | checkbox | false     | Enable custom text sizing below                                            |
| `enable_text_biggest`       | checkbox | false     | Apply sizes at 1921px+ breakpoint                                          |
| `pc_banner_title`           | text     | "60"      | PC banner title font-size (px)                                             |
| `pc_common_title`           | text     | "40"      | PC section title font-size (px)                                            |
| `pc_common_subtitle`        | text     | "22"      | PC subtitle font-size (px)                                                 |
| `mb_banner_title`           | text     | "28"      | Mobile banner title font-size (px)                                         |
| `mb_common_title`           | text     | "24"      | Mobile section title font-size (px)                                        |
| `mb_common_subtitle`        | text     | "14"      | Mobile subtitle font-size (px)                                             |
| `enable_ipad_settings`      | checkbox | false     | Enable iPad-specific sizes                                                 |
| `ipad_banner_title`         | text     | "48"      | iPad banner size                                                           |
| `ipad_common_title`         | text     | "36"      | iPad title size                                                            |
| `ipad_common_subtitle`      | text     | "24"      | iPad subtitle size                                                         |
| `show_not_animated`         | checkbox | false     | Reduce animation delays                                                    |
| `current_product`           | select   | "default" | Legacy product CSS selector                                                |
| `common_max_width`          | number   | —         | Max content width (px), e.g. 1200                                          |
| `common_section_pbottom`    | number   | —         | Section bottom padding (vw-based)                                          |
| `common_section_pbottom_mb` | number   | —         | Mobile section bottom padding                                              |

No blocks.

---

## common-media

**Purpose:** Versatile multi-block media container. Hero banners, image sections with text overlay, video backgrounds.

**Used in:** `product.h12-pro-flexreach.json`, `product.d10-plus-gen2.json`, `page.about-us.json`, `collection.store.json`, 15+ product templates

**Section settings:**
| Setting | Type | Default |
|---------|------|---------|
| `show_section` | checkbox | true |
| `section_css` | text | — |

**Block type:** `image` (name: "Item")

| Block Setting                | Type         | Default                                 | Description                               |
| ---------------------------- | ------------ | --------------------------------------- | ----------------------------------------- |
| `is_page_banner`             | checkbox     | false                                   | Applies banner styling                    |
| `enable_common_width`        | checkbox     | false                                   | Constrain to wrapper width                |
| `media_page`                 | checkbox     | false                                   | Media wrapper mode                        |
| `show_frame_image`           | checkbox     | false                                   | Frame image decoration                    |
| `show_image`                 | checkbox     | false                                   | Force show image regardless of media type |
| `block_css`                  | text         | —                                       | Custom CSS class                          |
| `custom_html_css`            | html         | —                                       | Inline CSS                                |
| `show_header`                | checkbox     | false                                   | Show header area                          |
| `section_kicker`             | html         | —                                       | Kicker text                               |
| `section_title`              | html         | —                                       | Header title                              |
| `section_text`               | html         | —                                       | Header text                               |
| `text_align`                 | select       | "left"                                  | PC text alignment (left/center/right)     |
| `text_align_mb`              | select       | "center"                                | Mobile text alignment                     |
| `text_width`                 | range        | 70                                      | Text container width (0-100%)             |
| `text_alignment`             | select       | "vertical-center horizontal-left"       | Text position (9-grid)                    |
| `text_alignment_mb`          | select       | "mb_vertical-bottom mb_horizontal-left" | Mobile text position                      |
| `text_position_mb`           | checkbox     | false                                   | Text top position on mobile               |
| `media_type`                 | select       | "image"                                 | image / video / youtube_video             |
| `video_radius`               | checkbox     | false                                   | Rounded video corners                     |
| `image`                      | image_picker | —                                       | PC background image                       |
| `image_pad`                  | image_picker | —                                       | iPad image                                |
| `image_mb`                   | image_picker | —                                       | Mobile image                              |
| `video_url`                  | textarea     | —                                       | HTML5 video URL                           |
| `video_mobile_url`           | textarea     | —                                       | Mobile video URL                          |
| `video_muted`                | checkbox     | false                                   | Mute video                                |
| `youtube_video`              | text         | —                                       | YouTube video URL                         |
| `show_animated`              | checkbox     | true                                    | Enable animations                         |
| `title`                      | html         | —                                       | Block title                               |
| `text`                       | html         | —                                       | Block subtitle                            |
| `text_position`              | select       | "bottom"                                | Subtitle position (top/bottom)            |
| `custom_html_content`        | html         | —                                       | Custom HTML injection                     |
| `link`                       | url          | —                                       | CTA link                                  |
| `addition_content`           | html         | —                                       | Additional content area                   |
| `addition_content_color`     | color        | #ffffff                                 | Additional content text color             |
| `addition_content_alignment` | select       | "left"                                  | left / center                             |

**Text position values:** `vertical-{top|center|bottom} horizontal-{left|center|right}`

---

## new-common-media

**Purpose:** Enhanced version of common-media with better mobile control and color settings.

**Used in:** `page.test.json` (newer pages preferred)

Same base as common-media, plus additional block settings:

- `enable_text_align` — separate text alignment per breakpoint
- `enable_media_fullWidth` — full-width media without wrapper
- `float_image_content` — floating overlay image
- `enable_color_settings` — per-block color override for title/subtitle
- `enable_media_additional_mb` — mobile-specific additional content
- `video_content` — custom video embed HTML
- `is_first_page_banner` — first banner special styling

---

## common-image_with_text

**Purpose:** Alternating image/video + text layout. Left image → right text, or reversed.

**Used in:** `product.d9-max-gen2.json` (3×), `product.d10-plus-gen2.json`, `collection.air-purifier.json`

**Section settings:**
| Setting | Type | Default |
|---------|------|---------|
| `section_title` | html | — |
| `show_animated` | checkbox | true |
| `bg_color` | color | #ffffff |
| `padding_top` | range | 0 (0-200px) |
| `padding_bottom` | range | 0 (0-200px) |

**Block type:** `block` (name: "Row")

| Block Setting           | Type         | Default | Description                 |
| ----------------------- | ------------ | ------- | --------------------------- |
| `layout`                | select       | "left"  | Image position (left/right) |
| `media_type`            | select       | "image" | image / video               |
| `image`                 | image_picker | —       | PC image                    |
| `image_mb`              | image_picker | —       | Mobile image                |
| `video_url`             | textarea     | —       | Video URL                   |
| `video_mobile_url`      | textarea     | —       | Mobile video URL            |
| `title`                 | html         | —       | Title                       |
| `subtitle`              | html         | —       | Subtitle                    |
| `second_text`           | html         | —       | Second text block           |
| `addition_left_content` | html         | —       | Mobile-specific text        |
| `block_css`             | text         | —       | Custom CSS class            |
| `custom_html_css`       | html         | —       | Inline CSS                  |
| `full_width`            | checkbox     | false   | Full width mode             |

---

## common-product-swiper

**Purpose:** Horizontal product/content carousel with Swiper.js. Supports pinning, pagination, arrows, scrollbar.

**Used in:** `product.d10-plus-gen2.json` (3×), `product.aqua10-ultra-roller-complete.json`

**Section settings:**
| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `show_animted` | checkbox | true | Animations |
| `enable_full_width` | checkbox | false | Full width |
| `section_css` | text | — | CSS class |
| `custom_css` | html | — | Inline CSS |
| `is_banner_title` | checkbox | false | Use banner title size |
| `title` | html | — | Section title |
| `subtitle` | html | — | Section subtitle |
| `custom_html` | html | — | Custom HTML above carousel |
| `additional_content` | html | — | Extra content |
| `enable_swiper` | checkbox | false | **Enable carousel** |
| `enable_vertical_swiper` | checkbox | false | Vertical direction |
| `swiper_inital_num` | text | "1" | Initial visible slides |
| `swiper_inital_mb_num` | text | — | Mobile initial slides |
| `enable_pin` | checkbox | false | Pin/sticky scroll effect |
| `pin_position` | text | — | Pin position |
| `enable_pagination` | checkbox | false | Dot pagination |
| `enable_scrollbar` | checkbox | false | Scrollbar |
| `enable_arrow` | checkbox | false | Navigation arrows |
| `arrow_position` | select | "left" | Arrow position (top/left) |
| `swiper_pc_num` | text | "4" | PC slides visible |
| `pc_spacebetween` | text | "20" | PC gap between slides |
| `swiper_ipad_num` | text | "3" | iPad slides |
| `swiper_mb_num` | text | "2" | Mobile slides |
| `enable_review` | checkbox | false | Show review widgets |
| `enable_left_right_layout` | checkbox | false | Left/right split layout |
| `enable_fade` | checkbox | false | Fade transition |
| `enable_slide_center` | checkbox | false | Center active slide |
| `enable_wheel` | checkbox | false | Mousewheel control |
| `image` | image_picker | — | Section background image |
| `image_mb` | image_picker | — | Mobile background |

**Block type:** `block`

| Block Setting        | Type         | Description      |
| -------------------- | ------------ | ---------------- |
| `product`            | product      | Linked product   |
| `block_css`          | text         | CSS class        |
| `image`              | image_picker | Slide image      |
| `image_mb`           | image_picker | Mobile image     |
| `bg_image`           | image_picker | Background image |
| `video_url`          | textarea     | Video URL        |
| `video_url_mb`       | textarea     | Mobile video     |
| `title`              | html         | Slide title      |
| `subtitle`           | html         | Slide subtitle   |
| `custom_html`        | html         | Custom content   |
| `additional_content` | html         | Extra content    |

---

## new-common-product-swiper

**Purpose:** Enhanced carousel with title navigation and bottom text positioning.

**Used in:** `collection.air-purifier.json`, `page.about-us.json`

Adds to common-product-swiper:

- `enable_title_navigation` — navigate via title buttons
- `enable_bottom_text` — text below carousel
- `enable_bottom_text_bottom` — position at section bottom
- `enable_m_bottom_text_bottom` — mobile text positioning
- `enable_animated` — animation control
- Per-block: `enable_text`, `enable_text_before`, `enable_media_fullWidth`, `banner_title`

---

## common-tabbar

**Purpose:** Sticky horizontal navigation with tab switching. Can include buy button.

**Used in:** `product.d10-plus-gen2.json`, `product.f10.json`, `product.l10-ultra.json`

**Section settings:**
| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `enable_sticky` | checkbox | true | Pin to top on scroll |
| `enable_header_sticky` | checkbox | false | Sticky with header |
| `enable_new_monitoring` | checkbox | false | Auto-highlight tab by scroll position |
| `enable_common_width` | checkbox | false | Content wrapper width |
| `enable_switch` | checkbox | false | Switch blocks visibility |
| `enable_classname` | checkbox | false | Use class names instead of IDs |
| `enable_scrollshow` | checkbox | false | Show on scroll only |
| `product` | product | — | Product for buy button |
| `title` | text | — | Product/page name |
| `another_btn_text` | text | "Add To Cart" | Buy button label |
| `bg_color` | color | rgba(0,0,0,0) | Tab background |
| `item_color` | color | #000 | Tab text color |
| `f_size` | range | 20 (12-100px) | PC font size |
| `mb_f_size` | range | 14 (8-50px) | Mobile font size |
| `max_width` | range | 1430 (1000-1920px) | Max container width |
| `section_css` | text | — | CSS class |
| `custom_css` | html | — | Inline CSS |

**Block type:** `html` (name: "Tabs Item")

| Block Setting | Type | Default    | Description                                     |
| ------------- | ---- | ---------- | ----------------------------------------------- |
| `tabs_id`     | text | "overview" | **Unique tab ID** (lowercase, no special chars) |
| `title`       | html | "overview" | Tab display label                               |

---

## common-product-faq

**Purpose:** Accordion-style Q&A. First item expanded by default.

**Used in:** `collection.air-purifier.json`, `page.member-points.json`, `product.d10-plus-gen2.json`

**Section settings:**
| Setting | Type | Default |
|---------|------|---------|
| `banner_title` | checkbox | false |
| `section_css` | text | — |
| `title` | html | — |
| `subtitle` | html | — |

**Block type:** `text`

| Block Setting | Type         | Description              |
| ------------- | ------------ | ------------------------ |
| `block_css`   | text         | CSS class                |
| `image`       | image_picker | Image per Q              |
| `image_mb`    | image_picker | Mobile image             |
| `text`        | text         | Question header/category |
| `title`       | html         | Question text            |
| `subtitle`    | html         | Answer HTML              |

---

## common-scroll-video

**Purpose:** Parallax video reveal triggered by scroll. Video expands from 30% to 100% width. **Requires `import_gsap: true` in common-settings.**

**Used in:** `product.f10.json`, `product.l50-ultra.json`

**Section settings:**
| Setting | Type | Default |
|---------|------|---------|
| `show_style` | checkbox | true |
| `section_css` | text | — |
| `banner_title` | html | — |
| `title` | html | — |
| `subtitle` | html | — |

**Block settings:**
| Setting | Type | Description |
|---------|------|-------------|
| `disabled_slide_animated` | checkbox | Disable scroll animation |
| `banner_title` | html | Block banner title |
| `title` | html | Block title |
| `subtitle` | html | Block subtitle |
| `image` | image_picker | PC fallback image |
| `image_ipad` | image_picker | iPad image |
| `image_mb` | image_picker | Mobile image |
| `video_url` | textarea | PC video URL |
| `video_url_mb` | textarea | Mobile video URL |
| `block_css` | text | CSS class |

---

## common-spec

**Purpose:** Product specifications with left/right image + feature list.

**Used in:** `product.d10-plus-gen2.json`, `product.f10.json`, `product.l10-ultra.json`

**Section settings:**
| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `enable_new_layout` | checkbox | false | Use new layout |
| `enable_common_width` | checkbox | false | Wrapper width |
| `section_css` | text | — | CSS class |
| `section_css_html` | html | — | Inline CSS |
| `bg_color` | color | #ffffff | Background |
| `layout` | select | "right" | Image position (left/right) |
| `image` | image_picker | — | PC image |
| `image_mb` | image_picker | — | Mobile image |
| `section_title` | html | — | Section title |
| `product_title` | html | — | Product name |
| `content` | html | — | Main content |
| `show_first_content` | html | — | Visible spec list |
| `show_more_content` | html | — | Expandable content |
| `tips` | html | — | Tips text |
| `show_animted` | checkbox | true | Animations |

No blocks.

---

## common-bgz

**Purpose:** Two-column split with long image + short image/video.

**Used in:** `product.d9-max.json` (3×), `product.hair-glory.json`

**Key settings:**

- `is_change_proportion` — allow custom ratio
- `left_proportion` — left column width (10-100%, default 50%)
- `sidecheck` — float right
- `image` / `image_mb` — long image
- `image2` / `image2_mb` — short image
- `replace_pic` — replace short image with video
- `video_url` / `video_mobile_url` — video sources
- `short_content_side` — content position (top/bottom)
- `long_title` / `title` — content text

---

## common-review-swiper

**Purpose:** Customer review/testimonial carousel.

**Used in:** `index.json`

**Section settings:**
| Setting | Type | Default |
|---------|------|---------|
| `enable_animated` | checkbox | true |
| `layout` | select | "two_line" | two_line / three_line |
| `section_css` | text | — |
| `section_width` | range | 100 (0-100%) |
| `title` | html | — |
| `text` | html | — |

**Block type:** `block`

- `image` — reviewer image
- `image_mb` — mobile image
- `subtitle` — review content HTML
- `link` — reviewer link

---

## common-product-compare

**Purpose:** Side-by-side product comparison with images and specs table.

**Used in:** Product comparison pages (e.g., `product.d10-plus-gen2.json`)

**Section settings:**

- `banner_title` — use banner title size
- `section_css` — CSS class
- `title` / `subtitle` — section heading

**Block settings:**

- `enable_compare_table` — show specs comparison table
- `compare_table_content` — HTML table content
- `image_left` / `image_right` — product images
- `image_left_mb` / `image_right_mb` — mobile images
- `area` — PC column ratio (e.g., "40%-60%")
- `area_m` — mobile ratio
- `gap_pc` / `gap_m` — gap between columns
- `title_left` / `title_right` — product names
- `subtitle_left` / `subtitle_right` — descriptions
- `left_product` / `right_product` — product selectors for buy buttons
- `compare_button_text` — buy button text (default: "Buy Now")

---

## custom-html

**Purpose:** Completely free-form HTML/Liquid section.

**Used in:** `page.2025-presale.json`, `product.d30-ultra.json`

**Section settings:**
| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `enable_full_width` | checkbox | false | Full page width |
| `css_name` | text | — | CSS class |
| `section_css` | text | — | Additional CSS class |
| `section_bg_color` | color | — | Background color |
| `use_new_settings` | checkbox | false | Enable font size controls |
| `font_color` | color | — | Text color |
| `pc_font_size` | range | 16 (1-60px) | PC font size |
| `mb_font_size` | range | 14 (1-60px) | Mobile font size |
| `padding_top` | range | 50 (0-200px) | PC padding top |
| `padding_bottom` | range | 50 (0-200px) | PC padding bottom |
| `padding_top_mb` | range | 20 (0-80px) | Mobile padding top |
| `padding_bottom_mb` | range | 20 (0-80px) | Mobile padding bottom |
| `custom_html` | html | — | **HTML content** |
| `custom_liquid` | liquid | — | **Liquid content** |

No blocks.

---

## include-rich-text

**Purpose:** Rich text content section with heading, body, and CTA button.

**Used in:** Various pages for rich text blocks

**Section settings:**
| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `section_css` | text | — | CSS class |
| `full_width` | checkbox | — | Full width |
| `title` | html | "Catchy heading" | Heading text |
| `heading_color` | color | #000000 | Heading color |
| `heading_alignment` | select | "center" | left/center/justify/right |
| `title_size_type` | select | "fixed" | fixed / adaptive |
| `heading_size` | range | 35 (20-120px) | PC heading size |
| `heading_size_mb` | range | 22 (20-50px) | Mobile heading size |
| `text` | richtext | — | Body content |
| `text_color` | color | #000000 | Text color |
| `text_alignment` | select | "center" | Text alignment |
| `text_size` | range | 14 (8-40px) | PC text size |
| `text_size_mb` | range | 14 (8-40px) | Mobile text size |
| `columns` | range | 1 (1-3) | Text columns |
| `button_label` | text | "Read more" | Button text |
| `button_link` | url | — | Button URL |
| `button_alignment` | select | "center" | Button alignment |
| `button_style` | select | "button--primary" | Button style |

No blocks.

---

## new-slideshow

**Purpose:** Homepage hero slideshow with multiple slides, autoplay, and navigation.

**Used in:** `index.json`, `page.app-store.json`

**Section settings:**
| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `class` | text | — | CSS class |
| `full_width` | checkbox | true | Full width |
| `content_cover` | checkbox | true | Content overlays image |
| `enable_swiper` | checkbox | true | Enable carousel |
| `show_swiper_btn` | checkbox | true | Show prev/next arrows |
| `show_swiper_pagination` | checkbox | true | Show dots |
| `enable_loop` | checkbox | true | Loop slides |
| `enable_autoplay` | checkbox | true | Auto-advance |
| `autoplay_delay` | number | 6000 | Autoplay interval (ms) |

**Block type:** `slide`

- `block_css` — CSS class
- `media_type` — image / video
- `image_desktop` — PC image
- `image_mobile` — Mobile image
- `content_width` — Content width (%)
- `text_alignment` — left/center/right
- `title` — Slide title HTML
- `subtitle` — Slide subtitle
- `text_color` — Text color
- `link_label` — CTA button text
- `link_url` — CTA URL

---

## common-product-showcase

**Purpose:** Hero product image + product grid/carousel. 2-column layout.

**Used in:** `collection.store.json` (10×)

**Key settings:**

- `collection` — Product collection
- `image` / `image_ipad` / `image_mb` — Hero images
- `link` — Hero CTA
- `title` / `subtitle` — Section headings
- `enable_swiper` — Carousel on product grid
- `enable_product_reviews` — Show ratings
- `buy_now_bg` / `add_to_cart_bgcolor` — Button colors

**Block settings:**

- `product` — Individual product
- `show_product_price` — Price display
- `custom_product_price` — Price override

---

## common-product-item

**Purpose:** Product feature grid with optional sidebar.

**Used in:** `product.d10-plus-gen2.json`, `product.z30.json`

**Key settings:**

- `enable_new_layout` — new version
- `left_image` / `left_text` / `left_content` — Sidebar
- `left-middle-right` — Grid layout ratio (e.g., "3-3-3")
- `each_precent` — Width percentages (e.g., "33.33%-33.33%-33.33%")
- `tips` — Tips content
- `show_learn_more` — CTA link option

**Block type:** `item`

- `image` / `image_mb` — Block image
- `title` / `subtitle` — Block text
- `custom_html` — Custom content
- `tip` — Tooltip text

---

## new-common-image-layout

**Purpose:** Flexible image/media grid on PC, converts to Swiper carousel on mobile. Supports text overlays and video.

**Used in:** `collection.air-purifier.json`, `product.d20-ultra.json`, `page.about-us.json`

**Section settings:**
| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `enable_animated` | checkbox | true | Enable animations |
| `section_css` | text | — | CSS class |
| `banner_title` | html | — | Banner title |
| `title` | html | — | Section title |
| `subtitle` | html | — | Section subtitle |
| `button_text` | text | — | CTA button text |
| `additional_content` | html | — | Extra content |
| `divided_into_count` | text | "1-1-1" | PC column ratio (e.g., "1-1-1", "2-1") |
| `divided_m_into_count` | text | — | Mobile column ratio |
| `enable_mb_swiper` | checkbox | true | Mobile Swiper carousel |
| `swiper_mb_num` | text | "1" | Mobile slides visible |
| `enable_swiper_style` | checkbox | false | Swiper style mode |
| `enable_auto_swiper` | checkbox | false | Auto-play carousel |
| `enable_auto_swiper_time` | text | "1800" | Auto-play interval (ms) |

**Block type:** `text` (name: "block")

| Block Setting                | Type         | Default                                 | Description        |
| ---------------------------- | ------------ | --------------------------------------- | ------------------ |
| `block_link`                 | url          | —                                       | Block link         |
| `enable_media_fullWidth`     | checkbox     | false                                   | Full-width media   |
| `enable_text`                | checkbox     | true                                    | Show text overlay  |
| `block_css`                  | text         | —                                       | CSS class          |
| `color`                      | color        | #ffffff                                 | PC text color      |
| `color_mb`                   | color        | #ffffff                                 | Mobile text color  |
| `text_width`                 | range        | 70 (0-100%)                             | PC text width      |
| `text_m_width`               | range        | 100 (0-100%)                            | Mobile text width  |
| `text_alignment_position`    | select       | "vertical-bottom horizontal-left"       | PC text position   |
| `text_alignment`             | select       | "center"                                | PC text alignment  |
| `text_alignment_position_mb` | select       | "mb_vertical-bottom mb_horizontal-left" | Mobile position    |
| `text_alignment_mb`          | select       | "center"                                | Mobile alignment   |
| `image`                      | image_picker | —                                       | PC image           |
| `image_ipad`                 | image_picker | —                                       | iPad image         |
| `image_mb`                   | image_picker | —                                       | Mobile image       |
| `video_url`                  | textarea     | —                                       | Video URL          |
| `video_url_mb`               | textarea     | —                                       | Mobile video URL   |
| `banner_title`               | html         | —                                       | Block banner title |
| `title`                      | html         | —                                       | Block title        |
| `subtitle`                   | html         | —                                       | Block subtitle     |
| `custom_html`                | html         | —                                       | Custom HTML        |
| `additional_content`         | html         | —                                       | Extra content      |

---

## common-media-st

**Purpose:** Media section for product pages with additional product name field, iframe video support, and inline text styling controls.

**Variant of:** `common-media` — adds `product_name`, `iframe_video_url`, inline color/size text controls per block.

**Section settings:** `show_section` (checkbox), `section_css` (text)

**Block type:** `image`

Key additional block settings vs base:

- `product_name` — Product name HTML
- `iframe_video_url` — Embedded iframe video
- Inline text color/size controls for title and subtitle per breakpoint

---

## common-media-sy

**Purpose:** Identical schema to `common-media-st`, used for region-specific tracking (SY store).

**Variant of:** `common-media-st` — same schema, different tracking scripts.

---

## common-media-video

**Purpose:** Video-focused section with title, tips area, and optional iframe modal playback.

**Section settings:** `enable_animated` (checkbox), `section_css` (text), `title` (html)

**Block type:** `block`

| Block Setting                       | Type         | Description                                |
| ----------------------------------- | ------------ | ------------------------------------------ |
| `block_css`                         | text         | CSS class                                  |
| `enable_common_width`               | checkbox     | Use wrapper width                          |
| `is_page_banner`                    | checkbox     | Banner styling                             |
| `tips`                              | html         | Tips content                               |
| `title`                             | html         | Block title                                |
| `subtitle`                          | html         | Block subtitle                             |
| `image` / `ipad_image` / `image_mb` | image_picker | Images                                     |
| `video_url` / `video_url_mb`        | textarea     | Video URLs                                 |
| `iframe_video_label`                | text         | Modal button text (default: "Schau Video") |
| `iframe_video_url`                  | text         | Modal iframe video                         |
| `additional_content`                | html         | Extra content                              |

---

## common-media-for-airstyle-pro-hi

**Purpose:** Enhanced media section with per-block color theming (title/subtitle colors for PC and mobile separately).

**Variant of:** `common-media-st` — adds `is_first_page_banner`, `enable_color_settings`, per-breakpoint `bg_color_pc/m`, `banner_title_color_pc/m`, `title_color_pc/m`, `subtitle_color_pc/m`.

**Section settings:** `show_section` (checkbox), `section_css` (text)

**Block type:** `image`

---

## common-image-layout

**Purpose:** Grid layout for multiple images with text overlays. PC uses CSS grid with configurable column ratios, mobile stacks vertically.

**Section settings:**

| Setting                | Type     | Default | Description               |
| ---------------------- | -------- | ------- | ------------------------- |
| `use_default_size`     | checkbox | true    | Use default sizing        |
| `image_no_move`        | checkbox | false   | Disable image hover       |
| `text_item_relative`   | checkbox | false   | Relative text positioning |
| `section_css`          | text     | —       | CSS class                 |
| `title`                | html     | —       | Section title             |
| `subtitle`             | html     | —       | Section subtitle          |
| `button_text`          | text     | —       | CTA button                |
| `divided_into_count`   | text     | "2-3-3" | PC column ratio           |
| `divided_m_into_count` | text     | —       | Mobile column ratio       |

**Block type:** `text`

Block settings: `block_css`, `image`, `image_ipad`, `image_mb`, `title`, `subtitle`, `custom_html`, `additional_content`

> **Note:** `new-common-image-layout` is the preferred newer version with mobile Swiper support.

---

## common-image-layout-st / common-image-layout-us

**Variant of:** `common-image-layout` — regional variants with identical schema. `-us` version has Shopify presets.

---

## common-image_with_text-st

**Purpose:** Image+text with additional section header controls, inline color settings, and per-block addition content colors.

**Variant of:** `common-image_with_text` — adds `show_header`, `section_title_color`, `section_title_size`, `addition_content_color/color_mb`, `addition_content_alignment` per block.

**Section settings:**

| Setting                          | Type     | Default |
| -------------------------------- | -------- | ------- |
| `section_css`                    | text     | —       |
| `section_css_html`               | html     | —       |
| `bg_color`                       | color    | #ffffff |
| `padding_top` / `padding_bottom` | range    | 0       |
| `show_header`                    | checkbox | false   |
| `section_title`                  | html     | —       |
| `section_title_color`            | color    | #000000 |
| `section_title_size`             | text     | "52"    |
| `show_animated`                  | checkbox | true    |

**Block type:** `block`

Same as base + `image_pad` (iPad image), `image_content` (HTML overlay), `header_html`, `addition_content`, `addition_content_color/color_mb`, `addition_content_alignment`

---

## common-image_with_text-us

**Variant of:** `common-image_with_text-st` — identical schema, adds inline GTM event tracking for US store.

---

## new-common-image_with_text

**Purpose:** Modern image+text with YouTube/Vimeo video support and lightbox modal.

**Variant of:** `common-image_with_text` — adds `video_type` (vimeo/youtube), `youtube_video/youtube_video_mb`, `youtube_open_modal` for lightbox, `show_same_animated`, `content` header field.

**Section settings:** Same as ST variant + `show_same_animated` (checkbox), `content` (html)

**Block type:** `block`

Key additions: `video_type` (select: vimeo/youtube), `youtube_video`, `youtube_video_mb`, `youtube_open_modal` (checkbox)

---

## common-product-swiper-slider

**Purpose:** Product carousel with configurable arrow HTML, title navigation, and outer pagination options.

**Variant of:** `common-product-swiper` — adds `enable_title_naviga`, `enable_pagination_outer`, `swiper_arrow_html_left/right`, `enable_content_whole`, `enable_m_hide`.

**Section settings:**

| Setting                        | Type     | Default  |
| ------------------------------ | -------- | -------- |
| `enable_swiper`                | checkbox | true     |
| `title` / `subtitle`           | html     | —        |
| `section_css`                  | text     | —        |
| `enable_pagination`            | checkbox | true     |
| `enable_arrow`                 | checkbox | true     |
| `arrow_position`               | select   | "bottom" |
| `enable_title_naviga`          | checkbox | false    |
| `swiper_pc_num`                | text     | "4"      |
| `swiper_mb_num`                | text     | "2"      |
| `swiper_arrow_html_left/right` | html     | —        |

**Block type:** `block`

Block settings: `product`, `block_css`, `enable_text_top`, `video_url/video_url_mb`, `bg_image`, `image/image_mb`, `image_content`, `tips`, `title`, `subtitle`, `custom_html`, `additional_content`

---

## common-product-max-swiper

**Purpose:** GSAP ScrollTrigger clip-path reveal carousel. Images progressively reveal via scroll, pinned layout.

**Requires `import_gsap: true`**

**Section settings:** `section_css` (text), `title` (html), `subtitle` (html), `enable_same_height` (checkbox, true), `enable_m_swiper` (checkbox, true)

**Block type:** `text`

Block settings: `block_css`, `image`, `image_mb`, `title` (text), `subtitle` (html), `custom_html`

---

## common-d9-max-swiper

**Purpose:** Three-image progressive clip reveal with scroll-triggered animation. Fixed 3 image slots, PC scroll-pin, mobile swiper fallback.

**Section settings:** `section_css`, `image_1/2/3`, `image_mb_1/2/3`, `title`, `content`, `use_default_width`, `use_new_slider`, `same_height`, `enable_slide_center`

No blocks.

---

## new-common-product-swiper-st

**Purpose:** Advanced product swiper with title navigation sidebar, bottom text container, pin animations, and per-block text/media controls.

**Variant of:** `new-common-product-swiper` — ST variant for single-text gate. Adds `enable_img_text_sep`, `enable_swiper_loop`, `disabled_swiper_mb`, `swiper_speed`, `enable_auto_swiper`, dialog fields per block.

**Section settings:** 35+ settings (core swiper + navigation + pin + animation controls)

**Block type:** `block` — 40+ settings including `enable_text`, `enable_text_before`, `enable_media_fullWidth`, `float_image_content`, dialog fields

---

## new-common-product-swiper-us-st / new-common-product-swiper-us

**Variant of:** `new-common-product-swiper-st` — US store regional variants. Same schema, different mobile navigation behavior and event tracking.

---

## new-common-product-swiper-2026valentine

**Variant of:** `new-common-product-swiper-us` — Valentine 2026 campaign themed variant. Same schema, uses themed CSS classes.

---

## new-common-tabbar

**Purpose:** Modern tabbar with optional mobile dropdown navigation and improved scroll detection.

**Used in:** `product.d30-ultra.json`, `product.f10.json`

**Section settings:**

| Setting                         | Type     | Default       |
| ------------------------------- | -------- | ------------- |
| `enable_header_sticky`          | checkbox | false         |
| `bg_color`                      | color    | #f4f4f3       |
| `product`                       | product  | —             |
| `enable_buy_now`                | checkbox | true          |
| `title`                         | text     | —             |
| `another_btn_text`              | text     | "Add To Cart" |
| `enable_sticky`                 | checkbox | true          |
| `section_css` / `section_css_1` | text     | —             |
| `enable_classname`              | checkbox | false         |
| `enable_scrollshow`             | checkbox | false         |
| `cart_url`                      | url      | —             |
| `enable_m_drop_down_nav`        | checkbox | false         |

**Block type:** `text` (name: "Tabs Item")

| Block Setting | Type | Default    |
| ------------- | ---- | ---------- |
| `text`        | text | "overview" |
| `title`       | html | "overview" |
| `class`       | html | —          |

---

## new-common-tabbar-fix

**Purpose:** Improved version with buffer-based scroll highlighting to prevent jitter during scroll/click sync.

**Variant of:** `new-common-tabbar` — replaces `enable_buy_now` with `show_btn`, adds `custom_btn_event` for custom button actions.

---

## new-common-tabbar-with-btn

**Purpose:** Extended tabbar with custom tab item colors (background, hover, font), button type selection, and GA tracking.

**Variant of:** `new-common-tabbar-fix` — adds `custom_tabbar_color`, `item_bgcolor`, `item_hover_bgcolor`, `item_font_color`, `item_hover_font_color`, `button_type` (select: buy_now/custom).

---

## common-tabbar-item

**Purpose:** Content container paired with tabbar — creates a target div with `id` and `class_name` for tab scroll anchoring.

**Section settings:** `id` (text), `class_name` (text)

No blocks. Utility section — place between content sections to create tab scroll targets.

---

## common-tabbar-item-us-st

**Variant of:** `common-tabbar-item` — US store variant, identical schema.

---

## common-product-featured

**Purpose:** Grid-based featured product cards with optional mobile swiper and hover image effect.

**Section settings:**

| Setting                | Type     | Default |
| ---------------------- | -------- | ------- |
| `section_css`          | text     | —       |
| `section_width`        | range    | 100%    |
| `title` / `text`       | html     | —       |
| `enabled_swiper_mb`    | checkbox | false   |
| `enabled_swiper_arrow` | checkbox | false   |
| `swiper_mb_num`        | number   | 2       |
| `enable_hover_image`   | checkbox | false   |
| `enable_max_width`     | checkbox | true    |
| `enable_same_height`   | checkbox | false   |

**Block type:** `block`

Block settings: `image`, `image_mb`, `title`, `subtitle`, `addition_content`

---

## common-product-featured-us

**Variant of:** `common-product-featured` — adds `enable_animated`, `enable_image_mfg` (image zoom), `row_num` for grid columns, video support (`video_url/video_url_mb`), `custom_html`, `additional_content` per block.

---

## new-common-product-featured

**Purpose:** Redesigned featured cards with inline video on hover, page count display, mobile Swiper pagination.

**Section settings:** `enable_img_video`, `section_css`, `row_num`, `title`, `text`, `enabled_swiper_mb`, `swiper_mb_num`, `enabled_swiper_pagecount`, `enable_arrow`, `custom_html`, `additional_content`

**Block type:** `block`

Block settings: `block_css`, `video_url/video_url_mb`, `image/image_mb`, `image_content`, `title`, `enable_subtitle_text`, `subtitle`, `custom_html`, `additional_content`

---

## common-product-showcase-summer

**Purpose:** Advanced product showcase with pin animation, discount display, countdown timer, custom product pricing, and multiple swiper configs.

**Section settings:** 35+ settings including `enable_swiper`, `enable_pin`, `enable_auto_swiper`, `count_downtime_settings`, `activate_first_product`, `custom_cart_icon`, `change_slide_event`

**Block type:** `block` — 30+ settings including `occupied_width_pc/ipad/m`, pricing, buy buttons, images

---

## common-product-showcase-us

**Variant of:** `common-product-showcase-summer` — US store variant, same schema with simplified code structure.

---

## common-product-item-layout

**Purpose:** Simple grid layout for product items with configurable PC/mobile column count.

**Section settings:** `title` (html), `subtitle` (html), `section_css` (text), `part_pc` (text, "5"), `part_mb` (text, "2")

**Block type:** `item`

Block settings: `title`, `subtitle`, `image`, `image_mb`

---

## new-common-product-item

**Purpose:** Left selector + right grid interactive layout. Clicking left items updates right grid dynamically. Supports learn-more rows.

**Variant of:** `common-product-item` — adds `section_banner_title`, `total_tips`, `isnoeffect`, `left-middle-right-mb`, `show_left_block_title`, `learn_more_row`, `show_learn_more`.

**Block type:** `item` — adds `left_image` per block for left-side thumbnails.

---

## common-product-icon

**Purpose:** Simple icon grid section — lightweight block layout for feature icons with subtitle.

**Section settings:** `section_css`, `section_width` (range), `title`, `text`, `custom_css`

**Block type:** `block`

Block settings: `image`, `image_mb`, `subtitle`

---

## common-product-faq-us

**Purpose:** FAQ with structured data markup and per-block color settings for PC/mobile.

**Variant of:** `common-product-faq` — adds `additional_content`, `enable_color_settings` + 12 color settings (bg/title/subtitle/answer colors for PC and mobile).

---

## common-desc-item

**Purpose:** Simple descriptive text container. Minimal section with just title text.

**Section settings:** `section_css` (text), `title` (text)

No blocks.

---

## common-product-tipstext

**Purpose:** Product tips text blocks — simple titled text items with background color.

**Section settings:** `color_background` (color, #F8F8F8), `section_css` (text)

**Block type:** `text`

Block settings: `block_css`, `title` (text), `text` (html)

---

## new-common-scroll-text

**Purpose:** GSAP-powered parallax scroll animation with synchronized media and text content. Text blocks animate in/out as user scrolls through a pinned video/image background.

**Requires `import_gsap: true`**

**Section settings:**

| Setting                         | Type         | Default |
| ------------------------------- | ------------ | ------- |
| `enable_scroll`                 | checkbox     | true    |
| `section_css` / `section_css_1` | text         | —       |
| `banner_title` / `title`        | html         | —       |
| `custom_html`                   | html         | —       |
| `video_url` / `video_url_mb`    | textarea     | —       |
| `image` / `image_mb`            | image_picker | —       |
| `additional_content`            | html         | —       |
| `show_test_markers`             | checkbox     | false   |

**Block type:** `text`

| Block Setting                         | Type     | Description            |
| ------------------------------------- | -------- | ---------------------- |
| `enable_scrolltop_text`               | checkbox | Pin text at scroll top |
| `enable_media_fullWidth`              | checkbox | Full-width media       |
| `enable_text_before`                  | checkbox | Text before media      |
| `enable_text`                         | checkbox | Show text overlay      |
| `block_css`                           | text     | CSS class              |
| `banner_title` / `title` / `subtitle` | html     | Text content           |
| `enable_media_additional_mb`          | checkbox | Mobile extra content   |
| `custom_html` / `additional_content`  | html     | Custom content         |

---

## new-common-scroll-text-us

**Variant of:** `new-common-scroll-text` — US variant adds `pc_video/mb_video` (video type), `video_url_pre/video_url_mb_pre` for preload, `image_content`, removes `show_test_markers`.

---

## new-common-scroll-text-matrix10

**Variant of:** `new-common-scroll-text-us` — Matrix10 product variant with specialized video rendering and pre-load image parameters.

---

## common-bgz-short

**Purpose:** Image showcase grid — 1 large featured image + up to 2 smaller images with tooltip overlays.

**Section settings:** `section_css` (text), `title` (html), `subtitle` (html)

**Block type:** `block`

Block settings: `image` (image_picker), `tipsdisplay` (checkbox), `tips` (textarea)

---

## common-in-the-box

**Purpose:** Boxed content container for product package contents — single content block with title/text/HTML.

**Section settings:** `section_css` (text), `section_width` (range, 0-100%), `title` (html), `text` (html), `content` (html)

No blocks.

---

## common-item

**Purpose:** Product variant selector — left image gallery, center description, right grid with variant items and tooltips.

**Section settings:** `section_css`, `section_title`, `product_title` (default: "Dreame"), `subtitle`, `color_background` (#f9f9f9), `left_image`, `left_text`, `showsectiontips`, `tips`

**Block type:** `item`

Block settings: `left_image`, `image`, `image_mb`, `title`, `showblocktips`, `tips`

---

## common-left-right-slide

**Purpose:** Two-panel horizontal slide animation on scroll — left and right panels slide in from edges with parallax effect.

**Section settings:** `use_default_width` (checkbox, true), `section_css`, `title`, `subtitle`, `enable_slide` (checkbox, true), `image_01`, `image_02`, `subtitle_01`, `subtitle_02`

No blocks.

---

## common-nav

**Purpose:** Fixed navigation bar with SVG icons and smooth scroll to anchor IDs. Auto-highlights current section on scroll.

**Section settings:** `section_css` (text), `section_css_html` (html)

**Block type:** `nav_item`

| Block Setting | Type | Description                            |
| ------------- | ---- | -------------------------------------- |
| `icon`        | html | SVG icon markup                        |
| `title`       | text | Nav item label (default: "Item Title") |
| `target_id`   | text | Scroll target element ID               |

---

## common-product-countdown

**Purpose:** Real-time countdown timer with configurable labels, Beijing timezone offset.

**Section settings:**

| Setting                              | Type     | Default                            |
| ------------------------------------ | -------- | ---------------------------------- |
| `section_css`                        | text     | —                                  |
| `title` / `subtitle`                 | html     | —                                  |
| `additional_content` / `custom_html` | html     | —                                  |
| `days/hours/minutes/seconds`         | textarea | "Days"/"Hours"/"Minutes"/"Seconds" |
| `countdown_time`                     | text     | "2023/8/22 00:00:00"               |
| `enable_color_settings`              | checkbox | false                              |
| + 8 color settings                   | color    | —                                  |

No blocks.

---

## common-product-filter

**Purpose:** Swiper-based filterable content buttons — clicking a filter button shows/hides content by CSS class.

**Section settings:** `show_style`, `enable_animated`, `is_full_width`, `section_css`, `banner_title`, `title`, `subtitle`, `custom_html`, `swiper_pc/ipad/mb_num` (default: "auto"), `swiper_pc/ipad/mb_gap` (default: "10"), `enable_color_settings` + color/button color settings

**Block type:** `text`

Block settings: `enable_active` (checkbox), `text` (filter name), `text_1` (html content), `filter_classname` (default: "overview")

---

## common-product-popup

**Purpose:** Modal popup triggered by a CSS class selector. Displays layered images and content when trigger element is clicked.

**Section settings:** `section_css`, `section_css_1` (popup trigger class), `title`, `subtitle`, `additional_content`

**Block type:** `block`

Block settings: `block_css`, `image`, `image_mb`, `title`, `subtitle`

---

## common-settings-sy

**Purpose:** Simplified page settings — CSS loading, GSAP, snow effect, video monitoring. No typography controls.

**Variant of:** `common-settings` — stripped-down version without `change_text_settings`, `common_max_width`, `common_section_pbottom`. Adds `enable_new_shopify_video`.

**Section settings:** `page_settings`, `show_snow`, `monitor_video`, `enable_new_shopify_video`, `import_gsap`, `show_not_animated`, `page_css`

No blocks.

---

## new-common-settings

**Purpose:** Advanced page settings with full responsive typography, color theming, 22 product presets, and section padding controls.

**Variant of:** `common-settings` — enhanced version with `enable_color_settings` + 6 color overrides, expanded `current_product` select with 22 options, higher default `common_section_pbottom` (180).

---

## common-video-settings

**Purpose:** Multi-format video player — supports YouTube, MP4, Vimeo with custom controls and popup modal playback.

**Section settings:** `section_css` (text), `title` (html)

**Block type:** `text` (name: "Video Item")

| Block Setting                      | Type         | Description                           |
| ---------------------------------- | ------------ | ------------------------------------- |
| `text`                             | text         | Trigger classname                     |
| `title`                            | html         | Video title                           |
| `image`                            | image_picker | Poster image                          |
| `video`                            | text         | MP4/MOV URL                           |
| `youtube_video`                    | text         | YouTube URL                           |
| `iframe_video_label`               | text         | Button label (default: "Watch Video") |
| `iframe_video_url`                 | text         | Iframe URL                            |
| `youtube_size` / `bg_youtube_size` | text         | Aspect ratio (default: "16-9")        |
| `enable_video_controls`            | checkbox     | Show controls                         |

---

## common-section

**Purpose:** Multi-block product template with 20+ block types (blog, divider, featured_collection, video, recommendations, etc.).

**Section settings:** `product_breadcrumb` (checkbox), `padding_top/bottom` (range), `css_class`, `custom_css`

**Block types:** `blog`, `divider`, `featured_collection`, `video`, `recommendations`, and 15+ more. Each has block-specific settings.

> **Note:** This is a complex product page builder section. Use only when building full product pages.

---

## new-common-spec

**Purpose:** Placeholder section with empty schema — reserved for future use.

No settings, no blocks.

---

## custom-html-sy

**Purpose:** Extended custom HTML container with optional image configuration (10 image slots) and style controls.

**Variant of:** `custom-html` — adds `common_width` (checkbox), `enable_common_style`, `enable_image_config` + `image_1` through `image_10` (image_picker).

---

## new-common-image-layout-us

**Purpose:** Advanced image grid with hover animations, GA4 tracking, pagination, and arrow navigation.

**Variant of:** `new-common-image-layout` — adds `enable_hover_animated_img`, `enable_pagination`, `enable_arrow`, `auto_play` per block, `enable_text_before` per block.

---

# Part 2: 扩展 Section 目录

> Lightweight index of product/page-specific sections. Search here when no Part 1 section fits.
> Each entry: section name + one-line purpose. Read the `.liquid` file for full schema when needed.

---

## Banner / Hero

| Section                                      | Purpose                       |
| -------------------------------------------- | ----------------------------- |
| `2024-ces-banner`                            | CES 2024 event hero banner    |
| `bf-banner`                                  | Black Friday campaign banner  |
| `d30-ultra-banner`                           | D30 Ultra product hero banner |
| `mothers-day-banner` / `mothers-day-banner2` | Mother's Day campaign banners |
| `prime-day-banner`                           | Prime Day sale banner         |
| `shc-banner`                                 | SHC campaign banner           |
| `xmas-banner`                                | Christmas campaign banner     |
| `california-privacy-notice-banner`           | Privacy notice banner         |
| `privacy-policy-banner`                      | Privacy policy banner         |
| `collection-banner`                          | Collection page header banner |
| `product-banner`                             | Product page hero banner      |

## Product Templates & Pages

| Section                                                            | Purpose                                  |
| ------------------------------------------------------------------ | ---------------------------------------- |
| `product-template`                                                 | Main product page template (full layout) |
| `new-product-template`                                             | Modernized product page template         |
| `accessories-product-template`                                     | Accessories product page layout          |
| `amazon-common-product-template`                                   | Amazon-linked product template           |
| `product-amazon-template`                                          | Amazon product variant template          |
| `d10-plus-launch-template`                                         | D10 Plus launch page template            |
| `l10s-ultra-preorder-launch-template`                              | L10S Ultra preorder launch               |
| `l10s-ultra-preorder-template`                                     | L10S Ultra preorder page                 |
| `l20ultra-product-preorder-template` / `l20ultra-product-template` | L20 Ultra product pages                  |
| `featured-product`                                                 | Featured product showcase                |
| `featured-products`                                                | Multiple featured products grid          |
| `featured-col-product`                                             | Featured collection product              |

## Product Detail Sections (by product line)

### D-Series (D9, D10, D20, D30)

| Section                                                               | Purpose                                          |
| --------------------------------------------------------------------- | ------------------------------------------------ |
| `d10-plus-item` / `d10-plus-gen2-channel`                             | D10 Plus product items and channel               |
| `d10s-item`                                                           | D10S product feature items                       |
| `d20-air-plus-image-fade` / `d20-air-plus-title-*`                    | D20 Air Plus animated sections                   |
| `d30-ultra-description` / `d30-ultra-heading` / `d30-ultra-layout`    | D30 Ultra content layout                         |
| `d30-ultra-media` / `d30-ultra-package` / `d30-ultra-pet-care`        | D30 Ultra media/features                         |
| `d30-ultra-scroll-accordion` / `d30-ultra-swiper`                     | D30 Ultra interactions                           |
| `d9-max-gen2-channel` / `d9-max-item` / `d9-max-part-5`               | D9 Max features                                  |
| `dd20-4models-pin` / `dd20-left-right` / `dd20-pin-many-images-white` | DD20 product sections                            |
| `dd20-video-bigger` / `dd20r-*`                                       | DD20R variant sections (media, tabbar, settings) |

### H-Series (H12, H13, H14, H15)

| Section                                                                                   | Purpose                          |
| ----------------------------------------------------------------------------------------- | -------------------------------- |
| `h12-*` (accessories, core-banner, image_with_text, item, part-2~8, pro-\*, spec, swiper) | H12 product page sections        |
| `h13-pro-part-1` / `h13-pro-part-2`                                                       | H13 Pro feature sections         |
| `h14-dual-part1`                                                                          | H14 Dual product section         |
| `h15-mix-scroll`                                                                          | H15 Mix scroll animation section |
| `hair-pocket-1` / `hair-pocket-2` / `hair-pocket-3`                                       | Hair Pocket product sections     |

### L-Series (L10, L20, L40, L50)

| Section                                                                                                                                        | Purpose                          |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
| `l10-ultra-item` / `l10-ultra-part-3`                                                                                                          | L10 Ultra features               |
| `l10s-*` (accessories, custom-clean, floors-shine, img-with-text, plus-channel, pro-\*)                                                        | L10S series sections (20+)       |
| `l20-ultra-accessories` / `l20-ultra-brand`                                                                                                    | L20 Ultra accessories/brand      |
| `l20ultra-*` (animateblock, compare-with, countdown, download, faq, imgwithtext, item, personalize, spec, step, swiper, tabbar, textovervideo) | L20 Ultra product sections (20+) |
| `l40-ultra-part1`                                                                                                                              | L40 Ultra feature section        |

### R-Series & Other Products

| Section                                                                                        | Purpose                   |
| ---------------------------------------------------------------------------------------------- | ------------------------- |
| `r20-part1` ~ `r20-part12` / `r20-item` / `r20-settings`                                       | R20 product page sections |
| `r-series-*` (multiple-image, part-3, sector-3)                                                | R-Series general sections |
| `z30-slim-*` (boom-diagram, common-product-swiper, new-common-product-swiper, vertical-swiper) | Z30 Slim product sections |
| `m12-*` (bgz, item, two-half, vertical-swiper-with-text)                                       | M12 product sections      |
| `mova-m1-item`                                                                                 | Mova M1 product items     |
| `FP10-page`                                                                                    | FP10 product page         |
| `AP10-gold`                                                                                    | AP10 Gold product section |
| `product_f9_redesign`                                                                          | F9 product redesign       |

### X-Series & Specialty

| Section                                                     | Purpose                       |
| ----------------------------------------------------------- | ----------------------------- |
| `x30-part2` / `x30-part5`                                   | X30 product sections          |
| `x50-fixed-image` / `x50-ultra-part1`                       | X50/X50 Ultra sections        |
| `procuct-ultra-product-item`                                | Ultra product item grid       |
| `procuct-x60-ultra-*` (privacy, product-item, spec, swiper) | X60 Ultra sections            |
| `airstyle-pro-channel` / `airstyle-video-list`              | Airstyle Pro product sections |

## Image + Text Layouts

| Section                                                  | Purpose                                |
| -------------------------------------------------------- | -------------------------------------- |
| `product-image_with_text`                                | Product-specific image+text layout     |
| `product-image-with-text-overlay`                        | Image with text overlay on product     |
| `product-col-image-text`                                 | Column image+text for products         |
| `product-bg_image-text` / `l10s-product-bg_image-text`   | Background image with text overlay     |
| `collection-text-image` / `collection-text-image-swiper` | Collection image+text + swiper variant |
| `featured-content` / `featured-info`                     | Featured content/info blocks           |
| `featured-row`                                           | Featured content row layout            |
| `columns-text`                                           | Multi-column text layout               |
| `text-box`                                               | Simple text box container              |
| `html_content`                                           | Raw HTML content block                 |

## Carousel / Swiper

| Section                                                           | Purpose                           |
| ----------------------------------------------------------------- | --------------------------------- |
| `collection-product-swiper` / `collection-product-feature-swiper` | Collection carousels              |
| `new-collection-product-feature-swiper1`                          | Updated collection feature swiper |
| `collection-review-swiper`                                        | Collection review carousel        |
| `custom-product-swiper`                                           | Custom product carousel           |
| `featured-swiper`                                                 | Featured content swiper           |
| `featured-text-slideshow` / `custom-text-slideshow`               | Text slideshow sections           |
| `index-swiper`                                                    | Homepage swiper                   |
| `product-featured-swiper`                                         | Product feature carousel          |
| `product-prime-swiper`                                            | Prime deal product swiper         |
| `product-recommend-swiper`                                        | Product recommendation carousel   |
| `pm20-product-swiper`                                             | PM20 product swiper               |
| `slideshow` / `homepage-slideshow-product`                        | Homepage slideshow variants       |
| `vertical-swiper-with-text`                                       | Vertical scroll swiper with text  |

## Video Sections

| Section                                | Purpose                          |
| -------------------------------------- | -------------------------------- |
| `product-video` / `product-video-text` | Product video with optional text |
| `featured-video`                       | Featured video showcase          |
| `video-scroller`                       | Scroll-triggered video player    |
| `valentines-day-video-list`            | Valentine's Day video collection |

## FAQ / Navigation

| Section                                                         | Purpose                        |
| --------------------------------------------------------------- | ------------------------------ |
| `faq` / `product-faq`                                           | FAQ sections                   |
| `page-faq-new-1` ~ `page-faq-new-4` / `page-faq2` / `page-faq3` | Page FAQ variants with columns |
| `page-troubleshooting`                                          | Troubleshooting FAQ page       |
| `cartoon-f-q`                                                   | Illustrated FAQ section        |
| `quick-jump-bar`                                                | Quick jump anchor navigation   |
| `fixed-top-navigator`                                           | Fixed top navigation bar       |
| `collection-bar`                                                | Collection filter/sort bar     |
| `collection-store-nav`                                          | Store collection navigation    |
| `ip-selector`                                                   | IP/Region selector             |

## Campaign / Promotional

| Section                                                                                | Purpose                        |
| -------------------------------------------------------------------------------------- | ------------------------------ |
| `2024-ces-*` (count-down, half-image, product)                                         | CES 2024 campaign sections     |
| `bf-*` (prduct-single, prduct-single-three, products-grid-2024, products-grid2/3-2024) | Black Friday 2024 sections     |
| `prime-day-*` (press, pride, product-showcase, products1, products2)                   | Prime Day sections             |
| `prime-s-d-part2`                                                                      | Prime September Double section |
| `mothers-day-*` (featured, product)                                                    | Mother's Day sections          |
| `fathers-day`                                                                          | Father's Day promotion         |
| `spring-collection-*` (2023, 2023-2, 2023-4, email) / `spring-collection`              | Spring campaigns               |
| `xmas-*` (product-single-three, product-single)                                        | Christmas product sections     |
| `easter-collection`                                                                    | Easter campaign section        |
| `valentines-day-video-list`                                                            | Valentine's video campaign     |
| `page-dec-promotion-24` (referenced in assets)                                         | December 2024 promotion        |

## Collection / Store

| Section                                                                  | Purpose                         |
| ------------------------------------------------------------------------ | ------------------------------- |
| `collection-template`                                                    | Main collection page template   |
| `collection-one-product`                                                 | Single product in collection    |
| `collection-new-accessories-one`                                         | New accessories collection item |
| `list-collections-template`                                              | Collections list page           |
| `homepage-product-filter`                                                | Homepage product filtering      |
| `homepage-product-showcase`                                              | Homepage product showcase grid  |
| `homepage-tab-products`                                                  | Homepage tabbed product display |
| `featured-collections`                                                   | Featured collections grid       |
| `section-sep-*` (activity-subscription, main-product-list, product-list) | September event sections        |

## Access / Accessories

| Section                                                                | Purpose                   |
| ---------------------------------------------------------------------- | ------------------------- |
| `access-acclist` / `access-acclist-new`                                | Accessories list sections |
| `access-productlist` / `access-productlist-new`                        | Product accessories list  |
| `app-store-*` (accessories, event, list, membership-program, products) | App Store page sections   |

## Product Components

| Section                                                 | Purpose                    |
| ------------------------------------------------------- | -------------------------- |
| `product-specification` / `product-d20-air-plus-spec`   | Product spec tables        |
| `product-tab`                                           | Product detail tabs        |
| `product-review`                                        | Product reviews section    |
| `product-recommendations`                               | AI product recommendations |
| `product-diver`                                         | Product divider            |
| `product-all-text`                                      | Product full text content  |
| `product-app-download` / `page-dreamehome-app-download` | App download sections      |
| `in-the-box-*` (p10, p10pro, t20, t30, z10)             | Product package contents   |
| `package-list`                                          | Package/accessory list     |
| `pc-compare-two-areas`                                  | PC comparison layout       |
| `preorder-benefits`                                     | Preorder benefits section  |
| `extend-warranty`                                       | Extended warranty section  |
| `shipping-info`                                         | Shipping info block        |
| `where-to-buy` / `where-to-buy-container`               | Where to buy sections      |

## Page Components

| Section                                                                        | Purpose                   |
| ------------------------------------------------------------------------------ | ------------------------- |
| `contact` / `contact-container` / `faq-contact`                                | Contact page sections     |
| `newsletter`                                                                   | Newsletter signup         |
| `pop-up-subscribe` / `popup` / `hide-pop-up`                                   | Popup/subscribe sections  |
| `map`                                                                          | Store locator map         |
| `payment-section`                                                              | Payment methods section   |
| `language`                                                                     | Language selector         |
| `user_manual` / `user_manual_more` / `manual-all` / `hsection-manual-download` | Manual/download sections  |
| `honor-list-v3`                                                                | Awards/honors list        |
| `featured-award`                                                               | Award showcase            |
| `featured-blog` / `article-template` / `blog-template`                         | Blog/article sections     |
| `sponsorship-product-grid` / `spon-*` (bgz-short, image_with_text)             | Sponsorship page sections |

## Layout / Global

| Section                                     | Purpose                         |
| ------------------------------------------- | ------------------------------- |
| `header`                                    | Site header/navigation          |
| `footer`                                    | Site footer                     |
| `password-content` / `password-header`      | Maintenance/password page       |
| `section-common-media` / `section-settings` | Legacy wrapper sections         |
| `section-l40-ultra-ae-dark-contrast`        | L40 Ultra dark contrast section |
| `index-media` / `index__html`               | Homepage media/HTML sections    |
| `channel` / `channel-list`                  | Product channel sections        |

## Pagefly / Third-party

| Section                                           | Purpose                    |
| ------------------------------------------------- | -------------------------- |
| `pagefly-home` / `pagefly-section`                | Pagefly page builder       |
| `pf-*` (0466479b, 0754348f, etc.)                 | Pagefly generated sections |
| `shogun-above` / `shogun-below` / `shogun-helper` | Shogun page builder        |
| `judgeme_carousel_section`                        | Judge.me review carousel   |

## P10 Landing

| Section                                                 | Purpose                   |
| ------------------------------------------------------- | ------------------------- |
| `p10-landing-part1` ~ `p10-landing-part8`               | P10 landing page sections |
| `p10-landing-settings` / `p10-landing-bottom-settings`  | P10 landing configuration |
| `p10pro-total` / `in-the-box-p10` / `in-the-box-p10pro` | P10/P10 Pro sections      |
| `t30-neo-specification`                                 | T30 Neo specs             |
