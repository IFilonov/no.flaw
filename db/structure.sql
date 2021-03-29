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
-- Name: gender; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.gender AS ENUM (
    'female',
    'male',
    'both'
);


--
-- Name: level; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.level AS ENUM (
    'low',
    'middle',
    'high',
    'none'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: females; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.females (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying,
    username character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    nickname character varying
);


--
-- Name: females_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.females_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: females_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.females_id_seq OWNED BY public.females.id;


--
-- Name: lifetimes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lifetimes (
    id bigint NOT NULL,
    taboo_date character varying,
    fire_date character varying,
    dateable_type character varying NOT NULL,
    dateable_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: lifetimes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lifetimes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lifetimes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lifetimes_id_seq OWNED BY public.lifetimes.id;


--
-- Name: males; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.males (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying,
    username character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    female_id bigint,
    nickname character varying
);


--
-- Name: males_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.males_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: males_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.males_id_seq OWNED BY public.males.id;


--
-- Name: pairs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pairs (
    id bigint NOT NULL,
    male_id bigint NOT NULL,
    female_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    divorced_at timestamp without time zone,
    level public.level
);


--
-- Name: pairs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pairs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pairs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pairs_id_seq OWNED BY public.pairs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: staffs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staffs (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: staffs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.staffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staffs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.staffs_id_seq OWNED BY public.staffs.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    gender public.gender,
    level public.level,
    category_id bigint NOT NULL
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: females id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.females ALTER COLUMN id SET DEFAULT nextval('public.females_id_seq'::regclass);


--
-- Name: lifetimes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lifetimes ALTER COLUMN id SET DEFAULT nextval('public.lifetimes_id_seq'::regclass);


--
-- Name: males id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.males ALTER COLUMN id SET DEFAULT nextval('public.males_id_seq'::regclass);


--
-- Name: pairs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pairs ALTER COLUMN id SET DEFAULT nextval('public.pairs_id_seq'::regclass);


--
-- Name: staffs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staffs ALTER COLUMN id SET DEFAULT nextval('public.staffs_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: females females_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.females
    ADD CONSTRAINT females_pkey PRIMARY KEY (id);


--
-- Name: lifetimes lifetimes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lifetimes
    ADD CONSTRAINT lifetimes_pkey PRIMARY KEY (id);


--
-- Name: males males_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.males
    ADD CONSTRAINT males_pkey PRIMARY KEY (id);


--
-- Name: pairs pairs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pairs
    ADD CONSTRAINT pairs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: staffs staffs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staffs
    ADD CONSTRAINT staffs_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: index_females_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_females_on_reset_password_token ON public.females USING btree (reset_password_token);


--
-- Name: index_females_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_females_on_username ON public.females USING btree (username);


--
-- Name: index_lifetimes_on_dateable_type_and_dateable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lifetimes_on_dateable_type_and_dateable_id ON public.lifetimes USING btree (dateable_type, dateable_id);


--
-- Name: index_males_on_female_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_males_on_female_id ON public.males USING btree (female_id);


--
-- Name: index_males_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_males_on_reset_password_token ON public.males USING btree (reset_password_token);


--
-- Name: index_males_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_males_on_username ON public.males USING btree (username);


--
-- Name: index_pairs_on_female_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pairs_on_female_id ON public.pairs USING btree (female_id);


--
-- Name: index_pairs_on_male_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pairs_on_male_id ON public.pairs USING btree (male_id);


--
-- Name: index_staffs_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_staffs_on_email ON public.staffs USING btree (email);


--
-- Name: index_staffs_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_staffs_on_reset_password_token ON public.staffs USING btree (reset_password_token);


--
-- Name: index_tasks_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_category_id ON public.tasks USING btree (category_id);


--
-- Name: index_tasks_on_gender; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_gender ON public.tasks USING btree (gender);


--
-- Name: index_tasks_on_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_level ON public.tasks USING btree (level);


--
-- Name: pairs fk_rails_418edd08a3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pairs
    ADD CONSTRAINT fk_rails_418edd08a3 FOREIGN KEY (male_id) REFERENCES public.males(id);


--
-- Name: pairs fk_rails_4f44d39aaf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pairs
    ADD CONSTRAINT fk_rails_4f44d39aaf FOREIGN KEY (female_id) REFERENCES public.females(id);


--
-- Name: tasks fk_rails_acbc5a096e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_acbc5a096e FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: males fk_rails_b1a34f6a13; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.males
    ADD CONSTRAINT fk_rails_b1a34f6a13 FOREIGN KEY (female_id) REFERENCES public.females(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20201128172709'),
('20201128172732'),
('20201128172906'),
('20210106200920'),
('20210116185813'),
('20210218072608'),
('20210226194640'),
('20210313201700'),
('20210318180914'),
('20210318181153'),
('20210329183529');


