六、如果你“心理上不舒服”，可以做 2 个小优化（可选）
✅ 优化 1：明确指定首页（推荐）

在 index.html 里加一行：

<script>
  window.$docsify = {
    name: 'Bear Wiki',
    homepage: 'README.md',   // 👈 关键
    loadSidebar: true,
    subMaxLevel: 2
  }
</script>


👉 作用：
Docsify 一启动就知道首页是谁，减少 404 闪现概率
