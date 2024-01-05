import CommonConstants from '../CommonConstants'
import ItemData from '../ItemData'
import DataModel from '../DataModel'
import router from '@ohos.router';
import prompt from '@ohos.promptAction'

// @Entry
@Component
export default struct MySetting {

  @Prop account: string;
  // 构建设置单元格的函数，接收一个ItemData类型的item作为参数
  @Builder
  settingCell(item: ItemData) {
    Row() { // 创建一个行布局
      Row({ space: CommonConstants.COMMON_SPACE }) { // 创建一个有间隔的内嵌行布局
        Image(item.img) // 显示图像
          .width($r('app.float.setting_size')) // 设置图像的宽度
          .height($r('app.float.setting_size')) // 设置图像的高度
        Text(item.title) // 显示文本
          .fontSize($r('app.float.normal_text_size')) // 设置文本的字号
      }

      // 如果item的others属性为空，则显示一个图像，否则显示一个开关组件
      if (!item.others) {
        Image($r('app.media.right_grey')) // 显示一个灰色的箭头图像
          .width($r('app.float.setting_jump_width')) // 设置图像宽度
          .height($r('app.float.setting_jump_height')) // 设置图像高度
          .onClick(()=>{
            console.log('arrow=>')
          })
      } else {
        Toggle({ type: ToggleType.Switch, isOn: false }) // 显示一个开关组件
          .onChange(val=>{
            prompt.showToast({  // 开启一个确认的弹层
              message: val ? '已开启推送通知' : '已关闭推送通知'
            })
          })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween) // 设置内容在主轴方向的对齐方式为两端对齐
    .width(CommonConstants.FULL_PARENT) // 设置宽度为父容器的100%
    .padding({ // 设置内边距
      left: $r('app.float.setting_settingCell_left'),
      right: $r('app.float.setting_settingCell_right')
    })
  }

  build() {
    Column({space: CommonConstants.COMMON_SPACE}){
      Column(){ // 创建一个内嵌的列布局
        Text($r('app.string.mainPage_tabTitles_mine'))
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.page_title_text_size'))
          .margin({ top: $r('app.float.mainPage_tabTitles_margin') })
          .padding({ left: $r('app.float.mainPage_tabTitles_padding') })
      }
      .width(CommonConstants.FULL_PARENT)
      .alignItems(HorizontalAlign.Start)

      // 接下来是账户信息的布局
      Row() {
        Image($r('app.media.account')) // 显示账户图片
          .width($r('app.float.setting_account_size'))
          .height($r('app.float.setting_account_size'))
        Column() {
          Text($r('app.string.setting_account_name'))
            .fontSize($r('app.float.setting_account_fontSize'))
          Text(this.account + '') // 显示账号
            .fontSize($r('app.float.little_text_size'))
            .margin({ top: $r('app.float.setting_name_margin') })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: $r('app.float.setting_account_margin') })
      }
      .width(CommonConstants.FULL_PARENT)
      .height($r('app.float.setting_account_height'))
      .backgroundColor(Color.White)
      .padding({ left: $r('app.float.setting_account_padding') })
      .borderRadius($r('app.float.setting_account_borderRadius'))

      // 列表布局组件
      List(){
        ForEach(DataModel.getSettingListData(), (item: ItemData) => {
          // 构建每一个列表项
          ListItem() {
            this.settingCell(item)
          }
          .height($r('app.float.setting_list_height'))
        })
      }
      .backgroundColor(Color.White) // 设置背景颜色为白色
      .width(CommonConstants.FULL_PARENT)
      .height(CommonConstants.SET_LIST_WIDTH)
      .divider({ // 设置列表项之间的分割线
        strokeWidth: $r('app.float.setting_list_strokeWidth'), // 设置分割线的宽度
        color: Color.Grey, // 设置分割线的颜色为灰色
        startMargin: $r('app.float.setting_list_startMargin'), // 设置分割线的起始边距
        endMargin: $r('app.float.setting_list_endMargin') // 设置分割线的结束边距
      })
      .borderRadius($r('app.float.setting_list_borderRadius'))
      .padding({ top: $r('app.float.setting_list_padding'), bottom: $r('app.float.setting_list_padding'),left: 10, right: 10 }) // 设置内边距

      Blank()

      // 退出按钮
      Button($r('app.string.setting_button'), { type: ButtonType.Capsule })
        .width(CommonConstants.BUTTON_WIDTH)
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontColor($r('app.color.setting_button_fontColor'))
        .fontWeight(FontWeight.Medium) // 设置字体权重
        .backgroundColor($r('app.color.setting_button_backgroundColor'))
        .margin({ bottom: $r('app.float.setting_button_bottom')})
        .onClick(()=>{
          router.replaceUrl({ url: 'pages/Login/Login' })
        })
    }
    .height(CommonConstants.FULL_PARENT)
  }
}