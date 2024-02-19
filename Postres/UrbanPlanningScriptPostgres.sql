--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-02-19 23:49:52

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE "UrbanPlanning";
--
-- TOC entry 4990 (class 1262 OID 17584)
-- Name: UrbanPlanning; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "UrbanPlanning" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


\connect "UrbanPlanning"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 258 (class 1255 OID 17851)
-- Name: fn_all_builds(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_all_builds(in_idestateobject integer) RETURNS TABLE(id_estate_object integer, square numeric, price numeric, date_of_definition timestamp without time zone, date_of_application timestamp without time zone, number integer, adress character varying, id_type_of_activity integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT eo.id_estate_object, eo."square", eo.price, eo.date_of_defenition, eo.date_of_application, eo."number", eo.adress, eo.id_type_of_activity
    FROM estate_object eo
    JOIN estate_relation er ON eo.id_estate_object = er.id_building_estate
    WHERE er.id_place_estate = in_idestateobject
    GROUP BY eo.id_estate_object, eo."square", eo.price, eo.date_of_defenition, eo.date_of_application, eo."number", eo.adress, eo.id_type_of_activity;
END;
$$;


--
-- TOC entry 244 (class 1255 OID 17849)
-- Name: fn_all_flats(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_all_flats(in_idestateobject integer) RETURNS TABLE(id_estate_object integer, square numeric, price numeric, date_of_defenition timestamp without time zone, date_of_application timestamp without time zone, number integer, adress character varying, id_type_of_activity integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT eo.id_estate_object, eo."square", eo.price, eo.date_of_defenition, eo.date_of_application, eo."number", eo.adress, eo.id_type_of_activity
    FROM estate_object eo
    JOIN flat_relation fr ON eo.id_estate_object = fr.id_flat_estate
    WHERE fr.id_build_estate = in_idestateobject
    GROUP BY eo.id_estate_object, eo."square", eo.price, eo.date_of_defenition, eo.date_of_application, eo."number", eo.adress, eo.id_type_of_activity;
END;
$$;


--
-- TOC entry 259 (class 1255 OID 17885)
-- Name: fn_history_check(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_history_check(in_idestateobject integer) RETURNS TABLE(id_check integer, date_of_the_sale timestamp without time zone, full_cost numeric, employee_name text, client_name text, id_estate_object integer, actual_cost numeric, actual_client text)
    LANGUAGE plpgsql
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
        (SELECT cl.last_name || ' ' || cl.first_name || ' ' || cl.patronymic FROM "check" ch JOIN client cl ON ch.id_client = cl.id_client WHERE ch.is_estate_object = in_idestateobject ORDER BY ch.date_of_the_sale LIMIT 1) as actual_client
        
    FROM "check" ch
    JOIN client cl ON ch.id_client = cl.id_client
    JOIN employee e ON ch.id_employee = e.id_employee
    WHERE is_estate_object = in_idestateobject;
END;
$$;


--
-- TOC entry 256 (class 1255 OID 17841)
-- Name: pr_add_common_cost(integer, numeric); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.pr_add_common_cost(IN in_idplace integer, IN in_cost numeric)
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


--
-- TOC entry 257 (class 1255 OID 17842)
-- Name: pr_add_common_flat_cost(integer, numeric); Type: PROCEDURE; Schema: public; Owner: -
--

CREATE PROCEDURE public.pr_add_common_flat_cost(IN in_idbuild integer, IN in_cost numeric)
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


--
-- TOC entry 261 (class 1255 OID 17904)
-- Name: tr_difference_flat_block(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.tr_difference_flat_block() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (SELECT id_estate_object FROM estate_object eo WHERE id_type_of_activity <> 3 and new.id_flat_estate=eo.id_estate_object) is not null THEN
        raise exception 'Запрет объявления квартиры на участке или в квартире';
    ELSIF (SELECT id_estate_object FROM estate_object eo WHERE id_type_of_activity <> 2 and new.id_build_estate=eo.id_estate_object) is not null THEN
        raise exception 'Запрет объявления квартиры на участке или в квартире';
    END IF;
    RETURN NEW;
END;
$$;


--
-- TOC entry 260 (class 1255 OID 17886)
-- Name: tr_difference_place_block(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.tr_difference_place_block() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if (SELECT id_estate_object FROM estate_object eo WHERE id_type_of_activity <> 1 and new.id_place_estate=eo.id_estate_object)is not null THEN
        raise exception 'Запрет объявления участка в доме, участке или квартире';
    elsif (SELECT id_estate_object FROM estate_object eo WHERE id_type_of_activity <> 2 and new.id_building_estate=eo.id_estate_object)is not null THEN
        raise exception 'Запрет объявления участка в доме, участке или квартире';
    END IF;
    RETURN NEW;
END;
$$;


--
-- TOC entry 262 (class 1255 OID 17907)
-- Name: tr_is_legal_entity(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.tr_is_legal_entity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF ((new.is_legal_entity = true  AND ((new.pasport_number IS NOT NULL OR new.pasport_series IS NOT NULL) OR (new.company_title IS NULL OR new."INN" IS NULL OR new."KPP" IS NULL OR new."OGRN" IS NULL OR new.payment_account IS NULL OR new.correspondent_account IS NULL OR new."BIK" IS NULL))))THEN
        raise exception 'Запрет добавления данных для юр. лица в физ. Лицо';
    END IF;
    
    IF ((new.is_legal_entity = false AND ((new.pasport_number IS NULL OR new.pasport_series IS NULL) OR (new.company_title IS NOT NULL OR new."INN" IS NOT NULL OR new."KPP" IS NOT NULL OR new."OGRN" IS NOT NULL OR new.payment_account IS NOT NULL OR new.correspondent_account IS NOT NULL OR new."BIK" IS NOT NULL))))THEN
        raise exception 'Запрет добавления данных для физ. лица в юр. Лицо';
    END IF;

    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 240 (class 1259 OID 17859)
-- Name: check; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."check" (
    id_check integer NOT NULL,
    date_of_the_sale timestamp without time zone NOT NULL,
    full_cost numeric(14,2) NOT NULL,
    id_employee integer NOT NULL,
    id_client integer NOT NULL,
    is_estate_object integer NOT NULL
);


--
-- TOC entry 241 (class 1259 OID 17862)
-- Name: check_id_check_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."check" ALTER COLUMN id_check ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.check_id_check_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 242 (class 1259 OID 17910)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    last_name character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    patronymic character varying(50) NOT NULL,
    birthday date NOT NULL,
    phone character(13) NOT NULL,
    is_legal_entity boolean NOT NULL,
    pasport_series character(4),
    pasport_number character(6),
    company_title character varying(50),
    "INN" character(10),
    "KPP" character(9),
    "OGRN" character(13),
    payment_account character(20),
    correspondent_account character(20),
    "BIK" character(13),
    id_gender integer
);


--
-- TOC entry 243 (class 1259 OID 17913)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.client ALTER COLUMN id_client ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.client_id_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 17593)
-- Name: employee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employee (
    id_employee integer NOT NULL,
    last_name character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    patronymic character varying(50) NOT NULL,
    birthday date NOT NULL,
    phone character(13) NOT NULL,
    pasport_series character(4) NOT NULL,
    pasport_number character(6) NOT NULL,
    login character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    id_post integer NOT NULL,
    id_gender integer NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 17596)
-- Name: employee_id_employee_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.employee ALTER COLUMN id_employee ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.employee_id_employee_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 17757)
-- Name: estate_object; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estate_object (
    id_estate_object integer NOT NULL,
    square numeric(14,4) NOT NULL,
    price numeric(12,2) NOT NULL,
    date_of_defenition timestamp without time zone NOT NULL,
    date_of_application timestamp without time zone NOT NULL,
    number integer NOT NULL,
    adress character varying(100) NOT NULL,
    id_postindex integer NOT NULL,
    id_type_of_activity integer NOT NULL,
    id_format integer NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 17760)
-- Name: estate_object_id_estate_object_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.estate_object ALTER COLUMN id_estate_object ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.estate_object_id_estate_object_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 17601)
-- Name: estate_photo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estate_photo (
    id_estate_photo integer NOT NULL,
    photo_path character varying(500) NOT NULL,
    id_estate_object integer NOT NULL,
    id_employee integer NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 17606)
-- Name: estate_photo_id_estate_photo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.estate_photo ALTER COLUMN id_estate_photo ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.estate_photo_id_estate_photo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 17607)
-- Name: estate_relation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estate_relation (
    id_estate_relation integer NOT NULL,
    id_place_estate integer NOT NULL,
    id_building_estate integer NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 17610)
-- Name: estate_relation_id_estate_relation_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.estate_relation ALTER COLUMN id_estate_relation ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.estate_relation_id_estate_relation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 17611)
-- Name: flat_relation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flat_relation (
    id_flat_relation integer NOT NULL,
    id_build_estate integer NOT NULL,
    id_flat_estate integer NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 17614)
-- Name: flat_relation_id_flat_relation_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.flat_relation ALTER COLUMN id_flat_relation ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.flat_relation_id_flat_relation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 17615)
-- Name: format; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.format (
    id_format integer NOT NULL,
    format_title character varying(50) NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 17618)
-- Name: format_id_format_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.format ALTER COLUMN id_format ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.format_id_format_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 17619)
-- Name: gender; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gender (
    id_gender integer NOT NULL,
    gender_title character varying(50) NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 17622)
