import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State TEST01: router.RouterOptions = { 'url': 'pages/TEST01' }
  @State TEST02: router.RouterOptions = { 'url': 'pages/TEST02' }
  @State TEST03: router.RouterOptions = { 'url': 'pages/TEST03' }

  build() {
    RelativeContainer() {


      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })


      List({ space: 10 }) {
        ListItem() {
          Button("进入测试1-图片&按钮").onClick(() => {
            router.pushUrl(this.TEST01)
          })
            .width('50%')
            .borderRadius(20)
            .height(40)
        }
        ListItem() {
          Button("进入测试2-数据渲染").onClick(() => {
            router.pushUrl(this.TEST02)
          })
            .width('50%')
            .borderRadius(20)
            .height(40)
        }
        ListItem() {
          Button("进入测试3-计算器").onClick(() => {
            router.pushUrl(this.TEST03)
          })
            .width('50%')
            .borderRadius(20)
            .height(40)
        }
        ListItem() {
          Button("进入测试4").onClick(() => {
            router.pushUrl(this.TEST01)
          })
            .width('50%')
            .borderRadius(20)
            .height(40)
        }
        ListItem() {
          Button("进入测试5").onClick(() => {
            router.pushUrl(this.TEST01)
          })
            .width('50%')
            .borderRadius(20)
            .height(40)
        }
        ListItem() {
          Button("进入测试6").onClick(() => {
            router.pushUrl(this.TEST01)
          })
            .width('50%')
            .borderRadius(20)
            .height(40)
        }
        ListItem() {
          Button("进入测试7").onClick(() => {
            router.pushUrl(this.TEST01)
          })
            .width('50%')
            .borderRadius(20)
            .height(40)
        }
        ListItem() {
          Button("进入测试8").onClick(() => {
            router.pushUrl(this.TEST01)
          })
            .width('50%')
            .borderRadius(20)
            .height(40)
        }
      }
      .alignListItem(ListItemAlign.Center)
    }
    .height('100%')
    .width('100%')
  }
}