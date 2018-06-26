object FormCBtoDEL: TFormCBtoDEL
  Left = 0
  Top = 0
  Caption = 'FormCBtoDEL'
  ClientHeight = 644
  ClientWidth = 748
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #65325#65331' '#12468#12471#12483#12463
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 373
    Top = 156
    Height = 420
    Align = alRight
    ExplicitLeft = 376
    ExplicitTop = 32
    ExplicitHeight = 644
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 153
    Width = 748
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 373
    ExplicitWidth = 423
  end
  object Panel1: TPanel
    Left = 0
    Top = 156
    Width = 373
    Height = 420
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object CB: TRichEdit
      Left = 1
      Top = 1
      Width = 371
      Height = 418
      Align = alClient
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      Lines.Strings = (
        'while (!isend()){'
        #9'type=getsym(pos,str);'
        #9'if(!StrIComp(str,L"End")){'
        #9#9'type=getsym(pos,str);'
        #9#9'if(!StrIComp(str,L"Sub"))'
        #9#9#9'break;'
        #9'}'
        '}'
        ''
        '#end#'
        ''
        ''
        'p!=NULL;'
        '*p!=NULL;'
        ''
        'for(PChar p=CSTR(s);*p!=NULL;p+=StrLen(p)+1)'
        #9'G->RowCount++;'
        ''
        'for(int i=0;i<0;i++);'
        'for(int i=0;i<0;i++){}'
        'for(i=0;i<0;i++){}'
        ''
        ''
        'for(PChar p=CSTR(s);*p!=NULL;p+=StrLen(p)+1){'
        #9'G->RowCount++;'
        #9'G->Cells[1][G->RowCount-1]=p;'
        '}'
        '#end#'
        ''
        'do{'
        #9'S=PAddNameEdit->Text+" ('#12467#12500#12540'";'
        #9'if(i>0) S=S+i;'
        #9'S=S+")";'
        #9'i++;'
        '}while(fileExists(ConstDir+S));'
        ''
        ''
        ''
        'TExGrid * Grids(const int i){'
        #9'if(i<0 || i>=Name->Count)return NULL;'
        ''
        #9'TExGrid * G=(TExGrid*)Name->Objects[i];'
        #9'G->Index=i;'
        #9'return G;'
        '}'
        '#end#'
        '    TExGrid * Grids(const STRING NAME){'
        #9'int i=Index(NAME);'
        #9'if(i<0) return NullGrid;'
        #9'TExGrid * G=(TExGrid*)Name->Objects[i];'
        #9'G->Index=i;'
        #9'return G;'
        '}'
        ''
        ''
        'if( a==1|a==1&a==1||a==1&&a==1)b=2;'
        ''
        'a=1+(2+(3+4)+5)+6+(7+(8+9)+0);'
        'int *a;'
        'int &a;'
        'int a;'
        'a=1;'
        'a=1+1;')
      ParentFont = False
      PlainText = True
      PopupMenu = PopupMenu1
      ScrollBars = ssBoth
      TabOrder = 0
      WantTabs = True
      Zoom = 100
    end
  end
  object Panel2: TPanel
    Left = 376
    Top = 156
    Width = 372
    Height = 420
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 1
    object DEL: TRichEdit
      Left = 1
      Top = 1
      Width = 370
      Height = 418
      Align = alClient
      Font.Charset = SHIFTJIS_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #65325#65331' '#12468#12471#12483#12463
      Font.Style = []
      Lines.Strings = (
        'DEL')
      ParentFont = False
      PlainText = True
      PopupMenu = PopupMenu1
      ScrollBars = ssBoth
      TabOrder = 0
      WantTabs = True
      Zoom = 100
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 748
    Height = 153
    Margins.Top = 0
    Align = alTop
    TabOrder = 2
    object CG: TStringGrid
      Left = 1
      Top = 25
      Width = 746
      Height = 127
      Align = alClient
      Ctl3D = False
      DoubleBuffered = True
      RowCount = 3
      GradientEndColor = clBlack
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowMoving, goEditing, goThumbTracking]
      ParentCtl3D = False
      ParentDoubleBuffered = False
      PopupMenu = PopupMenu2
      TabOrder = 0
      OnSetEditText = CGSetEditText
      ColWidths = (
        64
        64
        64
        64
        64)
      RowHeights = (
        24
        24
        24)
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 746
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 2
      Padding.Bottom = 2
      TabOrder = 1
      object Label2: TLabel
        Left = 97
        Top = 2
        Width = 112
        Height = 20
        Align = alLeft
        AutoSize = False
        Caption = ' '#12521#12452#12531#12502#12525#12483#12463
        Layout = tlCenter
      end
      object Label1: TLabel
        Left = 304
        Top = 2
        Width = 98
        Height = 20
        Align = alLeft
        AutoSize = False
        Caption = ' '#23459#35328#12502#12525#12483#12463
        Layout = tlCenter
        ExplicitLeft = 273
        ExplicitTop = -2
        ExplicitHeight = 24
      end
      object Label3: TLabel
        Left = 0
        Top = 2
        Width = 40
        Height = 20
        Align = alLeft
        AutoSize = False
        Caption = ' '#35373#23450
        Layout = tlCenter
        ExplicitLeft = -1
        ExplicitTop = -1
        ExplicitHeight = 24
      end
      object EditLineBlock: TEdit
        Left = 209
        Top = 2
        Width = 95
        Height = 20
        Align = alLeft
        TabOrder = 0
        Text = '#define'
        ExplicitHeight = 21
      end
      object EditSet: TEdit
        Left = 40
        Top = 2
        Width = 57
        Height = 20
        Align = alLeft
        TabOrder = 1
        ExplicitHeight = 21
      end
      object ButtonOk: TButton
        Left = 671
        Top = 2
        Width = 75
        Height = 20
        Align = alRight
        Caption = #30906#23450
        ModalResult = 1
        TabOrder = 2
      end
      object EditVarBlock: TEdit
        Left = 402
        Top = 2
        Width = 190
        Height = 20
        Align = alLeft
        TabOrder = 3
        Text = 'struct class enum union'
        ExplicitHeight = 21
      end
    end
  end
  object LOG: TRichEdit
    Left = 0
    Top = 576
    Width = 748
    Height = 68
    Align = alBottom
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Lines.Strings = (
      'DEL')
    ParentFont = False
    PlainText = True
    PopupMenu = PopupMenu1
    ScrollBars = ssBoth
    TabOrder = 3
    Zoom = 100
  end
  object MainMenu1: TMainMenu
    Left = 72
    Top = 40
    object MConv: TMenuItem
      Caption = #22793#25563
      OnClick = MConvClick
    end
    object MSave: TMenuItem
      Caption = #20445#23384
      OnClick = MSaveClick
    end
    object MLoad: TMenuItem
      Caption = #35501#36796
      OnClick = MLoadClick
    end
    object MCut: TMenuItem
      Caption = #20999#12426#21462#12426
      OnClick = MCutClick
    end
    object MCopy: TMenuItem
      Caption = #12467#12500#12540
      OnClick = MCopyClick
    end
    object MPaste: TMenuItem
      Caption = #12506#12540#12473#12488
      OnClick = MPasteClick
    end
    object MFolder: TMenuItem
      Caption = #12501#12457#12523#12480
      OnClick = MFolderClick
    end
    object MSet: TMenuItem
      Caption = #35373#23450
      OnClick = MSetClick
      object MFixed: TMenuItem
        Caption = #22266#23450#21015#32232#38598
        OnClick = MSetClick
      end
      object MDvrow: TMenuItem
        Caption = #21512#33268#12375#12383#27083#36896#12434#36984#25246
        Checked = True
        OnClick = MSetClick
      end
      object MLSource: TMenuItem
        Caption = #12525#12464#12395#12477#12540#12473#20986#21147
        Checked = True
        OnClick = MSetClick
      end
      object MLStruct: TMenuItem
        Caption = #12525#12464#12395#27083#36896#20986#21147
        Checked = True
        OnClick = MSetClick
      end
    end
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 140
    Top = 40
    object PConv: TMenuItem
      Caption = #22793#25563
      ShortCut = 24643
      OnClick = MConvClick
    end
    object PCut: TMenuItem
      Caption = #20999#12426#21462#12426
    end
    object PCopy: TMenuItem
      Caption = #12467#12500#12540
    end
    object PPeste: TMenuItem
      Caption = #36028#12426#20184#12369
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Mend: TMenuItem
      Caption = '#end#'
      OnClick = MendClick
    end
  end
  object PopupMenu2: TPopupMenu
    AutoHotkeys = maManual
    Left = 204
    Top = 40
    object MenuItem1: TMenuItem
      Caption = #22793#25563
      OnClick = MConvClick
    end
    object MRowDup: TMenuItem
      Caption = #34892#35079#35069
      OnClick = MRowDupClick
    end
    object MRowDel: TMenuItem
      Caption = #34892#21066#38500
      OnClick = MRowDelClick
    end
    object MenuItem2: TMenuItem
      Caption = #20999#12426#21462#12426
    end
    object MenuItem3: TMenuItem
      Caption = #12467#12500#12540
    end
    object MenuItem4: TMenuItem
      Caption = #36028#12426#20184#12369
    end
    object MenuItem5: TMenuItem
      Caption = '-'
    end
    object MenuItem6: TMenuItem
      Caption = '%0% '#19968#33268#12375#12383#37096#20998
      OnClick = MenuItemGridClick
    end
    object MenuItem8: TMenuItem
      Caption = '%s0% '#12502#12525#12483#12463#20013#36523
      OnClick = MenuItemGridClick
    end
    object MenuItem7: TMenuItem
      Caption = '%s0% '#12477#12540#12473
      OnClick = MenuItemGridClick
    end
    object c01: TMenuItem
      Caption = '%c0% '#24460#12429#12377#12409#12390
    end
    object o01: TMenuItem
      Caption = '%o0% '#12477#12540#12473
    end
    object MenuItem10: TMenuItem
      Caption = '%CR% '#25913#34892
      OnClick = MenuItemGridClick
    end
    object MenuItem11: TMenuItem
      Caption = #65285'E%'
      OnClick = MenuItemGridClick
    end
    object MenuItem12: TMenuItem
      Caption = '%i% '#12452#12531#12487#12531#12488
      OnClick = MenuItemGridClick
    end
    object MenuItem13: TMenuItem
      Caption = '-'
    end
    object MenuItem14: TMenuItem
      Caption = #65372
      OnClick = MenuItemGrid2Click
    end
    object MenuItem15: TMenuItem
      Caption = '{*} '#12502#12525#12483#12463
      OnClick = MenuItemGrid2Click
    end
    object MenuItem16: TMenuItem
      Caption = '(*) '#12502#12525#12483#12463
      OnClick = MenuItemGrid2Click
    end
    object MenuItem17: TMenuItem
      Caption = #25991
      OnClick = MenuItemGrid2Click
    end
    object MenuItem18: TMenuItem
      Caption = #21491
      OnClick = MenuItemGrid2Click
    end
    object MenuItem19: TMenuItem
      Caption = #24038
      OnClick = MenuItemGrid2Click
    end
    object N1: TMenuItem
      Caption = #12467#12513#12531#12488
      OnClick = N1Click
    end
  end
end
