unit CBtoDELIDEunit;

interface

uses
	System.SysUtils,System.Classes,
	Vcl.Controls,Vcl.Forms,Vcl.StdCtrls,types,
	Vcl.Menus;

procedure Register;

implementation

uses ToolsAPI,CBtoDELunit;

type
	TCBtoDelBinding=class(TNotifierObject,IOTAKeyboardBinding)
	public
		procedure DelConv(const Context:IOTAKeyContext;KeyCode:TShortcut;var BindingResult:TKeyBindingResult);
		procedure DelConvEdit(const Context:IOTAKeyContext;KeyCode:TShortcut;var BindingResult:TKeyBindingResult);
		function GetBindingType:TBindingType;
		function GetDisplayName:string;
		function GetName:string;
		procedure BindKeyboard(const BindingServices:IOTAKeyBindingServices);
	end;

procedure Register;
begin
	(BorlandIDEServices as IOTAKeyboardServices).AddKeyboardBinding(TCBtoDelBinding.Create);
end;

function TCBtoDelBinding.GetBindingType:TBindingType;
begin
	Result:=btPartial;
end;

function TCBtoDelBinding.GetDisplayName:string;
begin
	Result:='CBtoDel';
end;

function TCBtoDelBinding.GetName:string;
begin
	Result:='CBtoDel';
end;

procedure TCBtoDelBinding.BindKeyboard(const BindingServices:IOTAKeyBindingServices);
begin
	BindingServices.AddKeyBinding([TextToShortCut('Ctrl+Shift+Alt+L')],DelConv,nil);
	BindingServices.AddKeyBinding([TextToShortCut('Ctrl+Shift+Alt+O')],DelConvEdit,nil);
	BindingServices.AddKeyBinding([TextToShortCut('Ctrl+Alt+L')],DelConv,nil);
	BindingServices.AddKeyBinding([TextToShortCut('Ctrl+Alt+O')],DelConvEdit,nil);
end;

procedure TCBtoDelBinding.DelConv(const Context:IOTAKeyContext;
	KeyCode:TShortcut;var BindingResult:TKeyBindingResult);
var
	F   :TFormCBtoDEL;
	IDE :INTAServices;
	IOTA:IOTAServices;
	text:string;
	EP  :IOTAEditPosition;
	c   :Integer;
begin
	IDE:=(BorlandIDEServices as INTAServices);
	IOTA:=(BorlandIDEServices as IOTAServices);
	F:=TFormCBtoDEL.Create(nil);
	if F.inidir='' then F.inidir:=ExtractFileDir(GetActiveProject.FileName);
	text:=Context.EditBuffer.EditBlock.text;
	F.MLoadClick(self);
	if trim(text)<>'' then F.CB.text:=text;
	F.MConvClick(self);

	EP:=Context.EditBuffer.EditPosition;
	EP.InsertText(Trim(F.DEL.text));
	F.free;

	BindingResult:=krHandled;
end;

procedure TCBtoDelBinding.DelConvEdit(const Context:IOTAKeyContext;KeyCode:TShortcut;var BindingResult:TKeyBindingResult);
var
	R:TRect;
	F:TFormCBtoDEL;
	//IOTA:	IOTAModuleServices;
	IDE :INTAServices;
	IOTA:IOTAServices;
	//IOTA:	IOTAModuleNotifier;
	Module :IOTAModule;
	Project:IOTAProject;
	text   :string;
	EP     :IOTAEditPosition;
	c      :Integer;
begin
	IDE:=(BorlandIDEServices as INTAServices);
	IOTA:=(BorlandIDEServices as IOTAServices);
	//IOTA:=(BorlandIDEServices as IOTAModuleNotifier);
	//Project:=GetActiveProject;

	F:=TFormCBtoDEL.Create(nil);
	if F.inidir='' then F.inidir:=ExtractFileDir(GetActiveProject.FileName);
	//	dmessage(GetActiveProject.FileName,GetActiveProject.FileSystem);
	text:=Context.EditBuffer.EditBlock.text;
	F.MLoadClick(self);
	if trim(text)<>'' then F.CB.text:=text;
	F.MConvClick(self);

	if F.ShowModal=mrOk then begin
		EP:=Context.EditBuffer.EditPosition;
		EP.InsertText(F.DEL.text);
	end;
	F.free;

	BindingResult:=krHandled;
end;

end.
