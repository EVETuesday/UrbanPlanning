
--Views

--1.1) Вывод всех объектов недвижимости, типа – участок со всеми домами на нём;

CREATE OR REPLACE VIEW vw_places AS
SELECT e.id_estate_object, "square", price, e.date_of_defenition, e.date_of_application, number, 
adress, post_index_value, t.title, format_title 
--STRING_AGG(e.number, ', ') AS builds
FROM estate_object e
JOIN post_index p ON e.id_postindex = p.id_post_index
JOIN type_of_activity t ON t.id_type_of_activity = e.id_type_of_activity
JOIN format f ON e.id_format = f.id_format
JOIN estate_relation er ON e.id_estate_object = er.id_place_estate
WHERE e.id_type_of_activity=1
GROUP BY e.id_estate_object, "square", price, e.date_of_defenition, e.date_of_application, number, 
adress, post_index_value, t.title, format_title;

SELECT * FROM vw_places;



--2.2) Вывод всех объектов недвижимости, типа – дом;

CREATE OR REPLACE VIEW vw_builds AS
SELECT e.id_estate_object, "square", price, e.date_of_defenition, e.date_of_application, number, 
adress, post_index_value, t.title, format_title 
FROM estate_object e
JOIN post_index p ON e.id_postindex = p.id_post_index
JOIN type_of_activity t ON t.id_type_of_activity = e.id_type_of_activity
JOIN format f ON e.id_format = f.id_format
JOIN flat_relation fr ON e.id_estate_object = fr.id_build_estate
WHERE e.id_type_of_activity=2
GROUP BY e.id_estate_object, "square", price, e.date_of_defenition, e.date_of_application, number, 
adress, post_index_value, t.title, format_title;

SELECT * FROM vw_builds;


--2.3) Вывод всех объектов недвижимости, типа – квартира;

CREATE OR REPLACE VIEW vw_flats AS
SELECT e.id_estate_object, "square", price, e.date_of_defenition, e.date_of_application, number, 
adress, post_index_value, t.title, format_title 
FROM estate_object e
JOIN post_index p ON e.id_postindex = p.id_post_index
JOIN type_of_activity t ON t.id_type_of_activity = e.id_type_of_activity
JOIN format f ON e.id_format = f.id_format
WHERE e.id_type_of_activity=3
GROUP BY e.id_estate_object, "square", price, e.date_of_defenition, e.date_of_application, number, 
adress, post_index_value, t.title, format_title;

SELECT * FROM vw_flats;

--Procedure

--2.1) Повышение/Понижение цены домов, находящихся на 1м общем участке;

