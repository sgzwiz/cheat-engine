unit LuaCanvas;
{
This unit will be used to register TCanvas class methods to lua
}

{$mode delphi}

interface

uses
  Classes, SysUtils, Graphics,lua, lualib, lauxlib, LuaHandler, fpcanvas;

procedure initializeLuaCanvas;

implementation

uses luaclass, luaobject;

function canvas_getPen(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
begin
  canvas:=luaclass_getClassObject(L);
  luaclass_newClass(L, canvas.pen);
  result:=1;
end;

function canvas_getBrush(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
begin
  canvas:=luaclass_getClassObject(L);
  luaclass_newClass(L, canvas.brush);
  result:=1;
end;

function canvas_getFont(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
begin
  canvas:=luaclass_getClassObject(L);
  luaclass_newClass(L, canvas.font);
  result:=1;
end;

function canvas_getWidth(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
begin
  canvas:=luaclass_getClassObject(L);
  lua_pushinteger(L, canvas.width);
  result:=1;
end;

function canvas_getHeight(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
begin
  canvas:=luaclass_getClassObject(L);
  lua_pushinteger(L, canvas.height);
  result:=1;
end;

function canvas_line(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  sourcex: integer;
  sourcey: integer;
  destinationx: integer;
  destinationy: integer;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);

  if lua_gettop(L)>=4 then
  begin
    sourcex:=lua_tointeger(L,-4);
    sourcey:=lua_tointeger(L,-3);
    destinationx:=lua_tointeger(L,-2);
    destinationy:=lua_tointeger(L,-1);
    canvas.Line(sourcex, sourcey, destinationx, destinationy);
  end;
end;

function canvas_lineTo(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  destinationx: integer;
  destinationy: integer;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);

  if lua_gettop(L)>=2 then
  begin
    destinationx:=lua_tointeger(L,-2);
    destinationy:=lua_tointeger(L,-1);
    canvas.LineTo(destinationx, destinationy);
  end;
end;

function canvas_rect(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x1,y1: integer;
  x2,y2: integer;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);


  if lua_gettop(L)>=4 then
  begin
    x1:=lua_tointeger(L,-4);
    y1:=lua_tointeger(L,-3);
    x2:=lua_tointeger(L,-2);
    y2:=lua_tointeger(L,-1);

    canvas.Rectangle(x1,y1,x2,y2);
  end;
end;

function canvas_fillRect(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x1,y1: integer;
  x2,y2: integer;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=4 then
  begin
    x1:=lua_tointeger(L,-4);
    y1:=lua_tointeger(L,-3);
    x2:=lua_tointeger(L,-2);
    y2:=lua_tointeger(L,-1);

    canvas.FillRect(x1,y1,x2,y2);
  end;
end;

function canvas_textOut(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x: integer;
  y: integer;
  text: string;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=3 then
  begin
    x:=lua_tointeger(L, -3);
    y:=lua_tointeger(L, -2);
    text:=lua_tostring(L, -1);
    canvas.TextOut(x,y,text);
  end;
end;

function canvas_getTextWidth(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  text: string;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=1 then
  begin
    text:=lua_tostring(L, -1);
    lua_pushinteger(L, canvas.GetTextWidth(text));
    result:=1;
  end;
end;

function canvas_getTextHeight(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  text: string;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=1 then
  begin
    text:=lua_tostring(L, -1);
    lua_pushinteger(L, canvas.GetTextHeight(text));
    result:=1;
  end;
end;

function canvas_getPixel(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x,y: integer;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=2 then
  begin
    x:=lua_tointeger(L, -2);
    y:=lua_tointeger(L, -1);

    lua_pushinteger(L, canvas.Pixels[x,y]);
    result:=1;
  end;
end;

function canvas_setPixel(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x,y: integer;
  color: TColor;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=3 then
  begin
    x:=lua_tointeger(L, -3);
    y:=lua_tointeger(L, -2);
    color:=TColor(lua_tointeger(L, -1));

    canvas.Pixels[x,y]:=color;
  end;
end;

function canvas_floodFill(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x,y: integer;
  fill: integer;
  color: TColor;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=2 then
  begin
    x:=lua_tointeger(L, -2);
    y:=lua_tointeger(L, -1);

    TFPCustomCanvas(canvas).floodfill(x,y);
  end;
end;

function canvas_ellipse(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x1,y1: integer;
  x2,y2: integer;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=4 then
  begin
    x1:=lua_tointeger(L,-4);
    y1:=lua_tointeger(L,-3);
    x2:=lua_tointeger(L,-2);
    y2:=lua_tointeger(L,-1);
    canvas.Ellipse(x1,y1,x2,y2);
  end;
end;

function canvas_gradientFill(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x1,y1: integer;
  x2,y2: integer;
  startcolor, stopcolor: tcolor;
  direction: integer;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=7 then
  begin
    x1:=lua_tointeger(L,-7);
    y1:=lua_tointeger(L,-6);
    x2:=lua_tointeger(L,-5);
    y2:=lua_tointeger(L,-4);

    startcolor:=lua_tointeger(L,-3);
    stopcolor:=lua_tointeger(L,-2);
    direction:=lua_tointeger(L,-1);

    canvas.GradientFill(rect(x1,y1,x2,y2), startcolor, stopcolor, TGradientDirection(direction));
  end;
end;

function canvas_copyRect(L: PLua_State): integer; cdecl;
var
  s_canvas: TCanvas;
  d_canvas: TCanvas;
  d_x1,d_y1: integer;
  d_x2,d_y2: integer;
  s_x1,s_y1: integer;
  s_x2,s_y2: integer;
begin
  result:=0;
  d_canvas:=luaclass_getClassObject(L);

  if lua_gettop(L)>=9 then
  begin
    d_x1:=lua_tointeger(L,-9);
    d_y1:=lua_tointeger(L,-8);
    d_x2:=lua_tointeger(L,-7);
    d_y2:=lua_tointeger(L,-6);

    s_canvas:=lua_toceuserdata(L,-5);
    s_x1:=lua_tointeger(L,-4);
    s_y1:=lua_tointeger(L,-3);
    s_x2:=lua_tointeger(L,-2);
    s_y2:=lua_tointeger(L,-1);

    d_canvas.CopyRect(rect(d_x1, d_y1, d_x2,d_y2), s_canvas, rect(s_x1, s_y1, s_x2,s_y2));
  end;
end;

function canvas_draw(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
  x,y: integer;
  graphic: TGraphic;

begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=3 then
  begin
    x:=lua_tointeger(L,-3);
    y:=lua_tointeger(L,-2);
    graphic:=lua_toceuserdata(L,-1);

    canvas.draw(x,y, graphic);
  end;
end;

function canvas_getPenPosition(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;
begin
  canvas:=luaclass_getClassObject(L);
  lua_pushinteger(L, canvas.PenPos.x);
  lua_pushinteger(L, canvas.PenPos.y);
  result:=2;
end;

function canvas_setPenPosition(L: PLua_State): integer; cdecl;
var
  canvas: TCanvas;

  pos: tpoint;
begin
  result:=0;
  canvas:=luaclass_getClassObject(L);
  if lua_gettop(L)>=2 then
  begin
    Pos.x:=lua_toInteger(L,-1);
    Pos.y:=lua_toInteger(L,-2);
    canvas.PenPos:=pos;
  end;
end;

procedure canvas_addMetaData(L: PLua_state; metatable: integer; userdata: integer );
begin
  object_addMetaData(L, metatable, userdata);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getBrush', canvas_getBrush);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getPen', canvas_getPen);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getFont', canvas_getFont);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getWidth', canvas_getWidth);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getHeight', canvas_getHeight);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_line', canvas_line);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_lineTo', canvas_lineTo);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_rect', canvas_rect);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_fillRect', canvas_fillRect);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_textOut', canvas_textOut);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getTextWidth', canvas_getTextWidth);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getTextHeight', canvas_getTextHeight);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getPixel', canvas_getPixel);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_setPixel', canvas_setPixel);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_floodFill', canvas_floodFill);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_ellipse', canvas_ellipse);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_gradientFill', canvas_gradientFill);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_copyRect', canvas_copyRect);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_draw', canvas_draw);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_getPenPosition', canvas_getPenPosition);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'canvas_setPenPosition', canvas_setPenPosition);

  Luaclass_addPropertyToTable(L, metatable, userdata, 'Brush', canvas_getBrush, nil);
  Luaclass_addPropertyToTable(L, metatable, userdata, 'Pen', canvas_getPen, nil);
  Luaclass_addPropertyToTable(L, metatable, userdata, 'Font', canvas_getFont, nil);
  Luaclass_addPropertyToTable(L, metatable, userdata, 'Width', canvas_getWidth, nil);
  Luaclass_addPropertyToTable(L, metatable, userdata, 'Height', canvas_getHeight, nil);
end;

procedure initializeLuaCanvas;
begin
  lua_register(LuaVM, 'canvas_getBrush', canvas_getBrush);
  lua_register(LuaVM, 'canvas_getPen', canvas_getPen);
  lua_register(LuaVM, 'canvas_getFont', canvas_getFont);
  lua_register(LuaVM, 'canvas_getWidth', canvas_getWidth);
  lua_register(LuaVM, 'canvas_getHeight', canvas_getHeight);
  lua_register(LuaVM, 'canvas_line', canvas_line);
  lua_register(LuaVM, 'canvas_lineTo', canvas_lineTo);
  lua_register(LuaVM, 'canvas_rect', canvas_rect);
  lua_register(LuaVM, 'canvas_fillRect', canvas_fillRect);
  lua_register(LuaVM, 'canvas_textOut', canvas_textOut);
  lua_register(LuaVM, 'canvas_getTextWidth', canvas_getTextWidth);
  lua_register(LuaVM, 'canvas_getTextHeight', canvas_getTextHeight);
  lua_register(LuaVM, 'canvas_getPixel', canvas_getPixel);
  lua_register(LuaVM, 'canvas_setPixel', canvas_setPixel);
  lua_register(LuaVM, 'canvas_floodFill', canvas_floodFill);
  lua_register(LuaVM, 'canvas_ellipse', canvas_ellipse);
  lua_register(LuaVM, 'canvas_gradientFill', canvas_gradientFill);
  lua_register(LuaVM, 'canvas_copyRect', canvas_copyRect);
  lua_register(LuaVM, 'canvas_draw', canvas_draw);
  lua_register(LuaVM, 'canvas_getPenPosition', canvas_getPenPosition);
  lua_register(LuaVM, 'canvas_setPenPosition', canvas_setPenPosition);
end;

initialization
  luaclass_register(TCanvas, canvas_addMetaData);


end.

