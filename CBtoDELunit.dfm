object FormCBtoDEL: TFormCBtoDEL
  Left = 0
  Top = 0
  Caption = 'FormCBtoDEL'
  ClientHeight = 593
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #65325#65331' '#12468#12471#12483#12463
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterDel: TSplitter
    Left = 380
    Top = 156
    Width = 4
    Height = 369
    Align = alRight
    ExplicitLeft = 373
    ExplicitHeight = 420
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 153
    Width = 756
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 373
    ExplicitWidth = 423
  end
  object Panel1: TPanel
    Left = 0
    Top = 156
    Width = 380
    Height = 369
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object CB: TRichEdit
      Left = 1
      Top = 1
      Width = 378
      Height = 367
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
      OnKeyDown = CBKeyDown
    end
  end
  object PanelDel: TPanel
    Left = 384
    Top = 156
    Width = 372
    Height = 369
    Align = alRight
    Caption = 'PanelDel'
    TabOrder = 1
    object DEL: TRichEdit
      Left = 1
      Top = 1
      Width = 370
      Height = 367
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
    Width = 756
    Height = 153
    Margins.Top = 0
    Align = alTop
    TabOrder = 2
    object CG: TStringGrid
      Left = 1
      Top = 25
      Width = 754
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
      Width = 754
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
        Width = 99
        Height = 20
        Align = alLeft
        AutoSize = False
        Caption = ' '#23459#35328#12502#12525#12483#12463
        Layout = tlCenter
        WordWrap = True
        ExplicitHeight = 28
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
        Left = 679
        Top = 2
        Width = 75
        Height = 20
        Align = alRight
        Caption = #30906#23450
        ModalResult = 1
        TabOrder = 2
      end
      object EditVarBlock: TEdit
        Left = 403
        Top = 2
        Width = 151
        Height = 20
        Align = alLeft
        TabOrder = 3
        Text = 'struct class enum union'
        ExplicitHeight = 21
      end
      object KEY: TMemo
        Left = 554
        Top = 2
        Width = 103
        Height = 20
        Align = alLeft
        Lines.Strings = (
          'Emit'
          'Final'
          'RESTRICT'
          '_Bool'
          '_Complex'
          '_Imaginary'
          '__asm'
          '__automated'
          '__cdecl'
          '__classid'
          '__classmethod'
          '__closure'
          '__declspec'
          '__declspec'
          '(allocate'
          '("SEGNAME"))'
          '__declspec'
          '(delphiclass)'
          '__declspec'
          '(delphirecord'
          ')'
          '__declspec'
          '(delphireturn'
          ')'
          '__declspec'
          '(delphirtti)'
          '__declspec'
          '(dllexport)'
          '__declspec'
          '(dllimport)'
          '__declspec'
          '(dynamic)'
          '__declspec'
          '(hidesbase)'
          '__declspec'
          '(naked)'
          '__declspec'
          '(noreturn)'
          '__declspec'
          '(nothrow)'
          '__declspec'
          '(novtable)'
          '__declspec'
          '(package)'
          '__declspec'
          '(pascalimplem'
          'enta'
          'tion)'
          '__declspec'
          '(property)'
          '__declspec'
          '(selectany)'
          '__declspec'
          '(thread)'
          '__declspec'
          '(uuid'
          '("ComObjectGU'
          'ID")'
          ')'
          '__delphirtti'
          '__dispid'
          '__except'
          '__export'
          '__fastcall'
          '__finally'
          '__import'
          '__inline'
          '__int16'
          '__int32'
          '__int64'
          '__int8'
          '__msfastcall'
          '__msreturn'
          '__pascal'
          '__property'
          '__published'
          '__rtti'
          '__stdcall'
          '__thread'
          '__try'
          '__typeof'
          '__typeof__'
          '__uuidof'
          '_asm'
          '_cdecl'
          '_export'
          '_fastcall'
          '_import'
          '_pascal'
          '_stdcall'
          'alignas'
          'alignof'
          'and'
          'and_eq'
          'asm'
          'auto'
          'axiom'
          'bitand'
          'bitor'
          'bool'
          'break'
          'case'
          'catch'
          'cdecl'
          'char'
          'char16_t'
          'char32_t'
          'class'
          'compl'
          'concept'
          'concept_map'
          'const'
          'const_cast'
          'constexpr'
          'continue'
          'decltype'
          'default'
          'delete'
          'deprecated'
          'do'
          'double'
          'dynamic_cast'
          'else'
          'enum'
          'explicit'
          'export'
          'extern'
          'false'
          'float'
          'for'
          'friend'
          'goto'
          'if'
          'inline'
          'int'
          'late_check'
          'long'
          'mutable'
          'namespace'
          'new'
          'noreturn'
          'not'
          'not_eq'
          'nullptr'
          'operator'
          'or'
          'or_eq'
          'pascal'
          'private'
          'protected'
          'public'
          'register'
          'reinterpret_c'
          'ast'
          '(typecast '
          'Operator)'
          'requires'
          'return'
          'short'
          'signed'
          'sizeof'
          'static'
          'static_assert'
          'static_cast'
          'struct'
          'template'
          'this'
          'thread_local'
          'throw'
          'true'
          'try'
          'typedef'
          'typeid'
          'typename'
          'typeof'
          'union'
          'unsigned'
          'using'
          'virtual'
          'void'
          'volatile'
          'wchar_t'
          'while'
          'xor'
          'xor_eq')
        TabOrder = 4
        Visible = False
      end
    end
  end
  object LOG: TRichEdit
    Left = 0
    Top = 525
    Width = 756
    Height = 68
    Align = alBottom
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #65325#65331' '#12468#12471#12483#12463
    Font.Style = []
    Lines.Strings = (
      'LOG')
    ParentFont = False
    PlainText = True
    PopupMenu = PopupMenu1
    ScrollBars = ssBoth
    TabOrder = 3
    Zoom = 100
    OnKeyDown = CBKeyDown
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
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
      object MSDvrow: TMenuItem
        Caption = #21512#33268#12375#12383#27083#36896#12434#36984#25246
        Checked = True
        OnClick = MSetClick
      end
      object MSLSource: TMenuItem
        Caption = #12525#12464#12395#12477#12540#12473#20986#21147
        Checked = True
        OnClick = MSetClick
      end
      object MSLStruct: TMenuItem
        Caption = #12525#12464#12395#27083#36896#20986#21147
        Checked = True
        OnClick = MSetClick
      end
      object MSExp: TMenuItem
        Caption = #35542#29702#24335#22793#25563
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
      OnClick = MCutClick
    end
    object PCopy: TMenuItem
      Caption = #12467#12500#12540
      OnClick = MCopyClick
    end
    object PPeste: TMenuItem
      Caption = #36028#12426#20184#12369
      OnClick = MPasteClick
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
    object MGRun: TMenuItem
      Caption = #22793#25563
      OnClick = MConvClick
    end
    object MGRowIns: TMenuItem
      Caption = #34892#25407#20837
      OnClick = MGRowInsClick
    end
    object MGRowDup: TMenuItem
      Caption = #34892#35079#35069
      OnClick = MGRowDupClick
    end
    object MGRowDel: TMenuItem
      Caption = #34892#21066#38500
      OnClick = MGRowDelClick
    end
    object MGCut: TMenuItem
      Caption = #20999#12426#21462#12426
      OnClick = MGCutClick
    end
    object MGCopy: TMenuItem
      Caption = #12467#12500#12540
      OnClick = MGCopyClick
    end
    object MGPaste: TMenuItem
      Caption = #36028#12426#20184#12369
      OnClick = MGPasteClick
    end
    object MGComment: TMenuItem
      Caption = #12467#12513#12531#12488#12488#12464#12523
      OnClick = MGCommentClick
    end
    object MenuItem5: TMenuItem
      Caption = '-'
    end
    object MGIns1: TMenuItem
      Caption = '%0% '#19968#33268#12375#12383#37096#20998
      OnClick = MenuItemGridClick
    end
    object MGIns2: TMenuItem
      Caption = '%s0% '#12502#12525#12483#12463#20013#36523
      OnClick = MenuItemGridClick
    end
    object MGIns3: TMenuItem
      Caption = '%c0% '#24460#12429#12377#12409#12390
    end
    object MGIns4: TMenuItem
      Caption = '%o0% '#12477#12540#12473
    end
    object N001: TMenuItem
      Caption = '%0?0% '#20998#21106#30058#21495#25351#23450
    end
    object x01: TMenuItem
      Caption = '%x0% '#27491#35215#34920#29694#12510#12483#12481
    end
    object r0xxx1: TMenuItem
      Caption = '%r0 xxx% '#27491#35215#34920#29694#32622#12365#25563#12360' '
    end
    object e0xxxxxx1: TMenuItem
      Caption = '%e0,xxx% '#12464#12523#12540#12503#12434#25277#20986#12375#12390'xxx'#36275#12375#12390','#12391#21306#20999#12427
    end
    object MGIns5: TMenuItem
      Caption = #65372' '#25913#34892
      OnClick = MenuItemGridClick
    end
    object MGIns6: TMenuItem
      Caption = #8594' '#12479#12502
      OnClick = MenuItemGridClick
    end
    object MGIns7: TMenuItem
      Caption = '%i% '#12452#12531#12487#12531#12488
      OnClick = MenuItemGridClick
    end
    object MenuItem13: TMenuItem
      Caption = '-'
    end
    object MGInsb1: TMenuItem
      Caption = #65372
      OnClick = MenuItemGrid2Click
    end
    object MGInsb2: TMenuItem
      Caption = '{*} '#12502#12525#12483#12463
      OnClick = MenuItemGrid2Click
    end
    object MGInsb3: TMenuItem
      Caption = '(*) '#12502#12525#12483#12463
      OnClick = MenuItemGrid2Click
    end
    object N1: TMenuItem
      Caption = #65290' '#35079#25968#19968#33268
    end
    object MGInsb7: TMenuItem
      Caption = '*; ;'#12414#12391#12398#12502#12525#12483#12463'(if'#38480#23450')'
    end
    object MGInsb4: TMenuItem
      Caption = #25991
      OnClick = MenuItemGrid2Click
    end
    object MGInsb6: TMenuItem
      Caption = #24335
      OnClick = MenuItemGrid2Click
    end
  end
end