CREATE OR REPLACE PROCEDURE pr_add_common_cost(
    in_idplace int,
    in_cost numeric(14,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    i int;
    idplaceestate int;
    idbuildestate int;
BEGIN
    i := 0;    
    IF ((SELECT id_type_of_activity FROM estate_object WHERE id_estate_object = in_idplace) = 1) THEN
        DECLARE
            objectcurs CURSOR FOR
            SELECT er.id_place_estate, er.id_building_estate
            FROM estate_object eo
            JOIN estate_relation er ON eo.id_estate_object = er.id_place_estate
            WHERE eo.id_type_of_activity = 1 AND er.id_place_estate = in_idplace
            ORDER BY er.id_place_estate;
        BEGIN
            OPEN objectcurs;
            LOOP
                FETCH objectcurs INTO idplaceestate, idbuildestate;
                EXIT WHEN NOT FOUND;
                
                UPDATE estate_object
                SET price = price + in_cost
                WHERE id_estate_object = idbuildestate;
            END LOOP;
            CLOSE objectcurs;
        END;
    ELSE
        RAISE NOTICE 'Данный объект недвижимости не является участком';
    END IF;
END;
$$;

CALL pr_add_common_cost(1, -100);

select eo.* from estate_object eo join estate_relation er on eo.id_estate_object =er.id_building_estate  where er.id_place_estate =1

--2.2) Повышение/Понижение цены квартир, находящихся в 1м общем доме;

CREATE OR REPLACE PROCEDURE pr_add_common_flat_cost(
    in_idbuild int,
    in_cost numeric(14,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    i int;
    idflatestate int;
    idbuildestate int;
BEGIN
    i := 0;
    
    IF ((SELECT id_type_of_activity FROM estate_object WHERE id_estate_object = in_idbuild) = 2) THEN
        DECLARE
            objectcurs CURSOR FOR
            SELECT f.id_build_estate, f.id_flat_estate
            FROM estate_object eo
            JOIN flat_relation f ON eo.id_estate_object = f.id_build_estate
            WHERE eo.id_type_of_activity = 2
            ORDER BY f.id_build_estate;
        BEGIN
            OPEN objectcurs;
            LOOP
                FETCH objectcurs INTO idbuildestate, idflatestate;
                EXIT WHEN NOT FOUND;
                
                UPDATE estate_object
                SET price = price + in_cost
                WHERE id_estate_object = idflatestate;
            END LOOP;
            CLOSE objectcurs;
        END;
    ELSE
        RAISE NOTICE 'Данный объект недвижимости не является строением';
    END IF;
END;
$$;

CALL pr_add_common_flat_cost(4, 100);

select eo.* from estate_object eo  join flat_relation fr on eo.id_estate_object =fr.id_flat_estate  where fr.id_build_estate=4


--Functions

--3.1) Получение списка всех квартир с возможностью указания дома;
CREATE OR REPLACE FUNCTION fn_all_flats(in_idestateobject int)
RETURNS TABLE (id_estate_object int, "square" decimal(14,2), price decimal(14,2), date_of_defenition timestamp,
date_of_application timestamp, "number" int, adress varchar(100), id_type_of_activity int)
AS $$
BEGIN
    RETURN QUERY 
    SELECT eo.id_estate_object, eo."square", eo.price, eo.date_of_defenition, eo.date_of_application, eo."number",
    eo.adress, eo.id_type_of_activity
    FROM estate_object eo
    JOIN flat_relation fr ON eo.id_estate_object = fr.id_flat_estate
    WHERE fr.id_build_estate = in_idestateobject
    GROUP BY eo.id_estate_object, eo."square", eo.price, eo.date_of_defenition, eo.date_of_application, eo."number",
   eo.adress, eo.id_type_of_activity;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fn_all_flats(4);

--3.2) Получение списка всех домов с возможностью указания участка;

CREATE OR REPLACE FUNCTION fn_all_builds(in_idestateobject int)
RETURNS TABLE (id_estate_object int, "square" decimal(14,2), price decimal(14,2), date_of_definition timestamp,
date_of_application timestamp, "number" int, adress varchar(100), id_type_of_activity int)
AS $$
BEGIN
    RETURN QUERY 
    SELECT eo.id_estate_object, eo."square", eo.price, eo.date_of_defenition, eo.date_of_application, eo."number",
    eo.adress, eo.id_type_of_activity
    FROM estate_object eo
    JOIN estate_relation er ON eo.id_estate_object = er.id_building_estate
    WHERE er.id_place_estate = in_idestateobject
    GROUP BY eo.id_estate_object, eo."square", eo.price, eo.date_of_defenition, eo.date_of_application, eo."number",
   eo.adress, eo.id_type_of_activity;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fn_all_builds(1);

--3.2) Получение списка истории продаж определённого объекта недвижимости;

CREATE OR REPLACE FUNCTION fn_history_check(in_idestateobject int)
RETURNS TABLE (
    id_check int,
    date_of_the_sale timestamp,
    full_cost decimal(14,2),
    employee_name text,
    client_name text,
    id_estate_object int,
    actual_cost decimal(14,2),
    actual_client text
)
AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        ch.id_check,
        ch.date_of_the_sale,
        ch.full_cost,
        e.last_name || ' ' || e.first_name || ' ' || e.patronymic as employee,
        cl.last_name || ' ' || cl.first_name || ' ' || cl.patronymic as client,
        ch.is_estate_object,
        (SELECT cc.full_cost FROM "check" cc WHERE cc.is_estate_object = in_idestateobject ORDER BY cc.date_of_the_sale LIMIT 1) as actual_cost,
        (SELECT cl.last_name || ' ' || cl.first_name || ' ' || cl.patronymic FROM "check" ch JOIN client cl ON 
        ch.id_client = cl.id_client WHERE ch.is_estate_object = in_idestateobject ORDER BY ch.date_of_the_sale LIMIT 1)
        as actual_client        
    FROM "check" ch
    JOIN client cl ON ch.id_client = cl.id_client
    JOIN employee e ON ch.id_employee = e.id_employee
    WHERE is_estate_object = in_idestateobject;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fn_history_check(7)
