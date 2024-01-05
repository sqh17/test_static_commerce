import prompt from '@ohos.promptAction'
import router from '@ohos.router'
import CommonConstants from '../CommonConstants'

@Extend(TextInput)
function inputStyle(){  // 输入文本框样式
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor($r('app.color.background'))
  .width(CommonConstants.FULL_PARENT)
  .padding({left: CommonConstants.INPUT_PADDING_LEFT})
  .margin({top: $r('app.float.input_margin_top')})
}

// Line组件的自定义样式扩展
@Extend(Line)
function lineStyle() {
  .width(CommonConstants.FULL_PARENT) // 宽度为父组件的100%
  .height($r('app.float.line_height')) // 高度
  .backgroundColor($r('app.color.line_color')) // 背景颜色
}

// Text组件的蓝色文本样式
@Extend(Text)
function blueTextStyle() {
  .fontColor($r('app.color.login_blue_text_color')) // 字体颜色
  .fontSize($r('app.float.small_text_size')) // 字体大小
  .fontWeight(FontWeight.Medium) // 字体粗细
}
@Entry
@Component
struct Login{
  @State account: string = ''
  @State password: string = ''
  @State isShowProgress: boolean = false
  private timeOutId:number = -1
  login(): void{
    if (this.account === ''){
      prompt.showToast({  // 开启一个确认的弹层
        message: $r('app.string.account_empty_tips')
      })

    }else if(this.password === ''){
      prompt.showToast({  // 开启一个确认的弹层
        message: $r('app.string.password_empty_tips')
      })
    }else{
      this.isShowProgress = true

      if (this.timeOutId === -1){
        // 设置一个定时器，定时两秒
        this.timeOutId = setTimeout( ()=>{
          // 2秒之后执行的函数
          this.isShowProgress = false
          this.timeOutId = -1
          // 页面跳转
          router.replaceUrl({
            url: "pages/Index/Index",
            params: {
              sendMsg: this.account + ''
            }
          })  // 目标页面会替换当前页，并销毁当前页。
        }, CommonConstants.LOGIN_DELAY_TIME)
      }
    }
  }

  aboutToDisappear(){
    // 取消定时器
    clearTimeout(this.timeOutId)
    this.timeOutId = -1

  }
  build(){
    Column(){
      Image($r('app.media.logo'))
        .width($r('app.float.logo_image_size'))
        .height($r('app.float.logo_image_size'))
        .margin({
          top: $r('app.float.logo_margin_top'),
          bottom: $r('app.float.logo_margin_bottom')
        })

      Text($r('app.string.login_page'))
        .fontColor($r('app.color.title_text_color'))
        .fontSize($r('app.float.page_title_text_size'))
        .fontWeight(FontWeight.Medium)

      Text($r('app.string.login_more'))
        .fontSize($r('app.float.normal_text_size'))
        .fontColor($r('app.color.login_more_text_color'))
        .margin({
          top: $r('app.float.login_more_margin_top'),
          bottom: $r('app.float.login_more_margin_bottom')
        })
      // 账号输入框
      TextInput({
        placeholder:$r('app.string.account')
      })
        .type(InputType.Number)
        .maxLength(CommonConstants.INPUT_ACCOUNT_LENGTH)
        .inputStyle()
        .onChange(val=>{
          this.account = val
        })

      Line()
        .lineStyle() // 账号输入框下面的一条线
      // 密码输入框
      TextInput({
        placeholder:$r('app.string.password')
      })
        .type(InputType.Password)
        .maxLength(CommonConstants.INPUT_PASSWORD_LENGTH)
        .inputStyle()
        .onChange(val=>{
          this.password = val
        })

      Line()
        .lineStyle() // 输入框下面的一条线

      Row(){// 短信提示， 和忘记密码
        Text($r('app.string.message_login'))
          .blueTextStyle()
          .onClick(()=>{

          })
        Text($r('app.string.forgot_password'))
          .blueTextStyle()
          .onClick(()=>{

          })

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonConstants.FULL_PARENT)
      .margin({
        top: $r('app.float.forgot_margin_top')
      })

      //登录按钮
      Button($r('app.string.login'), {type: ButtonType.Capsule})  // 胶囊形状的按钮
        .width(CommonConstants.BUTTON_WIDTH)
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.login_button_color'))
        .margin({
          top: $r('app.float.login_button_margin_top'),
          bottom: $r('app.float.login_button_margin_bottom')
        })
        .onClick(()=>{
          this.login()
        })

      // 注册账号文本
      Text($r('app.string.register_account'))
        .fontColor($r('app.color.login_blue_text_color')) // 字体颜色
        .fontSize($r('app.float.normal_text_size')) // 字体大小
        .fontWeight(FontWeight.Medium) // 字体粗细

      Column(){
        if (this.isShowProgress){
          LoadingProgress()   // 圆圈形状的进度条
            .color($r('app.color.loading_color')) // 颜色
            .width($r('app.float.login_progress_size')) // 宽度
            .height($r('app.float.login_progress_size')) // 高度
            .margin({ top: $r('app.float.login_progress_margin_top') }) // 上方边距
        }
      }
      .height($r('app.float.login_progress_size')) // 高度

      // 其他登录方式文本
      Text($r('app.string.other_login_method'))
        .fontColor($r('app.color.other_login_text_color')) // 字体颜色
        .fontSize($r('app.float.little_text_size')) // 字体大小
        .fontWeight(FontWeight.Medium) // 字体粗细
        .margin({ top: $r('app.float.other_login_margin_top'), bottom: $r('app.float.other_login_margin_bottom') }) // 边距

      // 三种登录方式
      Row({ space: CommonConstants.LOGIN_METHODS_SPACE}){
        this.imageButton($r('app.media.login_method1'))  // 登录方式1
        this.imageButton($r('app.media.login_method2'))  // 登录方式2
        this.imageButton($r('app.media.login_method3'))  // 登录方式3
      }
    }
    .backgroundColor($r('app.color.background'))
    .height(CommonConstants.FULL_PARENT)
    .width(CommonConstants.FULL_PARENT)
    .padding({
      left: $r('app.float.page_padding_hor'),
      right: $r('app.float.page_padding_hor'),
      bottom: $r('app.float.login_page_padding_bottom')
    })
  }
  @Builder
  imageButton(image: Resource) {
    // 构建按钮图片： 本质上，就是在按钮里面增加一个Image组件。
    Button({type: ButtonType.Circle, stateEffect: true}){  // 圆形的按钮， 并且，按钮按下去开启切换效果
      Image(image)
    }
    .height($r('app.float.other_login_image_size')) // 图片按钮高度
    .width($r('app.float.other_login_image_size')) // 图片按钮宽度
    .backgroundColor($r('app.color.background')) // 背景颜色

  }
}