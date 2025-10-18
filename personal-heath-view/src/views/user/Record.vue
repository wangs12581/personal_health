<template>
    <div>
        <div style="padding: 0 50px;">
            <div>
                <p style="font-size: 24px;padding: 10px 0;font-weight: bolder;">
                    <span @click="goBack" style="cursor: pointer;display: inline-block;padding: 0 20px 0 0;">
                        <i class="el-icon-arrow-left"></i>
                        返回首页
                    </span>
                    健康记录
                </p>
            </div>
        </div>
        <div style="height: 6px;background-color: rgb(248, 248, 248);"></div>
        <div style="padding: 10px 50px;">
            <el-row>
                <el-col :span="6" style="border-right: 1px solid #f1f1f1;min-height: calc(100vh - 250px);">
                    <el-tabs v-model="activeName" @tab-click="handleClick" style="margin-right: 40px;">
                        <el-tab-pane label="全局项目" name="first"></el-tab-pane>
                        <el-tab-pane label="我的项目" name="second"></el-tab-pane>
                    </el-tabs>
                    <div style="padding: 20px 0 30px 0;">
                        <span @click="addModel"
                            style="cursor: pointer;padding: 10px 20px;background-color: #000;border-radius: 5px;color: #fff;">
                            新增项目
                            <i class="el-icon-right"></i>
                        </span>
                    </div>
                    <div style="display: flex; flex-wrap: wrap; align-items: center; gap: 10px;">
                        <span style="margin-right: 10px;">配置名</span>
                        <el-input 
                            style="width: 148px;" 
                            v-model="userHealthModel.name" 
                            placeholder="输入处" 
                            clearable
                            @clear="handleFilterClear">
                        </el-input>
                        <el-button 
                            class="customer"
                            style="background-color: rgb(43, 121, 203); border: none;" 
                            type="primary"
                            @click="searModel">
                            搜索
                        </el-button>
                    </div>

                    <div
                        style="padding: 10px 6px;margin-right: 40px;height: 500px;overflow-y: scroll;overflow-x: hidden;">
                        <div @click="modelSelected(model)" class="item-model" v-for="(model, index) in modelList"
                            :key="index">
                            <el-tooltip class="item" effect="dark" :content="'该项配置【' + model.name + '】，点击即可选中'"
                                placement="bottom">
                                <el-row style="padding: 20px 0;">
                                    <el-col :span="4">
                                        <img :src="model.cover" style="width: 50px;height: 50px;margin-top: 5px;">
                                    </el-col>
                                    <el-col :span="20">
                                        <div style="padding: 0 10px;">
                                            <div style="font-size: 24px;font-weight: bolder;">{{ model.name }}</div>
                                            <div style="font-size: 14px;margin-top: 5px;">
                                                <span>{{ model.unit }}</span>
                                                <span style="margin-left: 10px;">{{ model.symbol }}</span>
                                                <span @click="updateModel(model)" v-if="!model.isGlobal"
                                                    style="margin-left: 10px;color: #333;">修改</span>
                                                <span @click="deleteModel(model)" v-if="!model.isGlobal"
                                                    style="margin-left: 10px;color: red;">删除</span>
                                            </div>
                                        </div>
                                    </el-col>
                                </el-row>
                            </el-tooltip>
                        </div>
                    </div>
                </el-col>
                <el-col :span="18">
                    <div style="padding: 0 150px;box-sizing: border-box;">
                        <div style="padding: 15px 0;font-size:24px;">
                            数据录入面板
                            <span @click="clearData" style="font-size: 14px;margin-left: 20px;">重置</span>
                        </div>
                        <el-row>
                            <el-row v-if="selectedModel.length === 0">
                                <el-empty description="快选中模型记录吧"></el-empty>
                            </el-row>
                            <el-row>
                                <el-col :span="12" v-for="(model, index) in selectedModel" :key="index">
                                    <h3>{{ model.name }}({{ model.unit }})</h3>
                                    <input type="text" v-model="model.value" class="input-model"
                                        :placeholder="'正常值范围：' + model.valueRange">
                                </el-col>
                            </el-row>
                        </el-row>

                    </div>
                    <div style="padding: 50px 150px;">
                        <span @click="toRecord"
                            style="cursor: pointer;padding: 10px 20px;background-color: #000;border-radius: 5px;color: #fff;">
                            立即记录
                            <i class="el-icon-right"></i>
                        </span>
                    </div>
                </el-col>
            </el-row>
        </div>

        <!-- BMI 悬浮球（可拖拽） -->
        <div 
            class="bmi-float-ball" 
            @mousedown.prevent="startDrag"
            @click.prevent="toggleBmiWindow">
            <span class="bmi-label">BMI</span>
        </div>

        <!-- BMI 计算器窗口 -->
        <div v-if="showBmiWindow" class="bmi-window" @click.stop>
            <p class="bmi-title">BMI 健康指标计算器</p>
            <div class="bmi-inputs">
                <el-input 
                    v-model="bmiData.height" 
                    placeholder="请输入身高（cm）" 
                    size="small"
                    type="number"
                ></el-input>
                <el-input 
                    v-model="bmiData.weight" 
                    placeholder="请输入体重（kg）" 
                    size="small"
                    type="number"
                ></el-input>
            </div>
            <div class="bmi-actions">
                <el-button size="small" type="primary" @click="calcBmi">计算</el-button>
                <el-button size="small" type="success" @click="copyBmi" :disabled="!bmiData.result">复制</el-button>
            </div>
            <div v-if="bmiData.result" class="bmi-result">
                <p><strong>BMI：{{ bmiData.result }}</strong></p>
                <p>{{ bmiData.comment }}</p>
            </div>
        </div>

        <el-dialog :show-close="false" :visible.sync="dialogUserOperaion" width="26%">
            <div slot="title">
                <p class="dialog-title">{{ !isOperation ? '健康模型新增' : '健康模型修改' }}</p>
            </div>
            <div style="padding:0 20px;">
                <p>*图标</p>
                <el-row style="margin-top: 10px;">
                    <el-upload class="avatar-uploader" action="/api/personal-heath/v1.0/file/upload"
                        :show-file-list="false" :on-success="handleAvatarSuccess">
                        <img v-if="data.cover" :src="data.cover" style="height: 64px;width: 64px;">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-row>
                <el-row style="padding: 0 10px 0 0;">
                    <p><span class="modelName">*配置名</span></p>
                    <input class="input-title" v-model="data.name" placeholder="请输入">
                </el-row>
                <el-row style="padding: 0 10px 0 0;">
                    <p style="font-size: 12px;padding: 3px 0;">
                        <span class="modelName">*单位</span>
                    </p>
                    <input class="input-title" v-model="data.unit" placeholder="请输入">
                </el-row>
                <el-row style="padding: 0 10px 0 0;">
                    <p style="font-size: 12px;padding: 3px 0;">
                        <span class="modelName">*符号</span>
                    </p>
                    <input class="input-title" v-model="data.symbol" placeholder="请输入">
                </el-row>
                <el-row style="padding: 0 20px 0 0;">
                    <p style="font-size: 12px;padding: 3px 0;">
                        <span class="modelName">*阈值（格式：最小值,最大值）</span>
                    </p>
                    <input class="input-title" v-model="data.valueRange" placeholder="请输入">
                </el-row>
                <el-row style="padding: 0 10px 0 0;">
                    <p style="font-size: 12px;padding: 3px 0;">
                        <span class="modelName">*简介</span>
                    </p>
                    <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 3 }" placeholder="简介"
                        v-model="data.detail">
                    </el-input>
                </el-row>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button size="small" v-if="!isOperation" style="background-color: rgb(43, 121, 203);border: none;"
                    class="customer" type="info" @click="addOperation">新增</el-button>
                <el-button size="small" v-else style="background-color: rgb(43, 121, 203);border: none;"
                    class="customer" type="info" @click="updateOperation">修改</el-button>
                <el-button class="customer" size="small" style="background-color: rgb(241, 241, 241);border: none;"
                    @click="cannel()">取消</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import Logo from '@/components/Logo';
