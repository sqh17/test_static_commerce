import router from '@ohos.router'
import CommonConstants from '../CommonConstants'
import Home from '../Home/Home'
import MySetting from '../MySetting/MySetting'

@Entry
@Component
struct Index {
  private tabsController: TabsController = new TabsController()
  @State currentIndex:number = CommonConstants.HOME_TAB_INDEX
  @State account: string = 'admin';

  onPageShow():void{
    let acc = router.getParams() as Record<string, string>
    console.log('acc', JSON.stringify(acc))
    if(acc){
      this.account = acc['sendMsg']
    }
  }
  @Builder
  TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource){
    Column() {
      Image(this.currentIndex == index ? selectedImg : normalImg)
        .width($r('app.float.mainPage_baseTab_size'))
        .height($r('app.float.mainPage_baseTab_size'))
      Text(title)
        .margin({ top: $r('app.float.mainPage_baseTab_top') })
        .fontSize($r('app.float.main_tab_fontSize'))
        .fontColor(this.currentIndex === index ? $r('app.color.mainPage_selected') : $r('app.color.mainPage_normal'))
    }
    .justifyContent(FlexAlign.Center)
    .height($r('app.float.mainPage_barHeight'))
    .width(CommonConstants.FULL_PARENT)
    .onClick(() => {
      this.currentIndex = index
      this.tabsController.changeIndex(this.currentIndex) // 修改页签的索引，从而造成页面的切换
    })
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }){
      TabContent(){
        Home()
      }
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.TabBuilder(CommonConstants.HOME_TITLE, CommonConstants.HOME_TAB_INDEX,
        $r('app.media.home_selected'), $r('app.media.home_normal')))

      TabContent(){
        MySetting({account: this.account})
      }
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.TabBuilder(CommonConstants.MINE_TITLE, CommonConstants.MINE_TAB_INDEX,
        $r('app.media.mine_selected'), $r('app.media.mine_normal')))
    }

  }
}