-- Name: gender_id_gender_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.gender ALTER COLUMN id_gender ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.gender_id_gender_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 17623)
-- Name: layout_estate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.layout_estate (
    id_layout_estate integer NOT NULL,
    main_photo character varying(500) NOT NULL,
    id_employee integer NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 17628)
-- Name: layout_estate_id_layout_estate_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.layout_estate ALTER COLUMN id_layout_estate ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.layout_estate_id_layout_estate_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 17629)
-- Name: post; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post (
    id_post integer NOT NULL,
    post_title character varying(50) NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 17632)
-- Name: post_id_post_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.post ALTER COLUMN id_post ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.post_id_post_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 17633)
-- Name: post_index; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_index (
    id_post_index integer NOT NULL,
    post_index_value character(6) NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 17636)
-- Name: post_index_id_post_index_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.post_index ALTER COLUMN id_post_index ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.post_index_id_post_index_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 17637)
-- Name: type_of_activity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.type_of_activity (
    id_type_of_activity integer NOT NULL,
    title character varying(50) NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 17640)
-- Name: type_of_activity_id_type_of_activity_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.type_of_activity ALTER COLUMN id_type_of_activity ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.type_of_activity_id_type_of_activity_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 17830)
-- Name: vw_builds; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_builds AS
 SELECT e.id_estate_object,
    e.square,
    e.price,
    e.date_of_defenition,
    e.date_of_application,
    e.number,
    e.adress,
    p.post_index_value,
    t.title,
    f.format_title
   FROM ((((public.estate_object e
     JOIN public.post_index p ON ((e.id_postindex = p.id_post_index)))
     JOIN public.type_of_activity t ON ((t.id_type_of_activity = e.id_type_of_activity)))
     JOIN public.format f ON ((e.id_format = f.id_format)))
     JOIN public.flat_relation fr ON ((e.id_estate_object = fr.id_build_estate)))
  WHERE (e.id_type_of_activity = 2)
  GROUP BY e.id_estate_object, e.square, e.price, e.date_of_defenition, e.date_of_application, e.number, e.adress, p.post_index_value, t.title, f.format_title;


--
-- TOC entry 239 (class 1259 OID 17836)
-- Name: vw_flats; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_flats AS
 SELECT e.id_estate_object,
    e.square,
    e.price,
    e.date_of_defenition,
    e.date_of_application,
    e.number,
    e.adress,
    p.post_index_value,
    t.title,
    f.format_title
   FROM (((public.estate_object e
     JOIN public.post_index p ON ((e.id_postindex = p.id_post_index)))
     JOIN public.type_of_activity t ON ((t.id_type_of_activity = e.id_type_of_activity)))
     JOIN public.format f ON ((e.id_format = f.id_format)))
  WHERE (e.id_type_of_activity = 3)
  GROUP BY e.id_estate_object, e.square, e.price, e.date_of_defenition, e.date_of_application, e.number, e.adress, p.post_index_value, t.title, f.format_title;


--
-- TOC entry 237 (class 1259 OID 17825)
-- Name: vw_places; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_places AS
 SELECT e.id_estate_object,
    e.square,
    e.price,
    e.date_of_defenition,
    e.date_of_application,
    e.number,
    e.adress,
    p.post_index_value,
    t.title,
    f.format_title
   FROM ((((public.estate_object e
     JOIN public.post_index p ON ((e.id_postindex = p.id_post_index)))
     JOIN public.type_of_activity t ON ((t.id_type_of_activity = e.id_type_of_activity)))
     JOIN public.format f ON ((e.id_format = f.id_format)))
     JOIN public.estate_relation er ON ((e.id_estate_object = er.id_place_estate)))
  WHERE (e.id_type_of_activity = 1)
  GROUP BY e.id_estate_object, e.square, e.price, e.date_of_defenition, e.date_of_application, e.number, e.adress, p.post_index_value, t.title, f.format_title;


--
-- TOC entry 4981 (class 0 OID 17859)
-- Dependencies: 240
-- Data for Name: check; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."check" VALUES (1, '1993-06-24 10:13:00', 301640000.00, 4, 4, 27);
INSERT INTO public."check" VALUES (2, '2012-05-29 13:36:00', 393520000.00, 5, 32, 24);
INSERT INTO public."check" VALUES (3, '1997-04-03 14:24:00', 28680000.00, 8, 13, 13);
INSERT INTO public."check" VALUES (4, '2018-05-16 17:47:00', 272280000.00, 11, 20, 14);
INSERT INTO public."check" VALUES (5, '2025-02-09 07:20:00', 393520000.00, 13, 36, 24);
INSERT INTO public."check" VALUES (6, '2001-09-21 07:12:00', 137000000.00, 15, 16, 41);
INSERT INTO public."check" VALUES (7, '2010-06-10 02:18:00', 228200000.00, 17, 7, 9);
INSERT INTO public."check" VALUES (8, '2010-10-09 07:29:00', 62440000.00, 18, 23, 30);
INSERT INTO public."check" VALUES (9, '2001-12-22 05:11:00', 105680000.00, 19, 18, 28);
INSERT INTO public."check" VALUES (10, '2018-05-24 07:55:00', 311360000.00, 22, 44, 16);
INSERT INTO public."check" VALUES (11, '1996-02-11 04:23:00', 61600000.00, 23, 10, 17);
INSERT INTO public."check" VALUES (12, '2015-11-18 14:02:00', 233120000.00, 26, 36, 22);
INSERT INTO public."check" VALUES (13, '2008-01-10 14:02:00', 39240000.00, 28, 23, 49);
INSERT INTO public."check" VALUES (14, '2012-12-02 03:57:00', 183800000.00, 29, 5, 26);
INSERT INTO public."check" VALUES (15, '2019-04-16 06:15:00', 37880000.00, 37, 20, 47);
INSERT INTO public."check" VALUES (16, '2005-12-26 01:04:00', 293120000.00, 38, 12, 21);
INSERT INTO public."check" VALUES (17, '2026-09-17 06:59:00', 301640000.00, 39, 22, 27);
INSERT INTO public."check" VALUES (18, '2005-05-16 12:23:00', 176760000.00, 40, 25, 29);
INSERT INTO public."check" VALUES (19, '2017-03-31 02:39:00', 366640000.00, 42, 33, 2);
INSERT INTO public."check" VALUES (20, '2001-09-26 08:42:00', 105680000.00, 43, 38, 28);
INSERT INTO public."check" VALUES (21, '2028-10-31 17:25:00', 346160000.00, 44, 49, 36);
INSERT INTO public."check" VALUES (22, '2022-01-21 18:56:00', 301640000.00, 47, 2, 27);
INSERT INTO public."check" VALUES (23, '2000-07-07 13:14:00', 385480000.00, 49, 42, 6);
INSERT INTO public."check" VALUES (24, '2019-10-30 16:20:00', 71720000.00, 4, 40, 12);
INSERT INTO public."check" VALUES (25, '2001-06-11 01:26:00', 124840000.00, 5, 13, 8);
INSERT INTO public."check" VALUES (26, '1999-05-02 02:57:00', 176760000.00, 8, 15, 29);
INSERT INTO public."check" VALUES (27, '1995-10-18 09:08:00', 311360000.00, 11, 14, 16);
INSERT INTO public."check" VALUES (28, '2001-03-18 16:20:00', 71720000.00, 13, 37, 12);
INSERT INTO public."check" VALUES (29, '2001-07-04 12:23:00', 102440000.00, 15, 50, 23);
INSERT INTO public."check" VALUES (30, '2025-09-24 13:36:00', 102440000.00, 17, 23, 23);
INSERT INTO public."check" VALUES (31, '2008-07-27 15:50:00', 62440000.00, 18, 26, 30);
INSERT INTO public."check" VALUES (32, '2008-06-21 03:23:00', 28680000.00, 19, 41, 13);
INSERT INTO public."check" VALUES (33, '2019-10-20 06:50:00', 22200000.00, 22, 12, 19);
INSERT INTO public."check" VALUES (34, '2027-10-15 15:41:00', 224560100.00, 23, 22, 42);
INSERT INTO public."check" VALUES (35, '2011-07-25 05:24:00', 272280000.00, 26, 10, 14);
INSERT INTO public."check" VALUES (36, '1999-12-19 00:00:00', 124830000.00, 28, 42, 8);
INSERT INTO public."check" VALUES (37, '2010-05-06 03:31:00', 137000000.00, 29, 16, 41);
INSERT INTO public."check" VALUES (38, '2009-10-27 13:45:00', 137000000.00, 37, 9, 41);
INSERT INTO public."check" VALUES (39, '2017-05-06 09:04:00', 332520000.00, 38, 15, 25);
INSERT INTO public."check" VALUES (40, '2008-12-26 16:55:00', 276560000.00, 39, 43, 40);
INSERT INTO public."check" VALUES (41, '2022-09-15 05:06:00', 272280000.00, 40, 23, 14);
INSERT INTO public."check" VALUES (42, '2014-07-18 07:29:00', 384560000.00, 42, 20, 7);
INSERT INTO public."check" VALUES (43, '1995-10-23 08:42:00', 137000000.00, 43, 20, 41);
INSERT INTO public."check" VALUES (44, '2006-11-20 05:36:00', 37880000.00, 44, 1, 47);
INSERT INTO public."check" VALUES (45, '1995-12-02 05:54:00', 393520000.00, 47, 48, 24);
INSERT INTO public."check" VALUES (46, '2017-07-12 18:25:00', 81960100.00, 49, 29, 50);
INSERT INTO public."check" VALUES (47, '2024-10-18 10:52:00', 216240000.00, 4, 16, 43);
INSERT INTO public."check" VALUES (48, '2008-12-25 12:57:00', 128800000.00, 5, 8, 20);
INSERT INTO public."check" VALUES (49, '1997-06-23 17:08:00', 62440000.00, 8, 7, 30);
INSERT INTO public."check" VALUES (50, '2007-02-19 06:59:00', 384560000.00, 11, 32, 7);


