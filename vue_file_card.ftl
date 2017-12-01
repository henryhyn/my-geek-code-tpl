<template lang='pug'>
  el-card
    h2 {{data.name || data.title}}
</template>

<script>
  export default {
    props: ['data']
  }
</script>