export default {
    components: { Logo },
    data() {
        return {
            data: { cover: '' },
            userInfo: {},
            modelList: [],
            activeName: 'first',
            userHealthModel: { isGlobal: true },
            dialogUserOperaion: false,
            isOperation: false,
            userId: null,
            selectedModel: [],

            // BMI 相关状态
            bmiData: {
                height: '',
                weight: '',
                result: '',
                comment: ''
            },
            showBmiWindow: false,

            // 拖拽相关
            isPointerDown: false,
            dragMoved: false,
            startPos: { x: 0, y: 0 },
            originPos: { left: 0, top: 0 },
        };
    },
    created() {
        this.getUserInfo();
        this.getAllModelConfig();
        this.getUser();
    },
    beforeDestroy() {
        // 清理全局事件监听
        document.removeEventListener('click', this.closeBmiWindow);
        document.removeEventListener('mousemove', this.onDrag);
        document.removeEventListener('mouseup', this.endDrag);
    },
    methods: {
        async clearData() {
            const confirmed = await this.$swalConfirm({
                title: "重置数据？",
                text: `重置之后需要重新输入,是否继续`,
                icon: 'warning',
            });
            if (confirmed) {
                this.selectedModel = [];
            }
        },
        cannel(){
            this.data = {};
            this.dialogUserOperaion = false;
            this.isOperation = false;
            this.cover = '';
        },
        updateOperation() {
            this.$axios.put('/health-model-config/update', this.data).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.dialogUserOperaion = false;
                    this.isOperation = false;
                    this.data = {};
                    this.$swal.fire({
                        title: '模型修改',
                        text: '模型修改成功',
                        icon: 'success',
                        showConfirmButton: false,
                        timer: 1000,
                    });
                    this.getAllModelConfig();
                }
            })
        },
        updateModel(model) {
            this.data = model;
            this.dialogUserOperaion = true;
            this.isOperation = true;
        },
        async deleteModel(model) {
            const confirmed = await this.$swalConfirm({
                title: '删除模型【' + model.name + "】",
                text: `删除后不可恢复，是否继续？`,
                icon: 'warning',
            });
            if (confirmed) {
                const ids = [];
                ids.push(model.id);
                this.$axios.post('/health-model-config/batchDelete', ids).then(response => {
                    const { data } = response;
                    if (data.code === 200) {
                        this.$swal.fire({
                            title: '模型删除',
                            text: '模型删除成功',
                            icon: 'success',
                            showConfirmButton: false,
                            timer: 1000,
                        });
                        this.getAllModelConfig();
                        this.selectedModel = this.selectedModel.filter(entity => entity.id !== model.id);
                    }
                })
            }
        },
        goBack() {
            this.$router.push('/user');
        },
        toRecord() {
            const userHealths = this.selectedModel.map(entity => ({
                healthModelConfigId: entity.id,
                value: entity.value
            }));
            this.$axios.post('/user-health/save', userHealths).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.$notify({
                        title: '记录操作',
                        message: '记录成功',
                        type: 'success'
                    });
                    setTimeout(() => {
                        this.$router.push('/user');
                    }, 2000)
                }
            })
        },
        modelSelected(model) {
            const saveFlag = this.selectedModel.find(entity => entity.id === model.id);
            if (!saveFlag) {
                this.selectedModel.push(model);
            }
        },
        searModel() {
            this.getAllModelConfig();
        },
        handleFilterClear() {
            this.userHealthModel.name = '';
            this.getAllModelConfig();
        },
        handleAvatarSuccess(res, file) {
            if (res.code !== 200) {
                this.$message.error(`健康模型封面上传异常`);
                return;
            }
            this.$message.success(`健康模型封面上传成功`);
            this.data.cover = res.data;
        },
        getUser() {
            const userInfo = sessionStorage.getItem('userInfo');
            const entity = JSON.parse(userInfo);
            this.userId = entity.id;
        },
        async addOperation() {
            try {
                this.data.userId = this.userId;
                const response = await this.$axios.post('/health-model-config/save', this.data);
                this.$message[response.data.code === 200 ? 'success' : 'error'](response.data.msg);
                if (response.data.code === 200) {
                    this.dialogUserOperaion = false;
                    this.getAllModelConfig();
                    this.data = {};
                }
            } catch (error) {
                console.error('提交表单时出错:', error);
                this.$message.error('提交失败，请稍后再试！');
            }
        },
        addModel() {
            this.dialogUserOperaion = true;
        },
        handleClick(tab, event) {
            this.userHealthModel = {};
            if (this.activeName === 'first') {
                this.userHealthModel.isGlobal = true;
            } else {
                const userInfo = sessionStorage.getItem('userInfo');
                const entity = JSON.parse(userInfo);
                this.userHealthModel.userId = entity.id;
            }
            this.getAllModelConfig();
        },
        getAllModelConfig() {
            this.$axios.post('/health-model-config/query', this.userHealthModel).then(response => {
                const { data } = response;
                if (data.code === 200) {
                    this.modelList = data.data;
                }
            });
        },
        getUserInfo() {
            const userInfo = sessionStorage.getItem('userInfo');
            this.userInfo = JSON.parse(userInfo);
        },

        // ---------------- BMI 功能 ----------------
        toggleBmiWindow() {
            // 如果刚完成拖拽，忽略此次点击（防止拖动后误触）
            if (this.dragMoved) {
                // 保持标记短时间内有效，避免误判
                setTimeout(() => { this.dragMoved = false; }, 50);
                return;
            }

            this.showBmiWindow = !this.showBmiWindow;

            if (this.showBmiWindow) {
                // 把 document 点击监听放到下一个事件循环，避免与当前 click 冲突
                setTimeout(() => {
                    document.addEventListener('click', this.closeBmiWindow);
                }, 0);
            } else {
                document.removeEventListener('click', this.closeBmiWindow);
            }
        },
        closeBmiWindow() {
            this.showBmiWindow = false;
            document.removeEventListener('click', this.closeBmiWindow);
        },
        calcBmi() {
            const h = parseFloat(this.bmiData.height);
            const w = parseFloat(this.bmiData.weight);
            if (!h || !w || isNaN(h) || isNaN(w) || h <= 0) {
                this.$message.warning('请输入合法的身高和体重！');
                return;
            }
            const bmi = (w / Math.pow(h / 100, 2));
            const bmiStr = bmi.toFixed(2);
            this.bmiData.result = bmiStr;
            if (bmi < 18.5) this.bmiData.comment = '偏瘦';
            else if (bmi < 24) this.bmiData.comment = '正常';
            else if (bmi < 28) this.bmiData.comment = '超重';
            else this.bmiData.comment = '肥胖';
        },
        copyBmi() {
            const text = this.bmiData.result || '';
            if (!text) {
                this.$message.warning('无可复制的 BMI 值');
                return;
            }
            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(text).then(() => {
                    this.$message.success('BMI 数值已复制');
                }).catch(() => {
                    this.fallbackCopy(text);
                });
            } else {
                this.fallbackCopy(text);
            }
        },
        fallbackCopy(text) {
            const textarea = document.createElement('textarea');
            textarea.value = text;
            textarea.style.position = 'fixed';
            textarea.style.left = '-9999px';
            document.body.appendChild(textarea);
            textarea.select();
            try {
                document.execCommand('copy');
                this.$message.success('BMI 数值已复制');
            } catch (err) {
                this.$message.error('复制失败，请手动复制');
            }
            document.body.removeChild(textarea);
        },

        // -------- 拖拽实现（更健壮） --------
        startDrag(e) {
            // 准备拖拽：记录起点、元素当前位置，绑定全局移动与结束事件
            this.isPointerDown = true;
            this.dragMoved = false;
            this.startPos.x = e.clientX;
            this.startPos.y = e.clientY;

            const ball = document.querySelector('.bmi-float-ball');
            const rect = ball.getBoundingClientRect();
            // 记录原始 left/top
            this.originPos.left = rect.left;
            this.originPos.top = rect.top;

            // 固定到绝对 left/top，清除 right/bottom，以便我们设置 left/top 移动
            ball.style.left = `${rect.left}px`;
            ball.style.top = `${rect.top}px`;
            ball.style.right = 'auto';
            ball.style.bottom = 'auto';

            // 全局监听（document），确保拖拽在移动到外部也能响应
            document.addEventListener('mousemove', this.onDrag);
            document.addEventListener('mouseup', this.endDrag);
        },
        onDrag(e) {
            if (!this.isPointerDown) return;
            const dx = e.clientX - this.startPos.x;
            const dy = e.clientY - this.startPos.y;

            // 细微移动不算拖拽
            if (!this.dragMoved && (Math.abs(dx) > 3 || Math.abs(dy) > 3)) {
                this.dragMoved = true;
            }

            const ball = document.querySelector('.bmi-float-ball');
            if (!ball) return;

            let newLeft = this.originPos.left + dx;
            let newTop = this.originPos.top + dy;

            // 限制在窗口内
            const maxLeft = window.innerWidth - ball.offsetWidth;
            const maxTop = window.innerHeight - ball.offsetHeight;
            newLeft = Math.min(Math.max(0, newLeft), maxLeft);
            newTop = Math.min(Math.max(0, newTop), maxTop);

            ball.style.left = `${newLeft}px`;
            ball.style.top = `${newTop}px`;
        },
        endDrag() {
            // 结束拖拽，移除全局监听
            this.isPointerDown = false;
            document.removeEventListener('mousemove', this.onDrag);
            document.removeEventListener('mouseup', this.endDrag);

            // 保持 dragMoved 在短时间内为 true，以阻止紧接着的 click 触发
            setTimeout(() => { this.dragMoved = false; }, 100);
        }
    },
};
</script>

