import { router } from '@kit.ArkUI';

class PEOPLE_DATA {
  name: string = ""
  age: string = ""
}

function mock(): PEOPLE_DATA[] {
  let persons_info_list: Array<PEOPLE_DATA> = [];
  let person1 : PEOPLE_DATA = { 'name': '吕子健' ,'age': '21'}
  let person2 : PEOPLE_DATA = { 'name': '何萌' ,'age': '5'}
  let person3 : PEOPLE_DATA = { 'name': '吴俊伟' ,'age': '50'}
  persons_info_list.push(person1);
  persons_info_list.push(person2);
  persons_info_list.push(person3);
  return persons_info_list;
}

@Entry
@Component
struct TEST02 {

  @State persons_info_list: PEOPLE_DATA[] = mock();
  @State Index: router.RouterOptions = { 'url': 'pages/Index' };


  build() {
    RelativeContainer() {
      Column({}) {
        Button('<', { type: ButtonType.Normal, stateEffect: true })
          .width(50)
          .height(30)
          .fontSize(15)
          .borderRadius(8)
          .backgroundColor(0xF55A42)
          .onClick(()=>{
            router.pushUrl(this.Index)
          })
        ForEach(this.persons_info_list, (item: PEOPLE_DATA, index?: number) => { // 循环数组创建每一个Item
          Text(`姓名: ${item.name} 年龄: ${item.age}`)                                     // 可以生成一个或多个子组件
            .fontSize(20)
        })
      }.width('100%').height(300).backgroundColor('rgb(242,242,242)').justifyContent(FlexAlign.SpaceEvenly)
    }
    .height('100%')
    .width('100%')
  }
}