--
-- TOC entry 4983 (class 0 OID 17910)
-- Dependencies: 242
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client VALUES (2, 'Коновалов', 'Артур', 'Кириллович', '1971-09-12', '86107857394  ', true, NULL, NULL, 'JesusAndWaltonCompany', '4651440006', '277099949', '7081755478805', '84455339221165200000', '10718292016957900000', '347003036    ', 1);
INSERT INTO public.client VALUES (4, 'Владимирова', 'Полина', 'Павловна', '1988-02-24', '81397898941  ', true, NULL, NULL, 'RichardAndPriceCompany', '2351462371', '713960699', '8183787100473', '31205407808751100000', '57178014595511500000', '736760351    ', 2);
INSERT INTO public.client VALUES (5, 'Полякова', 'Алина', 'Романовна', '1989-05-10', '83665536821  ', false, '6508', '304796', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (6, 'Яковлева', 'Альбина', 'Данииловна', '2005-07-17', '86994952037  ', false, '5689', '949910', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (7, 'Ершова', 'София', 'Владимировна', '1998-07-09', '84828257844  ', true, NULL, NULL, 'MichaelAndHollowayCompany', '6079033909', '994727367', '8771356148707', '78658313757047500000', '63441238117843800000', '896890906    ', 2);
INSERT INTO public.client VALUES (8, 'Иванов', 'Арсений', 'Михайлович', '1984-09-17', '85017190458  ', false, '8542', '513781', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (9, 'Третьякова', 'Таисия', 'Константиновна', '2003-05-16', '80215750595  ', false, '3438', '742921', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (10, 'Фомина', 'Вера', 'Макаровна', '1984-07-10', '85884431802  ', true, NULL, NULL, 'JanetAndStewartCompany', '6090387243', '961183330', '9287080707710', '13185688528930900000', '23120199793324800000', '618409774    ', 2);
INSERT INTO public.client VALUES (11, 'Розанов', 'Марк', 'Артёмович', '1977-04-27', '83937020301  ', false, '9043', '231513', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (12, 'Смирнов', 'Андрей', 'Миронович', '2002-10-20', '80789165310  ', true, NULL, NULL, 'AnnAndBurnsCompany', '1263644027', '189383685', '8380096233104', '40208929989408200000', '77993945926660200000', '996454009    ', 1);
INSERT INTO public.client VALUES (13, 'Злобина', 'Есения', 'Данииловна', '1976-01-10', '84190720145  ', true, NULL, NULL, 'CarolynAndCainCompany', '5708800973', '789451735', '9457093993768', '41988316348770900000', '22721571055825500000', '461634186    ', 2);
INSERT INTO public.client VALUES (14, 'Миронова', 'София', 'Ярославовна', '1995-11-11', '80692066300  ', true, NULL, NULL, 'CarlAndSuttonCompany', '1979441510', '912782320', '6349798816714', '99142098468069300000', '43783626432765600000', '464363278    ', 2);
INSERT INTO public.client VALUES (15, 'Терентьев', 'Виктор', 'Захарович', '1998-03-01', '89855696994  ', true, NULL, NULL, 'CarolAndPatrickCompany', '7692148593', '590498578', '3831340401446', '82109475838937500000', '55482944731266200000', '462385689    ', 1);
INSERT INTO public.client VALUES (16, 'Белов', 'Владислав', 'Максимович', '1975-05-20', '85560446537  ', false, '7488', '473457', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (17, 'Михеева', 'Полина', 'Алексеевна', '1998-03-06', '87688275471  ', false, '6266', '777977', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (18, 'Жилина', 'Милана', 'Константиновна', '2003-07-26', '82674380394  ', true, NULL, NULL, 'MelissaAndParkCompany', '5889020669', '849487878', '2933915207104', '76991184146466300000', '48372432354957800000', '671730501    ', 2);
INSERT INTO public.client VALUES (19, 'Яковлев', 'Роман', 'Александрович', '2001-06-15', '82028433737  ', false, '6281', '680569', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (20, 'Кузнецова', 'Анастасия', 'Львовна', '1977-11-26', '89164626489  ', true, NULL, NULL, 'LeslieAndJohnsonCompany', '7033435301', '439125867', '3568552171444', '80607670873651700000', '61551276205664200000', '650442240    ', 2);
INSERT INTO public.client VALUES (21, 'Филиппова', 'Арина', 'Фёдоровна', '2002-09-02', '80007548019  ', false, '9164', '808028', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (22, 'Титова', 'Полина', 'Александровна', '1977-03-12', '82339974415  ', true, NULL, NULL, 'DonnaAndNelsonCompany', '1119203486', '508734550', '8841543887438', '22510244548241800000', '86544920072443200000', '638619709    ', 2);
INSERT INTO public.client VALUES (23, 'Сергеева', 'Эмилия', 'Арсентьевна', '1993-11-15', '82505918426  ', true, NULL, NULL, 'ColleenAndReevesCompany', '7964168868', '847430855', '1414975914383', '50067482284130100000', '63321494106711700000', '420733566    ', 2);
INSERT INTO public.client VALUES (24, 'Александров', 'Михаил', 'Максимович', '2002-07-11', '82839736464  ', false, '9320', '466428', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (25, 'Смирнова', 'Софья', 'Фёдоровна', '1983-07-06', '84016902737  ', true, NULL, NULL, 'AndreaAndDavisCompany', '1387860518', '620778644', '2857186382755', '48446382598366700000', '87514247144503400000', '375715790    ', 2);
INSERT INTO public.client VALUES (26, 'Усов', 'Ярослав', 'Богданович', '2000-02-18', '89048237941  ', true, NULL, NULL, 'AngelAndMillerCompany', '9005451015', '491057504', '4967745420693', '82588169233634100000', '46731489136350000000', '770565236    ', 1);
INSERT INTO public.client VALUES (27, 'Зубова', 'Александра', 'Артуровна', '1998-01-19', '82978074577  ', true, NULL, NULL, 'CodyAndSmithCompany', '4115834234', '814188088', '6971050445510', '78043795419298000000', '34674020659547700000', '493847823    ', 2);
INSERT INTO public.client VALUES (28, 'Новиков', 'Лев', 'Артёмович', '2003-06-22', '80980581637  ', true, NULL, NULL, 'KennethAndEdwardsCompany', '5383898875', '685670952', '3772292466032', '69372958547983600000', '19388117348853800000', '301588083    ', 1);
INSERT INTO public.client VALUES (29, 'Кузнецов', 'Егор', 'Максимович', '1970-12-25', '85690048843  ', false, '6188', '911171', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (30, 'Бородин', 'Эмир', 'Дмитриевич', '1999-11-06', '80692713287  ', false, '3799', '718491', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (31, 'Князев', 'Михаил', 'Тимурович', '1991-04-12', '89581500287  ', true, NULL, NULL, 'RichardAndCunninghamCompany', '7444064475', '654244250', '4864603124950', '52754174561363900000', '80699150188985700000', '817327894    ', 1);
INSERT INTO public.client VALUES (32, 'Кузнецова', 'Софья', 'Максимовна', '2004-11-16', '85126968539  ', true, NULL, NULL, 'EmilyAndRayCompany', '3530064452', '662547685', '8468345314698', '51239893833254900000', '41615687801067900000', '301065576    ', 2);
INSERT INTO public.client VALUES (33, 'Малышева', 'Ясмина', 'Данииловна', '1984-08-07', '83295308173  ', true, NULL, NULL, 'EvaAndBrownCompany', '2636626042', '612941131', '9755192696665', '74180478687004500000', '98107638839142500000', '474301547    ', 2);
INSERT INTO public.client VALUES (34, 'Смирнова', 'Елизавета', 'Савельевна', '1990-07-13', '87397133330  ', true, NULL, NULL, 'ClaraAndHolmesCompany', '6440694197', '636519169', '5222355190173', '26775272102322200000', '84156542761946500000', '809574948    ', 2);
INSERT INTO public.client VALUES (35, 'Акимова', 'Таисия', 'Михайловна', '1981-06-01', '83604373807  ', true, NULL, NULL, 'PeterAndPowellCompany', '2568163895', '835435141', '1225617274392', '39033528376584400000', '28064695169998000000', '364368939    ', 2);
INSERT INTO public.client VALUES (36, 'Дорофеева', 'Александра', 'Ярославовна', '1991-08-03', '88577392780  ', false, '7154', '476074', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (37, 'Колосова', 'Василиса', 'Сергеевна', '1978-09-25', '85665620817  ', true, NULL, NULL, 'EvelynAndMurphyCompany', '7500095546', '111172127', '6120502907986', '85658189656311500000', '95247515954667000000', '425194878    ', 2);
INSERT INTO public.client VALUES (38, 'Захаров', 'Александр', 'Юрьевич', '1995-06-26', '89312386662  ', false, '9139', '896920', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (39, 'Фадеева', 'Полина', 'Владимировна', '2001-07-21', '87002894089  ', true, NULL, NULL, 'YolandaAndOwensCompany', '5059812065', '730695704', '8697187080375', '22786775433131500000', '78864501829580400000', '163557003    ', 2);
INSERT INTO public.client VALUES (40, 'Борисов', 'Максим', 'Фёдорович', '1995-02-05', '80699613981  ', false, '3262', '656194', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (41, 'Воронова', 'Елена', 'Константиновна', '1976-07-24', '87218917452  ', false, '2191', '305959', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (42, 'Рожкова', 'Камилла', 'Кирилловна', '1996-11-20', '83164632689  ', false, '8519', '481856', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (3, 'Худяков', 'Иван', 'Артёмович', '1983-08-18', '83653814430  ', false, '5177', '209495', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (43, 'Ситников', 'Тимур', 'Юрьевич', '1997-03-22', '88225404705  ', true, NULL, NULL, 'JohnAndBurgessCompany', '5457739811', '818911266', '4473619902071', '93347519502125600000', '51354761755880900000', '503486621    ', 1);
INSERT INTO public.client VALUES (44, 'Ширяев', 'Тимур', 'Матвеевич', '1972-01-22', '87070645425  ', true, NULL, NULL, 'KimAndWardCompany', '1921864483', '412437835', '8192289021107', '24528096154120400000', '55296235405904300000', '595824388    ', 1);
INSERT INTO public.client VALUES (45, 'Дьякова', 'Евангелина', 'Арсентьевна', '1990-08-16', '83183555680  ', false, '5006', '326464', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (46, 'Романов', 'Павел', 'Юрьевич', '1998-08-02', '85693528915  ', false, '1302', '867377', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (47, 'Чернышева', 'Вероника', 'Александровна', '1986-09-22', '87838303096  ', false, '5036', '681609', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (48, 'Лапшин', 'Алексей', 'Егорович', '1991-05-06', '89991052089  ', false, '3619', '818538', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (49, 'Чернышева', 'Ангелина', 'Максимовна', '1991-06-12', '84523771780  ', false, '2388', '879000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO public.client VALUES (50, 'Баженов', 'Александр', 'Маркович', '1991-01-04', '81065599198  ', false, '8955', '300514', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.client VALUES (1, 'Константинов', 'Матвей', 'Александрович', '1982-09-21', '85153127367  ', true, NULL, NULL, 'RachelAndMillerCompany', '6978006786', '620679453', '9133312695650', '95164386888201200000', '65286211061516500000', '809287306    ', 1);


--
-- TOC entry 4959 (class 0 OID 17593)
-- Dependencies: 215
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.employee VALUES (1, 'Козлов', 'Владимир', 'Вадимович', '1995-06-10', '89782904561  ', '9209', '734916', '123LE59Evfk', 'LE59Evfk', 3, 1);
INSERT INTO public.employee VALUES (2, 'Кириллова', 'Виктория', 'Давидовна', '1984-05-16', '81200222412  ', '6671', '526895', '456kp1WNnK2', 'kp1WNnK2', 2, 2);
INSERT INTO public.employee VALUES (3, 'Попова', 'Анна', 'Артёмовна', '2003-05-19', '86358379282  ', '7211', '809976', '789478Zwdlu', '478Zwdlu', 2, 2);
INSERT INTO public.employee VALUES (4, 'Ильин', 'Лука', 'Александрович', '1999-07-09', '81604920953  ', '2595', '714066', '11228uyhBjpn', '8uyhBjpn', 1, 1);
INSERT INTO public.employee VALUES (5, 'Петухова', 'Виктория', 'Егоровна', '1971-04-15', '83731866731  ', '1430', '789839', '1455OPSz7P6Z', 'OPSz7P6Z', 1, 2);
INSERT INTO public.employee VALUES (6, 'Попова', 'Полина', 'Максимовна', '1982-02-15', '80064733460  ', '6424', '235418', '1788PrqOC8zZ', 'PrqOC8zZ', 3, 2);
INSERT INTO public.employee VALUES (7, 'Самсонова', 'Кира', 'Николаевна', '1979-12-09', '87195926986  ', '9942', '277036', '2121KsH3SbHB', 'KsH3SbHB', 2, 2);
INSERT INTO public.employee VALUES (8, 'Иванов', 'Игорь', 'Андреевич', '1977-08-04', '85283589961  ', '3524', '534345', '2454E938XjF4', 'E938XjF4', 1, 1);
INSERT INTO public.employee VALUES (9, 'Евдокимов', 'Илья', 'Максимович', '1987-02-06', '81246141594  ', '3408', '528908', '2787Gd94iXtW', 'Gd94iXtW', 3, 1);
INSERT INTO public.employee VALUES (10, 'Петрова', 'Дарья', 'Платоновна', '1989-11-25', '80680727309  ', '2914', '768826', '31202ClI8lGQ', '2ClI8lGQ', 2, 2);
INSERT INTO public.employee VALUES (11, 'Казаков', 'Никита', 'Михайлович', '1973-09-25', '88901449446  ', '2450', '412722', '3453V8JOsVhz', 'V8JOsVhz', 1, 1);
INSERT INTO public.employee VALUES (12, 'Синицын', 'Александр', 'Даниилович', '1970-05-20', '84218656326  ', '5598', '387929', '3786bHWbf7Pz', 'bHWbf7Pz', 3, 1);
INSERT INTO public.employee VALUES (13, 'Козлов', 'Иван', 'Даниилович', '2002-06-06', '86940951118  ', '4089', '496330', '4119F6o9icG7', 'F6o9icG7', 1, 1);
INSERT INTO public.employee VALUES (14, 'Владимиров', 'Максим', 'Александрович', '1993-11-09', '89070431018  ', '2665', '593820', '4452m7qldF5V', 'm7qldF5V', 3, 1);
INSERT INTO public.employee VALUES (15, 'Русакова', 'Ульяна', 'Тимуровна', '1989-11-19', '81432581560  ', '4085', '428185', '4785MZhxpCC4', 'MZhxpCC4', 1, 2);
INSERT INTO public.employee VALUES (16, 'Евдокимова', 'Софья', 'Данииловна', '1991-09-13', '87695776225  ', '2704', '155133', '5118FASZgk7P', 'FASZgk7P', 3, 2);
INSERT INTO public.employee VALUES (17, 'Зверев', 'Дмитрий', 'Ярославович', '1970-08-26', '87266353847  ', '3100', '807366', '5451SBiDs1AV', 'SBiDs1AV', 1, 1);
INSERT INTO public.employee VALUES (18, 'Сизов', 'Леонид', 'Львович', '2003-09-02', '83394808883  ', '2882', '828585', '57848HZANvPn', '8HZANvPn', 1, 1);
INSERT INTO public.employee VALUES (19, 'Колосов', 'Даниил', 'Артёмович', '1977-02-09', '87578466255  ', '7001', '246928', '6117kJClV6Ug', 'kJClV6Ug', 1, 1);
INSERT INTO public.employee VALUES (20, 'Денисов', 'Марк', 'Романович', '1971-02-21', '87474363608  ', '1489', '874770', '645000Cv5IEt', '00Cv5IEt', 3, 1);
INSERT INTO public.employee VALUES (21, 'Кузнецов', 'Глеб', 'Даниилович', '1985-11-06', '86685573758  ', '6259', '104793', '6783WKeKQbQ0', 'WKeKQbQ0', 2, 1);
INSERT INTO public.employee VALUES (22, 'Морозов', 'Семён', 'Артёмович', '1973-08-24', '84269610601  ', '6005', '647699', '7116MdcEC8Iv', 'MdcEC8Iv', 1, 1);
INSERT INTO public.employee VALUES (23, 'Денисов', 'Константин', 'Иванович', '1977-05-14', '88640221450  ', '7528', '460218', '7449MF45U0By', 'MF45U0By', 1, 1);
INSERT INTO public.employee VALUES (24, 'Токарева', 'Кристина', 'Кирилловна', '1993-08-19', '89640854331  ', '6945', '387984', '7782wGQhrEC8', 'wGQhrEC8', 3, 2);
INSERT INTO public.employee VALUES (25, 'Кудряшов', 'Артём', 'Ильич', '1984-11-07', '81891145385  ', '4941', '380269', '81157puysBxP', '7puysBxP', 3, 1);
INSERT INTO public.employee VALUES (26, 'Жукова', 'Ксения', 'Никитична', '1974-07-28', '84739275572  ', '9055', '856975', '8448NzfW7tBX', 'NzfW7tBX', 1, 2);
INSERT INTO public.employee VALUES (27, 'Черняев', 'Андрей', 'Егорович', '1994-04-08', '85412023052  ', '4033', '177406', '87814ZUgQHzX', '4ZUgQHzX', 3, 1);
INSERT INTO public.employee VALUES (28, 'Павлов', 'Кирилл', 'Захарович', '1992-01-17', '87652326535  ', '6014', '656174', '9114Efl1HnFm', 'Efl1HnFm', 1, 1);
INSERT INTO public.employee VALUES (29, 'Данилова', 'Анна', 'Владимировна', '1988-10-20', '80712994518  ', '5555', '123819', '9447hp2TGirQ', 'hp2TGirQ', 1, 2);
INSERT INTO public.employee VALUES (30, 'Краснова', 'Кира', 'Егоровна', '1986-10-16', '85848597688  ', '6431', '317403', '9780RtC3n8OS', 'RtC3n8OS', 3, 2);
INSERT INTO public.employee VALUES (31, 'Савицкий', 'Михаил', 'Максимович', '1998-12-18', '87282889570  ', '5388', '445107', '10113qugNes86', 'qugNes86', 2, 1);
INSERT INTO public.employee VALUES (32, 'Кузнецов', 'Артём', 'Даниилович', '1975-05-22', '82530718803  ', '6773', '517386', '10446Vpp8H9Ej', 'Vpp8H9Ej', 3, 1);
INSERT INTO public.employee VALUES (33, 'Смирнова', 'Анастасия', 'Дмитриевна', '1970-09-19', '88840706548  ', '9621', '435541', '10779P9R7M7Mq', 'P9R7M7Mq', 3, 2);
INSERT INTO public.employee VALUES (34, 'Кузина', 'Кристина', 'Петровна', '1990-08-14', '88265718247  ', '4958', '489215', '11112FR4XZx87', 'FR4XZx87', 3, 2);
INSERT INTO public.employee VALUES (35, 'Кузнецов', 'Тимофей', 'Маркович', '1970-09-27', '80128825193  ', '7905', '119684', '11445OKXUeDH7', 'OKXUeDH7', 2, 1);
INSERT INTO public.employee VALUES (36, 'Лукьянова', 'Елена', 'Максимовна', '1986-12-12', '89950665742  ', '2894', '392830', '117782AfYKO4Z', '2AfYKO4Z', 2, 2);
INSERT INTO public.employee VALUES (37, 'Коровина', 'Алиса', 'Ивановна', '1975-11-24', '82688977059  ', '5647', '942564', '12111o0ZTLN7r', 'o0ZTLN7r', 1, 2);
INSERT INTO public.employee VALUES (38, 'Воронцова', 'Агния', 'Григорьевна', '2003-01-03', '84537810722  ', '6797', '935260', '12444lSq4eI1u', 'lSq4eI1u', 1, 2);
INSERT INTO public.employee VALUES (39, 'Галкин', 'Лев', 'Германович', '1997-09-06', '84255997454  ', '2818', '204150', '12777fea6r9Fe', 'fea6r9Fe', 1, 1);
INSERT INTO public.employee VALUES (40, 'Васильев', 'Константин', 'Родионович', '1988-04-01', '86280519294  ', '9363', '856562', '13110kkg6QNMR', 'kkg6QNMR', 1, 1);
INSERT INTO public.employee VALUES (41, 'Дубровина', 'София', 'Данииловна', '2002-08-04', '86952566335  ', '1628', '561906', '134434L8ttOHB', '4L8ttOHB', 2, 2);
INSERT INTO public.employee VALUES (42, 'Борисова', 'Злата', 'Вадимовна', '1979-12-15', '89829329108  ', '7998', '948146', '13776Iym4gNiw', 'Iym4gNiw', 1, 2);
INSERT INTO public.employee VALUES (43, 'Молчанова', 'Екатерина', 'Ивановна', '1979-03-22', '81904314051  ', '1922', '142584', '14109Q8ubzXeL', 'Q8ubzXeL', 1, 2);
INSERT INTO public.employee VALUES (44, 'Бочаров', 'Матвей', 'Алексеевич', '1993-10-21', '82369375340  ', '7765', '613698', '14442fdhl0OiW', 'fdhl0OiW', 1, 1);
INSERT INTO public.employee VALUES (45, 'Григорьева', 'Ирина', 'Кирилловна', '1994-10-08', '85200881502  ', '2295', '786749', '147755doBwZUj', '5doBwZUj', 2, 2);
INSERT INTO public.employee VALUES (46, 'Одинцова', 'Алиса', 'Львовна', '1973-11-18', '83018121548  ', '2187', '611605', '15108VPOU2WcX', 'VPOU2WcX', 2, 2);
INSERT INTO public.employee VALUES (47, 'Юдин', 'Тимофей', 'Романович', '1988-06-22', '89854695131  ', '9317', '222681', '15441GeO5mcOu', 'GeO5mcOu', 1, 1);
INSERT INTO public.employee VALUES (48, 'Романов', 'Данил', 'Михайлович', '2000-11-23', '88565932222  ', '7027', '846918', '15774RutED5qG', 'RutED5qG', 3, 1);
INSERT INTO public.employee VALUES (49, 'Савина', 'Арина', 'Ярославовна', '1980-05-21', '83745929786  ', '6492', '876148', '16107Ymk6imJv', 'Ymk6imJv', 1, 2);
INSERT INTO public.employee VALUES (50, 'Ушаков', 'Матвей', 'Фёдорович', '2002-11-28', '84996057163  ', '3456', '945955', '16440sat3BfzO', 'sat3BfzO', 3, 1);


--
-- TOC entry 4979 (class 0 OID 17757)
-- Dependencies: 235
-- Data for Name: estate_object; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.estate_object VALUES (1, 561.0000, 22440000.00, '1991-02-24 00:00:00', '1993-01-07 00:00:00', 8, 'г. Красноярск,  ул. Лермонтова, уч 8', 43, 1, 1);
INSERT INTO public.estate_object VALUES (2, 9166.0000, 366640000.00, '2010-04-15 00:00:00', '2011-08-16 00:00:00', 198, 'г. Тольятти,  ул. Свердлова, уч 198', 20, 1, 1);
INSERT INTO public.estate_object VALUES (5, 3343.0000, 133720000.00, '2021-11-25 00:00:00', '2024-03-26 00:00:00', 62, 'г. Екатеринбург,  ул. Энергетиков, уч 62', 5, 1, 3);
INSERT INTO public.estate_object VALUES (6, 9637.0000, 385480000.00, '1998-07-01 00:00:00', '1999-12-04 00:00:00', 14, 'г. Саратов,  ул. Фрунзе, уч 14', 49, 1, 2);
INSERT INTO public.estate_object VALUES (7, 9614.0000, 384560000.00, '2007-05-21 00:00:00', '2009-02-04 00:00:00', 23, 'г. Ростов-на-Дону,  ул. Южная, уч 23', 44, 1, 3);
INSERT INTO public.estate_object VALUES (8, 3121.0000, 124840000.00, '2008-06-12 00:00:00', '2009-08-07 00:00:00', 155, 'г. Уфа,  ул. Пролетарская, уч 155', 8, 1, 3);
INSERT INTO public.estate_object VALUES (9, 5705.0000, 228200000.00, '1997-10-26 00:00:00', '1999-09-05 00:00:00', 45, 'г. Нижний Новгород,  ул. Молодежная, уч 45', 13, 1, 2);
INSERT INTO public.estate_object VALUES (10, 4399.0000, 175960000.00, '2015-05-09 00:00:00', '2017-04-15 00:00:00', 28, 'г. Уфа,  ул. Дорожная, уч 28', 46, 1, 2);
INSERT INTO public.estate_object VALUES (11, 3260.0000, 130400000.00, '1992-04-24 00:00:00', '1993-06-04 00:00:00', 134, 'г. Тольятти,  ул. Свердлова, уч 198, д. 11', 43, 2, 3);
INSERT INTO public.estate_object VALUES (12, 1793.0000, 71720000.00, '2012-09-13 00:00:00', '2015-01-25 00:00:00', 60, 'г. Красноярск,  ул. Молодежная, уч 60', 2, 1, 3);
INSERT INTO public.estate_object VALUES (15, 4684.0000, 187360000.00, '2015-12-17 00:00:00', '2018-04-08 00:00:00', 163, 'г. Екатеринбург,  ул. Энергетиков, уч 62, д. 15', 23, 2, 2);
INSERT INTO public.estate_object VALUES (16, 7784.0000, 311360000.00, '2003-01-23 00:00:00', '2004-12-30 00:00:00', 64, 'г. Тюмень,  ул. Матросова, уч 64', 28, 1, 1);
INSERT INTO public.estate_object VALUES (17, 1540.0000, 61600000.00, '2023-09-15 00:00:00', '2025-05-18 00:00:00', 188, 'г. Тольятти,  ул. Парковая, уч 188', 6, 1, 1);
INSERT INTO public.estate_object VALUES (18, 4717.0000, 188680000.00, '2003-09-04 00:00:00', '2004-12-01 00:00:00', 94, 'г. Уфа,  ул. Фрунзе, уч 94', 13, 1, 3);
INSERT INTO public.estate_object VALUES (21, 7328.0000, 293120000.00, '2024-06-06 00:00:00', '2026-07-28 00:00:00', 144, 'г. Саратов,  ул. Фрунзе, уч 14, д. 21', 38, 2, 1);
INSERT INTO public.estate_object VALUES (22, 5828.0000, 233120000.00, '2019-05-19 00:00:00', '2021-09-10 00:00:00', 93, 'г. Ростов-на-Дону,  ул. Южная, уч 23, д. 22', 12, 2, 2);
INSERT INTO public.estate_object VALUES (24, 9838.0000, 393520000.00, '2017-07-02 00:00:00', '2018-09-11 00:00:00', 130, 'г. Краснодар,  ул. Железнодорожная, уч 130', 50, 1, 3);
INSERT INTO public.estate_object VALUES (26, 4595.0000, 183800000.00, '1996-07-27 00:00:00', '1998-09-13 00:00:00', 63, 'г. Волгоград,  ул. Вишневая, уч 63', 16, 1, 1);
INSERT INTO public.estate_object VALUES (29, 4419.0000, 176760000.00, '1998-05-15 00:00:00', '2000-10-20 00:00:00', 104, 'г. Краснодар,  ул. Свободы, уч 104', 22, 1, 2);
INSERT INTO public.estate_object VALUES (32, 5136.0000, 205440000.00, '2005-09-09 00:00:00', '2008-01-12 00:00:00', 95, 'г. Москва,  ул. Овражная, уч 95', 4, 1, 1);
INSERT INTO public.estate_object VALUES (34, 6162.0000, 246480000.00, '2024-09-06 00:00:00', '2025-12-09 00:00:00', 160, 'г. Тольятти,  ул. Нагорная, уч 160', 30, 1, 3);
INSERT INTO public.estate_object VALUES (35, 3846.0000, 153840000.00, '2009-04-16 00:00:00', '2010-06-30 00:00:00', 117, 'г. Москва,  ул. Клубная, уч 117', 10, 1, 2);
INSERT INTO public.estate_object VALUES (39, 5438.0000, 217520000.00, '2012-11-04 00:00:00', '2015-06-19 00:00:00', 103, 'г. Самара,  ул. Зеленая, уч 103', 7, 1, 3);
INSERT INTO public.estate_object VALUES (40, 6914.0000, 276560000.00, '2005-04-07 00:00:00', '2007-04-24 00:00:00', 5, 'г. Москва,  ул. Дорожная, уч 5', 50, 1, 1);
INSERT INTO public.estate_object VALUES (41, 3425.0000, 137000000.00, '2020-11-19 00:00:00', '2021-12-10 00:00:00', 107, 'г. Уфа,  ул. Пролетарская, уч 155, д. 41', 46, 2, 2);
INSERT INTO public.estate_object VALUES (44, 395.0000, 15800000.00, '2004-07-02 00:00:00', '2005-10-10 00:00:00', 110, 'г. Нижний Новгород,  ул. Молодежная, уч 45, д. 44', 12, 2, 3);
INSERT INTO public.estate_object VALUES (46, 5090.0000, 203600000.00, '2014-01-10 00:00:00', '2016-06-29 00:00:00', 118, 'г. Уфа,  ул. Дорожная, уч 28, д. 46', 5, 2, 3);
INSERT INTO public.estate_object VALUES (47, 947.0000, 37880000.00, '2021-04-19 00:00:00', '2022-09-01 00:00:00', 94, 'г. Красноярск,  ул. Молодежная, уч 60, д. 47', 14, 2, 2);
INSERT INTO public.estate_object VALUES (48, 381.0000, 15240000.00, '2004-03-21 00:00:00', '2006-11-20 00:00:00', 134, 'г. Ижевск,  ул. Трактовая, уч 134', 38, 1, 3);
INSERT INTO public.estate_object VALUES (49, 981.0000, 39240000.00, '1993-09-08 00:00:00', '1996-04-22 00:00:00', 86, 'г. Тюмень,  ул. Матросова, уч 64, д. 49', 45, 2, 2);
INSERT INTO public.estate_object VALUES (50, 2049.0000, 81959800.00, '2004-05-19 00:00:00', '2006-07-11 00:00:00', 97, 'г. Красноярск,  ул. Лермонтова, уч 8, д. 50', 13, 2, 1);
INSERT INTO public.estate_object VALUES (4, 3124.0000, 132418600.00, '2013-08-24 00:00:00', '2016-04-18 00:00:00', 63, 'г. Красноярск,  ул. Лермонтова, уч 8, д. 4', 26, 2, 2);
INSERT INTO public.estate_object VALUES (33, 6377.0000, 255080400.00, '2015-08-27 00:00:00', '2017-10-29 00:00:00', 16, 'г. Красноярск,  ул. Лермонтова, уч 8, д. 4, кв. 33', 28, 3, 1);
INSERT INTO public.estate_object VALUES (3, 236.0000, 9440400.00, '1993-08-13 00:00:00', '1996-03-30 00:00:00', 81, 'г. Красноярск,  ул. Лермонтова, уч 8, д. 4, кв. 3', 23, 3, 1);
INSERT INTO public.estate_object VALUES (42, 5614.0000, 224560400.00, '2011-09-08 00:00:00', '2012-11-11 00:00:00', 12, 'г. Красноярск,  ул. Лермонтова, уч 8, д. 4, кв. 42', 45, 3, 1);
INSERT INTO public.estate_object VALUES (13, 717.0000, 28680300.00, '2003-10-23 00:00:00', '2005-09-08 00:00:00', 47, 'г. Тольятти,  ул. Свердлова, уч 198, д. 11, кв. 13', 27, 3, 2);
INSERT INTO public.estate_object VALUES (36, 8654.0000, 346160300.00, '1997-09-28 00:00:00', '1999-01-13 00:00:00', 37, 'г. Тольятти,  ул. Свердлова, уч 198, д. 11, кв. 36', 15, 3, 1);
INSERT INTO public.estate_object VALUES (43, 5406.0000, 216240300.00, '1992-06-23 00:00:00', '1993-11-21 00:00:00', 52, 'г. Тольятти,  ул. Свердлова, уч 198, д. 11, кв. 43', 39, 3, 3);
INSERT INTO public.estate_object VALUES (37, 3095.0000, 123800300.00, '2007-07-26 00:00:00', '2009-07-04 00:00:00', 173, 'г. Екатеринбург,  ул. Энергетиков, уч 62, д. 15, кв. 37', 25, 3, 3);
INSERT INTO public.estate_object VALUES (45, 4443.0000, 177720300.00, '1991-01-14 00:00:00', '1993-06-06 00:00:00', 52, 'г. Екатеринбург,  ул. Энергетиков, уч 62, д. 15, кв. 45', 26, 3, 3);
INSERT INTO public.estate_object VALUES (14, 6807.0000, 272280300.00, '2008-03-18 00:00:00', '2010-06-08 00:00:00', 92, 'г. Екатеринбург,  ул. Энергетиков, уч 62, д. 15, кв. 14', 33, 3, 3);
INSERT INTO public.estate_object VALUES (19, 555.0000, 22200300.00, '2015-01-20 00:00:00', '2016-09-13 00:00:00', 177, 'г. Саратов,  ул. Фрунзе, уч 14, д. 21, кв. 19', 37, 3, 1);
INSERT INTO public.estate_object VALUES (38, 1787.0000, 71480300.00, '2005-08-13 00:00:00', '2007-11-29 00:00:00', 45, 'г. Саратов,  ул. Фрунзе, уч 14, д. 21, кв. 38', 3, 3, 2);
INSERT INTO public.estate_object VALUES (20, 3220.0000, 128800300.00, '1998-02-05 00:00:00', '1999-09-27 00:00:00', 93, 'г. Ростов-на-Дону,  ул. Южная, уч 23, д. 22, кв. 20', 49, 3, 3);
INSERT INTO public.estate_object VALUES (23, 2561.0000, 102440300.00, '1998-02-19 00:00:00', '1999-08-16 00:00:00', 2, 'г. Уфа,  ул. Пролетарская, уч 155, д. 41, кв. 23', 15, 3, 2);
INSERT INTO public.estate_object VALUES (25, 8313.0000, 332520300.00, '1996-07-07 00:00:00', '1999-03-06 00:00:00', 132, 'г. Нижний Новгород,  ул. Молодежная, уч 45, д. 44, кв. 25', 38, 3, 3);
INSERT INTO public.estate_object VALUES (27, 7541.0000, 301640300.00, '1993-01-24 00:00:00', '1994-04-02 00:00:00', 89, 'г. Уфа,  ул. Дорожная, уч 28, д. 46, кв. 27', 34, 3, 2);
INSERT INTO public.estate_object VALUES (28, 2642.0000, 105680300.00, '1996-12-20 00:00:00', '1998-06-26 00:00:00', 134, 'г. Красноярск,  ул. Молодежная, уч 60, д. 47, кв. 28', 11, 3, 1);
INSERT INTO public.estate_object VALUES (30, 1561.0000, 62440300.00, '2021-08-06 00:00:00', '2023-07-27 00:00:00', 110, 'г. Тюмень,  ул. Матросова, уч 64, д. 49, кв. 30', 47, 3, 2);
INSERT INTO public.estate_object VALUES (31, 4405.0000, 176200300.00, '2006-01-21 00:00:00', '2008-01-07 00:00:00', 99, 'г. Красноярск,  ул. Лермонтова, уч 8, д. 50, кв. 31', 41, 3, 2);


--
-- TOC entry 4961 (class 0 OID 17601)
-- Dependencies: 217
-- Data for Name: estate_photo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.estate_photo VALUES (1, 'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_65a94dff5fa2ee4ed86a10ab_65a94e0a95fa5f044c31c010/scale_1200', 3, 1);
INSERT INTO public.estate_photo VALUES (2, 'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_65a8f6154aebb8193f135bbc_65a8fd4d335af54b4b39ae87/scale_1200', 13, 6);
INSERT INTO public.estate_photo VALUES (3, 'https://forum.ivd.ru/uploads/monthly_2018_05/plan.jpeg.eefd27876f9d9cd190e9b68ce91a3cb1.jpeg', 14, 9);
INSERT INTO public.estate_photo VALUES (4, 'https://obstanovka.club/uploads/posts/2023-03/1678198235_obstanovka-club-p-planirovka-dvukhkomnatnikh-kvartir-dizain-68.png', 19, 12);
INSERT INTO public.estate_photo VALUES (5, 'https://otoplenie-vdome.ru/wp-content/uploads/1/2/2/12264ef9f2f811bc84b3f20f33dc48e4.jpeg', 20, 14);
INSERT INTO public.estate_photo VALUES (6, 'https://fonovik.com/uploads/posts/2023-02/1677560468_fonovik-com-p-neobichnie-planirovki-kvartir-31.jpg', 23, 16);
INSERT INTO public.estate_photo VALUES (7, 'https://www.archrevue.ru/images/tb/2/7/0/27087/15029715277327_w1500h1500.jpg', 25, 20);
INSERT INTO public.estate_photo VALUES (8, 'http://solncevopark.ru/forum/upload/foto/c/c/0/f_ff165c260acf6ae035ce79b6d90cc.jpg', 27, 24);
INSERT INTO public.estate_photo VALUES (9, 'https://addawards.ru/upload/iblock/aa3/plan.jpg', 28, 25);
INSERT INTO public.estate_photo VALUES (10, 'https://www.mebel-go.ru/mebelgoer/2772000074.jpg', 30, 27);
INSERT INTO public.estate_photo VALUES (11, 'http://molniam.ru/upload_files/image/yal10/plan/13.jpg', 31, 30);
INSERT INTO public.estate_photo VALUES (12, 'https://zelgorod.ru/uploads/all/40/70/73/4070732e1aed19b1d90df1d01c8cbf4d.jpg', 33, 32);
INSERT INTO public.estate_photo VALUES (13, 'https://static.diary.ru/userdir/3/2/2/8/3228530/80791828.jpg', 36, 33);
INSERT INTO public.estate_photo VALUES (14, 'https://i.pinimg.com/736x/30/85/48/308548de6d268fb89dc3be7c67a77f88.jpg', 37, 34);
INSERT INTO public.estate_photo VALUES (15, 'https://sk-amigo.ru/800/600/http/xn--h1agnge8d.xn--p1ai/filestore/uploaded/plan_1et_d3_678_normal.png', 38, 48);
INSERT INTO public.estate_photo VALUES (16, 'https://design-homes.ru/images/galery/1947/dizajn-kukhni-gostinoj-20-kv-m_5dbaeb27acdef.jpg', 42, 50);
INSERT INTO public.estate_photo VALUES (17, 'https://timeszp.com/wp-content/uploads/2022/12/1_dizajn-kvartiry-studii-ploshchadyu-30-kv-m-10.jpg', 43, 1);
INSERT INTO public.estate_photo VALUES (18, 'https://ecpu.ru/new-buildings/kazan/972/plans/doma-po-ul-pavlyuhina-kazan-plan-9.jpg', 45, 6);


--
-- TOC entry 4963 (class 0 OID 17607)
-- Dependencies: 219
-- Data for Name: estate_relation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.estate_relation VALUES (2, 2, 11);
INSERT INTO public.estate_relation VALUES (3, 5, 15);
INSERT INTO public.estate_relation VALUES (4, 6, 21);
INSERT INTO public.estate_relation VALUES (5, 7, 22);
INSERT INTO public.estate_relation VALUES (6, 8, 41);
INSERT INTO public.estate_relation VALUES (7, 9, 44);
INSERT INTO public.estate_relation VALUES (8, 10, 46);
INSERT INTO public.estate_relation VALUES (9, 12, 47);
INSERT INTO public.estate_relation VALUES (10, 16, 49);
INSERT INTO public.estate_relation VALUES (11, 1, 50);
INSERT INTO public.estate_relation VALUES (1, 1, 4);


--
-- TOC entry 4965 (class 0 OID 17611)
-- Dependencies: 221
-- Data for Name: flat_relation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.flat_relation VALUES (2, 11, 13);
INSERT INTO public.flat_relation VALUES (3, 15, 14);
INSERT INTO public.flat_relation VALUES (4, 21, 19);
INSERT INTO public.flat_relation VALUES (5, 22, 20);
INSERT INTO public.flat_relation VALUES (6, 41, 23);
INSERT INTO public.flat_relation VALUES (7, 44, 25);
INSERT INTO public.flat_relation VALUES (8, 46, 27);
INSERT INTO public.flat_relation VALUES (9, 47, 28);
INSERT INTO public.flat_relation VALUES (10, 49, 30);
INSERT INTO public.flat_relation VALUES (11, 50, 31);
INSERT INTO public.flat_relation VALUES (12, 4, 33);
INSERT INTO public.flat_relation VALUES (13, 11, 36);
INSERT INTO public.flat_relation VALUES (14, 15, 37);
INSERT INTO public.flat_relation VALUES (15, 21, 38);
INSERT INTO public.flat_relation VALUES (16, 4, 42);
INSERT INTO public.flat_relation VALUES (17, 11, 43);
INSERT INTO public.flat_relation VALUES (18, 15, 45);
INSERT INTO public.flat_relation VALUES (1, 4, 3);


--
-- TOC entry 4967 (class 0 OID 17615)
-- Dependencies: 223
-- Data for Name: format; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.format VALUES (1, 'Частная');
INSERT INTO public.format VALUES (2, 'Государственная');
INSERT INTO public.format VALUES (3, 'Муниципальная');


--
-- TOC entry 4969 (class 0 OID 17619)
-- Dependencies: 225
-- Data for Name: gender; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.gender VALUES (1, 'Мужчина');
INSERT INTO public.gender VALUES (2, 'Женщина');


--
-- TOC entry 4971 (class 0 OID 17623)
-- Dependencies: 227
-- Data for Name: layout_estate; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4973 (class 0 OID 17629)
-- Dependencies: 229
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.post VALUES (1, 'Менеджер');
INSERT INTO public.post VALUES (2, 'Кадастровый инженер');
INSERT INTO public.post VALUES (3, 'Архитектор');


--
-- TOC entry 4975 (class 0 OID 17633)
-- Dependencies: 231
-- Data for Name: post_index; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.post_index VALUES (1, '130558');
INSERT INTO public.post_index VALUES (2, '931953');
INSERT INTO public.post_index VALUES (3, '971003');
INSERT INTO public.post_index VALUES (4, '996253');
INSERT INTO public.post_index VALUES (5, '986345');
INSERT INTO public.post_index VALUES (6, '496041');
INSERT INTO public.post_index VALUES (7, '270586');
INSERT INTO public.post_index VALUES (8, '816238');
INSERT INTO public.post_index VALUES (9, '669871');
INSERT INTO public.post_index VALUES (10, '409499');
INSERT INTO public.post_index VALUES (11, '300183');
INSERT INTO public.post_index VALUES (12, '839456');
INSERT INTO public.post_index VALUES (13, '918396');
INSERT INTO public.post_index VALUES (14, '985785');
INSERT INTO public.post_index VALUES (15, '131916');
INSERT INTO public.post_index VALUES (16, '552075');
INSERT INTO public.post_index VALUES (17, '615283');
INSERT INTO public.post_index VALUES (18, '299405');
INSERT INTO public.post_index VALUES (19, '596754');
INSERT INTO public.post_index VALUES (20, '755424');
INSERT INTO public.post_index VALUES (21, '727123');
INSERT INTO public.post_index VALUES (22, '118487');
INSERT INTO public.post_index VALUES (23, '214375');
INSERT INTO public.post_index VALUES (24, '366661');
INSERT INTO public.post_index VALUES (25, '258071');
INSERT INTO public.post_index VALUES (26, '874345');
INSERT INTO public.post_index VALUES (27, '598861');
INSERT INTO public.post_index VALUES (28, '954504');
INSERT INTO public.post_index VALUES (29, '843672');
INSERT INTO public.post_index VALUES (30, '883053');
INSERT INTO public.post_index VALUES (31, '701507');
INSERT INTO public.post_index VALUES (32, '897087');
INSERT INTO public.post_index VALUES (33, '458943');
INSERT INTO public.post_index VALUES (34, '609283');
INSERT INTO public.post_index VALUES (35, '835241');
INSERT INTO public.post_index VALUES (36, '965265');
INSERT INTO public.post_index VALUES (37, '202945');
INSERT INTO public.post_index VALUES (38, '642910');
INSERT INTO public.post_index VALUES (39, '315619');
INSERT INTO public.post_index VALUES (40, '670509');
INSERT INTO public.post_index VALUES (41, '750899');
INSERT INTO public.post_index VALUES (42, '834178');
INSERT INTO public.post_index VALUES (43, '862699');
INSERT INTO public.post_index VALUES (44, '212105');
INSERT INTO public.post_index VALUES (45, '942453');
INSERT INTO public.post_index VALUES (46, '308833');
INSERT INTO public.post_index VALUES (47, '441457');
INSERT INTO public.post_index VALUES (48, '618410');
INSERT INTO public.post_index VALUES (49, '440394');
INSERT INTO public.post_index VALUES (50, '494023');


--
-- TOC entry 4977 (class 0 OID 17637)
-- Dependencies: 233
-- Data for Name: type_of_activity; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.type_of_activity VALUES (1, 'Участок');
INSERT INTO public.type_of_activity VALUES (2, 'Дом');
INSERT INTO public.type_of_activity VALUES (3, 'Квартира');


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 241
-- Name: check_id_check_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.check_id_check_seq', 50, true);


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 243
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_client_seq', 50, true);


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 216
-- Name: employee_id_employee_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.employee_id_employee_seq', 50, true);


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 236
-- Name: estate_object_id_estate_object_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estate_object_id_estate_object_seq', 50, true);


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 218
-- Name: estate_photo_id_estate_photo_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estate_photo_id_estate_photo_seq', 18, true);


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 220
-- Name: estate_relation_id_estate_relation_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estate_relation_id_estate_relation_seq', 11, true);


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 222
-- Name: flat_relation_id_flat_relation_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.flat_relation_id_flat_relation_seq', 18, true);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 224
-- Name: format_id_format_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.format_id_format_seq', 3, true);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 226
-- Name: gender_id_gender_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gender_id_gender_seq', 2, true);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 228
-- Name: layout_estate_id_layout_estate_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.layout_estate_id_layout_estate_seq', 1, false);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 230
-- Name: post_id_post_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_id_post_seq', 3, true);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 232
-- Name: post_index_id_post_index_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_index_id_post_index_seq', 50, true);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 234
-- Name: type_of_activity_id_type_of_activity_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.type_of_activity_id_type_of_activity_seq', 3, true);


--
-- TOC entry 4792 (class 2606 OID 17864)
-- Name: check check_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."check"
    ADD CONSTRAINT check_pk PRIMARY KEY (id_check);


--
-- TOC entry 4794 (class 2606 OID 17915)
-- Name: client client_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pk PRIMARY KEY (id_client);


--
-- TOC entry 4770 (class 2606 OID 17646)
-- Name: employee employee_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pk PRIMARY KEY (id_employee);


--
-- TOC entry 4790 (class 2606 OID 17764)
-- Name: estate_object estate_object_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_object
    ADD CONSTRAINT estate_object_pk PRIMARY KEY (id_estate_object);


--
-- TOC entry 4772 (class 2606 OID 17650)
-- Name: estate_photo estate_photo_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_photo
    ADD CONSTRAINT estate_photo_pk PRIMARY KEY (id_estate_photo);


--
-- TOC entry 4774 (class 2606 OID 17652)
-- Name: estate_relation estate_relation_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_relation
    ADD CONSTRAINT estate_relation_pk PRIMARY KEY (id_estate_relation);


--
-- TOC entry 4776 (class 2606 OID 17654)
-- Name: flat_relation flat_relation_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flat_relation
    ADD CONSTRAINT flat_relation_pk PRIMARY KEY (id_flat_relation);


--
-- TOC entry 4778 (class 2606 OID 17656)
-- Name: format format_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.format
    ADD CONSTRAINT format_pk PRIMARY KEY (id_format);


--
-- TOC entry 4780 (class 2606 OID 17658)
-- Name: gender gender_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gender
    ADD CONSTRAINT gender_pk PRIMARY KEY (id_gender);


--
-- TOC entry 4782 (class 2606 OID 17660)
-- Name: layout_estate layout_estate_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.layout_estate
    ADD CONSTRAINT layout_estate_pk PRIMARY KEY (id_layout_estate);


--
-- TOC entry 4786 (class 2606 OID 17662)
-- Name: post_index post_index_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_index
    ADD CONSTRAINT post_index_pk PRIMARY KEY (id_post_index);


--
-- TOC entry 4784 (class 2606 OID 17664)
-- Name: post post_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pk PRIMARY KEY (id_post);


--
-- TOC entry 4788 (class 2606 OID 17666)
-- Name: type_of_activity type_of_activity_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type_of_activity
    ADD CONSTRAINT type_of_activity_pk PRIMARY KEY (id_type_of_activity);


--
-- TOC entry 4811 (class 2620 OID 17906)
-- Name: flat_relation tr_difference_flat_block; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_difference_flat_block AFTER INSERT OR UPDATE ON public.flat_relation FOR EACH ROW EXECUTE FUNCTION public.tr_difference_flat_block();


--
-- TOC entry 4810 (class 2620 OID 17900)
-- Name: estate_relation tr_difference_place_block; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_difference_place_block AFTER INSERT OR UPDATE ON public.estate_relation FOR EACH ROW EXECUTE FUNCTION public.tr_difference_place_block();


--
-- TOC entry 4812 (class 2620 OID 17932)
-- Name: client tr_is_legal_entity; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tr_is_legal_entity AFTER INSERT OR UPDATE ON public.client FOR EACH ROW EXECUTE FUNCTION public.tr_is_legal_entity();


--
-- TOC entry 4806 (class 2606 OID 17926)
-- Name: check check_client_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."check"
    ADD CONSTRAINT check_client_fk FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 4807 (class 2606 OID 17865)
-- Name: check check_employee_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."check"
    ADD CONSTRAINT check_employee_fk FOREIGN KEY (id_employee) REFERENCES public.employee(id_employee);


--
-- TOC entry 4808 (class 2606 OID 17875)
-- Name: check check_estate_object_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."check"
    ADD CONSTRAINT check_estate_object_fk FOREIGN KEY (is_estate_object) REFERENCES public.estate_object(id_estate_object);


--
-- TOC entry 4809 (class 2606 OID 17916)
-- Name: client client_gender_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_gender_fk FOREIGN KEY (id_gender) REFERENCES public.gender(id_gender);


--
-- TOC entry 4795 (class 2606 OID 17687)
-- Name: employee employee_gender_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_gender_fk FOREIGN KEY (id_gender) REFERENCES public.gender(id_gender);


--
-- TOC entry 4796 (class 2606 OID 17692)
-- Name: employee employee_post_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_post_fk FOREIGN KEY (id_post) REFERENCES public.post(id_post);


--
-- TOC entry 4803 (class 2606 OID 17785)
-- Name: estate_object estate_object_format_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_object
    ADD CONSTRAINT estate_object_format_fk FOREIGN KEY (id_format) REFERENCES public.format(id_format);


--
-- TOC entry 4804 (class 2606 OID 17790)
-- Name: estate_object estate_object_post_index_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_object
    ADD CONSTRAINT estate_object_post_index_fk FOREIGN KEY (id_postindex) REFERENCES public.post_index(id_post_index);


--
-- TOC entry 4805 (class 2606 OID 17795)
-- Name: estate_object estate_object_type_of_activity_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_object
    ADD CONSTRAINT estate_object_type_of_activity_fk FOREIGN KEY (id_type_of_activity) REFERENCES public.type_of_activity(id_type_of_activity);


--
-- TOC entry 4797 (class 2606 OID 17800)
-- Name: estate_photo estate_photo_estate_object_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_photo
    ADD CONSTRAINT estate_photo_estate_object_fk FOREIGN KEY (id_estate_object) REFERENCES public.estate_object(id_estate_object);


--
-- TOC entry 4798 (class 2606 OID 17805)
-- Name: estate_relation estate_relation_estate_object_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_relation
    ADD CONSTRAINT estate_relation_estate_object_fk FOREIGN KEY (id_place_estate) REFERENCES public.estate_object(id_estate_object);


--
-- TOC entry 4799 (class 2606 OID 17810)
-- Name: estate_relation estate_relation_estate_object_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estate_relation
    ADD CONSTRAINT estate_relation_estate_object_fk_1 FOREIGN KEY (id_building_estate) REFERENCES public.estate_object(id_estate_object);


--
-- TOC entry 4800 (class 2606 OID 17815)
-- Name: flat_relation flat_relation_estate_object_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flat_relation
    ADD CONSTRAINT flat_relation_estate_object_fk FOREIGN KEY (id_build_estate) REFERENCES public.estate_object(id_estate_object);


--
-- TOC entry 4801 (class 2606 OID 17820)
-- Name: flat_relation flat_relation_estate_object_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flat_relation
    ADD CONSTRAINT flat_relation_estate_object_fk_1 FOREIGN KEY (id_flat_estate) REFERENCES public.estate_object(id_estate_object);


--
-- TOC entry 4802 (class 2606 OID 17747)
-- Name: layout_estate layout_estate_employee_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.layout_estate
    ADD CONSTRAINT layout_estate_employee_fk FOREIGN KEY (id_employee) REFERENCES public.employee(id_employee);


-- Completed on 2024-02-19 23:49:52

--
-- PostgreSQL database dump complete
--

