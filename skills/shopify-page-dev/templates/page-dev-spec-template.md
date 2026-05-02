# Page Development Spec — {页面名称}

> 每次开发新页面前，复制本模板并填写。将此文件和 Figma Frame 链接提供给 Copilot 即可开始开发。

## 基本信息

| 项目              | 值                                |
| ----------------- | --------------------------------- |
| 页面名称          | `page.xxx`                        |
| Template 文件     | `templates/page.xxx.json`         |
| CSS 文件          | `src/styles/xxx.scss`             |
| varScope          | `.xxx`                            |
| PC 设计稿宽度     | 2560px / 1920px（选择一个）       |
| Mobile 设计稿宽度 | 390px / 375px / 750px（选择一个） |

## Figma链接

- PC 设计稿：`粘贴 Figma Frame 链接`
- Mobile 设计稿：`粘贴 Figma Frame 链接`

## 页面结构（从上到下）

> 按设计稿中从上到下的顺序，列出每个区域。每个区域对应 template 中的一个 section。

### 区域 1: {名称，如 "Hero Banner"}

- **设计意图**：（简述该区域的功能/视觉效果）
- **推荐 Section**：`common-media` / `new-common-media` / 其他
- **推荐参考模板**：`product.d10-plus-gen2.json` / 其他（用于查看该 Section 的实际配置示例）
- **交互说明**：（如有特殊交互，在此描述。如 "视频自动播放"、"鼠标悬停放大"等）
- **备注**：

### 区域 2: {名称}

- **设计意图**：
- **推荐 Section**：
- **推荐参考模板**：
- **交互说明**：
- **备注**：

### 区域 3: {名称}

- **设计意图**：
- **推荐 Section**：
- **推荐参考模板**：
- **交互说明**：
- **备注**：

<!-- 按需添加更多区域 -->

## 特殊交互与动画

> 描述设计中的复杂交互效果，AI 无法仅从截图理解的部分。

| 区域         | 交互类型 | 详细描述                                                     |
| ------------ | -------- | ------------------------------------------------------------ |
| 例：Hero     | 滚动视频 | "用户向下滚动时，视频从30%宽度展开到100%，使用ScrollTrigger" |
| 例：特性展示 | Tab切换  | "点击Tab标签切换下方内容，Tab栏吸顶"                         |
| 例：产品卡片 | 轮播     | "PC端显示4张卡片，可左右滑动切换"                            |

## 图片资源说明

> 标注需要切图的图片位置和命名约定

| 区域        | 图片描述    | 命名                  | 尺寸      |
| ----------- | ----------- | --------------------- | --------- |
| Hero Banner | 主背景图 PC | `xxx-hero-01-pc.webp` | 2560×1200 |
| Hero Banner | 主背景图 MB | `xxx-hero-01-mb.webp` | 390×600   |

## 其他说明

> 任何 AI 需要知道但以上未涵盖的信息（如特殊字体、第三方脚本、SEO 要求等）

- ***

## 快速参考：Section 映射

| 设计区域类型                     | 推荐 Section                                          | 参考模板                         |
| -------------------------------- | ----------------------------------------------------- | -------------------------------- |
| Hero Banner (大图/视频+文字叠加) | `common-media` / `new-common-media`                   | `product.h12-pro-flexreach.json` |
| 图文交替 (图左文右/图右文左)     | `common-image_with_text`                              | `product.d9-max-gen2.json`       |
| 产品卡片轮播                     | `common-product-swiper` / `new-common-product-swiper` | `product.d10-plus-gen2.json`     |
| Tab 导航栏                       | `common-tabbar` / `new-common-tabbar`                 | `product.f10.json`               |
| FAQ 手风琴                       | `common-product-faq`                                  | `collection.air-purifier.json`   |
| 滚动视频展开                     | `common-scroll-video`                                 | `product.f10.json`               |
| 产品参数规格                     | `common-spec`                                         | `product.d10-plus-gen2.json`     |
| 两列分栏图                       | `common-bgz`                                          | `product.d9-max.json`            |
| 图片网格/多列                    | `new-common-image-layout`                             | `collection.air-purifier.json`   |
| 用户评价轮播                     | `common-review-swiper`                                | `index.json`                     |
| 产品对比                         | `common-product-compare`                              | `product.d10-plus-gen2.json`     |
| 首页幻灯片                       | `new-slideshow`                                       | `index.json`                     |
| 自由 HTML                        | `custom-html`                                         | `page.2025-presale.json`         |
| 产品展示+网格                    | `common-product-showcase`                             | `collection.store.json`          |
