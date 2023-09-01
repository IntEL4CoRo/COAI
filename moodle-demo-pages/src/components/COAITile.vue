<script setup>
import { ref, computed } from 'vue'

const props = defineProps({
  item: {
    type: Object,
    required: true
  },
  index: {
    type: Number,
    required: true
  }
})

let selectedEnv = props.item.environment.length !== 0
  ? ref(props.item.environment[0].name)
  : undefined

let selectedRob = props.item.environment.length !== 0 && props.item.environment[0].robot.length !== 0
  ? ref(props.item.environment[0].robot[0])
  : undefined

let selectedTask = props.item.environment.length !== 0 && props.item.environment[0].task.length !== 0
  ? ref(props.item.environment[0].task[0])
  : undefined

const envObj = computed(() => {
  let newVal = props.item.environment.length !== 0
    ? props.item.environment.find(e => e.name === selectedEnv.value)
    : undefined
  if (selectedRob && !~newVal.robot.indexOf(selectedRob.value)) {
    selectedRob.value = newVal.robot[0]
  }
  if (selectedTask && !~newVal.task.indexOf(selectedTask.value)) {
    selectedTask.value = newVal.task[0]
  }
  return newVal
})

const composedUrl = computed(() => {
  let env = selectedEnv && selectedEnv.value ? `&coaienv=${selectedEnv.value}` : ''
  let rob = selectedRob && selectedRob.value ? `&coairob=${selectedRob.value}` : ''
  let task = selectedTask && selectedTask.value ? `&coaitask=${selectedTask.value}` : ''
  return `${env}${rob}${task}`
})

function runCode(event) {
  window.open(event.target.href, '_blank', 'width=1280,height=720');
  return false;
}

</script>

<template>
  <div class="card row mb-3">
    <div class="row">
      <div class="col-md-3">
        <img :src="item.cover_img" class="card-img" alt="{{ item.title }}">
      </div>
      <div class="col-md-9">
        <div class="card-body">
          <h5 class="card-title">
            <a class="font-weight-bold" :href="item.link" target="_blank">{{ item.title }}</a>
          </h5>
          <p class="card-text">{{ item.description }}</p>
          <div class="row">
            <div class="env-select" v-if="item.environment && !!item.environment.length">
              <div class="form-floating mb-3" v-if="item.environment.length > 1">
                <select class="form-select text-capitalize" :id="'environmentSelect' + index" aria-label="Environment"
                  v-model="selectedEnv">
                  <option class="text-capitalize" v-for="env in item.environment" :value="env.name"
                    :selected="item.environment.name === selectedEnv">{{ env.name }}</option>
                </select>
                <label :for="'environmentSelect' + index">Selected Environment</label>
              </div>
              <div class="form-floating mb-3" v-if="envObj && envObj.robot.length !== 0">
                <select class="form-select text-capitalize" :id="'robotSelect' + index" aria-label="Robot"
                  v-model="selectedRob">
                  <option class="text-capitalize" v-for="rob in envObj.robot" :value="rob"
                    :selected="selectedRob === rob">{{ rob }}</option>
                </select>
                <label :for="'robotSelect' + index">Selected Robot</label>
              </div>
              <div class="form-floating mb-3" v-if="envObj && envObj.task.length !== 0">
                <select class="form-select text-capitalize" :id="'taskSelect' + index" aria-label="Task"
                  v-model="selectedTask">
                  <option class="text-capitalize" v-for="task in envObj.task" :value="task"
                    :selected="selectedTask === task">{{ task }}</option>
                </select>
                <label :for="'taskSelect' + index">Selected Task</label>
              </div>
            </div>
            <div class="mb-3">
              <a :href="composedUrl" @click.prevent="runCode($event)" class="btn btn-primary">Run Code</a>
              <a :href="item.open_ease" target="_blank" class="btn btn-secondary openease">Experimental Data</a>
            </div>
            <div>
              <a :href="item.src_url" target="_blank" class="card-link">Source Code</a>
              <a :href="item.asset_url" target="_blank" class="card-link">Assets</a>
              <a :href="item.videos" target="_blank" class="card-link">Videos</a>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<style scoped>
.env-select {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}

.form-floating {
  width: 48%;
}

.openease {
  margin-left: 1rem;
}

.card-img {
  height: 100%;
  min-height: 150px;
  object-fit: contain;
}
</style>
