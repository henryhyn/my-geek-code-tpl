<template lang='pug'>
  section
    ul.list-inline.vskipp
      li: el-button(type='primary' icon='el-icon-plus' @click='createHandler') 新增
      li: el-button(type='primary' icon='el-icon-refresh' @click='reload' :loading='${simpleNamePlural?uncap_first}.loading') 刷新
    div(v-loading='${simpleNamePlural?uncap_first}.loading')
      ${simpleName?uncap_first}-card.card-inline(v-for='item in ${simpleNamePlural?uncap_first}.list' :key='item.id' :data='item' @edit='editHandler' @delete='deleteHandler')
      el-pagination(:total='${simpleNamePlural?uncap_first}.total' :current-page='${simpleNamePlural?uncap_first}.page' :page-size='${simpleNamePlural?uncap_first}.pageSize' @current-change='handleCurrentChange' @size-change='handleSizeChange' layout='total, sizes, prev, pager, next, jumper')
    el-dialog(:title='formTitle' :visible.sync='formVisible')
      el-form(:model='${simpleNamePlural?uncap_first}.instance' :rules='${simpleNamePlural?uncap_first}.rules' ref='modal' label-width='85px' label-suffix=':')
        el-form-item(prop='name' label='${simpleName}名称')
          el-input(v-model='${simpleNamePlural?uncap_first}.instance.name')
      div(slot='footer')
        el-button(@click='formVisible=false') 取消
        el-button(@click='saveHandler' type='primary') 确定
</template>

<script>
  import {mapState, mapMutations, mapActions} from 'vuex';
  import {page} from 'hui-vue';
  import crud from '@/mixins/crud';
  import ${simpleName}Card from './${simpleName}Card';

  export default {
    data () {
      return {
        formVisible: false,
        formTitle: ''
      };
    },

    mixins: [page, crud],

    components: {${simpleName}Card},

    computed: {
      ...mapState(['${simpleNamePlural?uncap_first}'])
    },

    methods: {
      ...mapMutations('${simpleNamePlural?uncap_first}', ['newInstance']),
      ...mapActions('${simpleNamePlural?uncap_first}', ['getListByPage', 'getInstanceById', 'save', 'delete']),

      createHandler () {
        this.newInstance();
        this.formTitle = '新增${simpleName}';
        this.formVisible = true;
      },

      editHandler (id) {
        this.getInstanceById({
          id,
          cb: () => {
            this.formTitle = '编辑${simpleName}';
            this.formVisible = true;
          }
        });
      },

      deleteHandler (id) {
        this.delete({id, cb: this.getListByPage});
      }
    }
  };
</script>