<style scoped lang="scss">
.item-model:hover {
    cursor: pointer;
    background-color: #fafafa;
    border-radius: 5px;
}

.item-model{
    padding: 8px;
    box-sizing: border-box;
}

.input-model {
    font-size: 20px;
    box-sizing: border-box;
    font-weight: bold;
    padding: 20px;
    user-select: none;
    border-radius: 5px;
    border: none;
    outline: none;
    background-color: #f1f1f1;
    height: 50px;
    width: 85%;
}

/* BMI 悬浮球样式 */
.bmi-float-ball {
  position: fixed;
  right: 30px;
  bottom: 40px;
  width: 60px;
  height: 60px;
  background-color: #409EFF;
  color: #fff;
  font-weight: 700;
  font-size: 14px;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0 6px 16px rgba(0,0,0,0.18);
  cursor: grab;
  z-index: 2000;
  transition: transform 0.15s, background-color 0.15s;
  user-select: none;
}
.bmi-float-ball:active { cursor: grabbing; }
.bmi-float-ball:hover {
  transform: scale(1.05);
  background-color: #66b1ff;
}
.bmi-label {
  color: #fff;
  font-weight: 700;
  letter-spacing: 0.6px;
}

/* BMI 窗口 */
.bmi-window {
  position: fixed;
  right: 100px;
  bottom: 120px;
  width: 280px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 8px 28px rgba(0,0,0,0.18);
  padding: 16px;
  z-index: 2100;
  animation: fadeIn 0.16s ease;
}
.bmi-title {
  font-weight: 700;
  font-size: 16px;
  text-align: center;
  margin-bottom: 10px;
  color: #333;
}
.bmi-inputs {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 10px;
}
.bmi-actions {
  display: flex;
  justify-content: space-around;
  margin-bottom: 10px;
}
.bmi-result {
  text-align: center;
  font-size: 14px;
  color: #666;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(6px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
