//
//  JSON-RPC 2.0 Specification
//	https://www.jsonrpc.org/specification
//
// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃	--> {"jsonrpc": "2.0", "method": "subtract", "params": {"id": 1}				┃
// ┃	<-- {"jsonrpc": "2.0", "result": {"id": 1}                                      ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


Function rpcPOST(Запрос)
	
	Попытка
		ТелоЗапроса = ПрочитатьТелоЗапроса(Запрос);
	Исключение
		Возврат ПолучитьОшибкуОбработкиЗапроса(400,32700,"Invalid JSON was received by the server. An error occurred on the server while parsing the JSON text.");
	КонецПопытки;
	
	Если ТипЗнч(ТелоЗапроса) = Тип("Массив") Тогда
		ОтветСервера = Новый Массив;
		Для Каждого Элемент Из 	ТелоЗапроса Цикл
			ОтветСервера.Добавить(ProcessProcedureCall(Элемент));
		КонецЦикла;
	Иначе
		ОтветСервера = ProcessProcedureCall(ТелоЗапроса);
	КонецЕсли;
	
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.УстановитьТелоИзСтроки(ЗаписатьТелоЗапроса(ОтветСервера));
	Ответ.Заголовки.Вставить("Content-Type","application/json");
	Ответ.Заголовки.Вставить("Access-Control-Allow-Origin", "*");
    Ответ.Заголовки.Вставить("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE, HEAD, OPTIONS");
    Ответ.Заголовки.Вставить("Access-Control-Allow-Headers", "X-Requested-With, origin, content-type, accept, authorization");
 
	Возврат Ответ;
	
EndFunction

Функция ProcessProcedureCall(req)
	
	res = New Map;
	
	If req.Get("jsonrpc") = Undefined OR req.Get("jsonrpc")<>"2.0" Then
		Ошибка = Истина;
	EndIf;
	
	params = req["params"];
	Execute(StrTemplate("res = JsonRPC.%1(params)",req["method"]));
	
	res.Insert("id",req["id"]);
	res.Insert("jsonrpc","2.0");
	
	//ОтветРПС.Insert("result",Result);
	
	Возврат res;	
	
КонецФункции

Функция rpcOPTIONS(Запрос)
	
	Ответ = Новый HTTPСервисОтвет(200);
	Ответ.Заголовки.Вставить("Access-Control-Allow-Origin", "*");
    Ответ.Заголовки.Вставить("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE, HEAD, OPTIONS");
    Ответ.Заголовки.Вставить("Access-Control-Allow-Headers", "X-Requested-With, origin, content-type, accept, authorization");
	Возврат Ответ;
	
КонецФункции

Функция rpcANY(Запрос)
	
	Возврат ПолучитьОшибкуОбработкиЗапроса(405,32000,"Method Not Allowed");

КонецФункции

Функция ПрочитатьТелоЗапроса(Res)
	
	ResString = Res.GetBodyAsString(TextEncoding.UTF8);
	Reader = New JSONReader();
	Reader.SetString(ResString);
	Response = ReadJSON(Reader,true,,JSONDateFormat.ISO);
	Reader.Close();	
	
	Return Response;
	
КонецФункции

Функция ЗаписатьТелоЗапроса(Знач ТелоОтвета)

	Writer = New JSONWriter();
	Writer.SetString();
	WriteJSON(Writer,ТелоОтвета);
	ReqJSON = Writer.Close();
	
	Return ReqJSON;
	
КонецФункции


Функция ПолучитьОшибкуОбработкиЗапроса(КодСостояния,КодОшибки=0,Содержание,ИДЗапроса = "")

	Ошибка = ПолучитьСоответствиеОтвета();
	ОшибкаСообщение = Новый Соответствие;
	ОшибкаСообщение.Вставить("code",КодОшибки);
	ОшибкаСообщение.Вставить("message",Содержание);
	Ошибка.Вставить("error",ОшибкаСообщение);

	Ответ = Новый HTTPСервисОтвет(КодСостояния);
	Ответ.УстановитьТелоИзСтроки(ЗаписатьТелоЗапроса(Ошибка));
	Возврат Ответ;
	
КонецФункции

Функция ПолучитьСоответствиеОтвета()
	
	СоответствиеОтвета = Новый Соответствие;
	СоответствиеОтвета.Вставить("jsonrpc","2.0");
	Возврат СоответствиеОтвета; 
	
КонецФункции
