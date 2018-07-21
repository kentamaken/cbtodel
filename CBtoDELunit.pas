unit CBtoDELunit;

interface

uses
	Winapi.Windows,Winapi.Messages,System.SysUtils,System.Variants,System.Classes,Vcl.Graphics,
	Vcl.Controls,Vcl.Forms,Vcl.Dialogs,Vcl.ExtCtrls,Vcl.StdCtrls,types,
  Vcl.Menus,  Vcl.Grids, Vcl.ComCtrls,RegularExpressions;

type
	TIntArray=array of Integer;

	TtokenType=(tknError=$00000000,

		tknType=$01000000,tknVoid=$01000001,tknNumber=$01000002,tknChar=$01000003,tknInt=$01000004,tknDouble=$01000005,tknString=$01000006,tknItem=$0100000A,
		tknStruct=$0100000E,
		tknSemicolon,
		tknColon,
		tknAnd,
		tknOr,
		tknPointer,
		tknRef,

		tknBAnd,
		tknBOr,
		tknBXor,
		tknBNot,
		tknComment,

		tknBlock,tknKBlock,tknCBlock,tknOperator=$02000000,tknCommand=$02000001,
		tknLabel=$02000002,tknDelimiter=$02000003,tknEnd=$02000004,tknJump=$02000005,
		tknQualifier,
		tknReserved=$04000000,tknFunction=$04000001,tknVariable=$04000002,
		tknArray=$40000000,tknVar=$80000000,tknAll=$FFFFFFFF);


	Ttoken=record
	public
		typ:TtokenType;
		str:string;
		src:string;
		cmt:string;
		function typestr:string;
		function add(c:Ttoken):string;
		function addstr(const s,e:string):string;
		function convstr: string;
		function convblock: Ttoken;
		procedure indent;
		procedure clear;
		procedure trim(d:char);
		function counttoken(s:string):integer;
	end;

	Ptoken=^Ttoken;
	TtokenArray=array of Ttoken;

	Ttokens=record
		null:Ttoken;
		items:TtokenArray;
		function add(s:Ttoken):Integer;
		function last:Ptoken;
		function clear:Integer;
		function count:Integer;
		function hi:Integer;
		function structureis(position:integer;arg: array of TtokenType): boolean;
		function structure:string;
		function source:string;
		function getstring(Index:Integer):string;
		procedure putstring(Index:Integer;const s:string);
		property strings[Index:Integer]:string read getstring write putstring;

		function get(Index:Integer):Ttoken;
		procedure put(Index:Integer;const s:Ttoken);
		property item[Index:Integer]:Ttoken read get write put;default;

		//	  function del(i:Integer): Integer;
		function ins(t:Integer;s:Ttoken): Integer;
		function move(f,t:Integer): Integer;
	private
		function structureisstr(position:Integer;arg:TStringDynArray):Integer;
		function sourcestructure: string;
	end;

	TStringSelf=class(TStringList)
	public
		buf:string;
		function this:TStringList;
	end;

	TStringDynArrayHelper=record helper for TStringDynArray
		function add(s:string):Integer;
		function adduni(s:string):Integer;

		function item(i:Integer):String;
		function cat(s,e:string):String;
		function stringselfcreate:TStringSelf;
		function load(f:string):boolean;
		function save(f:string):boolean;
		function getcount:Integer;
		procedure setcount(const i:Integer);
		procedure clear;
		function hi:Integer;
		property count:Integer read getcount write setcount;
	end;

	TGrid=class(TStringGrid)
	type
		TFuncXY = reference to procedure(x,y: Integer);
	private
		constructor CreateEX(Origin:TStringGrid);
		procedure WMChar(var Msg:TWMChar);message WM_CHAR;
		procedure KeyDown(var Key:Word;Shift:TShiftState);override;
		procedure MouseDown(Button:TMouseButton;Shift:TShiftState;
			X,Y:Integer);override;
		function DoMouseWheelDown(Shift:TShiftState;MousePos:TPoint)
			:boolean;override;
		function DoMouseWheelUp(Shift:TShiftState;MousePos:TPoint)
			:boolean;override;
	function ColExpand(min: Integer): Integer;
	function RowDelete(y, cnt: integer): integer;
    function RowInsert(y, cnt: integer): integer;
    function RowClear(y, cnt: integer): integer;

	public
		saverect:TGridRect;
		buf:TGrid;

		procedure cutcopy(modecut:boolean);
		function paste:TGridRect;
		function selrowdo(func:TFuncXY):integer;
		function seldo(func:TFuncXY):integer;
		procedure copy(G:TGrid);
		procedure save;
		procedure seldel;

	published
		property InplaceEditor;
	end;





	TFormCBtoDEL=class(TForm)
		Panel1:TPanel;
	PanelDel: TPanel;
		DEL:TRichEdit;
		CB:TRichEdit;
	SplitterDel: TSplitter;
		PanelTop: TPanel;
		MainMenu1: TMainMenu;
		MConv: TMenuItem;
		MSave: TMenuItem;
		MLoad: TMenuItem;
		MCut: TMenuItem;
		MCopy: TMenuItem;
		MPaste: TMenuItem;
		CG: TStringGrid;
	Splitter2: TSplitter;
	MFolder: TMenuItem;
	PopupMenu1: TPopupMenu;
	PCut: TMenuItem;
	PCopy: TMenuItem;
	PPeste: TMenuItem;
	N8: TMenuItem;
	PopupMenu2: TPopupMenu;
	MGCut: TMenuItem;
	MGCopy: TMenuItem;
	MGPaste: TMenuItem;
	MenuItem5: TMenuItem;
	MGIns1: TMenuItem;
	MGIns2: TMenuItem;
	MGIns5: TMenuItem;
	MGIns6: TMenuItem;
    MGIns7: TMenuItem;
	MenuItem13: TMenuItem;
	MGInsb1: TMenuItem;
	MGInsb2: TMenuItem;
    MGInsb3: TMenuItem;
    MGInsb4: TMenuItem;
    MGInsb6: TMenuItem;
	Panel3: TPanel;
	Label2: TLabel;
	EditLineBlock: TEdit;
	Label1: TLabel;
	EditSet: TEdit;
    MGRowDup: TMenuItem;
	MGRowDel: TMenuItem;
    MSDvrow: TMenuItem;
	MSet: TMenuItem;
	MFixed: TMenuItem;
	MSLSource: TMenuItem;
	MSLStruct: TMenuItem;
	MGRowIns: TMenuItem;
	ButtonOk: TButton;
	EditVarBlock: TEdit;
	Label3: TLabel;
	MGIns3: TMenuItem;
	MGIns4: TMenuItem;
	MGComment: TMenuItem;
	MGInsb7: TMenuItem;
	MSExp: TMenuItem;
	KEY: TMemo;
	N001: TMenuItem;
	x01: TMenuItem;
	r0xxx1: TMenuItem;
	e0xxxxxx1: TMenuItem;
	N1: TMenuItem;
	LOG: TListBox;
	TMP: TComboBox;
	PConv: TMenuItem;
    MSVarProc: TMenuItem;
    MSVar: TMenuItem;
	MSOrg: TMenuItem;
    MSFont: TMenuItem;
    FontDialog: TFontDialog;
    MSHit: TMenuItem;
	procedure MConvClick(Sender: TObject);
	procedure MSaveClick(Sender: TObject);
	procedure MLoadClick(Sender: TObject);
	procedure MCutClick(Sender: TObject);
	procedure MCopyClick(Sender: TObject);
	procedure MPasteClick(Sender: TObject);
	procedure FormCreate(Sender: TObject);
	procedure CGSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
	procedure FormDestroy(Sender: TObject);
	procedure MFolderClick(Sender: TObject);
	procedure ButtonT0Click(Sender: TObject);
	procedure MenuItemGridClick(Sender: TObject);
	procedure MenuItemGrid2Click(Sender: TObject);
	procedure MGRowDupClick(Sender: TObject);
	procedure MGRowDelClick(Sender: TObject);
	procedure MSetClick(Sender: TObject);
	procedure MGCommentClick(Sender: TObject);
	procedure CBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
	procedure MGCopyClick(Sender: TObject);
	procedure MGCutClick(Sender: TObject);
	procedure MGPasteClick(Sender: TObject);
	procedure MGRowInsClick(Sender: TObject);
	procedure MSFontClick(Sender: TObject);

	private
	procedure logadd(s: string);

	public
	   inidir:String;
		function statements(breakchar:string):Ttoken;

	end;
	function tknget(var pos:pchar;str:pchar;strdeli:CHAR):TtokenType;






var
	FormCBtoDEL:TFormCBtoDEL;

implementation

{$R *.dfm}

uses
	strutils
	,IniFiles ,Masks,Clipbrd, Winapi.ShellAPI,Vcl.FileCtrl;

const
	TKNMAXLEN=1024;
	NULLNULL =#0#0;
	CR       =#13;
	LF       =#10;
	CRLF     =#13#10;
	TAB      =#9;
	CHEAD=',入力,出力,宣言';

var PCol, PRow: Integer;
	Ini: TIniFile;
	filename:string;
	txtfile:string;
	csvfile:string;
	Src        :String;
	lineblock:TStringDynArray;
	varblock:TStringDynArray;
	xs,ys,xw,yw:Integer;
	line,pline :Integer;
	b          :TButton;
	p          :pchar;
	pp         :pchar;
	dstt       :Ttoken;
	dsrc       :STRING;
	s          :STRING;
	ss         :STRING;
	sss        :STRING;
	tkntyp     :TtokenType;
	modecell   :boolean;
	modesheet  :boolean;
	col,row    :Integer;
	ia         :TIntArray;
