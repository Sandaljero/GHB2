
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ЗначениеОтбора = Новый Структура("Владелец", ПараметрКоманды);
	ПараметрыФормы = Новый Структура("Отбор", ЗначениеОтбора);
	ОткрытьФорму("Справочник.гхб_ДоговораКонтрагентовБазХолдинга.ФормаСписка", ПараметрыФормы);
	
КонецПроцедуры
