import { curves } from '@kit.ArkUI';
import { router } from '@kit.ArkUI';

function isLastCharNotDigit(operate: string): boolean {
  return !(/\d$/.test(operate) || /%$/.test(operate));
}

function reset_animate(context: TEST03): void{
  animateTo({ curve: curves.springMotion() }, () => {
    context.answer_animate = false;
    context.front_size_op = context.answer_animate ? 30 : 50;
    context.front_size_ans = context.answer_animate ? 50 : 30;
    context.front_color_op = context.answer_animate ? 0x9fa39a : 0x000000;
    context.front_color_ans = context.answer_animate ? 0x000000 : 0x9fa39a;
  })
}

function calculateExpression(operate: string): string {
  operate = operate.replace(/(\d+)%/g, (num) => (parseFloat(num) / 100).toString());

  // Function to handle operations
  const compute = (a: number, b: number, operator: string): number => {
    switch (operator) {
      case '+': return a + b;
      case '-': return a - b;
      case 'x': return a * b;
      case '÷': return a / b;
      default: throw new Error('Invalid operator');
    }
  };

  // Handle multiplication and division first
  const handleMulDiv = (expr: string): string => {
    const regex = /(-?\d+(\.\d+)?)([x÷])(-?\d+(\.\d+)?)/;
    let match : RegExpExecArray | null;
    while ((match = regex.exec(expr)) !== null) {
      const left = parseFloat(match[1]);
      const operator = match[3];
      const right = parseFloat(match[4]);
      const result = compute(left, right, operator);
      expr = expr.replace(match[0], result.toString());
    }
    return expr;
  };

  // Handle addition and subtraction
  const handleAddSub = (expr: string): string => {
    const regex = /(-?\d+(\.\d+)?)([+\-])(-?\d+(\.\d+)?)/;
    let match : RegExpExecArray | null;
    while ((match = regex.exec(expr)) !== null) {
      const left = parseFloat(match[1]);
      const operator = match[3];
      const right = parseFloat(match[4]);
      const result = compute(left, right, operator);
      expr = expr.replace(match[0], result.toString());
    }
    return expr;
  };

  // Process the expression
  let result = handleMulDiv(operate);
  result = handleAddSub(result);

  return result;
}

@Entry
@Component
struct TEST03 {
  @State OPERATE: string = '';
  @State ANSWER: string = '';
  @State front_size_op: number = 50;
  @State front_color_op: number = 0x000000;
  @State front_size_ans: number = 30;
  @State front_color_ans: number = 0x9fa39a;
  @State answer_animate: boolean = false;
  @State answer_num: number = 0;
  @State the1_num: number = 0;
  @State num_count: number = 1;
  @State Index: router.RouterOptions = { 'url': 'pages/Index' };


