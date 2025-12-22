# GitHub Wiki 网站模板

这是一个简单的GitHub Wiki风格网站模板，您只需添加Markdown文件即可创建自己的Wiki网站。

## 功能特性

- 响应式设计，支持桌面和移动设备
- 文件目录导航
- 页面大纲目录
- GitHub风格的界面设计
- 支持Markdown内容展示

## 如何使用

### 1. 添加您的Markdown文件

将您的Markdown文件放置在网站根目录下。文件名应以 `.md` 结尾。

### 2. 更新文件目录

在 `index.html` 文件中找到文件目录部分（位于 `<aside id="file-sidebar">` 标签内），按照现有格式添加您的文件条目：

```html
<div class="file-item p-2 rounded cursor-pointer flex items-center">
  <i class="far fa-file-alt mr-2 text-info"></i>
  <span>您的文件名.md</span>
</div>
```

### 3. 添加页面内容

在 `index.html` 中找到内容区域（位于 `<div class="prose max-w-none">` 标签内），将您的Markdown内容转换为HTML并添加到此处。

### 4. 更新大纲目录

在 `index.html` 中找到大纲目录部分（位于 `<div class="grid grid-cols-1 md:grid-cols-2 gap-2">` 标签内），按照现有格式添加您的目录条目：

```html
<a href="#section-id" class="toc-link block p-2 rounded">章节标题</a>
```

确保 `href` 属性指向内容中相应章节的ID。

## 自定义样式

您可以根据需要修改以下样式文件：

- `index.html` 中的 `<style>` 标签
- 通过CDN引入的Tailwind CSS和DaisyUI

## 技术栈

- HTML5
- Tailwind CSS
- DaisyUI
- Font Awesome Icons

## 浏览器支持

- Chrome (最新版)
- Firefox (最新版)
- Safari (最新版)
- Edge (最新版)

## 许可证

本项目基于MIT许可证开源，您可以自由使用和修改。