//	StrArray   :TArray<string>;
//	tknArray   :TArray<Ttoken>;
	str        :STRING;
	indent     :Integer;
	regmatchstr:TStringDynArray;
	tkn :Ttoken;
	ptkn:Ptoken;
	宣言中:boolean;
	宣言名:string;
	blocktype:string;
	gprevp:PChar;
	varlist:TStringDynArray;
	varpos:integer;
	level:integer;


procedure TFormCBtoDEL.FormCreate(Sender: TObject);
begin
   Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
   inidir    := Ini.ReadString( '', 'inidir', inidir );


	CG :=TGrid.CreateEX(CG);
//	CG.OnKeyDown:=CGKeyDown;
	MLoadClick(sender);
	PCol:=CG.Col;
	PRow:=CG.Row;
    ActiveControl:=CB;
	end;



procedure TFormCBtoDEL.FormDestroy(Sender: TObject);
var M:TMenuItem;
	s:string;
begin
	Ini.WriteInteger('','Width', Width );
	Ini.WriteInteger('','Height', Height );
	Ini.WriteInteger('','PanelTop.Height',PanelTop.Height);
	Ini.WriteInteger('','PanelDel.Width',PanelDel.Width);
	Ini.WriteInteger('','Font.Size',Font.Size);

	for m in MSet do Ini.WriteString( '',M.Caption,IfThen(M.Checked,'1','0'));
	Ini.Free;
end;



procedure TFormCBtoDEL.logadd(s:string);
begin
	log.items.add(s);
//	LOG.Perform(EM_LINESCROLL, 0, LOG.Lines.Count);
//	LOG.Perform(EM_SCROLL, SB_LINEUP, 0);
	LOG.TopIndex:=LOG.Count-1;
end;


function dmessage(m:string):TModalResult;
begin
	result:=MessageDlg(m, mtInformation, [mbYes], 0);
end;


function split(s:string;i:integer;d:string=' '):string;
begin
	result:=SplitString(s,d).item(i);
end;


procedure TFormCBtoDEL.ButtonT0Click(Sender: TObject);
begin
//	TGrid(CG).InplaceEditor.seltext:=TButton(Sender).Caption;
	CG.cells[CG.col,CG.row]:=CG.cells[CG.col,CG.row]+TButton(Sender).Caption;
end;


procedure TFormCBtoDEL.CGSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
//	CG.Options:=CG.Options-[goEditing];
	if CG.Canvas.TextWidth('aa'+Value)>CG.ColWidths[ACol] then CG.ColWidths[ACol]:=CG.Canvas.TextWidth('aa'+Value);
	if ARow=CG.RowCount-1 then CG.RowCount:=CG.RowCount+1;
	if ACol=CG.ColCount-1 then CG.ColCount:=CG.ColCount+1;
end;


procedure TFormCBtoDEL.MLoadClick(Sender: TObject);
var SL:TStringDynArray;
	i:integer;
	M:TMenuItem;

	procedure MemoTabChange(memo : TRichEdit; width : longint);
	begin
		memo.SelectAll;
		width := width * LoWord(GetDialogBaseUnits) div 2;
		memo.Perform(EM_SETTABSTOPS, 1, longint(@width));
		memo.Invalidate;
	end;
begin

	MemoTabChange(CB,4);
	MemoTabChange(DEL,4);

	varblock:=SplitString(EditVarBlock.text,' ');
	lineblock:=SplitString(EditLineBlock.text,' ');

	if DirectoryExists(inidir) then begin
		filename:=IncludeTrailingBackslash(inidir)+'CBtoDEL'+EditSet.text;
		Ini.Free;
		Ini := TIniFile.Create(ChangeFileExt(filename,'.INI'));
	end else begin
		filename:=ChangeFileExt(Application.ExeName,'')+EditSet.text;
	end;
	txtfile:=ChangeFileExt(filename,'.txt');
	csvfile:=ChangeFileExt(filename,'.csv');
	caption:=csvfile;

	try
		for M in MSet do
			M.Checked:=Ini.ReadBool( '',M.Caption,M.Checked);
		Width     := Ini.ReadInteger( '', 'Width', Width );
		Height    := Ini.ReadInteger( '', 'Height', Height );
		PanelTop.Height    := Ini.ReadInteger( '', 'PanelTop.Height', PanelTop.Height );
		PanelDel.Width    := Ini.ReadInteger( '', 'PanelDel.Width', ClientWidth div 2 );
		Font.Size:=Ini.ReadInteger('','Font.Size',Font.Size);
		CB.Font:=font;
		DEL.Font:=font;
		CB.Lines.Clear;
		CB.Lines.LoadFromFile(txtfile);
		logadd('読込:'+txtfile);
	except
	end;

	try
		CG.RowCount:=1;
		CG.DrawingStyle:=gdsClassic;
		CG.DefaultRowHeight:=round(-Font.Height*1.5);
		SL.load(csvfile);
		CG.RowCount:=SL.count;
		for i:=0 to SL.hi do begin
			TMP.Items.Delimiter:=',';
			TMP.Items.QuoteChar:='"';
			TMP.Items.StrictDelimiter:=true;
			TMP.Items.DelimitedText:=sl[i];
			CG.rows[i]:=TMP.Items;
		end;

		CG.ColCount:=SplitString(CHEAD,',').count;
		CG.Rows[0].CommaText:=CHEAD;
		CG.FixedCols:=1;
		CG.FixedRows:=1;

		TGrid(CG).save;
		TGrid(CG).ColExpand(10);

		logadd('読込:'+csvfile);

	except

	end;
		//CG.color:=clGray;


	ActiveControl:=CG;
end;

procedure TFormCBtoDEL.MSaveClick(Sender: TObject);
var SL:TStringDynArray;
	i:integer;
begin
	for i:=0 to CG.RowCount-1 do begin
		CG.rows[i].StrictDelimiter:=true;
		CG.rows[i].Delimiter:=',';
		CG.rows[i].QuoteChar:='"';
		SL.add(CG.rows[i].DelimitedText);
	end;
	SL.save(csvfile);
	logadd('保存:'+csvfile);

	CB.Lines.SaveToFile(txtfile);
	logadd('保存:'+txtfile);



end;









function indenttab:string;
begin
	result:=StringOfChar(TAB,indent);
end;

function indenttabplus:string;
begin
	inc(indent);
	result:=StringOfChar(TAB,indent);
end;

function indentstr(s:string):string;
begin
	result:=indenttab+s;
end;

function indentcr:string;
begin
	result:=CRLF+indenttab;
end;

function tryaddstr(s,b:string):string;
var ss:string;
begin
	ss:=trimright(s);
	if ss='' then exit(s);
	if ss[Length(ss)]<>b then result:=ss+b else result:=s;
end;

function existstr(s,a,b:string):string;
begin
	if s<>'' then result:=a+s+b;
end;


function regextract(t,s,d,f:string):string;
var
	m: TMatch;
	g:TGroup;
begin
	result:='';
	for m in TRegEx.Matches(t,s) do begin
		for g in m.Groups do begin
			if g.Value=m.Value then continue;
			if result<>'' then result:=result+d;
			result:=result+f+(g.Value);
		end;
	end;
end;


function regmatch(t,s:string;var matchstr:TStringDynArray):boolean;
var
	regex: TRegEx;
	match: TMatch;
	g:TGroup;
	i:integer;
begin
	regex := TRegEx.Create(s);
//		regmatchstr:=regex.Matchs(t);
	match := regex.Match(t);
	result:=match.Success;
	for i:=1 to match.Groups.Count-1 do begin
		g:=match.Groups.Item[i];
		matchstr.add(g.Value);
		matchstr[0]:=inttostr(matchstr.count);

	end;
end;