ORDER BY date_of_the_sale;


--Triggers

--4.1) Проверка на запрет объявления квартиры на участке или в квартире;}
		--4.2) Проверка на запрет объявления дома в доме или квартире;}
		--4.3) Проверка на запрет участка в доме, участке или квартире;}

CREATE OR REPLACE FUNCTION tr_difference_place_block()
RETURNS TRIGGER AS $$
begin
    if (SELECT id_estate_object FROM estate_object eo WHERE id_type_of_activity <> 1 
    and new.id_place_estate=eo.id_estate_object)is not null THEN
        raise exception 'Запрет объявления участка в доме, участке или квартире';
    elsif (SELECT id_estate_object FROM estate_object eo WHERE id_type_of_activity <> 2 
    and new.id_building_estate=eo.id_estate_object)is not null THEN
        raise exception 'Запрет объявления участка в доме, участке или квартире';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_difference_place_block
after INSERT OR UPDATE ON estate_relation
FOR EACH ROW
EXECUTE FUNCTION tr_difference_place_block();

update estate_relation 
set id_building_estate =1
where id_estate_relation =1

-------------

CREATE OR REPLACE FUNCTION tr_difference_flat_block()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT id_estate_object FROM estate_object eo WHERE id_type_of_activity <> 3 
    and new.id_flat_estate=eo.id_estate_object) is not null THEN
        raise exception 'Запрет объявления квартиры на участке или в квартире';
    ELSIF (SELECT id_estate_object FROM estate_object eo WHERE id_type_of_activity <> 2 
    and new.id_build_estate=eo.id_estate_object) is not null THEN
        raise exception 'Запрет объявления квартиры на участке или в квартире';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_difference_flat_block
AFTER INSERT OR UPDATE ON flat_relation
FOR EACH ROW
EXECUTE FUNCTION tr_difference_flat_block()

update flat_relation 
set id_flat_estate = 4
where id_flat_relation =1
/*4.4) Проверка на запрет добавления данных для юр. лица в физ. Лицо
  4.5) Проверка на запрет добавления данных для физ. лица в юр. лицо*/


CREATE OR REPLACE FUNCTION tr_is_legal_entity()
RETURNS TRIGGER AS $$
BEGIN
    IF ((new.is_legal_entity = true  AND ((new.pasport_number IS NOT NULL OR new.pasport_series IS NOT NULL) 
    OR (new.company_title IS NULL OR new."INN" IS NULL OR new."KPP" IS NULL OR new."OGRN" IS NULL 
    OR new.payment_account IS NULL OR new.correspondent_account IS NULL OR new."BIK" IS NULL))))THEN
        raise exception 'Запрет добавления данных для юр. лица в физ. Лицо';
    END IF;
    
    IF ((new.is_legal_entity = false AND ((new.pasport_number IS NULL OR new.pasport_series IS NULL) 
    OR (new.company_title IS NOT NULL OR new."INN" IS NOT NULL OR new."KPP" IS NOT NULL OR new."OGRN" IS NOT NULL 
    OR new.payment_account IS NOT NULL OR new.correspondent_account IS NOT NULL OR new."BIK" IS NOT NULL))))THEN
        raise exception 'Запрет добавления данных для физ. лица в юр. Лицо';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_is_legal_entity
AFTER INSERT OR UPDATE ON client
FOR EACH ROW
EXECUTE FUNCTION tr_is_legal_entity();

UPDATE client
SET pasport_number = 1111,
    pasport_series = 2222
WHERE id_client = 1;

SELECT * FROM client
where id_client = 1;