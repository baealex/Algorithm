class J5Button {
  int x, y, w, h;
  String text;
  int baseColor = 255;
  int hoverColor = 200;

  J5Button(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void setText(String text) {
    this.text = text;
  }

  void setColor(int c, int hc) {
    this.baseColor = c;
    this.hoverColor = hc;
  }

  boolean hover() {
    if (mouseX >= this.x && mouseX <= this.x+this.w && 
      mouseY >= this.y && mouseY <= this.y+this.h) {
      return true;
    } else {
      return false;
    }
  }

  void show() {
    stroke(0);
    if (this.hover()) {
      fill(color(this.hoverColor));
    } else {
      fill(color(this.baseColor));
    }
    rect(this.x, this.y, this.w, this.h);

    if (this.text != null) {
      fill(color(abs(255-this.baseColor)));
      textAlign(CENTER, CENTER);
      text(this.text, this.x+this.w/2, this.y+this.h/2);
    }
  }
}

class J5InputBoxGroup {
  int x, y, w, h;
  String text;
  
  J5InputBoxGroup(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void setText(String text) {
    this.text = text;
  }
  
  void show() {
    stroke(200);
    fill(255);
    rect(this.x,this.y,this.w,this.h);
    if(this.text != "") {
      fill(color(200));
      textAlign(CENTER, CENTER);
      text("DATA", this.x+this.w/2, this.y);
    }
  }
}

class J5InputBox {
  int x, y, w, h;
  String holder="";
  String result="";

  J5InputBox(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void setHolderText(String text) {
    this.holder = text;
  }

  void Input(String t) {
    this.result += t;
  }

  void deleteChar() {
    if (result.length() > 0) {
      result = result.substring(0, result.length()-1);
    }
  }

  void insertChar(char c) {
    result += c;
  }

  String getText() {
    return this.result;
  }

  void show() {
    stroke(100);
    fill(color(255));
    rect(this.x, this.y, this.w, this.h);

    if (this.result != "") {
      fill(color(0));
      textAlign(CENTER, CENTER);
      text(this.result, this.x+this.w/2, this.y+this.h/2);
    } else {
      if (this.holder != null) {
        fill(color(200));
        textAlign(CENTER, CENTER);
        text(this.holder, this.x+this.w/2, this.y+this.h/2);
      }
    }
  }
}

class J5MoterCanvas {
  int x;
  int y;
  int w;
  int h;

  int posX = 0;
  int posY = 0;

  J5MoterCanvas(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.posX = this.w+this.x;
    this.posY = this.h-this.y;
  }

  void setPos(int x, int y) {
    this.posX = x;
    this.posY = y;
  }

  void show() {
    this.update();
    stroke(0);
    fill(255);
    rect(this.x, this.y, this.w, this.h);

    stroke(0);
    fill(255, 0, 0);
    ellipse(this.posX, this.posY, 30, 30);
  }

  void update() {
  }
}

final int btn_number = 5;
final int btn_height = 50;
final int btn_width = 100;

final int inputbox_number = 5;
final int inputbox_height = 25;
final int inputbox_width = 100;

final int margin = 20;

int inputbox_focus = 0;

J5MoterCanvas mCanvas;
J5Button [] mButton;
J5InputBox [] mInputBox;
J5InputBoxGroup mInputBoxGroup;

public void settings() {
  size(800, 600);
}

void setup() {
  background(color(255));
  
  mCanvas = new J5MoterCanvas( margin, margin, 800-inputbox_width-margin*5, 600-btn_height-margin*3 );

  mButton = new J5Button[5];
  for (int i=0; i<5; i++) {
    mButton[i] = new J5Button(
      margin+(btn_width+margin)*i, 
      600-btn_height-margin, 
      btn_width, 
      btn_height
    );
  }
  mButton[0].setText("Start");
  mButton[1].setText("Force Stop");
  mButton[2].setText("-");
  mButton[3].setText("-");
  mButton[4].setText("Exit");

  mInputBox = new J5InputBox[5];
  for (int i=0; i<5; i++) {
    mInputBox[i] = new J5InputBox(
      800-inputbox_width-margin*2, 
      margin*4+(inputbox_height+margin)*i, 
      inputbox_width, 
      inputbox_height
    );
  }
  mInputBox[0].setHolderText("X");
  mInputBox[1].setHolderText("Y");
  mInputBox[2].setHolderText("Z");
  mInputBox[3].setHolderText("Object");
  mInputBox[4].setHolderText("Pulse");
  
  mInputBoxGroup = new J5InputBoxGroup( 800-inputbox_width-margin*3, margin*2, inputbox_width+margin*2, (inputbox_height+margin)*5+margin*2 );
  mInputBoxGroup.setText("DATA");
}

void draw() {
  background(color(255));

  for (int i=0; i<5; i++) {
    mButton[i].show();
  }

  mInputBoxGroup.show();
  for (int i=0; i<5; i++) {
    mInputBox[i].show();
  }

  mCanvas.show();
}

void mousePressed() {
  for (int i=0; i<btn_number; i++) {
    if (mButton[i].hover()) {
      switch(i) {
      case 0:
        print("\n<Send>");
        print("\nX : " + parseInt(mInputBox[0].getText()));
        print("\nY : " + parseInt(mInputBox[1].getText()));
        print("\nZ : " + parseInt(mInputBox[2].getText()));
        print("\nObject : " + parseInt(mInputBox[3].getText()));
        print("\nPulse : " + parseInt(mInputBox[4].getText()));
        break;
      case 1:
        print("\nForce Stop");
        break;
      case 2:
        print("Btn 3");
        break;
      case 3:
        print("Btn 4");
        break;
      case 4:
        exit();
        break;
      }
    }
  }
}

void keyPressed() {
  if (key==ENTER || key==RETURN || key==TAB) {
    inputbox_focus++;
    if (inputbox_focus >= inputbox_number) {
      inputbox_focus = 0;
    }
  } else if (key==BACKSPACE) {
    mInputBox[inputbox_focus].deleteChar();
  } else {
    mInputBox[inputbox_focus].insertChar(key);
  }
}