  build() {
    RelativeContainer() {
      Column({ space: 20 }) {
        Column({ space: 5 }) {
          Row({}) {
          Button('<', { type: ButtonType.Normal, stateEffect: true })
            .width(50)
            .height(30)
            .fontSize(15)
            .borderRadius(8)
            .backgroundColor(0xF55A42)
            .onClick(()=>{
              router.pushUrl(this.Index)
            })
          Text('Calculator').fontSize(30).fontColor(0xc1b2a3).width('90%');
          }.width('95%')
          Row().width('90%').height(70)
          Row({}) {
            Text(this.OPERATE).fontSize(this.front_size_op).fontWeight(FontWeight.Medium).fontColor(this.front_color_op)
          }
          .width('90%')
          .height(70)
          .id('OPERATE_ROW')
          .justifyContent(FlexAlign.End)

          Row({}) {
            Text(this.ANSWER).fontSize(this.front_size_ans).fontWeight(FontWeight.Medium).fontColor(this.front_color_ans)
          }
          .width('90%')
          .height(70)
          .id('ANSWER_ROW')
          .justifyContent(FlexAlign.End)
        }

        Column({ space: 15 }) {
          Row({}) {
            Column() {
              Button('AC', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xcdd1d3)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = ''
                  this.ANSWER = ''
                })
            }.width('20%').height(70)

            Column() {
              Button('%', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xcdd1d3)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  if (!isLastCharNotDigit(this.OPERATE)) {
                    this.OPERATE = this.OPERATE + '%'
                    this.ANSWER = calculateExpression(this.OPERATE)
                  }
                })
            }.width('20%').height(70)

            Column() {
              Button('<=', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xcdd1d3)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .fontSize(27)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  if (this.OPERATE) {
                    this.OPERATE = this.OPERATE.slice(0, -1);
                  }
                  this.ANSWER = calculateExpression(this.OPERATE)
                  console.info('Button onClick')
                })
            }.width('20%').height(70)

            Column() {
              Button('÷', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xcdd1d3)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .fontSize(30)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  if (!isLastCharNotDigit(this.OPERATE)) {
                    this.OPERATE = this.OPERATE + '÷'
                  }
                })
            }.width('20%').height(70)
          }
          .width('90%')
          .height(70)
          .id('OPERATE')
          .justifyContent(FlexAlign.SpaceAround)

          Row({}) {
            Column() {
              Button('7', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '7'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('8', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '8'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('9', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '9'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('X', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xcdd1d3)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  if (!isLastCharNotDigit(this.OPERATE)) {
                    this.OPERATE = this.OPERATE + 'x'
                  }
                })
            }.width('20%').height(70)
          }
          .width('90%')
          .height(70)
          .id('OPERATE')
          .justifyContent(FlexAlign.SpaceAround)

          Row({}) {
            Column() {
              Button('4', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '4'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('5', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '5'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('6', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '6'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('一', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xcdd1d3)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  if (!(/-$/.test(this.OPERATE))) {
                    this.OPERATE = this.OPERATE + '-'
                  }
                })
            }.width('20%').height(70)
          }
          .width('90%')
          .height(70)
          .id('OPERATE')
          .justifyContent(FlexAlign.SpaceAround)

          Row({}) {
            Column() {
              Button('1', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '1'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('2', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '2'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('3', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '3'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('+', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xcdd1d3)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Regular)
                .fontSize(42)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  if (!isLastCharNotDigit(this.OPERATE)) {
                    this.OPERATE = this.OPERATE + '+'
                  }
                })
            }.width('20%').height(70)
          }
          .width('90%')
          .height(70)
          .id('OPERATE')
          .justifyContent(FlexAlign.SpaceAround)

          Row({}) {
            Column() {
              Button('00', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '00'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('0', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  this.OPERATE = this.OPERATE + '0'
                  this.ANSWER = calculateExpression(this.OPERATE)
                })
            }.width('20%').height(70)

            Column() {
              Button('.', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfffef9)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)
                .fontSize(23)
                .width(65)
                .height(65)
                .onClick(()=>{
                  reset_animate(this)
                  if (!isLastCharNotDigit(this.OPERATE)) {
                    this.OPERATE = this.OPERATE + '.'
                  }
                })
            }.width('20%').height(70)

            Column() {
              Button('=', { type: ButtonType.Circle, stateEffect: true })
                .backgroundColor(0xfb8b05)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Regular)
                .fontSize(42)
                .width(65)
                .height(65)
                .onClick(()=>{
                  animateTo({ curve: curves.springMotion() }, () => {
                    this.answer_animate = true;
                    this.front_size_op = this.answer_animate ? 30 : 50;
                    this.front_size_ans = this.answer_animate ? 50 : 30;
                    this.front_color_op = this.answer_animate ? 0x9fa39a : 0x000000;
                    this.front_color_ans = this.answer_animate ? 0x000000 : 0x9fa39a;
                  })
                })
            }.width('20%').height(70)
          }
          .width('90%')
          .height(70)
          .id('OPERATE')
          .justifyContent(FlexAlign.SpaceAround)

        }.width('100%')
      }
    }.width('100%').backgroundColor('rgb(242,242,242)')
    .height('100%')
    .width('100%')
  }
}

function type(arg0: string) {
  throw new Error('Function not implemented.');
}
