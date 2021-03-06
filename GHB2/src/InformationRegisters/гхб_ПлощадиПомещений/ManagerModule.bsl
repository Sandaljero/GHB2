
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ЗаполнитьПлощадиПомещений() Экспорт

	Запрос = Новый Запрос();
	Запрос.Текст = "ВЫБРАТЬ
	               |	гхб_СвойстваПомещенийСрезПоследних.Локация КАК Помещение,
	               |	СУММА(гхб_СвойстваПомещенийСрезПоследних.Площадь) КАК Площадь
	               |ПОМЕСТИТЬ _ПомещенияПлощади
	               |ИЗ
	               |	РегистрСведений.гхб_СвойстваПомещений.СрезПоследних КАК гхб_СвойстваПомещенийСрезПоследних
	               |ГДЕ
	               |	гхб_СвойстваПомещенийСрезПоследних.ТипПомещения.ЭтоПомещение
	               |	И НЕ гхб_СвойстваПомещенийСрезПоследних.Закрыть
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	гхб_СвойстваПомещенийСрезПоследних.Локация
	               |
	               |ОБЪЕДИНИТЬ ВСЕ
	               |
	               |ВЫБРАТЬ
	               |	гхб_СвойстваПомещенийСрезПоследних.Корпус,
	               |	СУММА(гхб_СвойстваПомещенийСрезПоследних.Площадь)
	               |ИЗ
	               |	РегистрСведений.гхб_СвойстваПомещений.СрезПоследних КАК гхб_СвойстваПомещенийСрезПоследних
	               |ГДЕ
	               |	гхб_СвойстваПомещенийСрезПоследних.ТипПомещения.ЭтоПомещение
	               |	И НЕ гхб_СвойстваПомещенийСрезПоследних.Закрыть
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	гхб_СвойстваПомещенийСрезПоследних.Корпус
	               |
	               |ОБЪЕДИНИТЬ ВСЕ
	               |
	               |ВЫБРАТЬ
	               |	гхб_СвойстваПомещенийСрезПоследних.ЭлементСтроения,
	               |	СУММА(гхб_СвойстваПомещенийСрезПоследних.Площадь)
	               |ИЗ
	               |	РегистрСведений.гхб_СвойстваПомещений.СрезПоследних КАК гхб_СвойстваПомещенийСрезПоследних
	               |ГДЕ
	               |	гхб_СвойстваПомещенийСрезПоследних.ТипПомещения.ЭтоПомещение
	               |	И НЕ гхб_СвойстваПомещенийСрезПоследних.Закрыть
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	гхб_СвойстваПомещенийСрезПоследних.ЭлементСтроения
	               |
	               |ИНДЕКСИРОВАТЬ ПО
	               |	Помещение
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	гхб_Помещения.Ссылка КАК Помещение,
	               |	ЕСТЬNULL(_ПомещенияПлощади.Площадь, 0) КАК Площадь
	               |ИЗ
	               |	Справочник.гхб_Помещения КАК гхб_Помещения
	               |		ЛЕВОЕ СОЕДИНЕНИЕ _ПомещенияПлощади КАК _ПомещенияПлощади
	               |		ПО гхб_Помещения.Ссылка = _ПомещенияПлощади.Помещение
	               |ГДЕ
	               |	гхб_Помещения.ЭтоГруппа
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |УНИЧТОЖИТЬ _ПомещенияПлощади";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		МЗ = РегистрыСведений.гхб_ПлощадиПомещений.СоздатьМенеджерЗаписи();
		МЗ.Помещение = Выборка.Помещение;
		МЗ.Площадь = Выборка.Площадь;
		МЗ.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

#КонецЕсли