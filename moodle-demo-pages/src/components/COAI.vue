<script setup>
import COAITile from './COAITile.vue'
import demoList from '../coai.json'

const validatedList = demoList.map (e => {
  let _obj = {
    title: '',
    cover_img: '',
    description: '',
    link: '',
    src_url: '',
    open_ease: '',
    run_url: '',
    asset_url: '',
    environment: [],
    ...e
  }
  _obj.environment = _obj.environment.map(env => {
    return {
      name: '',
      robot: [],
      task: [],
      ...env
    }
  })
  return _obj
})

</script>

<template>
  <div class="coai-list">
    <COAITile v-for="(item, index) in validatedList" :item="item" :index="index"/>
  </div>
</template>

<style scoped>
.coai-list {
  max-width: 1280px;
  margin: 0 auto;
}
</style>
