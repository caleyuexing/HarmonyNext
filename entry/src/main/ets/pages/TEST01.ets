import { router } from '@kit.ArkUI';

class DividerTmp {
  strokeWidth: Length = 1
  startMargin: Length = 60
  endMargin: Length = 10
  color: ResourceColor = '#ffe9f0f0'

  constructor(strokeWidth: Length, startMargin: Length, endMargin: Length, color: ResourceColor) {
    this.strokeWidth = strokeWidth
    this.startMargin = startMargin
    this.endMargin = endMargin
    this.color = color
  }
}

let MTop: Record<string, number> = { 'top': 50 }

@Entry
@Component
struct TEST01 {
  @State message: string = 'Hi,Iam ';
  @State message2: string = 'Lyu Zijian';
  @State Index: router.RouterOptions = { 'url': 'pages/Index' }
  @State egDivider: DividerTmp = new DividerTmp(1, 60, 10, '#ffe9f0f0')
  @State egLanes: LengthConstrain = { minLength: 200, maxLength: 300 }

  build() {
    RelativeContainer() {
      List({ space: 5 }) {
        ListItem() {
          Text(this.message)
            .id('test01_hi')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }

        ListItem() {
          Text(this.message2)
            .id('test01_name')
            .fontSize(25)
            .fontWeight(FontWeight.Bolder)
        }


        ListItem() {
          Row() {
            Button("首页").onClick(() => {
              router.pushUrl(this.Index)
            })
              .width('50%')
              .borderRadius(20)
              .height(40)

            Button("翻译").onClick(() => {
              // 让文本变为中文
              if (this.message == "你好，我是") {
                this.message = "Hi,Iam "
                this.message2 = "Lyu Zijian"
              } else {
                this.message = "你好，我是"
                this.message2 = "吕子健"
              }
            })
              .width('50%')
              .borderRadius(20)
              .height(40)
          }
        }

        ListItem() {
          Row() {
            Image($r('app.media.31e2893f9b7f4680d377946a44e50d973814460'))
              .objectFit(ImageFit.Contain)
          }
        }
        ListItem() {
          Row() {
            Image($r('app.media.0386c7c8e15ce32457efb9e9f60558c83814460'))
              .objectFit(ImageFit.Cover)
          }
        }
        ListItem() {
          Row() {
            Image($r('app.media.b0554cf72e4f7e183a84e51e134fc8ed3814460'))
              .objectFit(ImageFit.Fill)
          }
        }
        ListItem() {
          Row() {
            Image($r('app.media.b0554cf72e4f7e183a84e51e134fc8ed3814460'))
              .objectFit(ImageFit.ScaleDown)
          }
        }
      }
      .backgroundColor('#FFF1F3F5')
      .height('100%')
      .width('100%')
      .padding(100)
      .scrollBar(BarState.Auto)
      .divider(this.egDivider)
      .lanes(this.egLanes)
      .alignListItem(ListItemAlign.Center)

    }
  }
}