function TFormCBtoDEL.statements(breakchar:string):Ttoken;
var
	tkns:Ttokens;
	stkn:Ttoken;
	s宣言中:boolean;
	s宣言名:string;
	sblocktype:string;
	svarlist:TStringDynArray;
	改行まで:boolean;

	イフ:boolean;
	次へ:boolean;
	prevtknp:PChar;

	procedure tknback;
	begin
		p:=gprevp;
	end;

	function gettoken:Ttoken;
	var
		t:TtokenType;
		s:string;
		ret:string;
		src:string;
		prevp:PChar;

		buf:array [0..1024] of CHAR;
		procedure get;
		begin
			prevp:=p;
			t:=tknget(p,buf,'''');
			s:=buf;
		end;
//		procedure ifadd(tt:TtokenType);
//		begin
//			if t<>tt then exit;
//			ret:=s;
//			get;
//			ret:=ret+' '+s;
//		end;
//		procedure add(tt:TtokenType);
//		begin
//			if t<>tt then exit;
//			ret:=s;
//			repeat
//				if ret='' then ret:=s else ret:=ret+' '+s;
//				get;
//			until t<>tt;
//			p:=pp;
//			t:=tt;
//		end;


		function replacegrid:boolean;
		var c,r:integer;
		var par:string;
		var rep:string;
		i:integer;

			function comp:boolean;
			var ss:string;
				pp:PChar;
				tt:TtokenType;
			begin
				pp:=PChar(par);
				result:=true;
				p:=prevtknp;
				src:='';
				repeat
					tt:=t;
					get;
					tknget(pp,buf,'''');
					ss:=buf;
					if ss='' then begin//先読み分戻す
						p:=prevp;
						t:=tt;
						break;
					end;
					src:=src+s;
					if s<>ss then exit(false);
				until(p[0]=#0);
			end;
//			function read:string;
//			var ss:string;
//				pp:PChar;
//			begin
//				p:=PChar(par);
//				result:=s;
//				while(p[0]<>#0)do begin
//					t:=tknget(p,buf,'''');
//					get;
//					result:=result+s;
//				end;
//			end;

		begin
			result:=false;
			for r := 1 to CG.RowCount do begin
				if CG.cells[0,r]<>'置換' then continue;
				par:= CG.cells[1,r];
				rep:= CG.cells[2,r];
				if MatchesMask(par,'/*/') then begin
					par:=par.Trim(['/']);
					p:=prevp;
					get;
					src:=s;
					ret:=TRegEx.Replace(src,par,rep);
					if ret<>src then begin
						if MSDvrow.Checked then CG.Selection:=TGridRect(Rect(1,r,3,r));
						exit(true);
					end;
				end;

				if comp then begin
					if MSDvrow.Checked then CG.Selection:=TGridRect(Rect(1,r,3,r));
					if rep='' then begin
						t:=tknError;
						p:=prevp;
					end;
					ret:=rep;
					exit(true);
				end;
			end;
		end;
	begin
		repeat
			prevtknp:=p;
			if not replacegrid then begin
				p:=prevtknp;
				get;
				src:=s;
				ret:=s;
			end;
			if t<>tknError then
				break;
		until (p[0]=#0);

		str:=ret;
		result.typ:=t;
		result.str:=ret;
		result.src:=src;
	end;


	procedure ブロックタイプ(s:string);
	begin
		sblocktype:=blocktype;
		blocktype:=s;
	end;

	procedure ブロックタイプ戻す;
	begin
		sblocktype:=blocktype;
	end;

	function 変数宣言(var t:Ttoken;names:TStringDynArray):boolean;
	var tt:ttoken;
	begin
		result:=false;
		if MSVar.Checked then begin
			if MatchStr(blocktype,names) then begin
				if varlist.count>0 then begin
					tt:=t;
					tt.indent;
					if MSVarProc.Checked then begin
						t.str:='TProc(procedure '+varlist.cat('',CRLF)+'begin'+CRLF+tt.str+'end)();'+CRLF;
					end else begin
						t.str:=varlist.cat('//',CRLF)+'begin'+CRLF+t.str+'end;'+CRLF;
					end;
					t.typ:=tknBlock;

					varlist:=svarlist;
//					varlist.clear;
					exit(true);
				end;
			end;
//			 else if blocktype='function' then begin
//				if varlist.count>0 then begin
//					t.str:=varlist.cat('',CRLF)+t.str+CRLF;
//					varlist.clear;
//				end;
//			end;
		end;
	end;


	function reconstruct(tkns:Ttokens):Ttoken;
	var
		tkn :Ttoken;
		p :Ptoken;
		stype :TtokenType;
		block :boolean;
		dstt:STRING;
		strc:STRING;
		ssrc:STRING;
		param:TStringDynArray;
		pcnt1:integer;
		pcnt2:integer;
		pcnt3:integer;
		valname:STRING;
		valvar:STRING;
		i:integer;
		pos:integer;
		posstart:integer;
		bindent:integer;

		function gets(i:integer):string;   //
		begin
			result:=tkns[i].str+tkns[i].cmt;
		end;


		function getstr(i:integer):string;   //
		begin
			result:=tkns[posstart+i].str+tkns[posstart+i].cmt;
		end;

		function getstradd(i:integer;s:string):string;   //
		begin
			result:=tkns[posstart+i].str+s+tkns[posstart+i].cmt;
		end;

		function getsrc(i:integer):string;   //
		begin
			p:=@tkns.items[posstart+i];
//			if p.typ=tknCBlock then begin
//				result:='{ '+p.src+' }';
//			end else if tkns[i].typ=tknKBlock then
//				result:=' ( '+p.src+' )'
//			else
				result:=p.src+p.cmt;
		end;

		function get(i:integer):string;   //
		begin
			inc(i,posstart);
			if tkns[i].typ=tknBlock then begin

				result:=tryaddstr(gets(i),';')+CRLF;  //existstr(gets(i),'',';'+CRLF);

			end else if tkns[i].typ=tknCBlock then begin

				result:='begin'+CRLF+gets(i)+'end;'+CRLF;

			end else if tkns[i].typ=tknKBlock then
				result:='('+tkns[i].str+')'+tkns[i].cmt
			else
				result:=tkns[i].convstr+tkns[i].cmt;
		end;

		function incget(i:integer):string;
		begin
			result:=get(i);
			inc(pos);
		end;

		function incgetval(i:integer):string;
		begin
			result:=tkns[posstart+i].str;
			valname:=result;
			inc(pos);
		end;

		function incgetsrc(i:integer):string;
		begin
			result:=tkns[posstart+i].str;
			inc(pos);
		end;

		function cat(pos:integer):string;   //最後までくっつける 最後の；なし
		var i:integer;
		begin
			result:='';
			for i:=posstart+pos to tkns.hi do begin
//					if (i=tkns.hi)and(tkns[i].str=';') then break;

				if result<>'' then result:=result+' ';
				result:=result+get(i-posstart);
			end;
//				result:=dtrimstring(result,' ;');
			result:=result.trimright([' ',';',CR,LF]);
		end;

		function inccat:string;   //最後までくっつける
		begin
			result:='';
			while pos<=tkns.hi do begin
				if result<>'' then result:=result+' ';
				result:=result+incget(pos-posstart);
			end;
			result:=result.trimright([' ',';',CR,LF]);
		end;

		function inccatfor(i:integer;s:string):string;
		begin
			result:='';
			pos:=i;
			while pos<=tkns.hi do begin
				if result<>'' then result:=result+' ';
				result:=result+get(pos);
				inc(pos);
				if tkns[pos].str=s then break;
			end;
		end;

		function sis(a:string):integer;
		begin
			if trim(a)='' then exit(0);
			result:=tkns.structureisstr(posstart,SplitString(a,'｜'));
			if MSHit.Checked then
				if result>0 then
					LOG.Items[LOG.Count-1]:=LOG.Items[LOG.Count-1]+'['+a+']';

		end;


		function replacegrid(var ret:string;var stype :TtokenType):boolean;
		var c,r:integer;
		var lab:string;
		var par:string;
		var para:TStringDynArray;
		var rep,rep2:string;
		var vrv:string;
		var con:string;
		var s:string;
		var ns:string;
		const a=1;
		var b:integer;
		i:integer;
		var inccnt:integer;
		idx:integer;
		regreplaccestr:TStringDynArray;

			//pからtsを左に抜き取り
			function trimrightlen(const s,ts:string;var p,m:integer):string;
			var
				i:integer;
				ei:integer;
				si:integer;
			begin
				result:='';
				ei:=p+1;
				for i:=p downto 1 do begin
					if(system.Pos(S[i],ts)<>0)then continue;
					p:=i;
					break;
				end;
				if p=0 then exit; //すべて削除文字
				dec(m,ei-p-1);
				si:=1;
				result:=Copy(S,si,p-si+1);
				result:=result+Copy(S,ei);
			end;

			procedure replace(var rep:string);
			var rc:integer;
			var c:integer;
			var rm:integer;
			var ri:integer;
			var rs:string;
			var rsd:string;
			regmtc: TMatchCollection;
			regmt: TMatch;
			regg: TGroup;
			var t:string;
			var s:string;
			var subc:integer;
			var subd:string;
			var subs:string;
			var subr:string;
			SA:TStringDynArray;

			function dele:boolean;
			begin
				if regmt.Value.indexof(s)<>0 then exit(false);
				result:=true;
			end;

			function setrs(const s,v:string):boolean;
			begin
				if regmt.Value.indexof(s)<>0 then exit(false);
				rs:=v;
				result:=true;
			end;

			begin
				//regmtc:=TRegEx.Matches(rep,'%[^%]*%');
				rep:=StringReplace(rep,'⇒',indenttab,[rfReplaceAll]);
				rep:=StringReplace(rep,'→',TAB,[rfReplaceAll]);
				rep:=StringReplace(rep,'｜',CRLF,[rfReplaceAll]);
				regmtc:=TRegEx.Matches(rep,'%([a-zA-Z]*)([0-9]*)([^%]?)([^%]*)%');
				rm:=0;
				for rc:=0 to regmtc.Count-1 do begin
					rs:='';
					regmt:=regmtc[rc];
					ri:=regmt.Index-1+rm;
					if regmt.Groups.Count<>5 then continue;
					subs:=regmt.Groups[0].value;
					t:=regmt.Groups[1].value;
					c:=StrToIntDef(regmt.Groups[2].value,0)-1;
					subd:=regmt.Groups[3].value;
					subr:=regmt.Groups[4].value;

					if (t='CR')and(c>=0) then begin
						if MatchesMask(tkns[posstart+c].cmt,'*'+CRLF) then
							rs:=CRLF;
					end else
					if t='CR' then rs:=CRLF else
					if t='E'  then rs:=indenttab+'end;' else
					if t='T'  then rs:=TAB   else
					if t='var'  then begin
						if MSVar.Checked then begin
							if varlist.count>0 then begin
								if MSVarProc.Checked then
									rs:=varlist.cat('',CRLF)
								else
									rs:=varlist.cat('//',CRLF);
								varlist.clear;
							end;
						end;
					end else
					if t='i' then
						tkns.items[c].indent else
//					if t+subd='i'  then rs:=indenttab else
//					if t+subd='i+'  then rs:=indenttabplus  else
					if t='d'  then rep:=trimrightlen(rep,'; '+CRLF,ri,rm) else
					if t='x' then rs:=regmatchstr.item(c+1) else
					if t='e' then begin
						s:=para[c].Trim(['/']);
						rs:=regextract(getsrc(c),s,subd,subr);
					end else
					if t='r' then begin
						s:=para[c].Trim(['/']);
						rs:=TRegEx.Replace(getsrc(c),s,subr)
					end else
					if (t='c') and (subd<>'') then
						rs:=inccatfor(c,subd) else
					if t='c' then begin
						pos:=c; rs:=inccat; end else
					if t='o' then begin
						if MSOrg.Checked then rs:='{'+getsrc(c)+'}'
					end else
					if t='s' then begin
						rs:=getstradd(c,subd+subr);

					end else
					if subd<>'' then begin
						subc:=StrToIntDef(regmt.Groups[4].value,0);
						rs:=trim(split(getstr(c),subc-1,subd));
					end else rs:=get(c);



					rep:=rep.remove(ri,regmt.Length);
					rep:=rep.insert(ri,rs);
					rm:=rm-regmt.Length+rs.length;
				end;
			end;


		begin
			result:=false;
			for r := 1 to CG.RowCount do begin
				lab:=CG.cells[0,r];
				if lab.indexof('//')=0 then continue;
				if lab.indexof('置換')=0 then continue;
				lab:=split(lab,1,'｜');
				if (blocktype='') then begin
					if (lab<>'') then continue;
				end else begin
					if (lab<>'')and(lab<>blocktype) then continue;
				end;
				par:= CG.cells[1,r];
				para:=SplitString(par,'｜');
				rep:= CG.cells[2,r];
				vrv:= CG.cells[3,r];
				inccnt:=sis(par);
				if inccnt>0 then begin
					if MSDvrow.Checked then CG.Selection:=TGridRect(Rect(1,r,3,r));

					replace(vrv);
					replace(rep);
//					idx:=rep.IndexOf('var');　
//					if idx>0 then begin
//						varstr:=varstr+rep.Substring(idx)+CRLF;
//						rep:=rep.Remove(idx);
//					end;

//					if pos<>tkns.count then inc(pos,inccnt);
					pos:=posstart+inccnt;

					if 宣言中 then begin
						ret:=vrv;

					end else begin
						if vrv.IndexOf('var')=0 then begin
							varlist.adduni(vrv);
						end;
						ret:=rep;
					end;

					result:=true;
					break;
				end;
			end;
		end;

		procedure adds(var s:string;a:string);
		begin
			if s<>'' then
				if not (s[length(s)] in [' ',CR,LF,TAB]) then
					s:=s+' ';
			s:=s+a;
		end;
	begin
		dstt:='';
		strc:=tkns.structure;
		ssrc:=tkns.sourcestructure;

		if MSLSource.Checked then logadd(indentstr(ssrc));
		if MSLStruct.Checked then logadd('名称:'+宣言名+' タイプ:'+blocktype+'|'+indentstr(strc));
		if MSHit.Checked then logadd('');
		pos:=0;
		bindent:=indent;
		block:=false;
		try
		for i := 0 to tkns.hi do begin
			if i<pos then continue;
			pos:=i;
			tkn:=tkns[i];
			s:=tkn.convstr;
			if s=CRLF then begin
				posstart:=pos;
				continue;
			end;
			posstart:=pos;
			stype:=tknVoid;
			valname:='';
			s:='';

			if replacegrid(s,stype) then begin
				stype:=stype;
			end else
			if sis('(*)')>0 then begin //
				s:=incget(0);
				stype:=tknKBlock;
			end else
			if sis('{*}')>0 then begin //
				stype:=tknCBlock;
				s:=incget(0);
				block:=true;
			end else begin
				s:=incget(0);
			end;

			if stype=tknVar then else
			if stype=tknFunction then adds(dstt,s+';'+CRLF) else
			if stype=tknLabel then adds(dstt,s) else
			if stype=tknCBlock then adds(dstt,s) else
				adds(dstt,s);
		end;
		except
			dmessage('replacegrid:'+ssrc);
		end;
		indent:=bindent;

		//dstt:='{##}'+dstt+'';
		tkn.typ:=stype;
		tkn.str:=dstt;
//		blocktype:=tkns[0].str;
		変数宣言(tkn,['do','while','for']);
		dstt:=tkn.str;



		result.src:=tkns.source;
		result.typ:=stype;
		result.str:=dstt;
	end;


	function token(const str, src: string; typ: TtokenType): Ttoken;
	begin
		result.str:=str;
		result.src:=src;
		result.typ:=typ;
	end;

	function 配列括弧:Ttoken;
	var
		ret:Ttoken;
		DEL:Ttoken;
	begin
		DEL.src:='][';
		DEL.str:=',';
		while (p[0]<>#0)and(str='[') do begin
			if result.str<>'' then result.add(DEL);

			result.add(statements(']'));
			if str=']' then gettoken;
		end;
		p:=prevtknp;
		result.addstr('[',']');
	end;

	function クラス初期化:Ttoken;
	begin
		result:=statements(';{');
		result.typ:=tknBlock;
		if str='{' then tknback;

	end;


	function 丸括弧(m:boolean):Ttoken;
	var s:Ttoken;
	begin
		result:=s;
		s宣言中:=宣言中;
		宣言中:=m;        //関数の中は宣言中
		ブロックタイプ('()');
		while p[0]<>#0 do begin
			s:=statements(',)');
			result.add(s);
			if str=')' then break;
		end;
		result.typ:=tknKBlock;
		if str=';' then result.addstr('',' ');
		ブロックタイプ戻す;
		宣言中:=s宣言中;
		tkns.add(result);
	end;

	function tknnextis(s:string):boolean;
	var ss:string;
	var pp:pchar;
	begin
		ss:=str;
		pp:=p;
		repeat
			gettoken;
		until str<>CRLF;
		if str=s then result:=true;
		str:=ss;
		p:=pp;
	end;


	procedure tknnext;
	var s:Ttoken;
	var ret:Ttoken;
	begin
		gprevp:=p;
		repeat
			ret:=gettoken;
			if str=CRLF then begin
				inc(line);
				if 改行まで then begin
					break;
				end;
			end;
		until str<>CRLF;

		ptkn:=tkns.last;
		if ret.typ=tknReserved then begin
			while (p[0]<>#0) do begin
				s:=gettoken;
				if s.str='[' then begin      //配列
					ret.add(配列括弧);
					continue;
				end else if s.convstr='.' then begin  //メンバ参照
					s.str:=s.convstr;
					ret.add(s);
					ret.typ:=tknReserved;
					s:=gettoken;
					if s.typ=tknReserved then begin
						ret.add(s);
						continue;
					end else begin
						p:=prevtknp;
						break;
					end;
				end else begin
					p:=prevtknp;
					break;
				end;
			end;
		end;
		tkn:=ret;
		str:=tkn.str;
	end;


	procedure 改行保持next(back:boolean);
	var ss:string;
	begin
		stkn:=tkn;
		ss:=str;
		repeat
			gprevp:=p;
			tkn:=gettoken;
			ptkn:=tkns.last;
			if str=CRLF then begin
				ptkn.cmt:=ptkn.cmt+CRLF;
				continue;
			end else if tkn.typ=tknComment then begin
				ptkn.cmt:=ptkn.cmt+tkn.str;
			end else begin
				if back then begin
					tknback;
					tkn:=stkn;
					str:=ss;
				end;
				break;
			end;
		until str<>CRLF;
	end;

	function 式変換(最初:boolean): boolean;
	var
		演算子:array of TStringDynArray;
		count:integer;
		var あった:boolean;
		var cpos1: integer;

		function カッコ(cpos1,ipos: integer): boolean;
		var cpos2: integer;
		begin
			if ipos>High(演算子) then exit(false);

			result:=カッコ(cpos1,ipos+1);
			if MatchText(tkn.str, 演算子[ipos]) then begin
				repeat
					tkns.add(tkn);
					tknnext;
					if tkn.str='(' then begin
						丸括弧(true);
						tknnext;
					end else begin
						tkns.add(tkn);
						tknnext;
						if tkn.str='(' then begin
							丸括弧(true);
							tknnext;

						end;

					end;
					result:=カッコ(tkns.hi,ipos+1);
				until not MatchText(tkn.str, 演算子[ipos]);
				cpos2:=tkns.count+1;
				tkns.ins(cpos1,token('(','(',tknDelimiter));
				tkns.ins(cpos2,token(')',')',tknDelimiter));
				最初:=false;
				あった:=true;
				result:=true;
			end;
		end;
	begin
		if not MSExp.checked then exit(false);
		if tkn.typ<>tknReserved then
			if tkn.typ<>tknNumber then
				 exit(false);
		count:=0;
		演算子:=[['||'],['&&'],['!'],['==','!=','<','>','>=','<=']];

		tkns.add(tkn);
		cpos1:=tkns.hi;
		tknnext;
		if tkn.str='(' then begin//関数
			丸括弧(true);
			tknnext;
		end;
		if breakchar.Contains(str) then exit(true);
		あった:=false;
		カッコ(cpos1,0);
		result:=あった;
	end;


	function 式:Ttoken;
	begin
		inc(indent);
		result:=statements(';}');
		result.typ:=tknBlock;
		if result.counttoken(';')>1 then
			result.typ:=tknCBlock;//複合になった
		result.indent;
		dec(indent);
	end;


	function 複合文:Ttoken;
	var s:Ttoken;
	begin
		result.clear;
		inc(indent);
		svarlist:=varlist;
//		varlist.clear;

		while p[0]<>#0 do begin
			result.add(statements(';}'));
			//自分の｝をどう判断するか

			if str='}' then break;
		end;
		result.typ:=tknCBlock;
		result.indent;

		変数宣言(result,['','if','while']);
//		if 変数宣言(result,['','if']) then
//			varlist:=svarlist;


		dec(indent);
	end;

	function ケース:Integer;
	var s:Ttoken;
		ts:Ttokens;
	begin
		result:=0;
		inc(indent);
		while p[0]<>#0 do begin
			if(str='case')or(str='default') then begin
				if str='case' then begin
					ts.add(tkn);
					tknnext;
					ts.add(tkn);
				end else begin
					ts.add(tkn);
				end;
				tknnext;
				if str=':' then 	ts.add(tkn);
				tknnext;
				if str='case' then continue;
				if str='{' then begin
					ts.add(複合文);
					if str='}' then tknnext;
				end else begin;
					tknback;
					ts.add(式);
					if str=';' then tknnext;
				end;
			end else
				tknnext;

			if str='}' then break;
		end;

		tkns.add(reconstruct(ts));
		tkns.last.typ:=tknCBlock;
		tkns.last.indent;
		dec(indent);
	end;

	function 文:Integer;
	var
		s:string;
		key:string;
		s宣言中:boolean;
	begin
		改行まで:=false;
		次へ:=false;
		while (p[0]<>#0) do begin
			tknnext;

			if tkn.typ=tknComment then begin
//					if tkns.count>0 then //前の要素に足す
//				dsrc:=dsrc+tkn.str;
				if pline=line then begin
					ptkn.cmt:=tkn.str;
					continue;
				end;
				continue;
			end;

			if MatchStr(str,lineblock) then begin
				改行まで:=true;
			end else if MatchStr(str,varblock) then begin
				宣言中:=true;
				blocktype:=str;
				tkns.add(tkn);
				tknnext;
				if str<>'{' then begin
					宣言名:=str;
					tkns.add(tkn);
					continue;
				end;
			end;

			if MatchStr(str,['if']) then begin
				Key:=str;
				tkns.add(tkn);
				ブロックタイプ(str);
				if tknnextis('(') then begin
					tknnext;
					丸括弧(false);
					if tknnextis('{') then begin
						tknnext;
						tkns.add(複合文);
					end else begin;
						tkns.add(式);
					end;
					if tknnextis('else') then begin
						tkns.last.trim(';');
						tknnext;
						tkns.add(tkn);
						if tknnextis('{') then begin
							tknnext;
							tkns.add(複合文);
						end else begin
							tkns.add(式);
						end;
					end else
						continue;
				end;
			end else if MatchStr(str,['while','for']) then begin
				Key:=str;
				tkns.add(tkn);
				if tknnextis('(') then begin
					tknnext;
					丸括弧(false);
					if tknnextis('{') then begin
						ブロックタイプ(key);
						tknnext;
						tkns.add(複合文);
						continue;
					end else begin;
						tkns.add(式);
					end;
				end;
			end else if str='do' then begin
				tkns.add(tkn);
				tknnext;
				ブロックタイプ(str);
				if str='{' then begin
					tkns.add(複合文)
				end else begin;
					tknback;
					tkns.add(式);
				end;
				if str='(' then begin
					丸括弧(false);
					tknnext;
				end;
			end else if str='switch' then begin
				ブロックタイプ(str);
				tkns.add(tkn);
				tknnext;
				丸括弧(false);
				tknnext;
				if str='{' then begin
					ケース;
					tknnext;
				end;
			end else
			if 式変換(true) then begin
//				if breakchar.Contains(str) then break;
//				continue;
			end else if str=CRLF then begin
				inc(line);
				if 改行まで then begin
					break;
				end;
				ptkn.cmt:=ptkn.cmt+CRLF;
				continue;
			end else if str='(' then begin

				丸括弧(true);
				continue;

			end else if str=':' then begin
				tkns.add(tkn);
				tkns.add(クラス初期化);
				continue;
			end;

			if breakchar.Contains(str) then break;
			if str='{' then begin
				if ptkn.typ=tknKBlock then begin
					ブロックタイプ('function');

				end else begin
					ブロックタイプ('{}');

				end;
				tkns.add(複合文);
				//if breakchar.Contains(str) then break;
				continue;
			end;

			tkns.add(tkn);
			pline:=line;

			if not 改行まで then begin
				if str=':' then begin
					if ptkn.typ=tknKBlock then continue;    //前カッコはメンバ初期
					if 宣言中 then continue;//label:
					break;
				end;
			end;


		end;
	end;


begin
	s宣言中:=宣言中;
	s宣言名:=宣言名;
	inc(level);
	tkns.null.clear;
	文;
	LOG.items.BeginUpdate;

	ptkn:=tkns.last;
	if breakchar.Contains(str) then begin
		if str=',' then begin

			tkns.add(tkn);

		end else if str=';' then begin
			if ptkn.typ<>tknBlock then tkns.add(tkn);
			改行保持next(true);
		end;
	end;

	result:=reconstruct(tkns);
	変数宣言(result,['']);


	宣言中:=s宣言中;
	宣言名:=s宣言名;
	dec(level);
	LOG.items.EndUpdate;
end;


procedure TFormCBtoDEL.MConvClick(Sender: TObject);
var
	i, j: Integer;
begin
	LOG.Clear;
//	int l=E->Perform(EM_LINEFROMCHAR,-1,0)+1;
//	int c=E->SelStart-E->Perform(EM_LINEINDEX,-1,0)+1;
//	int le=E->Perform(EM_LINEFROMCHAR, E->SelStart+E->SelLength-1, 0)+1;

	if CB.SelLength>0 then begin
		src:=CB.SelText;
		src:=StringReplace(src, CR, CRLF, [rfReplaceAll]);
		line:=CB.Perform(EM_LINEFROMCHAR, System.NativeUInt(-1), 0)+1;
	end
	else begin
		src:=CB.Text;
		line:=0;
	end;
	pline:=line;
	dsrc:='';
	varlist.clear;
	varpos:=0;
	blocktype:='';
	宣言名:='';
	宣言中:=false;

	p:=pchar(src);
	indent:=0;
	try


//		while (p[0]<>#0) do begin

			dstt:=statements(';}');


			dsrc:=dsrc+dstt.str;
//			dsrc:=dsrc+CRLF;
//		end;

//		if MSVar.Checked then begin
//			if varlist.count>0 then begin
//				dsrc:=indentcr+varlist.cat('',CRLF)+dsrc;
//			end;
//		end;
		DEL.Text:=dsrc;

	except
		on E: Exception do LOG.Items.add(E.Message);
	end;
	if MSDvrow.Checked then
		CG.TopRow:=CG.Row;

end;



procedure TFormCBtoDEL.MCopyClick(Sender: TObject);
	procedure Copy(M:TRichEdit);
	begin
		if not M.Focused then exit;
		Clipboard.AsText:=M.SelText;
		//M.CopyToClipboard;
	end;
begin
	Copy(CB);
	Copy(DEL);
//	Copy(LOG);
	TGrid(CG).CutCopy(false);

end;


procedure TFormCBtoDEL.MCutClick(Sender: TObject);
	procedure Cut(M:TRichEdit);
	begin
		if not M.Focused then exit;
{$IFDEF DEBUG}
		Clipboard.AsText:=M.SelText;
		M.SelText:='';
{$ELSE}
		M.CutToClipboard;
{$ENDIF}

	end;

begin
	Cut(CB);
	Cut(DEL);
//	Cut(LOG);
	TGrid(CG).CutCopy(true);
end;


procedure TFormCBtoDEL.MenuItemGrid2Click(Sender: TObject);
begin
	CG.cells[1,CG.row]:=CG.cells[1,CG.row]+ split(TmenuItem(Sender).Caption,0);

end;

procedure TFormCBtoDEL.MenuItemGridClick(Sender: TObject);
begin
	CG.cells[2,CG.row]:=CG.cells[2,CG.row]+ split(TmenuItem(Sender).Caption,0);

end;



procedure TFormCBtoDEL.MFolderClick(Sender: TObject);
var
  RootFolder   : String;
  SelectFolder : String;
begin
	 RootFolder := '';
	if inidir='' then begin
		  SelectFolder   := ExtractFileDir(Application.ExeName);
	end else begin
		  SelectFolder   := inidir;
	end;
	 if SelectDirectory('設定パス:'+inidir+CRLF+'実行パス:'+Application.ExeName,
		RootFolder,	SelectFolder,[sdNewUI, sdNewFolder, sdShowEdit],Self) then begin
		inidir:=SelectFolder;
		Ini.WriteString( '', 'inidir',inidir);

	 end;

end;



procedure TFormCBtoDEL.MSetClick(Sender: TObject);
begin
	TGrid(CG).saverect:=TGrid(CG).Selection;
	TMenuItem(Sender).Checked:=not TMenuItem(Sender).Checked;
	CG.FixedCols:=(not MFixed.Checked).ToInteger;
	TGrid(CG).Selection:=TGrid(CG).saverect;
end;



procedure TFormCBtoDEL.MSFontClick(Sender: TObject);
begin
 FontDialog.Font:=font;
 if FontDialog.Execute(handle) then
	font:=FontDialog.Font;
end;

//function:String begin Result:='deathma colosseum'end)

procedure TFormCBtoDEL.MGCommentClick(Sender: TObject);
begin
	TGrid(CG).selrowdo(procedure(x,y:integer)begin
		if CG.Cells[0,y].indexof('//')=0 then CG.Cells[0,y]:=CG.Cells[0,y].substring(2)
		else CG.Cells[0,y]:='//'+CG.Cells[0,y];
	end);
end;

procedure TFormCBtoDEL.MGCopyClick(Sender: TObject);
begin
	TGrid(CG).cutcopy(false);
end;

procedure TFormCBtoDEL.MGCutClick(Sender: TObject);
begin
	TGrid(CG).cutcopy(true);
end;

procedure TFormCBtoDEL.MGPasteClick(Sender: TObject);
begin
	TGrid(CG).paste;

end;

procedure TFormCBtoDEL.MGRowDelClick(Sender: TObject);
var r:integer;
begin
	TGrid(CG).save;
	TGrid(CG).selrowdo(procedure(x,y:integer)begin
		TGrid(CG).RowDelete(TGrid(CG).saverect.Top,1);
	end);
	CG.selection:=	TGrid(CG).saverect;
end;

procedure TFormCBtoDEL.MGRowDupClick(Sender: TObject);
begin
	TGrid(CG).save;
	TGrid(CG).selrowdo(procedure(x,y:integer)begin
		TGrid(CG).RowInsert(y,1);
		CG.Rows[y]:=CG.Rows[y+1];
	end);
	CG.selection:=	TGrid(CG).saverect;
end;

procedure TFormCBtoDEL.MGRowInsClick(Sender: TObject);
begin
	TGrid(CG).save;
	TGrid(CG).selrowdo(procedure(x,y:integer)begin
		TGrid(CG).RowInsert(y,1);
	end);
	CG.selection:=	TGrid(CG).saverect;
end;

procedure TFormCBtoDEL.MPasteClick(Sender: TObject);
	procedure Paste(M:TRichEdit);
	begin
		if not M.Focused then exit;
		M.PasteFromClipboard;
	end;
begin
	Paste(CB);
	Paste(DEL);
//	Paste(LOG);
	TGrid(CG).Paste;
end;

{ Ttokens }

function Ttokens.add(s:Ttoken):Integer;
begin
	SetLength(self.items,Length(self.items)+1);
	self[Length(self.items)-1]:=s;
	result              :=Length(self.items);
end;

function Ttokens.clear:Integer;
begin
	SetLength(self.items,0);
end;

function Ttokens.count:Integer;
begin
	result:=Length(self.items);
end;

function Ttokens.hi:Integer;
begin
	result:=High(self.items);
end;

procedure Ttoken.indent;
begin
	if str='' then exit;
	str:=tab+str;
	if MatchesMask(str,'*'+CRLF) then    //最後の改行を保持
		str:=StringReplace(TrimRight(str),CRLF,CRLF+tab,[rfReplaceAll])+CRLF
	else
		str:=StringReplace(str,CRLF,CRLF+tab,[rfReplaceAll]);

end;

procedure Ttoken.trim(d:char);
var s,r:string;
begin
	s:=str;
	if MatchesMask(s,'*'+CRLF) then begin   //最後の改行を保持
		s:=trimright(s);
		r:=CRLF;
	end;

	if MatchesMask(s,'*'+d) then    //最後の改行を保持
		str:=s.TrimRight(d)+r;

end;

function Ttoken.counttoken(s:string):integer;
var
	p:PChar;
	buf:array [0..1024] of CHAR;
begin
	result:=0;
	p:=PChar(src);
	while p[0]<>#0 do begin
		tknget(p,buf,'''');
		if s=buf then inc(result);
	end;
	if (result=0)and(''<>buf) then result:=1;
end;

function Ttokens.ins(t: Integer; s: Ttoken): Integer;
var i:integer;
begin
	if t<0 then t:=0;
	if t>count then t:=count; //範囲超は追加

	add(null);
	if t<hi then
		for i:=hi downto t+1 do
			self.items[i]:=self.items[i-1];

	self.items[t]:=s;
end;

function Ttokens.last: Ptoken;
begin
	if count=0 then exit(@null);
	result:=@self.items[count-1];
end;


function Ttokens.move(f, t: Integer): Integer;
var i:integer;
	s:Ttoken;
begin
	s:=self.items[f];
	if f>t then begin
		for i:=f downto t+1 do
			self.items[i]:=self.items[i-1];
	end else begin
		for i:=f to t-1 do
			self.items[i]:=self.items[i+1];
	end;
	self.items[t]:=s;
end;

function Ttokens.getstring(Index:Integer):string;
begin
	if index>High(self.items) then exit('');
	if index<0 then exit('');
	result:=self.items[index].str;
end;

procedure Ttokens.putstring(Index:Integer;const s:string);
begin
	if index>High(self.items) then exit;
	if index<0 then exit;
	self.items[index].str:=s;
end;

function Ttokens.get(Index:Integer):Ttoken;
begin
	if index>High(self.items) then exit(null);
	if index<0 then exit(null);
	result:=self.items[index];
end;

procedure Ttokens.put(Index:Integer;const s:Ttoken);
begin
	if index>High(self.items) then exit;
	if index<0 then exit;
	self.items[index]:=s;
end;


function Ttokens.source: string;
var tkn:Ttoken;
	s:string;
begin
	for tkn in self.items do begin
		s:=tkn.src;
//		if tkn.typ=tknBlock        then s:=s+';';
		if tkn.typ=tknKBlock       then s:=' ( '+s+' ) ';
		if tkn.typ=tknCBlock       then s:=' { '+s+' } ';

		if result='' then result:=s else result:=result+' '+s;
	end;
end;


function Ttokens.sourcestructure: string;
var tkn:Ttoken;
	s:string;
begin
	result:='';
	for tkn in self.items do begin
		s:=tkn.src;
		s:=StringReplace(s,CRLF,'',[rfReplaceAll]);
		s:=StringReplace(s,TAB,'',[rfReplaceAll]);
		if tkn.typ=tknKBlock       then s:=' ( '+s+' ) ';
		if tkn.typ=tknCBlock       then s:=' { '+s+' } ';
		result:=result+'['+s+']';
	end;
end;


function Ttokens.structure: string;
var tkn:Ttoken;
begin
	for tkn in self.items do begin
		if result='' then result:=tkn.typestr else result:=result+' '+tkn.typestr;
	end;
end;

function Ttokens.structureis(position:integer;arg: array of TtokenType):boolean;
var
	i:Integer;
begin
	if high(arg)<>high(self.items) then exit(false);
	result:=true;
	for i :=0 to high(arg) do begin
		if position+i>=count then exit(false);
		try
			if self[position+i].typ<>arg[i] then exit(false);
		except exit(false);
		end;
	end;
end;



function Ttokens.structureisstr(position:integer;arg: TStringDynArray):integer;
var
	i,j,si,di:Integer;
	tkn:Ttoken;
	typestr:string;
	s:string;
	wild:boolean;
	match:boolean;

	function regis(t,s:string):boolean;
	var
	  regex: TRegEx;
	begin
		regex := TRegEx.Create(s);
		result:=regex.Match(t).Success;
	end;


	function compare(si,di:integer):boolean;
	begin
		result:=true;
			if di>hi then exit(false);
			if si>arg.hi then exit(false);
			tkn:=self[di];
			typestr:=tkn.typestr;

			if MatchesMask(arg[si],'/*/') then begin
				if regmatch(tkn.src,arg[si].trim(['/']),regmatchstr) then exit(true);
				exit(false);
			end;
			if arg[si]='宣言名' then
				arg[si]:=宣言名;

			if arg[si]='左' then begin
				if tkn.typestr<>'文' then
					exit(false);
				exit(true);
			end else
			if arg[si]='式' then begin
				if typestr<>'数' then
					if typestr<>'文' then
						if typestr<>'文字列' then
							if typestr<>'(*)' then exit(false);
				exit(true);
			end;

			if (tkn.typ=tknDelimiter)and(tkn.str=arg[si]) then exit(true);

			if (tkn.typ=tknOperator)and(tkn.str=arg[si]) then exit(true);
			if (tkn.typ=tknQualifier)and (tkn.str=arg[si]) then exit(true);
			if (tkn.typ=tknReserved)and (tkn.str=arg[si]) then exit(true);
			if arg[si]<>typestr then exit(false);

	end;


begin
	regmatchstr.count:=1;
//	if high(arg)>high(self.items) then exit(false);
	si:=0;
	di:=0;
	result:=0;
	wild:=false;
//	match:=false;
	for i :=0 to self.hi do begin
		try
			di:=position+i;
			if si>high(arg) then begin
				break;
			end;
			if (arg[si]='＊') then begin
				wild:=true;
				inc(si);
			end;

			if compare(si,di) then begin
				inc(result);
				match:=true;
				if wild then wild:=false;
			end else begin
				if not wild then exit(0);
				if wild then inc(result);
			end;
			if not wild then begin
				inc(si);
				if high(arg)>high(self.items) then exit(0);
			end;

		except
			dmessage(arg[i]+CRLF+self[position+i].str);
			exit(0);
		end;
	end;
//	if match then
//		result:=di-position+1;
end;


function tknget(var pos:pchar;str:pchar;strdeli:CHAR):TtokenType;
var
	i,n    :Integer;
	prechr :CHAR;
	typ:TtokenType;
label gettknerror;
	//Identifiers識別子 Tokenstkns.add(複合文) Keywords予約語
	//Punctuators区切り文字! % ^ & * ( ) – + = { } | ~ [ ] \ ; ' : " < > ? , . / #



	function ISALPHA(c:CHAR):boolean;
	begin
		result:=(('A'<=c)and(c<='Z'))or(('a'<=c)and(c<='z'));
	end;

	function ISNUMBER(c:CHAR):boolean;
	begin
		result:=(strscan('0123456789.',c)<>nil)and(c<>#0);
	end;

	function ISDELIMITER(c:CHAR):boolean;
	begin
		result:=(strscan('''"(),;:[]{}'#13#10,c)<>nil)and(c<>#0);
	end;

	function ISOPERATOR(c:CHAR):boolean;
	begin
		result:=(strscan('.*^%/-+|&=<>\!',c)<>nil)and(c<>#0);
	end;

	function ISSPACER(c:CHAR):boolean;
	begin
		result:=(strscan(' '#9,c)<>nil)and(c<>#0);
	end;

	function addchr(c:CHAR):boolean;
	begin
		if (n>=TKNMAXLEN) then exit(true);
		str[n]:=c;
		inc(n);
		result:=false;
	end;
	function addchrinc:boolean;
	begin
		if (n>=TKNMAXLEN) then exit(true);
		str[n]:=pos[0];
		inc(n);
		inc(pos);
		result:=false;
	end;
	function addchrtype(t:TtokenType):boolean;
	begin
		if (n>=TKNMAXLEN) then exit(true);
		str[n]:=pos[0];
		inc(n);
		inc(pos);
		tkntyp:=t;
		result :=false;
	end;
	function isadd(s:PChar;t:TtokenType):boolean;
	begin
		result:=(strlcomp(pos,s,Length(s))=0);
		if not result then exit;
		tkntyp:=t;
		StrLCopy(str,s,Length(s));
		inc(n,Length(s));
		inc(pos,Length(s));
	end;
	function iscat(s:PChar;t:TtokenType):boolean;
	begin
		result:=(strlcomp(pos,s,Length(s))=0);
		if not result then exit;
		tkntyp:=t;
		str[n]:=#0;
		StrLCat(str,s,Length(str)+Length(s));
		inc(n,Length(s));
		inc(pos,Length(s));
	end;


begin
	n                          :=0;
	tkntyp                    :=tknVoid;
	if (pos[0]=#0) then tkntyp:=tknDelimiter;

	while ISSPACER(pos[0]) do inc(pos);

	while (pos[0]<>#0) do begin
//		if replacegrid then begin
//
//		end else
		if ((pos[0]='0')and(pos[1]='x')) then begin
			while ISNUMBER(pos[0])or ISALPHA(pos[0]) do begin
				if addchrinc then break;
				tkntyp:=tknNumber;
			end
		end else if ISNUMBER(pos[0]) then begin
			while ISNUMBER(pos[0]) do begin
				if addchrinc then break;
				tkntyp:=tknNumber;
			end
		end else if isadd('//',tknComment) then begin
			while (pos[0]<>#0) do begin
				if iscat(CRLF,tknComment) then break;
				addchrinc;
			end
		end else if isadd('/*',tknComment) then begin
			while (pos[0]<>#0) do begin
				if iscat('*/',tknComment) then break;
				addchrinc;
			end

		end else if isadd('<<=',tknOperator) then begin
		end else if isadd('>>=',tknOperator) then begin
		end else if isadd('<<',tknOperator) then begin
		end else if isadd('>>',tknOperator) then begin
		end else if isadd('++',tknOperator) then begin
		end else if isadd('--',tknOperator) then begin
		end else if isadd('==',tknOperator) then begin
		end else if isadd('!=',tknOperator) then begin
		end else if isadd('<=',tknOperator) then begin
		end else if isadd('>=',tknOperator) then begin
		end else if isadd('+=',tknOperator) then begin
		end else if isadd('-=',tknOperator) then begin
		end else if isadd('/=',tknOperator) then begin
		end else if isadd('*=',tknOperator) then begin
		end else if isadd('%=',tknOperator) then begin
		end else if isadd('&=',tknOperator) then begin
		end else if isadd('|=',tknOperator) then begin
		end else if isadd('^=',tknOperator) then begin
		end else if isadd('~=',tknOperator) then begin
		end else if isadd('&&',tknOperator) then begin
		end else if isadd('||',tknOperator) then begin
		end else if isadd('::',tknOperator) then begin
		end else if isadd('->',tknOperator) then begin
		end else if ISOPERATOR(pos[0]) then begin

			if addchrinc then break;
			tkntyp:=tknOperator;

		end else if (pos[0]='''')or(pos[0]='"')or((pos[0]='L')and ((pos[1]='"')or(pos[1]=''''))) then begin
				if (pos[0]='L') then inc(pos);
				if (pos[0]='"') then strdeli :='"' else
				if (pos[0]='''') then strdeli:='''' ;
				inc(pos);
				addchr('''');
				while (pos[0]<>#0) do begin
					if (pos[0]=strdeli) then break;
					if (pos[0]='\')and(pos[1]=strdeli) then begin
						inc(n);
						if (n>=TKNMAXLEN) then break;
						str[n]:=strdeli;
						inc(pos,2);
						continue;
					end;
					if (pos[0]='\')and(pos[1]=CR) then begin
						inc(pos);
						inc(pos);
						inc(pos);
					end;
					if (pos[0]=CR) then goto gettknerror;
					if (n>=TKNMAXLEN) then break;
					str[n]:=pos[0];
					inc(n);
					inc(pos);
				end;
				if (pos[0]=strdeli) then begin
					addchr('''');
					inc(pos);
					tkntyp:=tknString;
				end
				else tkntyp:=tknError;

		end else if ISDELIMITER(pos[0]) then begin

			tkntyp:=tknDelimiter;
			if (StrPos(pos,#13#10)=pos) then begin
				if ((n+1)>=TKNMAXLEN) then break;
				strmove(str,pos,2);
				n  :=n+2;
				pos:=pos+2;
			end else begin
				if (n>=TKNMAXLEN) then break;
				str[n]:=pos[0];
				inc(n);
				inc(pos);
			end;
		end else begin
			while pos[0]<>#0 do begin
				if ISOPERATOR(pos[0]) then break;
				if ISDELIMITER(pos[0]) then break;
				if ISSPACER(pos[0]) then break;
				if (n>=TKNMAXLEN) then break;
				str[n]:=pos[0];
				inc(n);
				if (n>=255) then break;
				inc(pos);
			end;
			tkntyp:=tknReserved;
		end;

		if (n>=TKNMAXLEN) then break;
		if (tkntyp<>tknVoid) then break;
		prechr:=pos[0];
		inc(pos);
	end;
	//    while ISSPACER(pos[0]) do inc(pos);

	str[n]:=#0;
	result:=tkntyp;
	exit;
gettknerror:
	str[0]:=#0;
	result:=tknVoid;
end;


{ Ttoken }

function Ttoken.convstr: string;
begin
	if str='!=' then exit('<>');
	if str='->' then exit('.');
	if str='==' then exit('=');
	if str='='  then exit(':=');
	if str='||' then exit('or');
	if str='|'  then exit('or');
	if str='&&' then exit('and');
	if str='&'  then exit('and');
	if str='!'  then exit('not');
	exit(str);
end;


function Ttoken.add(c: Ttoken): string;
begin
	convblock;
	str:=str+c.str;
	src:=src+c.src;
end;

function Ttoken.addstr(const s,e: string): string;
begin
	str:=s+str+e;
	src:=s+src+e;
end;

procedure Ttoken.clear;
begin
	typ:=tknError;
	str:='';
	src:='';
end;

function Ttoken.convblock: Ttoken;
begin
	if typ=tknBlock        then begin addstr('',';'); end;
	if typ=tknKBlock       then begin addstr('(',')'); end;
	if typ=tknCBlock       then begin addstr(' begin ',' end ');end;
	exit(self);
end;

function Ttoken.typestr: string;
begin
	if typ=tknType         then exit('Type');
	if typ=tknVoid         then exit('Void');
	if typ=tknNumber       then exit('数');
	if typ=tknChar         then exit('文字');
	if typ=tknInt          then exit('Int');
	if typ=tknDouble       then exit('Double');
	if typ=tknString       then exit('文字列');
	if typ=tknStruct       then exit('Struct');
	if typ=tknSemicolon    then exit(';');
	if typ=tknColon        then exit(':');

	if typ=tknAnd          then exit('&&' );
	if typ=tknOr           then exit('||' );
	if typ=tknPointer      then exit('*' );
	if typ=tknRef          then exit('&' );

	if typ=tknBlock        then exit('*;');
	if typ=tknKBlock       then exit('(*)');
	if typ=tknCBlock       then exit('{*}' );
	if typ=tknOperator     then exit('演算子');
	if typ=tknCommand      then exit('命令' );
	if typ=tknLabel        then exit('ラベル'   );
	if typ=tknDelimiter    then exit('区切');
	if typ=tknEnd          then exit('End'      );
	if typ=tknJump         then exit('Jump'     );
	if typ=tknQualifier    then exit('修飾子');
	if typ=tknReserved     then exit('文' );
	if typ=tknFunction     then exit('関数' );
	if typ=tknVariable     then exit('変数' );
	if typ=tknArray        then exit('配列'    );
end;

{ TStringDynArrayHelper }

function TStringDynArrayHelper.add(s: string): Integer;
begin
	SetLength(self,Length(self)+1);
	self[Length(self)-1]:=s;
	result              :=Length(self);

end;

function TStringDynArrayHelper.getcount: Integer;
begin
	result:=Length(self);
end;

procedure TStringDynArrayHelper.setcount(const i:integer);
begin
	SetLength(self,i);
end;

function TStringDynArrayHelper.hi: Integer;
begin
	result:=High(self);

end;

function TStringDynArrayHelper.item(i: Integer): String;
begin
	result:='';
	if i<0 then exit;
	if i>High(self) then exit;
	result:=self[i];
end;

function TStringDynArrayHelper.save(f: string): boolean;
begin
	with stringselfcreate do
		try
			SavetoFile(f,TEncoding.UTF8);
		except
			Free;
		end;
end;


function TStringDynArrayHelper.load(f: string): boolean;
begin
	with TStringList.Create do
		try
			LoadFromFile(f);
			self:=TStringDynArray(ToStringArray);
		except
			Free;
		end;
end;

function TStringDynArrayHelper.stringselfcreate:TStringSelf;
var s:string;
begin
	result:=TStringSelf.Create;
	for s in self do result.Add(s);
end;


function TStringDynArrayHelper.adduni(s: string): Integer;
var i:integer;
begin
	for i := 0 to hi do
		if self[i]=s then exit(-1);
	add(s);
	result:=count;
end;

function TStringDynArrayHelper.cat(s,e:string):String;
var t:string;
begin
	for t in self do result:=result+s+t+e;
end;

procedure TStringDynArrayHelper.clear;
begin
	SetLength(self,0);
end;

procedure TGrid.copy(G: TGrid);
var r:TGridRect;
begin
	colcount:=G.colCount;
	rowcount:=G.RowCount;
	r:=G.Selection;
	G.selection:=TGridrect(rect(1,1,G.colCount-1,G.rowCount-1));
	G.selrowdo(procedure(x,y:integer)begin
		Rows[y]:=G.Rows[y];
	end);
	G.Selection:=r;

end;

constructor TGrid.CreateEX(Origin :TStringGrid);
var
  MS :TMemoryStream;
begin
  Create(Origin.Owner);
  Self.Parent :=Origin.Parent;
  Self.Options :=Origin.Options;
  Self.OnSetEditText :=Origin.OnSetEditText;
	Buf:=TGrid.Create(self);

  MS :=TMemoryStream.Create;
   try
	 MS.WriteComponent(Origin);
	 Origin.Free;
	 MS.Position :=0;
	 MS.ReadComponent(Self);
   finally
	MS.Free;
   end;
end;

procedure TGrid.WMChar(var Msg: TWMChar);
begin
//	if (EnableEdit) and (AnsiChar(Msg.CharCode) in [^H, #32..#255]) then begin
	if ((CharInSet(Char(Msg.CharCode), [^H]) or (Char(Msg.CharCode) >= #32))) then begin
		Options:=Options+[goEditing];
		EditorMode:=true;

//		ShowObject(Word(Msg.CharCode));
//		if Edit.Visible then
//			PostMessage(Edit.Handle, WM_CHAR, Word(Msg.CharCode), 0);
//		if Combo.Visible then
//			PostMessage(Combo.Handle, WM_CHAR, Word(Msg.CharCode), 0);

	end else
		inherited;
end;







procedure TGrid.CutCopy(modecut:boolean);
var
	i,j:integer;
	xs,ys,xw,yw:integer;
	Txt:TStringList;
	s,ss:String;
	r:TGridRect;

	function d_dquotedstr(const s,d:string):string;
	var
		c:Char;
		b:boolean;
	begin
		result:=s;
		b:=false;
		if d='' then b:=true;
		for c in s do if pos(c,d)>0 then b:=true;

		if not b then exit;
		result:='"'+s+'"';
	end;

begin
	if not Focused then exit;
	if modecut then buf.copy(self);

	ys:=Selection.Top;
	xs:=Selection.Left;
	yw:=Selection.Bottom-ys;
	xw:=Selection.Right-xs;

	Txt:=TStringList.Create;
	for i:=0 to yw do begin
		s:='';
		for j:=0 to xw do begin
			if j>0 then s:=s+#9;
				ss:=StringReplace(Cells[xs+j,ys+i],#9,'',[rfReplaceAll]);//タブは削除
				//if Pos(ss,CRLF)>0 then
				ss:=d_dquotedstr(ss,CRLF);
				s:=s+ss;
				if modecut then Cells[xs+j,ys+i]:='';
		end;
		Txt.Add(s);
	end;
	s:=Txt.Text;
	s[Length(s)-1]:=#0;
	Clipboard.AsText:=s;
	Txt.Free;
end;

function TGrid.Paste:TGridRect;
var
	i,j,si,colcnt:integer;
	s:String;
	Txt:TStringList;
	ltxt:string;
	xs,ys,xw,yw,cnt:integer;
	cols:TStringDynArray;

begin
	if not Focused then exit;
	buf.copy(self);

	Txt:=TStringList.Create;
	s:=StringReplace(Clipboard.AsText,CRLF,CR,[rfReplaceAll]);
	for ltxt in SplitString(s,CR) do
		Txt.add(ltxt);


	ys:=Selection.Top;
	xs:=Selection.Left;
	yw:=txt.Count-1;
	xw:=1;
	for i:=0 to yw do begin
		s:=txt[i];
		colcnt:=SplitString(s,#9).count;
		if xw<colcnt then xw:=colcnt;
	end;
	dec(xw);


	si:=1;
	for i:=0 to yw do begin
		for j:=0 to xw do begin
			cols:=SplitString(txt[i],#9);
			s:=cols.item(j);
			Cells[xs+j,ys+i]:=s;
		end;
	end;
	Txt.Free;
	result:=TGridRect(Rect(xs,ys,xs+xw,ys+yw));
end;

procedure TGrid.save;
begin
	saverect:=selection;
	buf.copy(self);
end;

procedure TGrid.seldel;
begin
	save;
	 seldo(procedure(x,y:integer)begin cells[x,y]:=''; end);
end;

function TGrid.seldo(func: TFuncXY): integer;
var i,j:integer;
begin
	for i := selection.top to selection.bottom do
		for j := selection.Left to selection.Right do
			func(j,i);
end;

function TGrid.selrowdo(func:TFuncXY): integer;
var i:integer;
begin
	for i := selection.top to selection.bottom do
		func(0,i);
end;

procedure TGrid.KeyDown(var Key: Word; Shift: TShiftState);
var w:word;
begin
	if ssCtrl in Shift then begin
		if key=17 then exit;
		case Key of
			WORD('X'):CutCopy(true);
			WORD('C'):CutCopy(false);
			WORD('V'):Paste;
			WORD('Z'):copy(buf);
		end;
	end else begin
		case Key of
			VK_DELETE:seldel;
		end;
	end;

	inherited;
end;

procedure TFormCBtoDEL.CBKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{$IFDEF DEBUG}
	if ssCtrl in Shift then begin
	if key=17 then exit;
	case Key of
		WORD('X'):MCutClick(Sender);
		WORD('C'):MCopyClick(Sender);
		WORD('V'):MPasteClick(Sender);
		else exit;
	end;
	key:=0;
	end;
{$ENDIF}
end;


procedure TGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	ACol,ARow:Longint;
begin
	MouseToCell(X,Y,ACol,ARow);

	Options:=Options-[goEditing]+[goRangeSelect];

	if(Button=mbLeft)then begin
		if(FixedRows>0) and (ARow=0) and (ACol>0) and not Sizing(X,Y) then begin
		end	 else if (FixedCols>0) and (ACol=0) and (ARow>0) and not Sizing(X,Y) then begin
		end	else if((Col=ACol) and (Row=ARow))then begin
			Options:=Options+[goEditing]-[goRangeSelect];
			EditorMode:=true;
		end else begin
			EditorMode:=false;
		end;
	end;

	inherited;
end;

function GetNumScrollLines: Integer;
begin
  SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @Result, 0);
end;

function TGrid.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
var
i:integer;
begin
	for I := 1 to GetNumScrollLines do SendMessage(Handle, WM_VSCROLL, SB_LINEDOWN, 0);
	Result := True;
end;

function TGrid.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
var
i:integer;
begin
	for I := 1 to GetNumScrollLines do SendMessage(Handle, WM_VSCROLL, SB_LINEUP, 0);
	Result := True;
end;

function TGrid.ColExpand(min:Integer):Integer;
var
	i,j     :Integer;
	w1,w2,w3:Integer;
begin
	w3                        :=0;
	Canvas.Font               :=Font;
	for j:=0 to ColCount-1 do begin
		w1:=0;
		for i:=0 to RowCount-1 do begin
			w2:=Canvas.TextWidth('['+Cells[j,i]);
			if (w1<w2) then w1:=w2;
		end;
		if w1<min then w1:=min;
		ColWidths[j]     :=w1;
		w3               :=w3+(w1)+GridLineWidth;
	end;
	for j :=0 to ColCount-1 do
		if ColWidths[j]>gridWidth then ColWidths[j]:=trunc(gridWidth/2);

	DefaultRowHeight:=Canvas.TextHeight('あ')+2;
	result:=w3+4;
end;

function TGrid.RowDelete(y,cnt:integer):integer;
var
	i:integer;
	w:integer;
begin
	result:=0;
	if cnt<0 then Exit;
	if y<0 then Exit;
	if y>=RowCount then Exit;
	w                     :=RowCount-cnt;
	for i                 :=y to w-1 do begin
		Rows[i]      :=Rows[i+cnt];
		RowHeights[i]:=RowHeights[i+cnt];
	end;
	RowClear(w,cnt);
	RowCount:=w;
end;

function TGrid.RowInsert(y,cnt:integer):integer;
var
	i   :integer;
	lcnt:integer;
begin
	if cnt<0 then Exit;
	if (y<0)or(y>=RowCount) then y:=RowCount;
	RowCount:=RowCount+cnt;
	lcnt:=RowCount;

	for i:=lcnt-1 downto y+cnt do begin
		Rows[i]:=Rows[i-cnt];
		RowHeights[i]:=RowHeights[i-cnt];
	end;
	for i:=0 to cnt-1 do Rows[y+i].Clear();
	result:=0;
end;

function TGrid.RowClear(y,cnt:integer):integer;
var
	i:integer;
begin
	if (y<0) then y:=0;
	if y>=RowCount then y:=RowCount;
	for i:=0 to cnt-1 do Rows[y+i].Clear();
	result:=0
end;

function TStringSelf.this:TStringList;
begin
	exit(self);
end;



initialization
finalization
end.
