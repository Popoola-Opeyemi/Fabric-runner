--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.9
-- Dumped by pg_dump version 9.5.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_recovery; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE account_recovery (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token character varying(64),
    expires timestamp without time zone DEFAULT (now() + '01:00:00'::interval) NOT NULL,
    selector character varying(16)
);


ALTER TABLE account_recovery OWNER TO orbdba;

--
-- Name: account_recovery_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE account_recovery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_recovery_id_seq OWNER TO orbdba;

--
-- Name: account_recovery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE account_recovery_id_seq OWNED BY account_recovery.id;


--
-- Name: analytic; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE analytic (
    id bigint NOT NULL,
    browser character varying(250),
    referer character varying(250),
    page_url character varying(250),
    query character varying(200),
    tstamp timestamp without time zone DEFAULT now(),
    name character varying(200),
    session_id character varying(200)
);


ALTER TABLE analytic OWNER TO orbdba;

--
-- Name: analytic_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE analytic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE analytic_id_seq OWNER TO orbdba;

--
-- Name: analytic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE analytic_id_seq OWNED BY analytic.id;


--
-- Name: blog_category; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE blog_category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE blog_category OWNER TO orbdba;

--
-- Name: blog_category_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE blog_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE blog_category_id_seq OWNER TO orbdba;

--
-- Name: blog_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE blog_category_id_seq OWNED BY blog_category.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE category OWNER TO orbdba;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_id_seq OWNER TO orbdba;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE category_id_seq OWNED BY category.id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE comment (
    id bigint NOT NULL,
    user_id bigint,
    post_id bigint,
    content text DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE comment OWNER TO orbdba;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_id_seq OWNER TO orbdba;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE comment_id_seq OWNED BY comment.id;


--
-- Name: comment_users; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE comment_users (
    id bigint NOT NULL,
    name character varying(250),
    email character varying(250),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE comment_users OWNER TO orbdba;

--
-- Name: comment_users_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE comment_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_users_id_seq OWNER TO orbdba;

--
-- Name: comment_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE comment_users_id_seq OWNED BY comment_users.id;


--
-- Name: country; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE country (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE country OWNER TO orbdba;

--
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE country_id_seq OWNER TO orbdba;

--
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE country_id_seq OWNED BY country.id;


--
-- Name: file; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE file (
    id bigint NOT NULL,
    url character varying(255) NOT NULL,
    name character varying(255),
    size character varying(20),
    type character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE file OWNER TO orbdba;

--
-- Name: file_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE file_id_seq OWNER TO orbdba;

--
-- Name: file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE file_id_seq OWNED BY file.id;


--
-- Name: file_widget; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE file_widget (
    id bigint NOT NULL,
    file_id bigint NOT NULL,
    widget_id bigint NOT NULL
);


ALTER TABLE file_widget OWNER TO orbdba;

--
-- Name: file_widget_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE file_widget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE file_widget_id_seq OWNER TO orbdba;

--
-- Name: file_widget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE file_widget_id_seq OWNED BY file_widget.id;


--
-- Name: goose_db_version; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE goose_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now()
);


ALTER TABLE goose_db_version OWNER TO orbdba;

--
-- Name: goose_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE goose_db_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE goose_db_version_id_seq OWNER TO orbdba;

--
-- Name: goose_db_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE goose_db_version_id_seq OWNED BY goose_db_version.id;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE menu (
    id bigint NOT NULL,
    label character varying(50) NOT NULL,
    name character varying(50) NOT NULL,
    page_id bigint DEFAULT 0 NOT NULL,
    url character varying(255),
    pos integer DEFAULT 0 NOT NULL,
    is_visible smallint DEFAULT 1 NOT NULL
);


ALTER TABLE menu OWNER TO orbdba;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE menu_id_seq OWNER TO orbdba;

--
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE menu_id_seq OWNED BY menu.id;


--
-- Name: message; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE message (
    id bigint NOT NULL,
    type character varying(200),
    content text DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE message OWNER TO orbdba;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE message_id_seq OWNER TO orbdba;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE message_id_seq OWNED BY message.id;


--
-- Name: page; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE page (
    id bigint NOT NULL,
    title character varying(200),
    url character varying(200) DEFAULT 0 NOT NULL,
    content text DEFAULT 0 NOT NULL,
    published_at timestamp without time zone,
    is_published boolean DEFAULT false,
    seo_description character varying(250),
    seo_keywords character varying(250),
    is_index integer DEFAULT 0,
    type character varying(50),
    template bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE page OWNER TO orbdba;

--
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE page_id_seq OWNER TO orbdba;

--
-- Name: page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE page_id_seq OWNED BY page.id;


--
-- Name: page_widget; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE page_widget (
    id bigint NOT NULL,
    page_id bigint NOT NULL,
    widget_id bigint NOT NULL
);


ALTER TABLE page_widget OWNER TO orbdba;

--
-- Name: page_widget_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE page_widget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE page_widget_id_seq OWNER TO orbdba;

--
-- Name: page_widget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE page_widget_id_seq OWNED BY page_widget.id;


--
-- Name: post; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE post (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    content text DEFAULT 0 NOT NULL,
    category_id bigint,
    author_id bigint,
    published_date timestamp without time zone,
    seo_keywords character varying(255),
    seo_description text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    is_published boolean DEFAULT false
);


ALTER TABLE post OWNER TO orbdba;

--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_id_seq OWNER TO orbdba;

--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE post_id_seq OWNED BY post.id;


--
-- Name: post_tag; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE post_tag (
    post_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE post_tag OWNER TO orbdba;

--
-- Name: product; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE product (
    id bigint NOT NULL,
    name character varying(255),
    model character varying(255) NOT NULL,
    product_category_id bigint,
    file_id bigint,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    content text DEFAULT 0 NOT NULL
);


ALTER TABLE product OWNER TO orbdba;

--
-- Name: product_category; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE product_category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE product_category OWNER TO orbdba;

--
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE product_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_category_id_seq OWNER TO orbdba;

--
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE product_category_id_seq OWNED BY product_category.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_id_seq OWNER TO orbdba;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE product_id_seq OWNED BY product.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE role (
    id bigint,
    name character varying(200)
);


ALTER TABLE role OWNER TO orbdba;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE settings (
    id bigint NOT NULL,
    name character varying(200),
    title character varying(200),
    setting text
);


ALTER TABLE settings OWNER TO orbdba;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE settings_id_seq OWNER TO orbdba;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE settings_id_seq OWNED BY settings.id;


--
-- Name: subscriber; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE subscriber (
    id bigint NOT NULL,
    first_name character varying(250),
    last_name character varying(250),
    address character varying(255),
    email character varying(250) NOT NULL,
    password character varying(250),
    token character varying(64),
    email_verified boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT false NOT NULL
);


ALTER TABLE subscriber OWNER TO orbdba;

--
-- Name: subscriber_account; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE subscriber_account (
    id bigint NOT NULL,
    subscriber_id bigint,
    account_type character varying(255),
    bank_name character varying(100),
    account_name character varying(255),
    account_number character varying(255),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE subscriber_account OWNER TO orbdba;

--
-- Name: subscriber_account_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE subscriber_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subscriber_account_id_seq OWNER TO orbdba;

--
-- Name: subscriber_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE subscriber_account_id_seq OWNED BY subscriber_account.id;


--
-- Name: subscriber_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE subscriber_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subscriber_id_seq OWNER TO orbdba;

--
-- Name: subscriber_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE subscriber_id_seq OWNED BY subscriber.id;


--
-- Name: subscriber_transaction; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE subscriber_transaction (
    id bigint NOT NULL,
    subscriber_id bigint,
    transaction_type smallint,
    currency character varying(100),
    status smallint,
    account_number character varying(200),
    account_name character varying(200),
    bank_name character varying(200),
    reference character varying(200),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE subscriber_transaction OWNER TO orbdba;

--
-- Name: subscriber_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE subscriber_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE subscriber_transaction_id_seq OWNER TO orbdba;

--
-- Name: subscriber_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE subscriber_transaction_id_seq OWNED BY subscriber_transaction.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE tag (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE tag OWNER TO orbdba;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tag_id_seq OWNER TO orbdba;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE tag_id_seq OWNED BY tag.id;


--
-- Name: temp_users; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE temp_users (
    id bigint NOT NULL,
    name character varying(250),
    email character varying(250),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE temp_users OWNER TO orbdba;

--
-- Name: temp_users_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE temp_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE temp_users_id_seq OWNER TO orbdba;

--
-- Name: temp_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE temp_users_id_seq OWNED BY temp_users.id;


--
-- Name: template; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE template (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    file_name character varying(250) NOT NULL,
    is_index smallint DEFAULT 0
);


ALTER TABLE template OWNER TO orbdba;

--
-- Name: template_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE template_id_seq OWNER TO orbdba;

--
-- Name: template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE template_id_seq OWNED BY template.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE users (
    id bigint NOT NULL,
    firstname character varying(250),
    lastname character varying(250),
    email character varying(250) NOT NULL,
    username character varying(200) NOT NULL,
    password character varying(250),
    image_id character varying(255),
    is_active boolean DEFAULT true,
    role_id bigint,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE users OWNER TO orbdba;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO orbdba;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: widget; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE widget (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    heading character varying(255),
    content text,
    attribute1 character varying(200),
    attribute2 character varying(200),
    attribute3 character varying(200),
    attribute4 character varying(200),
    type_id integer DEFAULT 0,
    widget_parent integer DEFAULT 0,
    is_global integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE widget OWNER TO orbdba;

--
-- Name: widget_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE widget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE widget_id_seq OWNER TO orbdba;

--
-- Name: widget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE widget_id_seq OWNED BY widget.id;


--
-- Name: widget_type; Type: TABLE; Schema: public; Owner: orbdba
--

CREATE TABLE widget_type (
    id integer NOT NULL,
    type integer NOT NULL,
    name character varying(200)
);


ALTER TABLE widget_type OWNER TO orbdba;

--
-- Name: widget_type_id_seq; Type: SEQUENCE; Schema: public; Owner: orbdba
--

CREATE SEQUENCE widget_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE widget_type_id_seq OWNER TO orbdba;

--
-- Name: widget_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orbdba
--

ALTER SEQUENCE widget_type_id_seq OWNED BY widget_type.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY account_recovery ALTER COLUMN id SET DEFAULT nextval('account_recovery_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY analytic ALTER COLUMN id SET DEFAULT nextval('analytic_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY blog_category ALTER COLUMN id SET DEFAULT nextval('blog_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY category ALTER COLUMN id SET DEFAULT nextval('category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY comment ALTER COLUMN id SET DEFAULT nextval('comment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY comment_users ALTER COLUMN id SET DEFAULT nextval('comment_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY country ALTER COLUMN id SET DEFAULT nextval('country_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY file ALTER COLUMN id SET DEFAULT nextval('file_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY file_widget ALTER COLUMN id SET DEFAULT nextval('file_widget_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY goose_db_version ALTER COLUMN id SET DEFAULT nextval('goose_db_version_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY menu ALTER COLUMN id SET DEFAULT nextval('menu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY message ALTER COLUMN id SET DEFAULT nextval('message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY page ALTER COLUMN id SET DEFAULT nextval('page_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY page_widget ALTER COLUMN id SET DEFAULT nextval('page_widget_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY post ALTER COLUMN id SET DEFAULT nextval('post_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY product ALTER COLUMN id SET DEFAULT nextval('product_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY product_category ALTER COLUMN id SET DEFAULT nextval('product_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY settings ALTER COLUMN id SET DEFAULT nextval('settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber ALTER COLUMN id SET DEFAULT nextval('subscriber_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber_account ALTER COLUMN id SET DEFAULT nextval('subscriber_account_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber_transaction ALTER COLUMN id SET DEFAULT nextval('subscriber_transaction_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY tag ALTER COLUMN id SET DEFAULT nextval('tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY temp_users ALTER COLUMN id SET DEFAULT nextval('temp_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY template ALTER COLUMN id SET DEFAULT nextval('template_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY widget ALTER COLUMN id SET DEFAULT nextval('widget_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY widget_type ALTER COLUMN id SET DEFAULT nextval('widget_type_id_seq'::regclass);


--
-- Data for Name: account_recovery; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY account_recovery (id, user_id, token, expires, selector) FROM stdin;
\.


--
-- Name: account_recovery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('account_recovery_id_seq', 1, false);


--
-- Data for Name: analytic; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY analytic (id, browser, referer, page_url, query, tstamp, name, session_id) FROM stdin;
1	Chrome	\N	/		2017-08-11 09:45:59.868077	home	\N
2	Chrome	\N	/		2017-08-11 10:13:21.586696	home	\N
3	Chrome	\N	/		2017-08-11 10:47:18.228131	home	\N
4	Chrome	\N	/		2017-08-11 10:48:05.490082	home	\N
5	Chrome	\N	/		2017-08-11 11:03:48.116179	home	\N
6	Chrome	\N	/		2017-08-11 11:10:57.089296	home	\N
7	Chrome	\N	/		2017-08-11 11:12:50.277682	home	\N
8	Chrome	\N	/		2017-08-11 11:14:08.938094	home	\N
9	Chrome	\N	/		2017-08-11 11:14:11.802122	home	\N
10	Chrome	\N	/		2017-08-11 11:15:50.055356	home	\N
11	Chrome	\N	/		2017-08-11 11:16:55.69918	home	\N
12	Chrome	\N	/		2017-08-11 11:17:27.149481	home	\N
13	Chrome	\N	/		2017-08-11 11:18:16.993114	home	\N
14	Chrome	\N	/error		2017-08-11 11:25:45.204724	error	\N
15	Chrome	\N	/		2017-08-11 11:25:50.525873	home	\N
16	Chrome	\N	/		2017-08-11 11:28:04.7006	home	\N
17	Chrome	\N	/company		2017-08-11 11:28:15.434029	company	\N
18	Chrome	\N	/		2017-08-11 11:28:27.633666	home	\N
19	Chrome	\N	/company		2017-08-11 11:28:37.856184	company	\N
20	Chrome	\N	/		2017-08-11 11:39:25.276221	home	\N
21	Chrome	\N	/company		2017-08-11 11:39:32.822604	company	\N
22	Chrome	\N	/		2017-08-11 11:40:52.161349	home	\N
23	Chrome	\N	/company		2017-08-11 11:41:03.650109	company	\N
24	Chrome	\N	/		2017-08-14 08:18:29.338433	home	\N
25	Chrome	\N	/		2017-08-14 08:38:04.992182	home	\N
26	Chrome	\N	/		2017-08-14 08:38:08.007672	home	\N
27	Chrome	\N	/		2017-08-14 08:41:38.911135	home	\N
28	Chrome	\N	/company		2017-08-14 08:57:51.350982	company	\N
29	Chrome	\N	/company		2017-08-14 08:57:56.324577	company	\N
30	Chrome	\N	/company		2017-08-14 09:00:54.094004	company	\N
31	Chrome	\N	/company		2017-08-14 09:06:59.498506	company	\N
32	Chrome	\N	/company		2017-08-14 09:07:42.894675	company	\N
33	Chrome	\N	/company		2017-08-14 09:20:49.456361	company	\N
34	Chrome	\N	/company		2017-08-14 09:21:00.374528	company	\N
35	Chrome	\N	/company		2017-08-14 09:21:08.511364	company	\N
36	Chrome	\N	/company		2017-08-14 09:23:52.740027	company	\N
37	Chrome	\N	/brands		2017-08-14 09:54:00.258729	brands	\N
38	Chrome	\N	/brands		2017-08-14 11:02:49.414856	brands	\N
39	Chrome	\N	/brands		2017-08-14 11:04:08.092093	brands	\N
40	Chrome	\N	/brands		2017-08-14 11:04:22.300674	brands	\N
41	Chrome	\N	/brands		2017-08-14 11:05:04.588505	brands	\N
42	Chrome	\N	/brands		2017-08-14 11:05:29.138658	brands	\N
43	Chrome	\N	/brands		2017-08-14 11:05:57.474674	brands	\N
44	Chrome	\N	/brands		2017-08-14 11:06:31.84377	brands	\N
45	Chrome	\N	/news		2017-08-14 10:34:37.124183	news	\N
46	Chrome	\N	/news		2017-08-14 10:34:58.82798	news	\N
47	Chrome	\N	/news		2017-08-14 10:36:29.239314	news	\N
48	Chrome	\N	/news		2017-08-14 10:36:47.932492	news	\N
49	Chrome	\N	/news		2017-08-14 10:37:17.062238	news	\N
50	Chrome	\N	/news		2017-08-14 10:49:20.849565	news	\N
51	Chrome	\N	/error		2017-08-14 11:15:55.985917	error	\N
52	Chrome	\N	/news		2017-08-14 11:16:18.143557	news	\N
53	Chrome	\N	/error		2017-08-14 11:16:35.607724	error	\N
54	Chrome	\N	/error		2017-08-14 11:17:17.722171	error	\N
55	Chrome	\N	/contact		2017-08-14 11:17:26.006524	contact	\N
56	Chrome	\N	/		2017-08-14 11:48:22.977645	home	\N
57	Chrome	\N	/company		2017-08-14 11:48:45.755129	company	\N
58	Chrome	\N	/company		2017-08-14 12:15:49.752668	company	\N
59	Chrome	\N	/		2017-08-14 12:20:22.836164	home	\N
60	Chrome	\N	/news		2017-08-14 12:20:30.064125	news	\N
61	Chrome	\N	/news		2017-08-14 12:25:29.564925	news	\N
62	Chrome	\N	/news		2017-08-14 12:26:51.092705	news	\N
63	Chrome	\N	/news		2017-08-14 12:28:21.844901	news	\N
64	Chrome	\N	/news		2017-08-14 12:28:40.305362	news	\N
65	Chrome	\N	/news		2017-08-14 12:28:47.61916	news	\N
66	Chrome	\N	/news		2017-08-14 12:29:04.935969	news	\N
67	Chrome	\N	/news		2017-08-14 12:30:49.93831	news	\N
68	Chrome		/company		2017-08-14 12:30:53.407349	company	\N
69	Chrome		/brands		2017-08-14 12:30:56.240097	brands	\N
70	Chrome		/home		2017-08-14 12:30:58.558763	home	\N
71	Chrome		/home		2017-08-14 12:31:34.078723	home	\N
72	Chrome		/home		2017-08-14 12:32:06.770886	home	\N
73	Chrome		/home		2017-08-14 12:32:22.42162	home	\N
74	Chrome		/home		2017-08-14 12:32:40.577251	home	\N
75	Chrome		/home		2017-08-14 12:36:42.49965	home	\N
76	Chrome		/company		2017-08-14 13:22:17.587405	company	\N
77	Chrome		/brands		2017-08-14 13:22:22.755663	brands	\N
78	Chrome		/company		2017-08-14 14:42:23.708788	company	\N
79	Chrome		/brands		2017-08-14 14:42:25.637443	brands	\N
80	Chrome		/home		2017-08-14 14:42:27.436779	home	\N
81	Chrome		/news		2017-08-14 14:42:29.542026	news	\N
82	Chrome		/contact		2017-08-14 14:42:31.203866	contact	\N
83	Chrome	\N	/		2017-08-16 09:41:37.523431	home	\N
84	Chrome	\N	/		2017-08-16 09:49:47.72139	home	\N
85	Chrome	\N	/		2017-08-16 09:50:18.147013	home	\N
86	Chrome	\N	/		2017-08-16 09:51:03.27657	home	\N
87	Chrome	\N	/		2017-08-16 09:51:32.524484	home	\N
88	Chrome	\N	/		2017-08-16 10:00:06.164615	home	\N
89	Chrome	\N	/		2017-08-16 10:00:14.350607	home	\N
90	Chrome	\N	/		2017-08-16 10:01:36.211116	home	\N
91	Chrome	\N	/		2017-08-16 10:02:25.493498	home	\N
92	Chrome	\N	/		2017-08-16 10:03:07.058672	home	\N
93	Chrome	\N	/		2017-08-16 10:04:51.055497	home	\N
94	Chrome	\N	/		2017-08-16 10:05:07.483632	home	\N
95	Chrome	\N	/		2017-08-16 10:05:10.307346	home	\N
96	Chrome	\N	/		2017-08-16 10:05:56.662711	home	\N
97	Chrome	\N	/		2017-08-16 10:06:42.869667	home	\N
98	Chrome	\N	/		2017-08-16 10:06:55.709559	home	\N
99	Chrome	\N	/		2017-08-16 10:07:17.224401	home	\N
100	Chrome	\N	/		2017-08-16 10:08:39.341047	home	\N
101	Chrome	\N	/		2017-08-16 10:09:05.61126	home	\N
102	Chrome	\N	/		2017-08-16 10:37:08.797242	home	\N
103	Chrome	\N	/		2017-08-16 10:37:56.177755	home	\N
104	Chrome	\N	/		2017-08-16 10:38:40.005903	home	\N
105	Chrome	\N	/		2017-08-16 10:40:06.4913	home	\N
106	Chrome	\N	/		2017-08-16 10:40:53.547865	home	\N
107	Chrome	\N	/		2017-08-16 10:41:47.096676	home	\N
108	Chrome	\N	/		2017-08-16 10:45:53.903034	home	\N
109	Chrome	\N	/		2017-08-16 10:45:57.743094	home	\N
110	Chrome	\N	/		2017-08-16 10:46:52.950056	home	\N
111	Chrome	\N	/		2017-08-16 10:47:10.786475	home	\N
112	Chrome	\N	/		2017-08-16 10:47:44.724413	home	\N
113	Chrome	\N	/		2017-08-16 11:01:06.298254	home	\N
114	Chrome	\N	/		2017-08-16 11:06:58.94304	home	\N
115	Chrome	\N	/		2017-08-16 11:07:10.104794	home	\N
116	Chrome	\N	/		2017-08-16 11:07:18.361452	home	\N
117	Chrome	\N	/		2017-08-16 11:08:42.207833	home	\N
118	Chrome	\N	/		2017-08-16 11:10:25.519769	home	\N
119	Chrome	\N	/		2017-08-16 11:11:33.521713	home	\N
120	Chrome	\N	/		2017-08-16 11:12:04.674589	home	\N
121	Chrome	\N	/		2017-08-16 11:12:30.31039	home	\N
122	Chrome	\N	/		2017-08-16 11:13:39.033058	home	\N
123	Chrome	\N	/		2017-08-16 11:18:29.443211	home	\N
124	Chrome	\N	/		2017-08-16 12:28:46.412311	home	\N
125	Chrome	\N	/		2017-08-16 12:29:23.623195	home	\N
126	Chrome	\N	/		2017-08-16 12:32:09.14265	home	\N
127	Chrome	\N	/		2017-08-16 12:32:27.571427	home	\N
128	Chrome	\N	/		2017-08-16 12:36:46.961167	home	\N
129	Chrome	\N	/		2017-08-16 12:37:45.851406	home	\N
130	Chrome	\N	/		2017-08-16 12:38:30.114696	home	\N
131	Chrome	\N	/		2017-08-16 12:39:00.212545	home	\N
132	Chrome	\N	/		2017-08-16 12:40:28.010653	home	\N
133	Chrome	\N	/		2017-08-16 12:41:02.434772	home	\N
134	Chrome	\N	/		2017-08-16 12:49:56.725855	home	\N
135	Chrome	\N	/		2017-08-16 12:51:18.738496	home	\N
136	Chrome	\N	/		2017-08-16 12:51:52.316323	home	\N
137	Chrome	\N	/		2017-08-16 12:53:37.519496	home	\N
138	Chrome	\N	/		2017-08-16 12:53:52.787145	home	\N
139	Chrome	\N	/		2017-08-16 13:22:44.602986	home	\N
140	Chrome	\N	/		2017-08-16 13:27:20.001665	home	\N
141	Chrome	\N	/		2017-08-16 13:28:13.028957	home	\N
142	Chrome	\N	/		2017-08-16 13:28:38.897005	home	\N
143	Chrome	\N	/		2017-08-16 13:43:38.707627	home	\N
144	Chrome	\N	/		2017-08-16 13:44:14.028435	home	\N
145	Chrome	\N	/		2017-08-16 13:44:17.000843	home	\N
146	Chrome	\N	/		2017-08-16 13:45:09.807228	home	\N
147	Chrome	\N	/		2017-08-16 13:45:49.529248	home	\N
148	Chrome	\N	/		2017-08-16 13:46:45.809251	home	\N
149	Chrome	\N	/		2017-08-16 13:47:06.725824	home	\N
150	Chrome	\N	/		2017-08-16 13:48:58.659723	home	\N
151	Chrome	\N	/		2017-08-16 13:49:25.943734	home	\N
152	Chrome	\N	/		2017-08-16 13:49:48.207412	home	\N
153	Chrome	\N	/		2017-08-16 13:50:50.593702	home	\N
154	Chrome	\N	/		2017-08-16 13:52:02.890073	home	\N
155	Chrome	\N	/error		2017-08-16 13:56:22.268188	error	\N
156	Chrome	\N	/error		2017-08-16 13:56:35.411054	error	\N
157	Chrome	\N	/		2017-08-16 13:56:39.763831	home	\N
158	Chrome	\N	/		2017-08-16 13:57:11.402874	home	\N
159	Chrome	\N	/		2017-08-16 13:57:23.377468	home	\N
160	Chrome	\N	/		2017-08-16 14:54:42.664828	home	\N
161	Chrome	\N	/		2017-08-16 15:00:35.639646	home	\N
162	Chrome	\N	/		2017-08-17 08:26:13.528477	home	\N
163	Chrome	\N	/company		2017-08-17 08:26:52.060958	company	\N
164	Chrome	\N	/company		2017-08-17 08:27:25.601441	company	\N
165	Chrome	\N	/company		2017-08-17 08:54:01.13567	company	\N
166	Chrome	\N	/company		2017-08-17 08:58:53.449284	company	\N
167	Chrome	\N	/company		2017-08-17 08:59:36.248058	company	\N
168	Chrome	\N	/company		2017-08-17 09:11:45.125753	company	\N
169	Chrome	\N	/company		2017-08-17 09:11:55.890871	company	\N
170	Chrome	\N	/company		2017-08-17 09:12:48.293895	company	\N
171	Chrome	\N	/company		2017-08-17 09:15:02.11442	company	\N
172	Chrome	\N	/company		2017-08-17 09:17:29.973974	company	\N
173	Chrome	\N	/company		2017-08-17 09:17:39.725994	company	\N
174	Chrome	\N	/company		2017-08-17 09:20:08.126117	company	\N
175	Chrome	\N	/company		2017-08-17 09:20:47.674959	company	\N
176	Chrome	\N	/company		2017-08-17 09:21:41.197778	company	\N
177	Chrome	\N	/company		2017-08-17 09:22:56.304173	company	\N
178	Chrome	\N	/company		2017-08-17 09:26:12.200706	company	\N
179	Chrome	\N	/company		2017-08-17 09:26:33.481121	company	\N
180	Chrome	\N	/company		2017-08-17 09:27:14.341798	company	\N
181	Chrome	\N	/company		2017-08-17 09:45:55.474751	company	\N
182	Chrome	\N	/company		2017-08-17 09:46:04.647125	company	\N
183	Chrome	\N	/company		2017-08-17 09:52:44.114969	company	\N
184	Chrome	\N	/company		2017-08-17 09:52:58.756839	company	\N
185	Chrome	\N	/company		2017-08-17 09:53:21.671542	company	\N
186	Chrome	\N	/company		2017-08-17 09:53:34.717006	company	\N
187	Chrome	\N	/company		2017-08-17 09:55:57.408868	company	\N
188	Chrome	\N	/company		2017-08-17 09:58:21.98682	company	\N
189	Chrome		/news		2017-08-17 10:14:10.563549	news	\N
190	Chrome		/home		2017-08-17 10:41:39.79114	home	\N
191	Chrome		/home		2017-08-17 10:42:02.879814	home	\N
192	Chrome		/contact		2017-08-17 10:42:04.950362	contact	\N
193	Chrome		/contact		2017-08-17 11:22:06.009992	contact	\N
194	Chrome		/contact		2017-08-17 11:24:01.663336	contact	\N
195	Chrome		/contact		2017-08-17 11:24:10.764239	contact	\N
196	Chrome		/contact		2017-08-17 11:24:49.088197	contact	\N
197	Chrome		/contact		2017-08-17 11:25:04.113965	contact	\N
198	Chrome		/contact		2017-08-17 11:25:17.816048	contact	\N
199	Chrome		/contact		2017-08-17 11:25:35.899858	contact	\N
200	Chrome		/contact		2017-08-17 11:26:01.439754	contact	\N
201	Chrome		/contact		2017-08-17 11:26:21.623225	contact	\N
202	Chrome		/contact		2017-08-17 11:27:49.228211	contact	\N
203	Chrome		/contact		2017-08-17 11:55:57.108271	contact	\N
204	Chrome		/contact		2017-08-17 11:57:19.76619	contact	\N
205	Chrome		/contact		2017-08-17 11:57:56.107521	contact	\N
206	Chrome		/news		2017-08-17 11:58:19.769455	news	\N
207	Chrome		/news		2017-08-17 12:15:45.43724	news	\N
208	Chrome		/news		2017-08-17 12:19:19.302999	news	\N
209	Chrome		/news		2017-08-17 12:20:04.088943	news	\N
210	Chrome		/news		2017-08-17 12:29:47.379079	news	\N
211	Chrome		/news		2017-08-17 12:31:53.533325	news	\N
212	Chrome		/news		2017-08-17 12:44:09.246367	news	\N
213	Chrome		/news		2017-08-17 13:01:57.883383	news	\N
214	Chrome		/news		2017-08-17 13:02:00.318216	news	\N
215	Chrome		/news		2017-08-17 13:03:01.497574	news	\N
216	Chrome		/news		2017-08-17 13:04:12.724338	news	\N
217	Chrome		/news		2017-08-17 13:06:43.812355	news	\N
218	Chrome		/news		2017-08-17 13:20:39.989417	news	\N
219	Chrome		/news		2017-08-17 13:20:57.536887	news	\N
220	Chrome		/news		2017-08-17 13:23:54.966426	news	\N
221	Chrome		/news		2017-08-17 13:24:34.116554	news	\N
222	Chrome		/news		2017-08-17 13:25:26.318642	news	\N
223	Chrome		/contact		2017-08-17 13:26:37.79442	contact	\N
224	Chrome		/news		2017-08-17 13:31:52.991221	news	\N
225	Chrome		/news		2017-08-17 13:35:19.884964	news	\N
226	Chrome		/news		2017-08-17 13:35:33.892356	news	\N
227	Chrome		/news		2017-08-17 13:37:12.388567	news	\N
228	Chrome		/news		2017-08-17 13:42:15.293292	news	\N
229	Chrome		/home		2017-08-17 13:44:41.303476	home	\N
230	Chrome	\N	/		2017-08-17 13:45:51.539629	home	\N
231	Chrome	\N	/		2017-08-17 13:48:36.861552	home	\N
232	Chrome	\N	/		2017-08-17 13:48:45.304207	home	\N
233	Chrome	\N	/		2017-08-17 13:50:01.739323	home	\N
234	Chrome	\N	/		2017-08-17 13:50:54.401896	home	\N
235	Chrome	\N	/		2017-08-17 14:02:22.037304	home	\N
236	Chrome	\N	/		2017-08-17 14:06:54.384197	home	\N
237	Chrome	\N	/		2017-08-17 14:11:08.46959	home	\N
238	Chrome	\N	/		2017-08-17 14:12:23.537302	home	\N
239	Chrome	\N	/		2017-08-17 14:16:06.10425	home	\N
240	Chrome	\N	/		2017-08-17 14:17:28.312955	home	\N
241	Chrome	\N	/		2017-08-17 14:25:28.390812	home	\N
242	Chrome	\N	/		2017-08-17 14:27:12.69319	home	\N
243	Chrome	\N	/		2017-08-17 14:31:15.016875	home	\N
244	Chrome	\N	/		2017-08-17 14:31:43.62411	home	\N
245	Chrome		/brands		2017-08-17 14:32:31.026823	brands	\N
246	Chrome		/brands		2017-08-17 14:32:56.858424	brands	\N
247	Chrome		/brands		2017-08-17 14:32:59.507479	brands	\N
248	Chrome		/brands		2017-08-17 14:33:05.188622	brands	\N
249	Chrome		/brands		2017-08-17 14:33:07.388538	brands	\N
250	Chrome		/brands		2017-08-17 14:33:12.930724	brands	\N
251	Chrome		/home		2017-08-17 14:33:16.605907	home	\N
252	Chrome		/home		2017-08-17 14:33:19.732537	home	\N
253	Chrome		/home		2017-08-17 14:33:25.036764	home	\N
254	Chrome		/home		2017-08-17 14:33:27.286219	home	\N
255	Chrome		/home		2017-08-17 14:34:37.238942	home	\N
256	Chrome		/home		2017-08-17 14:34:42.152105	home	\N
257	Chrome		/home		2017-08-17 14:35:03.601784	home	\N
258	Chrome		/home		2017-08-17 14:35:21.302039	home	\N
259	Chrome		/home		2017-08-17 14:36:58.304975	home	\N
260	Chrome		/brands		2017-08-17 14:37:04.237391	brands	\N
261	Chrome		/home		2017-08-17 14:37:39.127213	home	\N
262	Chrome		/brands		2017-08-17 14:39:17.794918	brands	\N
263	Chrome		/contact		2017-08-17 14:39:37.803472	contact	\N
264	Chrome		/company		2017-08-17 14:40:33.638465	company	\N
265	Chrome	\N	/		2017-08-17 16:01:59.874767	home	\N
266	Chrome	\N	/		2017-08-17 16:06:58.938725	home	\N
267	Chrome	\N	/		2017-08-17 16:14:05.946602	home	\N
268	Chrome	\N	/		2017-08-17 16:14:24.20377	home	\N
269	Chrome	\N	/		2017-08-17 16:24:50.465095	home	\N
270	Chrome	\N	/		2017-08-17 16:25:23.068394	home	\N
271	Chrome	\N	/		2017-08-17 16:26:02.310919	home	\N
272	Chrome	\N	/		2017-08-17 21:06:11.561872	home	\N
273	Chrome		/		2017-08-17 21:06:25.393247	home	\N
274	Chrome		/		2017-08-18 08:54:40.218926	home	\N
275	Chrome		/		2017-08-18 08:57:16.377088	home	\N
276	Chrome	\N	/		2017-08-18 09:53:16.263408	home	\N
277	Chrome		/brands		2017-08-18 10:00:59.073957	brands	\N
278	Chrome		/brands		2017-08-18 10:01:10.867787	brands	\N
279	Chrome		/company		2017-08-18 10:01:13.145883	company	\N
280	Chrome		/home		2017-08-18 10:01:17.515698	home	\N
281	Chrome	\N	/		2017-08-18 10:02:03.086366	home	\N
282	Chrome	\N	/		2017-08-18 10:02:58.812311	home	\N
283	Chrome		/		2017-08-18 10:03:00.559061	home	\N
284	Chrome		/brands		2017-08-18 10:03:50.43694	brands	\N
285	Chrome		/brands		2017-08-18 10:04:35.689112	brands	\N
286	Chrome		/brands		2017-08-18 11:03:43.874285	brands	\N
287	Chrome		/brands		2017-08-18 11:04:10.586348	brands	\N
288	Chrome		/brands		2017-08-18 11:06:55.964499	brands	\N
289	Chrome		/brands		2017-08-18 11:17:32.875358	brands	\N
290	Chrome		/brands		2017-08-18 11:17:53.785521	brands	\N
291	Chrome		/brands		2017-08-18 11:19:13.011917	brands	\N
292	Chrome		/brands		2017-08-18 11:20:02.691519	brands	\N
293	Chrome		/brands		2017-08-18 11:20:15.525282	brands	\N
294	Chrome		/brands		2017-08-18 11:24:35.193896	brands	\N
295	Chrome		/brands		2017-08-18 11:25:21.801873	brands	\N
296	Chrome		/brands		2017-08-18 11:27:01.786398	brands	\N
297	Chrome		/brands		2017-08-18 11:27:36.454667	brands	\N
298	Chrome		/brands		2017-08-18 11:27:49.288718	brands	\N
299	Chrome		/brands		2017-08-18 11:27:53.310696	brands	\N
300	Chrome		/brands		2017-08-18 11:29:19.703115	brands	\N
301	Chrome		/brands		2017-08-18 11:29:21.019708	brands	\N
302	Chrome		/brands		2017-08-18 11:46:54.419937	brands	\N
303	Chrome		/brands		2017-08-18 11:50:30.132515	brands	\N
304	Chrome		/brands		2017-08-18 11:52:01.695783	brands	\N
305	Chrome		/brands		2017-08-18 11:54:02.899179	brands	\N
306	Chrome		/company		2017-08-18 11:54:10.248121	company	\N
307	Chrome		/brands		2017-08-18 11:54:11.712502	brands	\N
308	Chrome		/news		2017-08-18 11:54:13.264507	news	\N
309	Chrome		/contact		2017-08-18 11:54:14.793945	contact	\N
310	Chrome		/contact		2017-08-18 11:54:47.145579	contact	\N
311	Chrome		/contact		2017-08-18 15:30:19.046763	contact	\N
312	Chrome		/contact		2017-08-18 15:31:09.865339	contact	\N
313	Chrome		/contact		2017-08-18 15:32:35.986736	contact	\N
314	Chrome		/contact		2017-08-18 15:33:19.157969	contact	\N
315	Chrome		/contact		2017-08-18 15:33:22.907507	contact	\N
316	Chrome		/contact		2017-08-18 15:33:46.520712	contact	\N
317	Chrome		/contact		2017-08-18 15:35:24.879919	contact	\N
318	Chrome		/contact		2017-08-18 15:37:00.032499	contact	\N
319	Chrome		/contact		2017-08-18 15:37:20.693479	contact	\N
320	Chrome		/contact		2017-08-18 15:37:34.797223	contact	\N
321	Chrome		/		2017-08-18 15:38:19.116312	home	\N
322	Chrome		/		2017-08-18 15:39:28.812156	home	\N
323	Chrome		/		2017-08-18 15:40:55.028384	home	\N
324	Chrome		/		2017-08-18 15:41:38.869614	home	\N
325	Chrome		/		2017-08-18 15:41:54.780524	home	\N
326	Chrome		/		2017-08-18 16:03:47.636036	home	\N
327	Chrome		/		2017-08-18 16:09:55.259505	home	\N
328	Chrome	\N	/		2017-08-22 09:03:35.70621	home	\N
329	Chrome	\N	/		2017-08-22 11:51:35.830655	home	\N
330	Chrome	\N	/		2017-08-22 11:58:18.386484	home	\N
331	Chrome	\N	/		2017-08-22 12:02:51.624342	home	\N
332	Chrome	\N	/		2017-08-22 12:02:53.173146	home	\N
333	Chrome	\N	/		2017-08-22 12:03:40.887542	home	\N
334	Chrome	\N	/		2017-08-22 12:06:19.558996	home	\N
335	Chrome	\N	/		2017-08-22 12:07:50.937838	home	\N
336	Chrome	\N	/		2017-08-22 12:08:11.492137	home	\N
337	Chrome	\N	/		2017-08-22 12:08:12.939266	home	\N
338	Chrome	\N	/		2017-08-22 12:08:42.771746	home	\N
339	Chrome	\N	/		2017-08-22 12:08:42.990025	home	\N
340	Chrome	\N	/		2017-08-22 12:15:06.075685	home	\N
341	Chrome	\N	/		2017-08-22 12:15:49.59549	home	\N
342	Chrome	\N	/		2017-08-22 12:16:23.687471	home	\N
343	Chrome	\N	/		2017-08-22 13:10:46.038794	home	\N
344	Chrome	\N	/		2017-08-22 13:10:53.290251	home	\N
345	Chrome	\N	/		2017-08-22 13:23:55.989069	home	\N
346	Chrome		/company		2017-08-22 13:31:44.120735	company	\N
347	Chrome		/company		2017-08-22 13:32:52.058914	company	\N
348	Chrome		/company		2017-08-22 13:33:01.858535	company	\N
349	Chrome		/company		2017-08-22 13:36:38.266098	company	\N
350	Chrome	\N	/		2017-08-22 13:40:35.105634	home	\N
351	Chrome	\N	/		2017-08-22 14:05:25.31466	home	\N
352	Chrome	\N	/		2017-08-22 14:08:10.437872	home	\N
353	Chrome	\N	/		2017-08-22 14:09:08.656723	home	\N
354	Chrome		/company		2017-08-22 14:09:16.908272	company	\N
355	Chrome		/news		2017-08-22 14:29:26.670093	news	\N
356	Chrome		/news		2017-08-22 15:38:05.628285	news	\N
357	Chrome		/news		2017-08-22 15:44:56.372529	news	\N
358	Chrome		/news		2017-08-22 15:45:23.25202	news	\N
359	Chrome		/news		2017-08-22 15:49:41.855021	news	\N
360	Chrome	\N	/		2017-08-24 09:00:44.306256	home	\N
361	Chrome		/brands		2017-08-24 09:00:47.803054	brands	\N
362	Chrome		/company		2017-08-24 09:00:57.936399	company	\N
363	Chrome		/contact		2017-08-24 09:01:04.230314	contact	\N
364	Chrome		/contact		2017-08-24 09:04:15.36948	contact	\N
365	Chrome	\N	/drink		2017-08-24 09:04:29.267716	drink	\N
366	Chrome	\N	/drink		2017-08-24 09:47:31.542333	drink	\N
367	Chrome	\N	/drink		2017-08-24 09:51:37.474128	drink	\N
368	Chrome	\N	/drink		2017-08-24 09:52:05.711333	drink	\N
369	Chrome	\N	/drink		2017-08-24 10:03:23.594468	drink	\N
370	Chrome	\N	/drink		2017-08-24 10:03:25.932143	drink	\N
371	Chrome	\N	/drink		2017-08-24 10:03:41.709585	drink	\N
372	Chrome	\N	/drink		2017-08-24 10:06:52.514729	drink	\N
373	Chrome		/company		2017-08-24 10:33:13.989941	company	\N
374	Chrome		/brands		2017-08-24 10:33:15.2381	brands	\N
375	Chrome		/brands		2017-08-24 10:33:23.642746	brands	\N
376	Chrome		/news		2017-08-24 10:33:24.595622	news	\N
377	Chrome		/contact		2017-08-24 10:33:25.97901	contact	\N
378	Chrome		/contact		2017-08-24 10:33:35.096906	contact	\N
379	Chrome		/news		2017-08-24 10:33:36.90042	news	\N
380	Chrome		/contact		2017-08-24 10:33:38.523189	contact	\N
381	Chrome		/news		2017-08-24 10:33:40.538924	news	\N
382	Chrome		/brands		2017-08-24 10:33:42.041154	brands	\N
383	Chrome		/company		2017-08-24 10:33:44.894729	company	\N
384	Chrome		/brands		2017-08-24 10:33:52.632205	brands	\N
385	Chrome		/news		2017-08-24 10:33:53.944873	news	\N
386	Chrome		/contact		2017-08-24 10:33:55.682771	contact	\N
387	Chrome	\N	/error		2017-08-24 11:40:02.198095	error	\N
388	Chrome	\N	/error		2017-08-24 11:57:49.470846	error	\N
389	Chrome	\N	/error		2017-08-24 12:01:26.459771	error	\N
390	Chrome	\N	/terms_conditions		2017-08-24 12:20:06.573877	terms_conditions	\N
391	Chrome	\N	/terms_conditions		2017-08-24 12:27:30.02063	terms_conditions	\N
392	Chrome	\N	/terms_conditions		2017-08-24 12:29:19.564418	terms_conditions	\N
393	Chrome	\N	/terms_conditions		2017-08-24 12:30:16.698564	terms_conditions	\N
394	Chrome	\N	/terms_conditions		2017-08-24 12:31:24.20949	terms_conditions	\N
395	Chrome	\N	/terms_conditions		2017-08-24 13:00:23.033732	terms_conditions	\N
396	Chrome	\N	/portfolio		2017-08-24 14:02:04.7789	portfolio	\N
397	Chrome	\N	/portfolio		2017-08-24 14:06:38.608482	portfolio	\N
398	Chrome	\N	/portfolio		2017-08-24 14:06:50.190492	portfolio	\N
399	Chrome	\N	/portfolio		2017-08-24 14:07:05.910036	portfolio	\N
400	Chrome	\N	/portfolio		2017-08-24 14:07:45.864207	portfolio	\N
401	Chrome	\N	/portfolio		2017-08-24 14:10:31.847934	portfolio	\N
402	Chrome	\N	/portfolio		2017-08-24 14:12:13.8069	portfolio	\N
403	Chrome	\N	/portfolio		2017-08-24 14:19:37.626297	portfolio	\N
404	Chrome	\N	/		2017-08-25 08:47:38.015993	home	\N
405	Chrome		/brands		2017-08-25 08:48:31.749039	brands	\N
406	Chrome		/news		2017-08-25 08:48:33.171002	news	\N
407	Chrome		/contact		2017-08-25 08:48:34.774281	contact	\N
408	Chrome		/news		2017-08-25 08:48:37.532751	news	\N
409	Chrome	\N	/login		2017-08-25 08:53:47.768393	login	\N
410	Chrome	\N	/login		2017-08-25 08:53:52.457771	login	\N
411	Chrome	\N	/single-blog		2017-08-25 09:08:58.245142	single-blog	\N
412	Chrome	\N	/single-blog		2017-08-25 09:09:53.875081	single-blog	\N
413	Chrome	\N	/single-blog		2017-08-25 09:12:30.735371	single-blog	\N
414	Chrome	\N	/single-blog		2017-08-25 09:27:27.530539	single-blog	\N
415	Chrome	\N	/single-blog		2017-08-25 09:33:04.898877	single-blog	\N
416	Chrome	\N	/single-blog		2017-08-25 09:34:47.977338	single-blog	\N
417	Chrome	\N	/single-blog		2017-08-25 09:48:48.806469	single-blog	\N
418	Chrome	\N	/terms_conditions		2017-08-25 09:49:07.07445	terms_conditions	\N
419	Chrome	\N	/terms_conditions		2017-08-25 09:49:22.67304	terms_conditions	\N
420	Chrome	\N	/portfolio		2017-08-25 09:52:05.085971	portfolio	\N
421	Chrome	\N	/login		2017-08-25 10:02:13.50296	login	\N
422	Chrome	\N	/login		2017-08-25 10:08:07.615799	login	\N
423	Chrome	\N	/		2017-08-25 10:08:41.93503	home	\N
424	Chrome	\N	/login		2017-08-25 10:29:12.641437	login	\N
425	Chrome	\N	/		2017-08-28 08:49:51.339282	home	\N
426	Chrome		/company		2017-08-28 08:52:55.573879	company	\N
427	Chrome	\N	/		2017-08-28 08:52:58.125265	home	\N
428	Chrome		/brands		2017-08-28 08:52:59.436198	brands	\N
429	Chrome	\N	/		2017-08-28 08:53:02.25201	home	\N
430	Chrome		/news		2017-08-28 08:53:03.838841	news	\N
431	Chrome	\N	/		2017-08-28 08:53:05.373907	home	\N
432	Chrome		/contact		2017-08-28 08:53:06.541911	contact	\N
433	Chrome	\N	/		2017-08-28 08:53:09.684075	home	\N
434	Chrome		/company		2017-08-28 09:08:40.329801	company	\N
435	Chrome	\N	/		2017-08-28 09:08:45.591848	home	\N
436	Chrome	\N	/		2017-08-28 09:16:02.511136	home	\N
437	Chrome		/company/		2017-08-28 09:16:04.252068	company/	\N
438	Chrome		/company		2017-08-28 09:16:04.294144	company	\N
439	Chrome	\N	/		2017-08-28 09:16:07.780988	home	\N
440	Chrome		/company		2017-08-28 09:17:06.611813	company	\N
441	Chrome		/company		2017-08-28 09:22:08.545721	company	\N
442	Chrome		/brands		2017-08-28 09:22:10.36906	brands	\N
443	Chrome		/company		2017-08-28 09:22:12.099528	company	\N
444	Chrome		/news		2017-08-28 09:22:13.263261	news	\N
445	Chrome		/company		2017-08-28 09:22:15.530398	company	\N
446	Chrome		/contact		2017-08-28 09:22:16.790345	contact	\N
447	Chrome		/company		2017-08-28 09:22:18.752786	company	\N
448	Chrome		/brands		2017-08-28 09:22:46.332345	brands	\N
449	Chrome		/brands		2017-08-28 09:22:52.102945	brands	\N
450	Chrome		/company		2017-08-28 09:22:54.489972	company	\N
451	Chrome		/brands		2017-08-28 09:23:01.779062	brands	\N
452	Chrome		/brands		2017-08-28 09:24:54.858277	brands	\N
453	Chrome		/drink/		2017-08-28 09:24:56.106982	drink/	\N
454	Chrome		/drink		2017-08-28 09:24:56.179422	drink	\N
455	Chrome		/brands		2017-08-28 09:25:01.523338	brands	\N
456	Chrome		/news		2017-08-28 09:25:24.23064	news	\N
457	Chrome	\N	/single-blog		2017-08-28 09:27:34.667432	single-blog	\N
458	Chrome		/news		2017-08-28 09:27:37.648053	news	\N
459	Chrome	\N	/single-blog		2017-08-28 09:27:47.528515	single-blog	\N
460	Chrome		/news		2017-08-28 09:27:48.938414	news	\N
461	Chrome		/news		2017-08-28 09:28:06.317072	news	\N
462	Chrome		/single-blog/		2017-08-28 09:28:07.663527	single-blog/	\N
463	Chrome		/single-blog		2017-08-28 09:28:07.70649	single-blog	\N
464	Chrome		/news		2017-08-28 09:28:10.156132	news	\N
465	Chrome		/news		2017-08-28 09:30:05.997715	news	\N
466	Chrome		/single-blog/		2017-08-28 09:30:07.775402	single-blog/	\N
467	Chrome		/single-blog		2017-08-28 09:30:07.811931	single-blog	\N
468	Chrome		/news		2017-08-28 09:30:11.233881	news	\N
469	Chrome		/single-blog/		2017-08-28 09:30:14.068285	single-blog/	\N
470	Chrome		/single-blog		2017-08-28 09:30:14.111066	single-blog	\N
471	Chrome		/news		2017-08-28 09:30:16.11943	news	\N
472	Chrome		/single-blog/		2017-08-28 09:30:19.172455	single-blog/	\N
473	Chrome		/single-blog		2017-08-28 09:30:19.210485	single-blog	\N
474	Chrome		/news		2017-08-28 09:30:20.533896	news	\N
475	Chrome		/single-blog/		2017-08-28 09:30:21.813337	single-blog/	\N
476	Chrome		/single-blog		2017-08-28 09:30:21.901973	single-blog	\N
477	Chrome		/news		2017-08-28 09:30:23.339527	news	\N
478	Chrome		/contact		2017-08-28 09:32:02.662239	contact	\N
479	Chrome		/company		2017-08-28 09:33:00.320298	company	\N
480	Chrome		/contact		2017-08-28 09:33:01.529753	contact	\N
481	Chrome		/brands		2017-08-28 09:33:02.755844	brands	\N
482	Chrome		/contact		2017-08-28 09:33:04.073065	contact	\N
483	Chrome		/news		2017-08-28 09:33:05.220428	news	\N
484	Chrome		/contact		2017-08-28 09:33:06.402248	contact	\N
485	Chrome		/contact		2017-08-28 09:33:07.677448	contact	\N
486	Chrome		/news		2017-08-28 09:33:09.707524	news	\N
487	Chrome		/brands		2017-08-28 09:33:21.396658	brands	\N
488	Chrome		/drink/		2017-08-28 09:33:24.571845	drink/	\N
489	Chrome		/drink		2017-08-28 09:33:24.614268	drink	\N
490	Chrome		/company		2017-08-28 09:33:29.559914	company	\N
491	Chrome		/drink		2017-08-28 09:33:31.325615	drink	\N
492	Chrome		/brands		2017-08-28 09:33:32.66594	brands	\N
493	Chrome		/drink		2017-08-28 09:33:34.523575	drink	\N
494	Chrome		/news		2017-08-28 09:33:35.804211	news	\N
495	Chrome		/drink		2017-08-28 09:33:37.101323	drink	\N
496	Chrome		/contact		2017-08-28 09:33:38.160701	contact	\N
497	Chrome		/drink		2017-08-28 09:33:40.101409	drink	\N
498	Chrome		/drink		2017-08-28 09:47:52.465343	drink	\N
499	Chrome		/drink		2017-08-28 09:49:03.579306	drink	\N
500	Chrome		/drink		2017-08-28 09:55:50.822753	drink	\N
501	Chrome	\N	/		2017-08-28 11:24:19.200378	home	\N
502	Chrome	\N	/		2017-08-28 11:25:40.243812	home	\N
503	Chrome		/company		2017-08-28 11:25:42.167107	company	\N
504	Chrome		/company		2017-08-28 11:25:48.958374	company	\N
505	Chrome		/brands		2017-08-28 11:25:50.878083	brands	\N
506	Chrome		/drink/		2017-08-28 11:25:54.371742	drink/	\N
507	Chrome		/drink		2017-08-28 11:25:54.523418	drink	\N
508	Chrome		/brands		2017-08-28 11:25:59.169545	brands	\N
509	Chrome		/drink/		2017-08-28 11:26:01.015054	drink/	\N
510	Chrome		/drink		2017-08-28 11:26:01.102903	drink	\N
511	Chrome		/brands		2017-08-28 11:26:03.409377	brands	\N
512	Chrome		/drink/		2017-08-28 11:26:06.539023	drink/	\N
513	Chrome		/drink		2017-08-28 11:26:06.609119	drink	\N
514	Chrome		/brands		2017-08-28 11:26:13.255566	brands	\N
515	Chrome		/news		2017-08-28 11:26:17.980366	news	\N
516	Chrome		/single-blog/		2017-08-28 11:26:21.177204	single-blog/	\N
517	Chrome		/single-blog		2017-08-28 11:26:21.328616	single-blog	\N
518	Chrome		/news		2017-08-28 11:26:27.849065	news	\N
519	Chrome		/single-blog/		2017-08-28 11:26:30.137522	single-blog/	\N
520	Chrome		/single-blog		2017-08-28 11:26:30.204677	single-blog	\N
521	Chrome		/contact		2017-08-28 11:26:34.89533	contact	\N
522	Chrome		/brands		2017-08-28 11:28:37.685627	brands	\N
555	Chrome	\N	/		2017-08-28 13:19:11.88912	home	\N
556	Chrome	\N	/		2017-08-28 13:19:22.99767	home	\N
557	Chrome		/		2017-08-28 13:21:57.848994	home	\N
558	Chrome		/brands		2017-08-28 13:22:10.813589	brands	\N
559	Chrome		/		2017-08-28 13:24:57.259086	home	\N
560	Chrome		/		2017-08-28 13:25:50.35826	home	\N
561	Chrome		/		2017-08-28 13:25:52.102788	home	\N
562	Chrome		/		2017-08-28 13:26:26.614357	home	\N
563	Chrome		/		2017-08-28 13:29:39.756417	home	\N
564	Chrome		/		2017-08-28 13:41:57.47733	home	\N
565	Chrome		/		2017-08-28 14:02:21.881458	home	\N
566	Chrome		/brands		2017-08-28 14:02:27.046883	brands	\N
567	Chrome		/brands		2017-08-28 14:06:27.25758	brands	\N
568	Chrome		/brands		2017-08-28 14:06:43.423136	brands	\N
569	Chrome		/brands		2017-08-28 14:07:50.537162	brands	\N
570	Chrome		/brands		2017-08-28 14:09:05.162798	brands	\N
571	Chrome		/brands		2017-08-28 14:09:19.094471	brands	\N
572	Chrome		/brands		2017-08-28 14:10:15.998812	brands	\N
573	Chrome		/brands		2017-08-28 14:11:30.30509	brands	\N
574	Chrome		/brands		2017-08-28 14:13:11.057599	brands	\N
575	Chrome		/brands		2017-08-28 14:13:17.372544	brands	\N
576	Chrome		/brands		2017-08-28 14:14:20.346904	brands	\N
577	Chrome		/brands		2017-08-28 14:19:08.08617	brands	\N
578	Chrome		/error		2017-08-28 14:19:27.299527	error	\N
579	Chrome		/		2017-08-28 14:19:42.183506	home	\N
580	Chrome		/news		2017-08-28 14:20:04.611157	news	\N
581	Chrome		/news		2017-08-28 14:20:48.785838	news	\N
582	Chrome		/news		2017-08-28 14:21:02.567335	news	\N
583	Chrome		/news		2017-08-28 14:21:28.405824	news	\N
584	Chrome		/news		2017-08-28 14:21:37.39953	news	\N
585	Chrome	\N	/		2017-08-28 16:50:20.849927	home	\N
586	Chrome		/company		2017-08-28 16:52:18.221737	company	\N
587	Chrome		/contact		2017-08-28 16:52:21.048612	contact	\N
588	Chrome		/news		2017-08-28 16:52:31.054503	news	\N
589	Chrome		/company		2017-08-28 16:52:33.425272	company	\N
590	Chrome		/		2017-08-28 16:52:34.464278	home	\N
591	Safari		/		2017-08-28 16:53:31.887506	home	\N
592	Chrome		/		2017-08-28 16:53:47.926342	home	\N
593	Chrome		/company		2017-08-28 16:54:14.519896	company	\N
594	Chrome	\N	/		2017-08-29 08:50:36.327875	home	\N
595	Chrome		/error		2017-08-29 09:27:30.819535	error	\N
596	Chrome		/error		2017-08-29 09:27:52.124296	error	\N
597	Chrome	\N	/		2017-08-29 09:27:55.817658	home	\N
598	Chrome	\N	/error		2017-08-29 09:28:00.807937	error	\N
599	Chrome	\N	/		2017-08-29 09:28:25.866717	home	\N
600	Chrome	\N	/error		2017-08-29 10:50:28.995863	error	\N
601	Chrome		/error		2017-08-29 10:51:41.522224	error	\N
602	Chrome		/error		2017-08-29 10:52:32.645444	error	\N
603	Chrome	\N	/error		2017-08-29 11:31:58.508004	error	\N
604	Chrome	\N	/error		2017-08-29 11:32:31.91847	error	\N
605	Chrome	\N	/		2017-08-29 11:56:12.533304	home	\N
606	Chrome		/error		2017-08-29 12:11:46.477308	error	\N
607	Chrome		/error		2017-08-29 12:26:42.160969	error	\N
608	Chrome		/error		2017-08-29 12:27:09.934478	error	\N
609	Chrome		/error		2017-08-29 12:27:39.27181	error	\N
610	Chrome		/error		2017-08-29 13:20:40.759341	error	\N
611	Chrome		/error		2017-08-29 13:22:23.967781	error	\N
612	Chrome		/error		2017-08-29 13:47:35.090299	error	\N
613	Chrome		/error		2017-08-29 13:48:15.897481	error	\N
614	Chrome		/error		2017-08-29 13:49:09.691559	error	\N
615	Chrome		/error		2017-08-29 13:53:06.152964	error	\N
616	Chrome	\N	/		2017-08-30 10:43:33.542358	home	\N
617	Chrome	\N	/		2017-08-30 10:45:55.84925	home	\N
618	Chrome	\N	/		2017-08-30 11:10:44.927736	home	\N
619	Chrome		/error		2017-08-30 11:18:56.503315	error	\N
620	Chrome	\N	/		2017-08-30 11:36:15.632357	home	\N
621	Chrome	\N	/		2017-08-30 11:37:31.813938	home	\N
622	Chrome	\N	/		2017-08-30 12:12:54.695754	home	\N
623	Chrome	\N	/brands		2017-08-30 12:13:01.678836	brands	\N
624	Chrome	\N	/		2017-08-30 12:13:04.39298	home	\N
625	Chrome		/brands/Cognac		2017-08-30 12:16:32.828253	brands/Cognac	\N
626	Chrome		/		2017-08-30 12:16:53.38323	home	\N
627	Chrome		/brands/Whiskey		2017-08-30 12:16:57.990839	brands/Whiskey	\N
628	Chrome		/		2017-08-30 12:17:20.957993	home	\N
629	Chrome		/brands/Champagne		2017-08-30 12:17:23.853807	brands/Champagne	\N
630	Chrome		/		2017-08-30 12:17:51.058016	home	\N
631	Chrome		/brands/Cognac		2017-08-30 12:17:54.061873	brands/Cognac	\N
632	Chrome		/		2017-08-30 12:17:56.108717	home	\N
633	Chrome		/brands/Champagne		2017-08-30 12:17:59.472491	brands/Champagne	\N
634	Chrome		/		2017-08-30 12:18:01.12688	home	\N
635	Chrome		/brands/Gin		2017-08-30 12:19:02.614822	brands/Gin	\N
636	Chrome		/		2017-08-30 12:19:28.320909	home	\N
637	Chrome		/brands/Champagne		2017-08-30 12:19:30.185943	brands/Champagne	\N
638	Chrome		/		2017-08-30 12:19:32.650689	home	\N
639	Chrome		/brands/Champagne		2017-08-30 12:20:56.246281	brands/Champagne	\N
640	Chrome		/		2017-08-30 12:21:04.645842	home	\N
641	Chrome		/brands/Champagne		2017-08-30 12:21:14.977581	brands/Champagne	\N
642	Chrome		/brands/Champagne		2017-08-30 12:24:08.680376	brands/Champagne	\N
643	Chrome		/error		2017-08-30 12:25:19.648715	error	\N
644	Chrome		/		2017-08-30 12:27:05.807079	home	\N
645	Chrome		/brands/Cognac		2017-08-30 12:27:09.249108	brands/Cognac	\N
646	Chrome		/brands/Cognac		2017-08-30 12:27:30.487386	brands/Cognac	\N
647	Chrome		/brands/Cognac		2017-08-30 12:28:00.251459	brands/Cognac	\N
648	Chrome		/brands/Cognac		2017-08-30 12:32:42.861879	brands/Cognac	\N
649	Chrome		/brands/Cognac		2017-08-30 12:32:55.882371	brands/Cognac	\N
650	Chrome		/brands/Champagne		2017-08-30 12:33:00.800137	brands/Champagne	\N
651	Chrome		/brands/Gin		2017-08-30 12:33:03.243975	brands/Gin	\N
652	Chrome		/brands/Whiskey		2017-08-30 12:33:05.581025	brands/Whiskey	\N
653	Chrome		/brands/Whiskey		2017-08-30 12:33:42.737512	brands/Whiskey	\N
654	Chrome		/brands/Gin		2017-08-30 12:33:47.430324	brands/Gin	\N
655	Chrome		/error		2017-08-30 12:52:11.947863	error	\N
656	Chrome		/brands/Gin		2017-08-30 13:35:34.208139	brands/Gin	\N
657	Chrome		/brands/Cognac		2017-08-30 13:35:38.232203	brands/Cognac	\N
658	Chrome		/brands/Cognac		2017-08-30 13:36:08.792083	brands/Cognac	\N
659	Chrome		/brands/Cognac		2017-08-30 13:36:34.342375	brands/Cognac	\N
660	Chrome		/brands/Cognac		2017-08-30 15:04:37.643279	brands/Cognac	\N
661	Chrome		/brands/Cognac		2017-08-30 15:04:44.961074	brands/Cognac	\N
662	Chrome		/brands/Cognac		2017-08-30 15:07:09.651332	brands/Cognac	\N
663	Chrome		/error		2017-08-30 15:08:20.040426	error	\N
664	Chrome		/brands/Gin		2017-08-30 15:08:48.132754	brands/Gin	\N
665	Chrome		/brands/Cognac		2017-08-30 15:08:53.321864	brands/Cognac	\N
666	Chrome		/brands/Cognac		2017-08-30 15:11:26.800421	brands/Cognac	\N
667	Chrome		/brands/Cognac		2017-08-30 15:12:27.785956	brands/Cognac	\N
668	Chrome		/brands/Cognac		2017-08-30 15:13:17.540927	brands/Cognac	\N
669	Chrome		/brands/Cognac		2017-08-30 15:14:59.28765	brands/Cognac	\N
670	Chrome		/brands/Cognac		2017-08-30 15:15:20.853799	brands/Cognac	\N
671	Chrome		/company		2017-08-30 15:15:24.165915	company	\N
672	Chrome		/brands/Cognac		2017-08-30 15:15:27.283377	brands/Cognac	\N
673	Chrome	\N	/brands		2017-08-30 15:15:47.127318	brands	\N
674	Chrome	\N	/brands/Cognac		2017-08-30 15:15:47.285126	brands/Cognac	\N
675	Chrome	\N	/brands		2017-08-30 15:15:51.537303	brands	\N
676	Chrome	\N	/brands/Cognac		2017-08-30 15:15:51.637303	brands/Cognac	\N
677	Chrome		/brands/Cognac/2		2017-08-30 15:16:27.907415	brands/Cognac/2	\N
678	Chrome	\N	/brands/Cognac		2017-08-30 15:16:29.803224	brands/Cognac	\N
679	Chrome	\N	/brands/Cognac	id=5	2017-08-30 15:17:00.634648	brands/Cognac	\N
680	Chrome		/brands/Cognac		2017-08-30 15:18:10.30176	brands/Cognac	\N
681	Chrome		/news		2017-08-30 15:18:14.266527	news	\N
682	Chrome		/error		2017-08-30 15:19:56.467327	error	\N
683	Chrome		/news		2017-08-30 15:21:24.959765	news	\N
684	Chrome		/brands/Cognac		2017-08-30 15:21:26.981302	brands/Cognac	\N
685	Chrome	\N	/brands/Cognac	id=5	2017-08-30 15:21:34.309269	brands/Cognac	\N
686	Chrome	\N	/brands/Cognac	id=5	2017-08-30 15:28:00.309847	brands/Cognac	\N
687	Chrome	\N	/brands/Cognac	id=1	2017-08-30 15:31:23.665368	brands/Cognac	\N
688	Chrome	\N	/brands/Cognac	id=1	2017-08-30 15:31:49.426602	brands/Cognac	\N
689	Chrome	\N	/brands/Cognac	id=1	2017-08-30 15:32:58.30249	brands/Cognac	\N
690	Chrome	\N	/brands/Cognac	id=1	2017-08-30 15:33:48.354455	brands/Cognac	\N
691	Chrome	\N	/brands/Cognac	id=1	2017-08-30 15:34:05.894701	brands/Cognac	\N
692	Chrome		/brands/Cognac		2017-08-30 15:35:22.90035	brands/Cognac	\N
693	Chrome		/brands/Cognac/2		2017-08-30 15:35:25.75854	brands/Cognac/2	\N
694	Chrome		/brands/Cognac		2017-08-30 15:35:28.057007	brands/Cognac	\N
695	Chrome		/brands/Cognac		2017-08-30 15:35:55.899019	brands/Cognac	\N
696	Chrome		/brands/Cognac/	id=2	2017-08-30 15:35:57.619902	brands/Cognac/	\N
697	Chrome		/brands/Cognac	id=2	2017-08-30 15:35:57.690707	brands/Cognac	\N
698	Chrome		/brands/Cognac		2017-08-30 15:36:03.950199	brands/Cognac	\N
699	Chrome		/brands/Cognac/	id=3	2017-08-30 15:36:05.546568	brands/Cognac/	\N
700	Chrome		/brands/Cognac	id=3	2017-08-30 15:36:05.612017	brands/Cognac	\N
701	Chrome		/brands/Cognac		2017-08-30 15:36:16.805615	brands/Cognac	\N
702	Chrome		/brands/Cognac/	id=1	2017-08-30 15:36:19.256487	brands/Cognac/	\N
703	Chrome		/brands/Cognac	id=1	2017-08-30 15:36:19.339108	brands/Cognac	\N
704	Chrome		/brands/Cognac		2017-08-30 15:36:31.933933	brands/Cognac	\N
705	Chrome		/brands/Cognac/	id=2	2017-08-30 15:36:35.202198	brands/Cognac/	\N
706	Chrome		/brands/Cognac	id=2	2017-08-30 15:36:35.271496	brands/Cognac	\N
707	Chrome		/brands/Cognac	id=2	2017-08-30 15:42:22.082261	brands/Cognac	\N
708	Chrome		/brands/Brandy		2017-08-30 15:42:25.257396	brands/Brandy	\N
709	Chrome		/brands/Cognac		2017-08-30 15:42:34.190842	brands/Cognac	\N
710	Chrome		/error		2017-08-30 16:07:52.612714	error	\N
711	Chrome		/brands/Cognac		2017-08-30 16:09:39.745069	brands/Cognac	\N
712	Chrome		/brands/Cognac/	id=2	2017-08-30 16:09:42.889169	brands/Cognac/	\N
713	Chrome		/brands/Cognac	id=2	2017-08-30 16:09:42.952002	brands/Cognac	\N
714	Chrome		/brands/Cognac		2017-08-30 16:09:47.977111	brands/Cognac	\N
715	Chrome		/brands/Cognac/	id=1	2017-08-30 16:09:51.20261	brands/Cognac/	\N
716	Chrome		/brands/Cognac	id=1	2017-08-30 16:09:51.273281	brands/Cognac	\N
717	Chrome		/error		2017-08-30 16:59:57.737496	error	\N
718	Chrome		/error		2017-08-30 17:06:03.947701	error	\N
719	Chrome		/error		2017-08-30 17:07:11.269995	error	\N
720	Chrome		/error		2017-08-30 17:08:51.739733	error	\N
721	Chrome		/brands/Cognac		2017-08-30 17:09:30.813277	brands/Cognac	\N
722	Chrome		/brands/Cognac		2017-08-30 17:09:40.177594	brands/Cognac	\N
723	Chrome		/brands/Cognac		2017-08-30 17:09:41.487962	brands/Cognac	\N
724	Chrome		/brands/Cognac/	id=1	2017-08-30 17:09:43.058826	brands/Cognac/	\N
725	Chrome		/brands/Cognac	id=1	2017-08-30 17:09:43.144074	brands/Cognac	\N
726	Chrome		/brands/Cognac		2017-08-30 17:18:27.581547	brands/Cognac	\N
727	Chrome		/brands/Cognac/	id=3	2017-08-30 17:18:30.178504	brands/Cognac/	\N
728	Chrome		/brands/Cognac	id=3	2017-08-30 17:18:30.329643	brands/Cognac	\N
729	Chrome		/brands/Brandy		2017-08-30 17:18:36.883522	brands/Brandy	\N
730	Chrome		/brands/Cognac		2017-08-30 17:18:40.257908	brands/Cognac	\N
731	Chrome		/brands/Cognac/	id=1	2017-08-30 17:18:43.023904	brands/Cognac/	\N
732	Chrome		/brands/Cognac	id=1	2017-08-30 17:18:43.190481	brands/Cognac	\N
733	Chrome		/brands/Cognac	id=1	2017-08-30 17:30:27.572039	brands/Cognac	\N
734	Chrome		/brands/Cognac	id=1	2017-08-30 17:30:49.323833	brands/Cognac	\N
735	Chrome		/brands/Cognac	id=1	2017-08-30 17:30:50.762614	brands/Cognac	\N
736	Chrome		/brands/Cognac	id=1	2017-08-30 17:31:11.277726	brands/Cognac	\N
737	Chrome		/brands/Brandy		2017-08-30 17:31:22.014173	brands/Brandy	\N
738	Chrome		/brands/Cognac		2017-08-30 17:31:23.631819	brands/Cognac	\N
739	Chrome		/brands/Cognac/	id=2	2017-08-30 17:31:26.03879	brands/Cognac/	\N
740	Chrome		/brands/Cognac	id=2	2017-08-30 17:31:26.120643	brands/Cognac	\N
741	Chrome		/brands/Cognac		2017-08-30 17:31:41.790775	brands/Cognac	\N
742	Chrome	\N	/		2017-09-05 11:46:10.036342	home	\N
743	Chrome		/brands/Cognac		2017-09-05 11:46:15.750351	brands/Cognac	\N
744	Chrome		/brands/Cognac/	id=2	2017-09-05 11:48:14.43479	brands/Cognac/	\N
745	Chrome		/brands/Cognac	id=2	2017-09-05 11:48:14.527347	brands/Cognac	\N
746	Chrome		/brands/Cognac		2017-09-05 11:48:22.478468	brands/Cognac	\N
747	Chrome		/brands/Cognac/	id=1	2017-09-05 11:48:24.52558	brands/Cognac/	\N
748	Chrome		/brands/Cognac	id=1	2017-09-05 11:48:24.598844	brands/Cognac	\N
749	Chrome		/brands/Cognac	id=1	2017-09-05 11:48:33.372077	brands/Cognac	\N
750	Chrome		/brands/Cognac	id=1	2017-09-05 11:56:45.905675	brands/Cognac	\N
751	Chrome		/brands/Cognac		2017-09-05 11:56:49.441911	brands/Cognac	\N
752	Chrome		/brands/Cognac/	id=1	2017-09-05 11:56:52.718369	brands/Cognac/	\N
753	Chrome		/brands/Cognac	id=1	2017-09-05 11:56:52.79355	brands/Cognac	\N
754	Chrome		/brands/Cognac	id=1	2017-09-05 11:58:28.308238	brands/Cognac	\N
755	Chrome		/brands/Cognac		2017-09-05 11:58:42.539616	brands/Cognac	\N
756	Chrome		/brands/Cognac/	id=1	2017-09-05 11:58:46.60749	brands/Cognac/	\N
757	Chrome		/brands/Cognac	id=1	2017-09-05 11:58:46.687634	brands/Cognac	\N
758	Chrome		/brands/Cognac	id=1	2017-09-05 12:00:05.836025	brands/Cognac	\N
759	Chrome		/brands/Cognac	id=1	2017-09-05 12:00:14.969655	brands/Cognac	\N
760	Chrome		/brands/Cognac		2017-09-05 12:00:27.138505	brands/Cognac	\N
761	Chrome		/brands/Cognac/	id=1	2017-09-05 12:00:31.732349	brands/Cognac/	\N
762	Chrome		/brands/Cognac	id=1	2017-09-05 12:00:31.810959	brands/Cognac	\N
763	Chrome		/brands/Cognac	id=1	2017-09-05 12:01:28.242002	brands/Cognac	\N
764	Chrome		/brands/Cognac	id=1	2017-09-05 12:01:37.79436	brands/Cognac	\N
765	Chrome		/brands/Cognac	id=1	2017-09-05 12:01:39.268281	brands/Cognac	\N
766	Chrome		/brands/Cognac		2017-09-05 12:01:41.882246	brands/Cognac	\N
767	Chrome		/brands/Cognac/	id=3	2017-09-05 12:01:43.991817	brands/Cognac/	\N
768	Chrome		/brands/Cognac	id=3	2017-09-05 12:01:44.069042	brands/Cognac	\N
769	Chrome		/brands/Cognac	id=3	2017-09-05 12:01:56.911914	brands/Cognac	\N
770	Chrome		/brands/Cognac	id=3	2017-09-05 12:04:41.788303	brands/Cognac	\N
771	Chrome		/brands/Cognac	id=3	2017-09-05 12:07:19.328845	brands/Cognac	\N
772	Chrome		/brands/Cognac	id=3	2017-09-05 12:09:37.563896	brands/Cognac	\N
773	Chrome		/error		2017-09-05 12:09:59.762719	error	\N
774	Chrome		/brands/Cognac		2017-09-05 12:10:08.114498	brands/Cognac	\N
775	Chrome		/brands/Cognac/	id=3	2017-09-05 12:10:11.045663	brands/Cognac/	\N
776	Chrome		/brands/Cognac	id=3	2017-09-05 12:10:11.10223	brands/Cognac	\N
777	Chrome		/brands/Cognac	id=3	2017-09-05 12:10:25.518383	brands/Cognac	\N
778	Chrome		/brands/Cognac	id=3	2017-09-05 12:10:33.161491	brands/Cognac	\N
779	Chrome		/brands/Brandy		2017-09-05 12:10:41.248579	brands/Brandy	\N
780	Chrome		/brands/Brandy		2017-09-05 12:14:44.51206	brands/Brandy	\N
781	Chrome		/brands/Brandy/	id=7	2017-09-05 12:14:48.123341	brands/Brandy/	\N
782	Chrome		/brands/Brandy	id=7	2017-09-05 12:14:48.227099	brands/Brandy	\N
783	Chrome		/brands/Cognac		2017-09-05 12:16:12.178601	brands/Cognac	\N
784	Chrome		/brands/Cognac/	id=1	2017-09-05 12:16:14.835158	brands/Cognac/	\N
785	Chrome		/brands/Cognac	id=1	2017-09-05 12:16:14.902257	brands/Cognac	\N
786	Chrome		/brands/Cognac		2017-09-05 12:21:47.341582	brands/Cognac	\N
787	Chrome		/brands/Cognac/	id=1	2017-09-05 12:22:02.966934	brands/Cognac/	\N
788	Chrome		/brands/Cognac	id=1	2017-09-05 12:22:03.048705	brands/Cognac	\N
789	Chrome		/brands/Brandy		2017-09-05 12:22:06.625111	brands/Brandy	\N
790	Chrome		/brands/Brandy/	id=7	2017-09-05 12:22:09.056481	brands/Brandy/	\N
791	Chrome		/brands/Brandy	id=7	2017-09-05 12:22:09.140776	brands/Brandy	\N
896	Chrome		/login		2017-10-03 11:57:38.118126	login	\N
792	Chrome		/brands/Brandy	id=7	2017-09-05 12:23:49.178825	brands/Brandy	\N
793	Chrome		/brands/Brandy	id=7	2017-09-05 12:28:58.412445	brands/Brandy	\N
794	Chrome		/brands/Brandy	id=7	2017-09-05 12:29:11.605883	brands/Brandy	\N
795	Chrome		/brands/Brandy	id=7	2017-09-05 12:29:29.623837	brands/Brandy	\N
796	Chrome		/brands/Brandy	id=7	2017-09-05 12:30:55.836319	brands/Brandy	\N
797	Chrome		/error		2017-09-05 12:31:07.825864	error	\N
798	Chrome		/error		2017-09-05 12:45:09.111729	error	\N
799	Chrome		/brands/Brandy	id=7	2017-09-05 15:23:01.634161	brands/Brandy	\N
800	Chrome		/brands/Cognac		2017-09-05 15:23:06.077724	brands/Cognac	\N
801	Chrome		/brands/Cognac/	id=1	2017-09-05 15:23:10.401061	brands/Cognac/	\N
802	Chrome		/brands/Cognac	id=1	2017-09-05 15:23:10.591614	brands/Cognac	\N
803	Chrome		/brands/Cognac		2017-09-05 15:23:13.676906	brands/Cognac	\N
804	Chrome		/brands/Cognac/	id=3	2017-09-05 15:23:16.160392	brands/Cognac/	\N
805	Chrome		/brands/Cognac	id=3	2017-09-05 15:23:16.238465	brands/Cognac	\N
806	Chrome		/brands/Cognac	id=3	2017-09-05 15:25:41.921102	brands/Cognac	\N
807	Chrome		/brands/Brandy		2017-09-05 15:25:43.802169	brands/Brandy	\N
808	Chrome		/brands/Brandy/	id=8	2017-09-05 15:25:46.491576	brands/Brandy/	\N
809	Chrome		/brands/Brandy	id=8	2017-09-05 15:25:46.56483	brands/Brandy	\N
810	Chrome		/		2017-09-05 15:30:02.381841	home	\N
811	Chrome		/		2017-09-05 15:30:25.889626	home	\N
812	Chrome	\N	/		2017-09-06 10:01:30.256394	home	\N
813	Chrome	\N	/		2017-09-06 10:14:23.223646	home	\N
814	Chrome	\N	/		2017-09-25 08:45:57.428498	home	\N
815	Chrome		/brands/Brandy		2017-09-25 08:46:02.076939	brands/Brandy	\N
816	Chrome		/brands/Cognac		2017-09-25 08:46:06.36292	brands/Cognac	\N
817	Chrome		/brands/Cognac/	id=1	2017-09-25 08:46:10.588103	brands/Cognac/	\N
818	Chrome		/brands/Cognac	id=1	2017-09-25 08:46:10.683515	brands/Cognac	\N
819	Chrome		/brands/Cognac	id=1	2017-09-25 08:46:18.791293	brands/Cognac	\N
820	Chrome		/brands/Cognac	id=1	2017-09-25 09:03:00.01372	brands/Cognac	\N
821	Chrome		/brands/Cognac	id=1	2017-09-25 09:03:02.012399	brands/Cognac	\N
822	Chrome		/brands/Cognac		2017-09-25 09:10:39.569427	brands/Cognac	\N
823	Chrome		/brands/Cognac/	id=3	2017-09-25 09:11:26.602403	brands/Cognac/	\N
824	Chrome		/brands/Cognac	id=3	2017-09-25 09:11:26.677794	brands/Cognac	\N
825	Chrome		/brands/Cognac		2017-09-25 09:11:36.613878	brands/Cognac	\N
826	Chrome		/brands/Cognac		2017-09-25 09:29:13.625414	brands/Cognac	\N
827	Chrome		/brands/Brandy		2017-09-25 09:29:16.910703	brands/Brandy	\N
828	Chrome		/brands/Brandy/	id=9	2017-09-25 09:29:19.645058	brands/Brandy/	\N
829	Chrome		/brands/Brandy	id=9	2017-09-25 09:29:19.713335	brands/Brandy	\N
830	Chrome		/brands/Brandy	id=9	2017-09-25 09:29:37.044287	brands/Brandy	\N
831	Chrome		/brands/Cognac		2017-09-25 09:29:39.578092	brands/Cognac	\N
832	Chrome	\N	/authenticate/login		2017-09-25 09:39:31.258796	authenticate/login	\N
833	Chrome	\N	/		2017-09-25 09:39:37.372229	home	\N
834	Chrome	\N	/		2017-09-25 09:40:10.690245	home	\N
835	Chrome	\N	/portal/buy		2017-09-25 10:05:29.463982	portal/buy	\N
836	Chrome	\N	/		2017-10-03 08:37:13.423898	home	\N
837	Chrome		/brands/Cognac		2017-10-03 08:37:18.372639	brands/Cognac	\N
838	Chrome		/brands/Cognac/	id=3	2017-10-03 08:37:23.035645	brands/Cognac/	\N
839	Chrome		/brands/Cognac	id=3	2017-10-03 08:37:23.121594	brands/Cognac	\N
840	Chrome		/brands/Cognac	id=3	2017-10-03 08:37:26.423295	brands/Cognac	\N
841	Chrome		/error		2017-10-03 08:38:45.350781	error	\N
842	Chrome	\N	/brands/Cognac	id=3	2017-10-03 10:34:46.926265	brands/Cognac	\N
843	Chrome	\N	/error		2017-10-03 10:34:47.145234	error	\N
844	Chrome	\N	/error		2017-10-03 10:38:34.045716	error	\N
845	Chrome	\N	/		2017-10-03 10:55:30.083057	home	\N
846	Chrome		/brands/Cognac		2017-10-03 10:55:36.678911	brands/Cognac	\N
847	Chrome	\N	/login		2017-10-03 10:56:59.754289	login	\N
848	Chrome	\N	/login		2017-10-03 10:57:44.261681	login	\N
849	Chrome	\N	/login		2017-10-03 10:59:17.86502	login	\N
850	Chrome	\N	/login		2017-10-03 10:59:44.98533	login	\N
851	Chrome		/login		2017-10-03 10:59:46.94983	login	\N
852	Chrome		/login		2017-10-03 10:59:59.064967	login	\N
853	Chrome		/		2017-10-03 11:00:01.166596	home	\N
854	Chrome		/company		2017-10-03 11:00:07.352042	company	\N
855	Chrome	\N	/login		2017-10-03 11:02:03.677684	login	\N
856	Chrome	\N	/login		2017-10-03 11:02:38.016581	login	\N
857	Chrome	\N	/login		2017-10-03 11:02:44.489579	login	\N
858	Chrome		/		2017-10-03 11:02:49.865826	home	\N
859	Chrome		/brands/Cognac		2017-10-03 11:02:52.304351	brands/Cognac	\N
860	Chrome		/login		2017-10-03 11:02:52.374735	login	\N
861	Chrome		/company		2017-10-03 11:02:59.149111	company	\N
862	Chrome		/login		2017-10-03 11:02:59.256735	login	\N
863	Chrome		/contact		2017-10-03 11:03:01.346786	contact	\N
864	Chrome		/login		2017-10-03 11:03:01.436851	login	\N
865	Chrome		/brands/Cognac		2017-10-03 11:03:03.948527	brands/Cognac	\N
866	Chrome		/login		2017-10-03 11:03:04.024531	login	\N
867	Chrome		/news		2017-10-03 11:03:05.588063	news	\N
868	Chrome		/login		2017-10-03 11:03:05.662765	login	\N
869	Chrome		/login		2017-10-03 11:03:49.249168	login	\N
870	Chrome		/login		2017-10-03 11:07:27.321544	login	\N
871	Chrome	\N	/signup		2017-10-03 11:12:34.908723	signup	\N
872	Chrome	\N	/login		2017-10-03 11:12:35.010901	login	\N
873	Chrome	\N	/sign-up		2017-10-03 11:12:54.729164	sign-up	\N
874	Chrome	\N	/sign-up		2017-10-03 11:13:23.735798	sign-up	\N
875	Chrome	\N	/sign-up		2017-10-03 11:13:48.7712	sign-up	\N
876	Chrome	\N	/sign-up		2017-10-03 11:14:38.339876	sign-up	\N
877	Chrome	\N	/sign-up		2017-10-03 11:26:13.443918	sign-up	\N
878	Chrome		/sign-up	name=&email=&password=	2017-10-03 11:36:27.702552	sign-up	\N
879	Chrome		/sign-up	name=&email=&password=	2017-10-03 11:38:23.074359	sign-up	\N
880	Chrome		/sign-up	name=&email=&password=	2017-10-03 11:39:08.509009	sign-up	\N
881	Chrome	\N	/sign-up		2017-10-03 11:39:16.525143	sign-up	\N
882	Chrome		/login		2017-10-03 11:39:39.785731	login	\N
883	Chrome		/login		2017-10-03 11:39:45.744868	login	\N
884	Chrome		/login		2017-10-03 11:40:01.313086	login	\N
885	Chrome		/login		2017-10-03 11:40:53.006166	login	\N
886	Chrome		/login		2017-10-03 11:53:35.553553	login	\N
887	Chrome		/login		2017-10-03 11:54:45.436651	login	\N
888	Chrome		/login		2017-10-03 11:54:47.523358	login	\N
889	Chrome		/login		2017-10-03 11:55:30.004759	login	\N
890	Chrome		/login		2017-10-03 11:55:31.934088	login	\N
891	Chrome		/login		2017-10-03 11:55:34.622084	login	\N
892	Chrome		/login		2017-10-03 11:56:08.583178	login	\N
893	Chrome		/login		2017-10-03 11:56:12.677082	login	\N
894	Chrome		/login		2017-10-03 11:57:20.839903	login	\N
895	Chrome		/login		2017-10-03 11:57:36.645211	login	\N
897	Chrome	\N	/login		2017-10-03 11:58:01.055083	login	\N
898	Chrome		/login		2017-10-03 11:58:03.041139	login	\N
899	Chrome		/login		2017-10-03 11:58:33.942669	login	\N
900	Chrome		/error		2017-10-03 11:58:35.899929	error	\N
901	Chrome		/login		2017-10-03 11:58:39.063792	login	\N
902	Chrome		/login		2017-10-03 11:59:02.589588	login	\N
903	Chrome		/login		2017-10-03 11:59:16.488639	login	\N
904	Chrome		/company		2017-10-03 11:59:21.002531	company	\N
905	Chrome		/login		2017-10-03 11:59:21.086937	login	\N
906	Chrome		/login		2017-10-03 11:59:25.911225	login	\N
907	Chrome		/login		2017-10-03 12:02:04.249987	login	\N
908	Chrome		/company		2017-10-03 12:02:07.132723	company	\N
909	Chrome		/login		2017-10-03 12:02:07.198751	login	\N
910	Chrome		/login		2017-10-03 12:02:26.274323	login	\N
911	Chrome		/news		2017-10-03 12:02:30.096462	news	\N
912	Chrome		/login		2017-10-03 12:02:30.203887	login	\N
913	Chrome		/brands/Cognac		2017-10-03 12:02:36.606993	brands/Cognac	\N
914	Chrome		/login		2017-10-03 12:02:36.684714	login	\N
915	Chrome		/error		2017-10-03 12:24:37.902945	error	\N
916	Chrome		/error		2017-10-03 12:25:59.809015	error	\N
917	Chrome		/error		2017-10-03 12:26:01.118018	error	\N
918	Chrome	\N	/		2017-10-03 12:32:58.107615	home	\N
919	Chrome		/company		2017-10-03 12:34:30.6657	company	\N
920	Chrome		/login		2017-10-03 12:34:30.77718	login	\N
921	Chrome		/login		2017-10-03 12:34:41.744971	login	\N
922	Chrome		/login		2017-10-03 12:51:07.845942	login	\N
923	Chrome		/sign-up		2017-10-03 12:51:12.846285	sign-up	\N
924	Chrome		/sign-up		2017-10-03 12:51:53.299356	sign-up	\N
925	Chrome		/company		2017-10-03 12:51:59.147681	company	\N
926	Chrome		/login		2017-10-03 12:51:59.225112	login	\N
927	Chrome		/login		2017-10-03 13:05:18.983269	login	\N
928	Chrome		/error		2017-10-03 13:14:16.288057	error	\N
929	Chrome		/error		2017-10-03 13:18:49.813292	error	\N
930	Chrome	\N	/error		2017-10-03 13:22:03.472093	error	\N
931	Chrome	\N	/error		2017-10-03 13:23:51.335118	error	\N
932	Chrome	\N	/		2017-10-03 13:28:05.381677	home	\N
933	Chrome		/company		2017-10-03 14:14:45.30765	company	\N
934	Chrome		/login		2017-10-03 14:14:45.392652	login	\N
935	Chrome		/sign-up		2017-10-03 14:14:52.621703	sign-up	\N
936	Chrome		/sign-up		2017-10-03 14:18:15.043293	sign-up	\N
937	Chrome		/sign-up		2017-10-03 14:18:33.163924	sign-up	\N
938	Chrome		/sign-up		2017-10-03 14:18:34.300956	sign-up	\N
939	Chrome		/login		2017-10-03 14:18:46.914525	login	\N
940	Chrome		/sign-up		2017-10-03 14:19:35.159188	sign-up	\N
941	Chrome		/login		2017-10-03 14:20:24.361995	login	\N
942	Chrome		/login		2017-10-03 14:21:15.951705	login	\N
943	Chrome		/login		2017-10-03 14:21:27.587292	login	\N
944	Chrome	\N	/sign-up		2017-10-03 14:22:51.022062	sign-up	\N
945	Chrome	\N	/sign-up		2017-10-03 14:37:51.05097	sign-up	\N
946	Chrome	\N	/sign-up		2017-10-03 14:38:22.448159	sign-up	\N
947	Chrome		/login		2017-10-03 14:38:43.3256	login	\N
948	Chrome	\N	/sign-up		2017-10-03 14:39:01.286284	sign-up	\N
949	Chrome	\N	/sign-up		2017-10-03 14:40:16.672971	sign-up	\N
950	Chrome	\N	/sign-up		2017-10-03 14:40:30.816506	sign-up	\N
951	Chrome	\N	/sign-up		2017-10-03 14:40:32.305864	sign-up	\N
952	Chrome	\N	/sign-up		2017-10-03 14:41:43.884222	sign-up	\N
953	Chrome	\N	/sign-up		2017-10-03 14:41:45.808278	sign-up	\N
954	Chrome	\N	/sign-up		2017-10-03 14:42:06.748474	sign-up	\N
955	Chrome	\N	/sign-up		2017-10-03 14:43:37.025541	sign-up	\N
956	Chrome	\N	/sign-up		2017-10-03 14:44:14.561928	sign-up	\N
957	Chrome	\N	/sign-up		2017-10-03 14:44:27.210354	sign-up	\N
958	Chrome	\N	/sign-up		2017-10-03 14:45:08.620777	sign-up	\N
959	Chrome	\N	/sign-up		2017-10-03 14:45:22.31316	sign-up	\N
960	Chrome	\N	/sign-up		2017-10-03 14:45:23.346846	sign-up	\N
961	Chrome	\N	/sign-up		2017-10-03 14:45:37.208747	sign-up	\N
962	Chrome	\N	/sign-up		2017-10-03 14:45:45.883139	sign-up	\N
963	Chrome	\N	/sign-up		2017-10-03 14:47:08.771084	sign-up	\N
964	Chrome	\N	/sign-up		2017-10-03 14:47:26.184352	sign-up	\N
965	Chrome	\N	/sign-up		2017-10-03 14:47:27.266779	sign-up	\N
966	Chrome	\N	/sign-up		2017-10-03 14:47:42.936806	sign-up	\N
967	Chrome	\N	/sign-up		2017-10-03 14:47:57.709959	sign-up	\N
968	Chrome	\N	/sign-up		2017-10-03 14:48:25.249537	sign-up	\N
969	Chrome	\N	/sign-up		2017-10-03 14:48:45.58323	sign-up	\N
970	Chrome	\N	/sign-up		2017-10-03 14:48:54.23534	sign-up	\N
971	Chrome	\N	/sign-up		2017-10-03 14:49:35.471761	sign-up	\N
972	Chrome	\N	/sign-up		2017-10-03 14:50:22.807928	sign-up	\N
973	Chrome	\N	/sign-up		2017-10-03 14:59:09.035673	sign-up	\N
974	Chrome	\N	/sign-up		2017-10-03 14:59:39.02216	sign-up	\N
975	Chrome	\N	/sign-up		2017-10-03 14:59:47.052922	sign-up	\N
976	Chrome		/login		2017-10-03 15:02:54.122661	login	\N
977	Chrome		/login		2017-10-03 15:03:42.85699	login	\N
978	Chrome		/login		2017-10-03 15:04:07.998608	login	\N
979	Chrome		/login		2017-10-03 15:04:19.406634	login	\N
980	Chrome		/login		2017-10-03 15:04:32.472648	login	\N
981	Chrome		/login		2017-10-03 15:04:48.039013	login	\N
982	Chrome		/login		2017-10-03 15:05:07.73481	login	\N
983	Chrome		/login		2017-10-03 15:05:24.778242	login	\N
984	Chrome		/login		2017-10-03 15:06:01.870471	login	\N
985	Chrome		/login		2017-10-03 15:06:35.517075	login	\N
986	Chrome		/company		2017-10-03 15:07:35.995402	company	\N
987	Chrome		/login		2017-10-03 15:07:36.071042	login	\N
988	Chrome		/sign-up		2017-10-03 15:07:40.168502	sign-up	\N
989	Chrome		/sign-up		2017-10-03 15:07:55.374365	sign-up	\N
990	Chrome		/sign-up		2017-10-03 15:08:29.863166	sign-up	\N
991	Chrome		/sign-up		2017-10-03 15:08:51.692486	sign-up	\N
992	Chrome		/sign-up		2017-10-03 15:09:10.127708	sign-up	\N
993	Chrome		/sign-up		2017-10-03 15:09:18.640672	sign-up	\N
994	Chrome		/sign-up		2017-10-03 15:09:28.296994	sign-up	\N
995	Chrome		/sign-up		2017-10-03 15:32:08.816082	sign-up	\N
996	Chrome		/error		2017-10-03 15:32:34.788365	error	\N
997	Chrome		/sign-up		2017-10-03 15:33:34.870521	sign-up	\N
998	Chrome		/error		2017-10-03 15:33:41.965787	error	\N
999	Chrome		/sign-up		2017-10-03 15:34:28.850119	sign-up	\N
1000	Chrome		/sign-up		2017-10-03 15:34:34.036712	sign-up	\N
1001	Chrome		/sign-up		2017-10-03 15:51:57.680933	sign-up	\N
1002	Chrome		/sign-up		2017-10-03 15:52:26.797616	sign-up	\N
1003	Chrome		/sign-up		2017-10-03 16:01:36.110853	sign-up	\N
1004	Chrome		/sign-up		2017-10-03 16:02:40.484256	sign-up	\N
1005	Chrome		/sign-up		2017-10-03 16:03:07.352927	sign-up	\N
1006	Chrome		/sign-up		2017-10-03 16:03:09.161345	sign-up	\N
1007	Chrome		/sign-up		2017-10-03 16:03:17.451919	sign-up	\N
1008	Chrome		/sign-up		2017-10-03 16:04:10.107841	sign-up	\N
1009	Chrome		/sign-up		2017-10-03 16:04:27.194426	sign-up	\N
1010	Chrome		/sign-up		2017-10-03 16:08:13.655858	sign-up	\N
1011	Chrome		/sign-up		2017-10-03 16:08:50.715122	sign-up	\N
1012	Chrome		/sign-up		2017-10-03 16:09:26.660374	sign-up	\N
1013	Chrome		/sign-up		2017-10-03 16:09:34.606892	sign-up	\N
1014	Chrome		/error		2017-10-03 16:09:52.349224	error	\N
1015	Chrome		/sign-up		2017-10-03 16:19:57.138862	sign-up	\N
1016	Chrome		/error		2017-10-03 16:20:02.592048	error	\N
1017	Chrome		/sign-up		2017-10-03 16:21:09.882464	sign-up	\N
1018	Chrome		/		2017-10-03 16:21:20.396572	home	\N
1019	Chrome		/		2017-10-03 16:45:46.934956	home	\N
1020	Chrome		/		2017-10-03 16:47:19.571801	home	\N
1021	Chrome		/brands/Cognac		2017-10-03 16:47:25.208032	brands/Cognac	\N
1022	Chrome		/login		2017-10-03 16:47:25.289482	login	\N
1023	Chrome		/company		2017-10-03 16:47:27.558834	company	\N
1024	Chrome		/login		2017-10-03 16:47:27.635721	login	\N
1025	Chrome		/sign-up		2017-10-03 16:47:30.494287	sign-up	\N
1026	Chrome		/news		2017-10-03 16:47:44.712703	news	\N
1027	Chrome		/login		2017-10-03 16:47:44.79274	login	\N
1028	Safari		/		2017-10-03 16:51:25.511017	home	\N
1029	Chrome		/company		2017-10-03 16:53:29.682466	company	\N
1030	Chrome		/login		2017-10-03 16:53:29.76706	login	\N
1031	Chrome		/sign-up		2017-10-03 16:53:32.221556	sign-up	\N
1032	Chrome		/login		2017-10-03 16:53:52.001921	login	\N
1033	Chrome	\N	/login		2017-10-04 10:58:06.442808	login	\N
1034	Chrome		/company		2017-10-04 10:58:13.911757	company	\N
1035	Chrome		/login		2017-10-04 10:58:13.98849	login	\N
1036	Chrome		/error		2017-10-04 12:08:56.940087	error	\N
1037	Chrome		/error		2017-10-04 12:10:35.360964	error	\N
1038	Chrome		/error		2017-10-04 12:11:07.586426	error	\N
1039	Chrome		/error		2017-10-04 12:24:20.133831	error	\N
1040	Chrome		/sign-up		2017-10-04 12:52:44.730616	sign-up	\N
1041	Chrome		/login		2017-10-04 13:06:43.81395	login	\N
1042	Chrome		/company		2017-10-04 13:11:04.237336	company	\N
1043	Chrome		/login		2017-10-04 13:11:04.31363	login	\N
1044	Chrome	\N	/login		2017-10-04 13:31:00.534762	login	\N
1045	Chrome		/login		2017-10-04 13:31:03.926658	login	\N
1046	Chrome		/login		2017-10-04 13:31:42.79792	login	\N
1047	Chrome		/login		2017-10-04 13:32:22.435047	login	\N
1048	Chrome		/login		2017-10-04 13:32:45.249091	login	\N
1049	Chrome		/login		2017-10-04 13:33:05.686807	login	\N
1050	Chrome		/login		2017-10-04 13:34:21.924499	login	\N
1051	Chrome		/login		2017-10-04 13:34:26.09812	login	\N
1052	Chrome		/login		2017-10-04 13:35:06.377755	login	\N
1053	Chrome		/login		2017-10-04 13:36:09.133998	login	\N
1054	Chrome		/login		2017-10-04 13:36:38.230183	login	\N
1055	Chrome		/login		2017-10-04 13:39:51.818981	login	\N
1056	Chrome		/login		2017-10-04 13:44:25.893169	login	\N
1057	Chrome		/login		2017-10-04 13:44:29.18347	login	\N
1058	Chrome		/login		2017-10-04 13:46:54.493777	login	\N
1059	Chrome		/login		2017-10-04 13:46:57.397027	login	\N
1060	Chrome		/login		2017-10-04 13:47:24.283694	login	\N
1061	Chrome		/login		2017-10-04 13:48:54.545927	login	\N
1062	Chrome		/login		2017-10-04 13:49:17.326173	login	\N
1063	Chrome		/login		2017-10-04 13:49:32.025211	login	\N
1064	Chrome		/login		2017-10-04 13:49:45.267543	login	\N
1065	Chrome		/login		2017-10-04 13:49:50.843281	login	\N
1066	Chrome		/sign-up		2017-10-04 13:49:54.508327	sign-up	\N
1067	Chrome		/sign-up		2017-10-04 13:50:10.53437	sign-up	\N
1068	Chrome		/sign-up		2017-10-04 13:50:22.484001	sign-up	\N
1069	Chrome		/sign-up		2017-10-04 13:50:28.612141	sign-up	\N
1070	Chrome		/sign-up		2017-10-04 13:51:50.547227	sign-up	\N
1071	Chrome		/company		2017-10-04 13:51:53.105428	company	\N
1072	Chrome		/login		2017-10-04 13:51:53.187985	login	\N
1073	Chrome		/login		2017-10-04 13:52:23.05864	login	\N
1074	Chrome		/login		2017-10-04 13:52:35.44206	login	\N
1075	Chrome		/login		2017-10-04 13:52:56.345701	login	\N
1076	Chrome		/login		2017-10-04 13:53:06.167136	login	\N
1077	Chrome		/login		2017-10-04 13:53:19.821464	login	\N
1078	Chrome		/login		2017-10-04 13:53:28.658249	login	\N
1079	Chrome		/login		2017-10-04 13:53:59.28216	login	\N
1080	Chrome		/login		2017-10-04 13:54:12.254684	login	\N
1081	Chrome		/login		2017-10-04 13:54:25.408155	login	\N
1082	Chrome		/login		2017-10-04 13:54:35.842243	login	\N
1083	Chrome		/login		2017-10-04 13:54:59.943306	login	\N
1084	Chrome		/company		2017-10-04 13:55:05.04885	company	\N
1085	Chrome		/login		2017-10-04 13:55:05.135629	login	\N
1086	Chrome		/login		2017-10-04 13:55:15.75141	login	\N
1087	Chrome	\N	/login		2017-10-04 14:28:10.149109	login	\N
1088	Chrome		/error		2017-10-04 14:31:30.426115	error	\N
1089	Chrome	\N	/login		2017-10-04 14:31:42.588357	login	\N
1090	Chrome		/company		2017-10-04 14:32:37.838371	company	\N
1091	Chrome		/company		2017-10-04 14:32:56.263886	company	\N
1092	Chrome		/brands/Cognac		2017-10-04 14:32:58.136454	brands/Cognac	\N
1093	Chrome		/news		2017-10-04 14:33:02.999423	news	\N
1094	Chrome		/contact		2017-10-04 14:33:11.567152	contact	\N
1095	Chrome	\N	/contact		2017-10-05 08:57:16.916768	contact	\N
1096	Chrome	\N	/login		2017-10-05 08:57:18.005876	login	\N
1097	Chrome		/company		2017-10-05 08:57:41.62733	company	\N
1098	Chrome		/login		2017-10-05 08:57:41.689255	login	\N
1099	Chrome		/company		2017-10-05 08:57:52.677397	company	\N
1100	Chrome		/news		2017-10-05 08:58:10.818401	news	\N
1101	Chrome		/contact		2017-10-05 08:58:14.159822	contact	\N
1102	Chrome		/contact		2017-10-05 09:16:54.261784	contact	\N
1103	Chrome		/contact		2017-10-05 09:17:28.631182	contact	\N
1104	Chrome		/contact		2017-10-05 09:56:00.100254	contact	\N
1105	Chrome		/contact		2017-10-05 10:12:05.929321	contact	\N
1106	Chrome		/contact		2017-10-05 10:18:51.714847	contact	\N
1107	Chrome		/login		2017-10-05 10:18:51.792788	login	\N
1108	Chrome		/login		2017-10-05 10:19:00.260192	login	\N
1109	Chrome		/login		2017-10-05 10:20:18.513887	login	\N
1110	Chrome		/login		2017-10-05 10:20:41.854874	login	\N
1111	Chrome		/login		2017-10-05 10:20:50.725945	login	\N
1112	Chrome		/login		2017-10-05 10:54:07.041943	login	\N
1113	Chrome		/company		2017-10-05 10:54:09.588737	company	\N
1114	Chrome		/login		2017-10-05 10:54:09.672649	login	\N
1115	Chrome		/company		2017-10-05 10:54:21.647271	company	\N
1116	Chrome		/login		2017-10-05 10:54:21.733934	login	\N
1117	Chrome		/brands/Cognac		2017-10-05 10:54:27.327271	brands/Cognac	\N
1118	Chrome		/login		2017-10-05 10:54:27.411462	login	\N
1119	Chrome		/brands/Cognac		2017-10-05 10:54:36.25048	brands/Cognac	\N
1120	Chrome		/brands/Cognac/	id=1	2017-10-05 10:54:41.962668	brands/Cognac/	\N
1121	Chrome		/brands/Cognac	id=1	2017-10-05 10:54:42.074263	brands/Cognac	\N
1122	Chrome		/error		2017-10-05 11:05:06.273768	error	\N
1123	Chrome		/error		2017-10-05 11:28:50.997161	error	\N
1124	Chrome		/error		2017-10-05 12:01:07.426128	error	\N
1125	Chrome		/error		2017-10-05 12:02:57.876672	error	\N
1126	Chrome		/news		2017-10-05 14:04:38.352387	news	\N
1127	Chrome		/login		2017-10-05 14:04:38.444218	login	\N
1128	Chrome		/sign-up		2017-10-05 14:04:43.148781	sign-up	\N
1129	Chrome		/error		2017-10-05 14:05:11.720359	error	\N
1130	Chrome		/sign-up		2017-10-05 14:05:14.84692	sign-up	\N
1131	Chrome		/error		2017-10-05 14:05:58.241111	error	\N
1132	Chrome		/sign-up		2017-10-05 14:06:01.630233	sign-up	\N
1133	Chrome		/		2017-10-05 14:07:14.370435	home	\N
1134	Chrome		/company		2017-10-05 14:09:18.153128	company	\N
1135	Chrome		/login		2017-10-05 14:09:18.233179	login	\N
1136	Chrome		/company		2017-10-05 14:09:21.567598	company	\N
1137	Chrome		/login		2017-10-05 14:09:21.658433	login	\N
1138	Chrome		/sign-up		2017-10-05 14:09:27.997818	sign-up	\N
1139	Chrome		/		2017-10-05 14:10:03.668774	home	\N
1140	Chrome		/company		2017-10-05 14:10:11.933725	company	\N
1141	Chrome		/login		2017-10-05 14:10:12.021447	login	\N
1142	Chrome		/sign-up		2017-10-05 14:15:53.761857	sign-up	\N
1143	Chrome		/		2017-10-05 14:16:18.608946	home	\N
1144	Chrome		/company		2017-10-05 14:30:30.492375	company	\N
1145	Chrome		/login		2017-10-05 14:30:30.577433	login	\N
1146	Chrome		/sign-up		2017-10-05 14:30:32.341532	sign-up	\N
1147	Chrome		/sign-up		2017-10-05 14:34:51.208209	sign-up	\N
1148	Chrome		/		2017-10-05 14:35:21.425317	home	\N
1149	Chrome		/error		2017-10-05 16:37:38.455727	error	\N
1150	Chrome		/error		2017-10-05 16:38:44.34685	error	\N
1151	Chrome		/error		2017-10-05 16:40:04.930546	error	\N
1152	Chrome		/error		2017-10-05 16:40:16.005862	error	\N
1153	Chrome		/company		2017-10-05 17:16:02.74698	company	\N
1154	Chrome		/login		2017-10-05 17:16:02.900489	login	\N
1155	Chrome	\N	/login		2017-10-06 10:00:39.833257	login	\N
1156	Chrome	\N	/login		2017-10-06 10:00:59.952456	login	\N
1157	Chrome		/company		2017-10-06 10:01:02.548104	company	\N
1158	Chrome	\N	/login		2017-10-06 10:02:51.656458	login	\N
1159	Chrome	\N	/login		2017-10-06 10:22:22.242464	login	\N
1160	Chrome		/login		2017-10-06 10:23:13.924921	login	\N
1161	Chrome		/login		2017-10-06 10:23:42.910645	login	\N
1162	Chrome		/login		2017-10-06 10:27:36.476303	login	\N
1163	Chrome		/		2017-10-06 10:27:44.681142	home	\N
1164	Chrome		/contact		2017-10-06 10:27:53.710883	contact	\N
1165	Chrome		/contact		2017-10-06 11:31:01.394648	contact	\N
1166	Chrome		/login		2017-10-06 11:31:01.476657	login	\N
1167	Chrome		/contact		2017-10-06 11:31:19.759973	contact	\N
1168	Chrome		/contact		2017-10-06 11:31:55.631701	contact	\N
1169	Chrome		/contact		2017-10-06 11:31:57.835841	contact	\N
1170	Chrome		/contact		2017-10-06 11:32:05.220639	contact	\N
1171	Chrome		/contact		2017-10-06 11:33:26.807033	contact	\N
1172	Chrome		/contact		2017-10-06 11:34:28.671413	contact	\N
1173	Chrome		/contact		2017-10-06 11:34:30.647176	contact	\N
1174	Chrome		/contact		2017-10-06 11:36:25.277754	contact	\N
1175	Chrome		/contact		2017-10-06 11:37:49.045018	contact	\N
1176	Chrome		/contact		2017-10-06 11:37:50.782168	contact	\N
1177	Chrome		/contact		2017-10-06 11:39:01.882358	contact	\N
1178	Chrome		/contact		2017-10-06 11:39:21.939109	contact	\N
1179	Chrome		/contact		2017-10-06 11:39:42.203085	contact	\N
1180	Chrome		/contact		2017-10-06 11:41:26.94977	contact	\N
1181	Chrome		/contact		2017-10-06 11:41:28.146281	contact	\N
1182	Chrome		/contact		2017-10-06 11:41:30.209957	contact	\N
1183	Chrome		/contact		2017-10-06 11:43:35.370018	contact	\N
1184	Chrome		/contact		2017-10-06 11:47:36.601296	contact	\N
1185	Chrome		/contact		2017-10-06 11:51:10.70116	contact	\N
1186	Chrome	\N	/		2017-10-06 12:15:41.415637	home	\N
1187	Chrome		/brands/Cognac		2017-10-06 12:15:45.774863	brands/Cognac	\N
1188	Chrome		/brands/Cognac/	id=3	2017-10-06 12:15:49.581896	brands/Cognac/	\N
1189	Chrome		/brands/Cognac	id=3	2017-10-06 12:15:49.714241	brands/Cognac	\N
1190	Chrome		/news		2017-10-06 12:16:00.548165	news	\N
1191	Chrome		/news		2017-10-06 12:17:37.819768	news	\N
1192	Chrome		/single-blog/		2017-10-06 12:17:40.931918	single-blog/	\N
1193	Chrome		/single-blog		2017-10-06 12:17:41.002595	single-blog	\N
1194	Chrome		/news		2017-10-06 12:23:04.993014	news	\N
1195	Chrome		/single-blog/		2017-10-06 12:23:47.488006	single-blog/	\N
1196	Chrome		/single-blog		2017-10-06 12:23:47.563215	single-blog	\N
1197	Chrome		/news		2017-10-06 13:30:56.166972	news	\N
1198	Chrome		/login		2017-10-06 13:30:56.271515	login	\N
1199	Chrome		/news		2017-10-06 13:31:03.247097	news	\N
1200	Chrome		/single-blog/		2017-10-06 13:31:08.702422	single-blog/	\N
1201	Chrome		/single-blog		2017-10-06 13:31:08.769091	single-blog	\N
1202	Chrome		/news		2017-10-06 13:31:15.455411	news	\N
1203	Chrome		/single-blog/		2017-10-06 13:31:22.911225	single-blog/	\N
1204	Chrome		/single-blog		2017-10-06 13:31:22.998936	single-blog	\N
1205	Chrome		/news		2017-10-06 13:33:22.058125	news	\N
1206	Chrome		/error		2017-10-06 13:41:29.940385	error	\N
1207	Chrome		/login		2017-10-06 13:41:33.047308	login	\N
1208	Chrome		/news		2017-10-06 13:51:38.651938	news	\N
1209	Chrome		/blog/remy-martins-announces-microsoft-holollen-again		2017-10-06 13:51:57.372291	blog/remy-martins-announces-microsoft-holollen-again	\N
1210	Chrome	\N	/news		2017-10-06 13:53:40.86763	news	\N
1211	Chrome	\N	/news		2017-10-06 13:54:48.199911	news	\N
1212	Chrome	\N	/news		2017-10-06 13:55:36.149632	news	\N
1213	Chrome		/news		2017-10-06 13:55:39.461186	news	\N
1214	Chrome		/news		2017-10-06 13:57:05.108321	news	\N
1215	Chrome		/old-news		2017-10-06 13:57:06.183067	old-news	\N
1216	Chrome		/single-blog/		2017-10-06 14:33:23.454632	single-blog/	\N
1217	Chrome		/single-blog		2017-10-06 14:33:23.561127	single-blog	\N
1218	Chrome		/single-blog		2017-10-06 14:41:57.607853	single-blog	\N
1219	Chrome		/error		2017-10-06 14:42:03.263723	error	\N
1220	Chrome		/single-blog		2017-10-06 14:42:09.552709	single-blog	\N
1221	Chrome		/error		2017-10-06 14:42:36.94138	error	\N
1222	Chrome		/single-blog		2017-10-06 14:42:39.577051	single-blog	\N
1223	Chrome		/error		2017-10-06 14:42:51.225729	error	\N
1224	Chrome		/single-blog		2017-10-06 14:42:52.863741	single-blog	\N
1225	Chrome		/error		2017-10-06 14:43:02.059162	error	\N
1226	Chrome		/single-blog		2017-10-06 14:43:03.519875	single-blog	\N
1227	Chrome		/single-blog		2017-10-06 14:43:22.456799	single-blog	\N
1228	Chrome		/news		2017-10-06 14:43:24.61675	news	\N
1229	Chrome		/news		2017-10-06 14:43:50.862727	news	\N
1230	Chrome		/news		2017-10-06 14:44:42.437033	news	\N
1231	Chrome		/news		2017-10-06 14:45:11.870691	news	\N
1232	Chrome		/old-news		2017-10-06 14:45:42.76847	old-news	\N
1233	Chrome		/news		2017-10-06 14:45:55.880593	news	\N
1234	Chrome		/news		2017-10-06 14:46:44.085597	news	\N
1235	Chrome		/news		2017-10-06 14:47:07.020901	news	\N
1236	Chrome		/news		2017-10-06 14:49:31.67967	news	\N
1237	Chrome		/news		2017-10-06 14:50:03.015683	news	\N
1238	Chrome		/error		2017-10-06 15:07:21.416941	error	\N
1239	Chrome		/old-news		2017-10-06 15:07:33.170359	old-news	\N
1240	Chrome		/news		2017-10-06 15:09:17.293531	news	\N
1241	Chrome		/error		2017-10-06 15:13:32.652009	error	\N
1242	Chrome		/old-news		2017-10-06 15:17:06.605723	old-news	\N
1243	Chrome		/error		2017-10-06 15:17:08.848957	error	\N
1244	Chrome		/old-news		2017-10-06 15:17:30.319364	old-news	\N
1245	Chrome		/news		2017-10-06 15:17:32.407642	news	\N
1246	Chrome		/news		2017-10-06 15:17:56.933177	news	\N
1247	Chrome		/news		2017-10-06 15:21:55.697787	news	\N
1248	Chrome		/news		2017-10-06 15:21:57.404963	news	\N
1249	Chrome		/news		2017-10-06 15:21:58.934966	news	\N
1250	Chrome		/news		2017-10-06 15:22:29.592763	news	\N
1251	Chrome		/news		2017-10-06 15:22:30.923668	news	\N
1252	Chrome		/news		2017-10-06 15:24:47.168377	news	\N
1253	Chrome		/news		2017-10-06 15:24:48.479247	news	\N
1254	Chrome		/news		2017-10-06 15:25:34.209245	news	\N
1255	Chrome		/news		2017-10-06 15:26:34.39605	news	\N
1256	Chrome		/news		2017-10-06 15:26:35.447106	news	\N
1257	Chrome		/news		2017-10-06 15:27:23.650205	news	\N
1258	Chrome		/news		2017-10-06 16:11:53.236541	news	\N
1259	Chrome		/login		2017-10-06 16:11:53.33207	login	\N
1260	Chrome		/brands/Cognac		2017-10-06 16:11:57.036606	brands/Cognac	\N
1261	Chrome		/login		2017-10-06 16:11:57.126618	login	\N
1262	Chrome		/news		2017-10-06 16:11:58.311769	news	\N
1263	Chrome		/login		2017-10-06 16:11:58.453865	login	\N
1264	Chrome		/news		2017-10-06 16:12:04.385162	news	\N
1265	Chrome		/news		2017-10-06 16:14:17.824721	news	\N
1266	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:14:33.083041	blog/remy-martins-announces-microsoft-holollens	\N
1267	Chrome		/old-news		2017-10-06 16:19:10.450606	old-news	\N
1268	Chrome		/single-blog/		2017-10-06 16:19:13.071301	single-blog/	\N
1269	Chrome		/single-blog		2017-10-06 16:19:13.147933	single-blog	\N
1270	Chrome		/contact		2017-10-06 16:27:58.099859	contact	\N
1271	Chrome		/news		2017-10-06 16:27:59.095701	news	\N
1272	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:28:02.031966	blog/remy-martins-announces-microsoft-holollens	\N
1273	Chrome		/news		2017-10-06 16:28:12.458099	news	\N
1274	Chrome		/news		2017-10-06 16:28:36.882701	news	\N
1275	Chrome		/blog/remy-martins-announces-microsoft-holollen-again		2017-10-06 16:28:48.400642	blog/remy-martins-announces-microsoft-holollen-again	\N
1276	Chrome		/news		2017-10-06 16:29:16.174743	news	\N
1277	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:29:36.547164	blog/remy-martins-announces-microsoft-holollens	\N
1278	Chrome		/old-news		2017-10-06 16:30:17.728573	old-news	\N
1279	Chrome		/single-blog/		2017-10-06 16:30:20.175646	single-blog/	\N
1280	Chrome		/single-blog		2017-10-06 16:30:20.245829	single-blog	\N
1281	Chrome		/single-blog		2017-10-06 16:31:02.217145	single-blog	\N
1282	Chrome		/old-news		2017-10-06 16:31:06.933025	old-news	\N
1283	Chrome		/old-news		2017-10-06 16:31:31.918927	old-news	\N
1284	Chrome		/single-blog/		2017-10-06 16:31:33.857361	single-blog/	\N
1285	Chrome		/single-blog		2017-10-06 16:31:33.917569	single-blog	\N
1286	Chrome		/old-news		2017-10-06 16:31:37.10046	old-news	\N
1287	Chrome		/single-blog/		2017-10-06 16:31:46.202242	single-blog/	\N
1288	Chrome		/single-blog		2017-10-06 16:31:46.284767	single-blog	\N
1289	Chrome		/old-news		2017-10-06 16:31:50.177046	old-news	\N
1290	Chrome		/news		2017-10-06 16:32:08.636986	news	\N
1291	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:32:14.608072	blog/remy-martins-announces-microsoft-holollens	\N
1292	Chrome		/news		2017-10-06 16:32:18.020322	news	\N
1293	Chrome		/blog/remy-martins-announces-microsoft-holollen-again		2017-10-06 16:32:19.465697	blog/remy-martins-announces-microsoft-holollen-again	\N
1294	Chrome		/blog/remy-martins-announces-microsoft-holollen-again		2017-10-06 16:34:33.233412	blog/remy-martins-announces-microsoft-holollen-again	\N
1295	Chrome		/news		2017-10-06 16:34:36.071136	news	\N
1296	Chrome		/news		2017-10-06 16:34:43.60609	news	\N
1297	Chrome		/blog/remy-martins-announces-microsoft-holollen-again		2017-10-06 16:34:51.607357	blog/remy-martins-announces-microsoft-holollen-again	\N
1298	Chrome		/news		2017-10-06 16:34:54.166827	news	\N
1299	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:34:55.515799	blog/remy-martins-announces-microsoft-holollens	\N
1300	Chrome		/news		2017-10-06 16:35:24.416161	news	\N
1301	Chrome		/company		2017-10-06 16:35:32.527132	company	\N
1302	Chrome		/news		2017-10-06 16:36:49.154819	news	\N
1303	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:36:54.995845	blog/remy-martins-announces-microsoft-holollens	\N
1304	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:40:59.794864	blog/remy-martins-announces-microsoft-holollens	\N
1305	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:41:25.413454	blog/remy-martins-announces-microsoft-holollens	\N
1306	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:41:48.083657	blog/remy-martins-announces-microsoft-holollens	\N
1307	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:42:39.524556	blog/remy-martins-announces-microsoft-holollens	\N
1308	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:43:15.431325	blog/remy-martins-announces-microsoft-holollens	\N
1309	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:44:28.852597	blog/remy-martins-announces-microsoft-holollens	\N
1310	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:44:41.22359	blog/remy-martins-announces-microsoft-holollens	\N
1311	Chrome		/blog/remy-martins-announces-microsoft-holollens		2017-10-06 16:44:59.131666	blog/remy-martins-announces-microsoft-holollens	\N
1312	Chrome		/news		2017-10-06 16:46:09.50532	news	\N
1313	Chrome		/news		2017-10-06 16:46:15.647192	news	\N
1314	Chrome		/news		2017-10-06 16:56:09.573791	news	\N
1315	Chrome		/news		2017-10-06 16:57:40.572217	news	\N
1316	Chrome		/contact		2017-10-06 16:57:43.668827	contact	\N
1317	Chrome		/contact		2017-10-06 16:58:50.102055	contact	\N
1318	Chrome		/contact		2017-10-06 17:12:30.642869	contact	\N
1319	Chrome		/contact		2017-10-06 17:21:57.728347	contact	\N
1320	Chrome		/contact		2017-10-06 17:22:27.353349	contact	\N
1321	Chrome		/		2017-10-06 17:22:29.350609	home	\N
1322	Chrome		/		2017-10-06 17:23:49.222107	home	\N
1323	Chrome		/		2017-10-06 17:26:15.46251	home	\N
1324	Chrome		/		2017-10-06 17:28:18.645393	home	\N
1325	Chrome		/		2017-10-06 17:29:07.016476	home	\N
1326	Chrome		/		2017-10-06 17:29:34.569343	home	\N
1327	Chrome		/		2017-10-06 17:31:04.370898	home	\N
1328	Chrome		/		2017-10-06 17:36:30.890173	home	\N
1329	Chrome		/company		2017-10-06 17:36:42.676581	company	\N
1330	Chrome		/		2017-10-06 17:38:44.657204	home	\N
1331	Chrome		/		2017-10-06 17:39:10.812443	home	\N
1332	Chrome		/		2017-10-06 17:39:31.800253	home	\N
1333	Chrome		/		2017-10-06 17:40:07.35474	home	\N
1334	Chrome		/contact		2017-10-06 17:40:12.229849	contact	\N
1335	Chrome		/contact		2017-10-06 17:40:33.166107	contact	\N
1336	Chrome		/news		2017-10-06 17:40:36.493047	news	\N
1337	Chrome		/contact		2017-10-06 17:40:37.720842	contact	\N
\.


--
-- Name: analytic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('analytic_id_seq', 1337, true);


--
-- Data for Name: blog_category; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY blog_category (id, name) FROM stdin;
1	general
\.


--
-- Name: blog_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('blog_category_id_seq', 1, true);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY category (id, name) FROM stdin;
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('category_id_seq', 1, false);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY comment (id, user_id, post_id, content, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('comment_id_seq', 1, false);


--
-- Data for Name: comment_users; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY comment_users (id, name, email, created_at) FROM stdin;
\.


--
-- Name: comment_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('comment_users_id_seq', 1, false);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY country (id, name) FROM stdin;
\.


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('country_id_seq', 1, false);


--
-- Data for Name: file; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY file (id, url, name, size, type, created_at, updated_at) FROM stdin;
1	blv0zQ18001a83116d6f.png	johnny-walker	40.41kB	png	2017-08-14 13:40:01.093745	2017-08-14 13:40:01.093745
3	wsxvgN7738416c82d554.jpg	our_heritage	39.55kB	jpeg	2017-08-16 09:56:24.185872	2017-08-16 09:56:24.185872
4	u026gB8017021aa6206a.png	jack_daniels	25.52kB	png	2017-08-16 10:42:50.401657	2017-08-16 10:42:50.401657
5	pf84aD8019821c665dbb.png	glen-fiddich	19.52kB	png	2017-08-16 10:43:18.417327	2017-08-16 10:43:18.417327
6	is3h9A80860245c858f4.png	courvoisier	18.21kB	png	2017-08-16 10:54:20.547244	2017-08-16 10:54:20.547244
8	zm4h1Q80926249e9176c.jpg	brand_building1	166.12kB	jpeg	2017-08-16 10:55:26.596	2017-08-16 10:55:26.596
9	33jv0Y8094924b58a116.jpg	brand_building2	203.30kB	jpeg	2017-08-16 10:55:49.56565	2017-08-16 10:55:49.56565
10	ynos4Z906714aaf42cd1.jpg	slider1	72.72kB	jpeg	2017-08-16 13:37:51.274325	2017-08-16 13:37:51.274325
11	dlrnyW906954ac7df902.jpg	slider2	72.72kB	jpeg	2017-08-16 13:38:15.916363	2017-08-16 13:38:15.916363
12	iblioU907104ad6cdc66.jpg	slider3	72.72kB	jpeg	2017-08-16 13:38:30.845475	2017-08-16 13:38:30.845475
13	j1ytvO588855525b271b.jpg	company_slogan	248.94kB	jpeg	2017-08-17 08:34:45.731126	2017-08-17 08:34:45.731126
14	66q29R654196eab4d38a.jpg	remy-ma	40.27kB	jpeg	2017-08-17 10:23:39.316415	2017-08-17 10:23:39.316415
15	h60t8K654606ed4e361a.jpg	johnny_walker_news	31.72kB	jpeg	2017-08-17 10:24:20.931465	2017-08-17 10:24:20.931465
16	dvn9wJ53668c7642eefd.png	drink-jack-daniels	92.90kB	png	2017-08-18 10:54:28.192441	2017-08-18 10:54:28.192441
17	3ix5uE53707c78ba9757.png	drink-remy-martin	74.26kB	png	2017-08-18 10:55:07.694255	2017-08-18 10:55:07.694255
18	ki3wdD53833c809169c2.png	drink-glenfiddich	71.56kB	png	2017-08-18 10:57:13.092726	2017-08-18 10:57:13.092726
20	z0i0wV68432a230a60ae.png	big-remy	327.09kB	png	2017-08-24 09:53:52.68028	2017-08-24 09:53:52.68028
21	7355nV52695eb5717e05.jpg	remy-single-post	111.48kB	jpeg	2017-08-25 09:18:15.098004	2017-08-25 09:18:15.098004
23	big-remf8ih6L96526b10eaacc3.png	vsop-8743	327.09kB	png	2017-08-30 13:35:26.69971	2017-08-30 13:35:26.69971
24	remy-maralc6D02026c68a3cf65.png	1738	74.26kB	png	2017-08-30 15:07:06.282612	2017-08-30 15:07:06.282612
25	jack-daok29gD02496c8606fb94.png	xo-excellence	92.90kB	png	2017-08-30 15:14:56.457746	2017-08-30 15:14:56.457746
26	xo2.pngqdvndP10077871dbadc7.png	xo	399.04kB	png	2017-09-05 12:14:37.765603	2017-09-05 12:14:37.765603
28	ki3wdD5qkn80U28148be541850b.png	test-image	71.56kB	png	2017-09-25 09:29:08.099856	2017-09-25 09:29:08.099856
19	xs2vuK08003b1e3ae728.png	ledrop-logo	5.80kB	png	2017-08-18 15:27:41.954946	2017-10-06 17:40:03.715069
\.


--
-- Name: file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('file_id_seq', 28, true);


--
-- Data for Name: file_widget; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY file_widget (id, file_id, widget_id) FROM stdin;
1	1	2
2	2	4
11	3	6
20	1	7
21	4	7
22	5	7
23	7	7
24	6	7
30	8	9
31	9	9
34	9	10
35	10	11
36	11	11
37	12	11
39	13	13
47	17	23
50	16	22
51	18	24
53	13	12
56	20	26
57	21	31
58	19	25
\.


--
-- Name: file_widget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('file_widget_id_seq', 58, true);


--
-- Data for Name: goose_db_version; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY goose_db_version (id, version_id, is_applied, tstamp) FROM stdin;
1	0	t	2017-08-11 08:42:23.737922
2	20170310213225	t	2017-08-11 09:06:38.825006
\.


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('goose_db_version_id_seq', 2, true);


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY menu (id, label, name, page_id, url, pos, is_visible) FROM stdin;
2	company	company	2		1	1
6	brands	our brands	3		2	1
7	news	news	11		4	1
9	contact	contact	12		3	1
\.


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('menu_id_seq', 9, true);


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY message (id, type, content, created_at) FROM stdin;
4	access-revoked	hello {{user}}, \r\n\r\nYour full access to ledrop.com site has been revoked.\r\n\r\nThis may be due to the following reasons:\r\n a. You have not used your account for close to a year.\r\n\r\nYou can request send us an email for a new request at anytime.\r\n\r\nRegard	2017-10-05 16:05:51.409465
3	admin-alert	Hello admin,\r\n\r\nA new request for access has been sent by {{user}}. \r\n\r\nPlease attend to this urgently.	2017-10-05 14:23:12.666116
2	access-granted	Hello {{user}}, \r\n\r\nYou have been granted access to full content on our website ( ledrop.com ) \r\nYou can now login.\r\n\r\nRegard\r\n	2017-10-05 12:07:43.832908
1	welcome	Hello {{user}}, \r\n\r\nThank you for your interest in knowing more about us.\r\n\r\nYour request for access has been received, you would get a notification when your request is processed.\r\n\r\nRegards.	2017-10-05 11:55:43.440164
\.


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('message_id_seq', 4, true);


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY page (id, title, url, content, published_at, is_published, seo_description, seo_keywords, is_index, type, template, created_at, updated_at) FROM stdin;
1	home	home	<p>We are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa.</p>\r\n\r\n<p>The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n	2017-08-11 00:00:00	t			1	1	1	2017-08-18 10:43:26.826998	2017-08-18 10:43:26.826998
2	company	company	<p>few compulsory words</p>\r\n	2017-08-11 00:00:00	t			0	0	6	2017-08-22 15:37:23.047295	2017-08-22 15:37:23.047295
3	brands	brands	<p>insert content</p>\r\n	2017-08-14 00:00:00	t			0	0	7	2017-08-22 15:37:46.823281	2017-08-22 15:37:46.823281
7	terms_conditions	terms_conditions	<p>insert content</p>\r\n	2017-08-24 00:00:00	t			0	0	11	2017-08-25 09:49:20.093399	2017-08-25 09:49:20.093399
8	portfolio	portfolio	<p>insert content</p>\r\n	2017-08-24 00:00:00	t			0	0	12	2017-08-25 09:51:56.253454	2017-08-25 09:51:56.253454
10	login	login	<p>insert</p>\r\n	2017-08-25 00:00:00	t			0	0	14	2017-08-25 10:00:39.07289	2017-08-25 10:00:39.07289
6	drink	drink	<p>insert content</p>\r\n	2017-08-24 00:00:00	t			0	0	10	2017-08-28 09:52:07.176011	2017-08-28 09:52:07.176011
11	news	news	<p>news</p>\r\n	2017-10-06 00:00:00	t	Ledrop news section		0	0	4	2017-10-06 16:55:54.339618	2017-10-06 16:55:54.339618
12	contact	contact	<p>contact details</p>\r\n	2017-10-06 00:00:00	t			0	0	9	2017-10-06 17:01:48.974683	2017-10-06 17:01:48.974683
\.


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('page_id_seq', 12, true);


--
-- Data for Name: page_widget; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY page_widget (id, page_id, widget_id) FROM stdin;
108	9	31
109	9	20
110	7	27
111	7	20
112	8	28
113	8	29
114	8	30
115	8	20
116	10	20
117	6	26
118	6	20
58	1	6
59	1	7
60	1	9
61	1	10
62	1	11
63	1	19
64	1	20
65	1	21
82	2	12
83	2	13
84	2	14
85	2	19
86	2	20
87	3	1
88	3	21
89	3	22
90	3	23
91	3	24
92	3	19
93	3	20
94	5	15
95	5	16
96	5	19
97	5	20
119	4	17
120	4	18
121	4	19
122	4	20
124	12	16
125	12	19
126	12	20
\.


--
-- Name: page_widget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('page_widget_id_seq', 126, true);


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY post (id, title, url, content, category_id, author_id, published_date, seo_keywords, seo_description, created_at, updated_at, is_published) FROM stdin;
3	REMY MARTINS ANNOUNCES MICROSOFT HOLOLLENS THRID TIME	remy-martins-announces-microsoft-holollens-thrid-time	<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa. The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n\r\n<p>&nbsp;</p>\r\n	1	1	2017-10-06 00:00:00			2017-10-06 14:45:51.082731	2017-10-06 14:45:51.082731	t
2	REMY MARTINS ANNOUNCES MICROSOFT HOLOLLEN AGAIN	remy-martins-announces-microsoft-holollen-again	<p><img alt="" height="288" src="/uploads/files/h60t8K654606ed4e361a.jpg" width="443" /></p>\r\n\r\n<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa. The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img alt="" height="266" src="/uploads/files/wsxvgN7738416c82d554.jpg" width="466" /></p>\r\n\r\n<p>&nbsp;</p>\r\n	1	1	2017-10-06 00:00:00			2017-10-06 13:32:54.699002	2017-10-06 16:31:28.805397	t
1	REMY MARTINS ANNOUNCES MICROSOFT HOLOLLENS	remy-martins-announces-microsoft-holollens	<p><img alt="" height="306" src="/uploads/files/66q29R654196eab4d38a.jpg" width="471" /></p>\r\n\r\n<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa. The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n\r\n<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa. The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n\r\n<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa. The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n	1	1	2017-10-06 00:00:00			2017-10-06 13:17:40.016369	2017-10-06 16:44:53.841242	t
\.


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('post_id_seq', 3, true);


--
-- Data for Name: post_tag; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY post_tag (post_id, tag_id) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY product (id, name, model, product_category_id, file_id, created_at, content) FROM stdin;
1	Remy Martin	VSOP	1	23	2017-08-30 13:35:26.69971	Dominant notes of vanilla thanks to longer ageing in French Limousin oak barrels, followed by ripe apricot, baked apple, and an elegant floral note.\r\n\r\nA perfect harmony between the firm character of ripe fruit and subtle notes of liquorice, offering a great complexity of elegant and powerful aromas.\r\nWell-balanced, structured, and multi-layered, it combines the roundness of ripe fruit with a silky texture.\r\n\r\n            \r\n            \r\n            \r\n            \r\n            \r\n            \r\n            \r\n            
3	Remy Martin	XO Excellence	1	25	2017-08-30 15:14:56.457746	In 1927, Rémy Martin’s Cellar Master André Renaud created the very first VSOP Fine Champagne—a truly visionary and audacious decision. This prestigious appellation would be officially recognized 11 years later as an AOC (Appellation d’Origine Contrôlée - a specific growing area protected by French law).\r\nIn 2010, Rémy Martin VSOP Fine Champagne Cognac won a gold medal at the Spirits Business Cognac Masters (UK).\r\n            
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY product_category (id, name) FROM stdin;
1	Cognac
5	Brandy
\.


--
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('product_category_id_seq', 5, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('product_id_seq', 9, true);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY role (id, name) FROM stdin;
1	super
2	admin
3	staff
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY settings (id, name, title, setting) FROM stdin;
1	smtp	smtp	{"host":"smtp.mailtrap.io", "port": "25", "username": "ff3215f925e8cc", "password": "c4cf6b1e7ff683"}
2	dispatcher	dispatcher	willpoint@gmail.com
4	email	\N	{"sender_email":"willpoint@gmail.com","sender_name":"Ledrop"}
5	mailgun	\N	{"api_key":"key-4d4ba8140dfaf401b9160d6edf8f3270","secret":"sandboxd04b181d1a244fd590c628c5013e21ff.mailgun.org"}
3	timeout	timeout	120
\.


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('settings_id_seq', 5, true);


--
-- Data for Name: subscriber; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY subscriber (id, first_name, last_name, address, email, password, token, email_verified, created_at, is_active) FROM stdin;
9	Dan	Abramov	\N	dan_abramov@gmail.com	$2y$10$LY5MfMe0zVD8el.jrvn0eeRkOVkDnSb69RkG3G1x9oj3PDKiVrJgW	f00455749569594ae9a96dfeb22c2890391567098407969f4379d817281831e2	f	2017-10-05 14:16:13.997201	f
4	Shola	Sunday	\N	shola_sunday@sharklasers.com	$2y$10$LCIF7F1oMzFsKQx4xwJHP.EtdyWsDEjjESKP69Cct.wgJKzCoW3rG	none	t	2017-10-04 12:26:26.149559	t
8	Daniel	Montege	\N	daniel_montege@me.com	$2y$10$x9H.LN/tEpCXTyh2KwYlaeOqkGjB3y75fsja13.6U3vGVAY4pVtQW	388c29216b5e2199838bb87a33efa1c1de109e6057e60a53e6156030f47ef87e	f	2017-10-05 14:09:57.42091	f
3	Uzondu	Enudeme	\N	willpoint@gmail.com	$2y$10$qq1mzJ5V1IOMge47bzEMK.3ZL96Ku/HwW1Sf/je3jhidMaTovwSzS	02c2024fe0e91a6cf1009ec78b2a772526003cacd722a3c2b0db2a58b2653706	f	2017-10-03 16:21:14.507051	t
\.


--
-- Data for Name: subscriber_account; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY subscriber_account (id, subscriber_id, account_type, bank_name, account_name, account_number, created_at) FROM stdin;
\.


--
-- Name: subscriber_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('subscriber_account_id_seq', 1, false);


--
-- Name: subscriber_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('subscriber_id_seq', 10, true);


--
-- Data for Name: subscriber_transaction; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY subscriber_transaction (id, subscriber_id, transaction_type, currency, status, account_number, account_name, bank_name, reference, created_at) FROM stdin;
\.


--
-- Name: subscriber_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('subscriber_transaction_id_seq', 1, false);


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY tag (id, name) FROM stdin;
\.


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('tag_id_seq', 1, false);


--
-- Data for Name: temp_users; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY temp_users (id, name, email, created_at) FROM stdin;
\.


--
-- Name: temp_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('temp_users_id_seq', 1, false);


--
-- Data for Name: template; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY template (id, name, file_name, is_index) FROM stdin;
1	index	index	1
2	page	page	0
4	blog	blog	0
6	company	company	0
7	brands	brands	0
8	news	news	0
9	contact	contact	0
10	drink	drink	0
11	terms_conditions	terms_conditions	0
12	portfolio	portfolio	0
13	single-blog	single-blog	0
14	login	login	0
\.


--
-- Name: template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('template_id_seq', 15, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY users (id, firstname, lastname, email, username, password, image_id, is_active, role_id, created_at) FROM stdin;
1	Super	Admin	admin@admin.com	superuser	$2y$10$X36qB8wK85Pp0rVJD77bpuSoLMEzhLfhyfxu4ug1m/SN5jbGa0zBu	\N	t	1	2017-08-11 09:06:38.825006
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Data for Name: widget; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY widget (id, name, heading, content, attribute1, attribute2, attribute3, attribute4, type_id, widget_parent, is_global, created_at, updated_at) FROM stdin;
12	CompanyExcerpt	About Our Company	<p>Originally founded in 1996, starting with Jack Daniels and Southern Comfort, the Really Great Brand Company&rsquo;s portfolio has grown to no less than 25 really great premier brands&hellip; spectacular champagnes, whiskies, bourbons, cognacs, vodka and liqueurs. Known as RGBC, we&rsquo;re a small, driven, independent and owner-managed company that aspires to provide its clients with really, really great service. RGBC has a vision to be the leading supplier of premium spirits in Southern Africa.</p>\r\n					0	0	0	2017-08-17 08:29:52.586356	2017-08-22 13:36:29.112729
6	OurHeritage	Our Heritage	<p>We are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa.</p>\r\n\r\n<p>The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n					0	0	0	2017-08-16 09:55:41.543358	2017-08-16 10:58:35.655876
10	features2	beverage Distribution	<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa.</p>\r\n					0	0	0	2017-08-16 13:25:52.613186	2017-08-16 13:28:54.900891
11	homeSlider	slider	<p>insert content</p>\r\n					0	0	0	2017-08-16 13:39:57.120968	2017-08-16 13:39:57.120968
7	BrandsSupported	Brands We Support	<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa.</p>\r\n\r\n<p>The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n					0	0	0	2017-08-16 10:34:24.265794	2017-08-16 11:13:33.631626
1	Whiskey	Whiskey	<p>Whiskey</p>\r\n	whiskey				0	0	0	2017-08-14 13:31:57.745279	2017-08-14 13:43:22.530115
2	Whiskey-Johnny-Walker	REMY MARTIN	<p>proudly bearing teh title world most peated whisky, The Bruichladdich Octomore has a cult following around the world.&nbsp;</p>\r\n	1968 VSOP 				0	1	0	2017-08-14 13:35:40.48268	2017-08-14 13:40:47.842326
3	Brandy	Brandy	<p>insert content</p>\r\n	brandy				0	0	0	2017-08-14 13:53:48.383192	2017-08-14 13:55:36.34532
4	Brandy-Martell	Martell	<p>Insert Content</p>\r\n					0	3	0	2017-08-14 13:55:22.459608	2017-08-14 13:57:37.650373
5	Whiskey-Jack-Daniels	Jack Daniels	<p>Insert Content</p>\r\n					0	0	0	2017-08-14 14:19:08.504451	2017-08-14 14:19:48.303746
9	features	Brand Building	<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa.</p>\r\n					0	0	0	2017-08-16 12:50:49.883396	2017-08-16 12:54:11.711869
13	CompanyOurValues	Our Values	<h3>Appreciate The Customer</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Appreciate The Customer</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Appreciate The Customer</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Appreciate The Customer</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Appreciate The Customer</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Appreciate The Customer</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n					0	0	0	2017-08-17 09:08:55.285596	2017-08-17 09:23:31.729381
14	CompanyOurServices	Our Services	<h3>Production</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Distribution</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Branding</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>African Markets</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Production</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n\r\n<h3>Appreciate The Customer</h3>\r\n\r\n<p>Whether we are dealing with customers or consumers, fellow staff, principals or suppliers, we treat them with the same respect and consideration that we would expect to be shown to ourselves.</p>\r\n					0	0	0	2017-08-17 09:51:37.281106	2017-08-17 09:55:27.879586
15	ContactItems	Contact Us	<p>We may have set opening hours for our store but our phones are always on, so contact us directly to book an appointment or to find out more about our beverage distribution service.</p>\r\n					0	0	0	2017-08-17 10:51:11.830852	2017-08-17 11:25:14.604211
16	AddressItems	Address	<p>Le Drop 24 Ogbunike Street Off Admiralty Way Lekki Phase 1, Lagos Nigeria</p>\r\n					0	0	0	2017-08-17 11:29:59.159946	2017-08-17 11:57:53.241463
21	BrandsWhiskey	Whiskeys	<p>Insert content</p>\r\n					0	0	0	2017-08-18 10:20:38.405772	2017-08-18 11:03:49.825917
23	DrinkRemyMartin	Remy Martin	<p>Old No 7</p>\r\n					0	0	0	2017-08-18 11:14:33.628245	2017-08-18 11:14:33.628245
19	FooterContactItems	Contact Us	<p>Tel: 800-255-9999 Fax: 1234 568 Email: example.com</p>\r\n					0	0	0	2017-08-17 13:55:23.9802	2017-08-17 14:12:07.520751
20	FooterContactExtras	Extras	<p>Pelleesque conquat dignissim lacus quis altrcies.</p>\r\n					0	0	0	2017-08-17 14:08:27.006655	2017-08-17 14:17:25.694557
22	DrinkJackDaniels	Jack Daniels	<p>Old No 7</p>\r\n					0	0	0	2017-08-18 10:47:25.846826	2017-08-18 11:20:13.220039
24	DrinkGlenFiddich	Glen Fiddich	<p>OLD NO 7</p>\r\n					0	0	0	2017-08-18 11:23:11.978052	2017-08-18 11:23:11.978052
26	single-drink-remy	Remy Martin	<p>Proudly bearing the title &ldquo;Worlds most peated Whisky&rdquo;, The Bruichladdich Octomore has a cult following around the world. 5 years in American oak barrels perfectly finish a whisky distilled entirely from Scottish Barley, and peated to 208ppm.</p>\r\n\r\n<p>The nose shows sea spray, caramel, citrus and tobacco with subtle hints of smoke. The palate is smoky, smooth and sweet, with soft fruits, vanilla, honey and lemon. The finish is sweet, oak-laden and smooth.</p>\r\n					0	0	0	2017-08-24 09:57:49.001403	2017-08-24 10:03:55.317249
28	portfolio_item1	johnny walker	<p>MMI is proud to partner many of the world&rsquo;s top spirit brand owners including Bacardi-Martini, Brown Forman, Campari, The Edrington Group, Mo&euml;t Hennessy, Pernod Ricard and Russian Standard amongst many others.</p>\r\n\r\n<p>Our portfolio of brands is among the finest and most globally recognisable, from Absolut, Belvedere, Grey Goose, Russian Standard Vodka to Jack Daniel&rsquo;s, Hennessy Cognac, Patr&oacute;n Tequila and Bacardi to name just a few.</p>\r\n\r\n<p>We also work with many of the lesser known, niche producers who help us deliver a real point of difference for our customers whilst we add value to their operations. These partners include Joseph Cartron Liqueurs, Heaven Hill Distilleries, Bruichladdich Single Malt, Morrison Bowmore and Gosling&rsquo;s Bermudan Rums.</p>\r\n\r\n<p>We have the largest collection of boutique gins in the Middle East, from Bulldog to Tarquin and Sacred to Sipsmith with over 40 of the world&rsquo;s finest craft gins under one roof.</p>\r\n\r\n<p>We constantly seek new partners to stay ahead of emerging global trends and help you meet and exceed the expectations of your guests and clients.</p>\r\n					0	0	0	2017-08-24 13:15:43.655525	2017-08-24 13:15:43.655525
29	portfolio_item2	Remy Martin	<p>MMI is proud to partner many of the world&rsquo;s top spirit brand owners including Bacardi-Martini, Brown Forman, Campari, The Edrington Group, Mo&euml;t Hennessy, Pernod Ricard and Russian Standard amongst many others.</p>\r\n\r\n<p>Our portfolio of brands is among the finest and most globally recognisable, from Absolut, Belvedere, Grey Goose, Russian Standard Vodka to Jack Daniel&rsquo;s, Hennessy Cognac, Patr&oacute;n Tequila and Bacardi to name just a few.</p>\r\n\r\n<p>We also work with many of the lesser known, niche producers who help us deliver a real point of difference for our customers whilst we add value to their operations. These partners include Joseph Cartron Liqueurs, Heaven Hill Distilleries, Bruichladdich Single Malt, Morrison Bowmore and Gosling&rsquo;s Bermudan Rums.</p>\r\n\r\n<p>We have the largest collection of boutique gins in the Middle East, from Bulldog to Tarquin and Sacred to Sipsmith with over 40 of the world&rsquo;s finest craft gins under one roof.</p>\r\n\r\n<p>We constantly seek new partners to stay ahead of emerging global trends and help you meet and exceed the expectations of your guests and clients.</p>\r\n					0	0	0	2017-08-24 14:06:12.256316	2017-08-24 14:06:12.256316
27	terms_widget	Terms & Conditions	<p>&nbsp;</p>\r\n\r\n<ol>\r\n\t<li>\r\n\t<p>Acceptance Of Terms</p>\r\n\r\n\t<p>Ledrop, Inc. (&quot;Ledrop&quot;) welcomes you. Yahoo provides the Ledro Services (defined below) to you subject to the following Terms of Service (&quot;TOS&quot;), which may be updated by us from time to time without notice to you. You can review the most current version of the TOS at any time.Descriptiion Of Services<br />\r\n\t&nbsp;</p>\r\n\t</li>\r\n\t<li>\r\n\t<p>Description Of Services</p>\r\n\r\n\t<p>Ledrop provides users with access to a rich collection of resources, including without limitation various communications tools, forums, shopping services, search services, personalized content and branded programming through its network of properties which may be accessed through any various medium or device now known or hereafter developed (the &quot;Yahoo Services&quot;).<br />\r\n\t&nbsp;</p>\r\n\t</li>\r\n\t<li>\r\n\t<p>Ledrop Privacy Policy</p>\r\n\r\n\t<p>Ledrop provides users with access to a rich collection of resources, including ordering drinks, warehouse imports, shopping services, search services.<br />\r\n\t&nbsp;</p>\r\n\t</li>\r\n\t<li>\r\n\t<p>Member Account, Privacy &amp; Security</p>\r\n\r\n\t<p>You will receive a password and account designation upon completing the Ledrop Service&#39;s registration process. You are responsible for maintaining the confidentiality of the password and account and are fully responsible for all activities that occur under your password or account.</p>\r\n\t</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n					0	0	0	2017-08-24 11:49:19.726058	2017-08-24 12:48:20.571807
30	portfolio_item3	Glen Fiddich	<p>MMI is proud to partner many of the world&rsquo;s top spirit brand owners including Bacardi-Martini, Brown Forman, Campari, The Edrington Group, Mo&euml;t Hennessy, Pernod Ricard and Russian Standard amongst many others.</p>\r\n\r\n<p>Our portfolio of brands is among the finest and most globally recognisable, from Absolut, Belvedere, Grey Goose, Russian Standard Vodka to Jack Daniel&rsquo;s, Hennessy Cognac, Patr&oacute;n Tequila and Bacardi to name just a few.</p>\r\n\r\n<p>We also work with many of the lesser known, niche producers who help us deliver a real point of difference for our customers whilst we add value to their operations. These partners include Joseph Cartron Liqueurs, Heaven Hill Distilleries, Bruichladdich Single Malt, Morrison Bowmore and Gosling&rsquo;s Bermudan Rums.</p>\r\n\r\n<p>We have the largest collection of boutique gins in the Middle East, from Bulldog to Tarquin and Sacred to Sipsmith with over 40 of the world&rsquo;s finest craft gins under one roof.</p>\r\n\r\n<p>We constantly seek new partners to stay ahead of emerging global trends and help you meet and exceed the expectations of your guests and clients.</p>\r\n					0	0	0	2017-08-24 14:09:06.315824	2017-08-24 14:09:06.315824
31	single-blog-post1	 REMY MARTINS ANNOUNCES MICROSOFT HOLOLLENS	<p>we are the largest and most effective independent premium beverage marketer and distributor in Nigeria with a vast experience in premium beverage distribution, brand building and maintenance in Nigeria and West Africa. The Ledrop website is to be an information portal to expand our key competencies generally and safe duplication. It will not be our primary revenue source.</p>\r\n					0	0	0	2017-08-25 09:22:12.14134	2017-08-25 09:22:12.14134
25	header	header	<p>content</p>\r\n					0	0	1	2017-08-18 15:27:05.699742	2017-10-06 17:28:13.491138
\.


--
-- Name: widget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('widget_id_seq', 31, true);


--
-- Data for Name: widget_type; Type: TABLE DATA; Schema: public; Owner: orbdba
--

COPY widget_type (id, type, name) FROM stdin;
1	0	regular
2	1	inventory
3	2	announcements
\.


--
-- Name: widget_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orbdba
--

SELECT pg_catalog.setval('widget_type_id_seq', 3, true);


--
-- Name: account_recovery_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY account_recovery
    ADD CONSTRAINT account_recovery_pkey PRIMARY KEY (id);


--
-- Name: analytic_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY analytic
    ADD CONSTRAINT analytic_pkey PRIMARY KEY (id);


--
-- Name: blog_category_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY blog_category
    ADD CONSTRAINT blog_category_pkey PRIMARY KEY (id);


--
-- Name: category_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: comment_users_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY comment_users
    ADD CONSTRAINT comment_users_pkey PRIMARY KEY (id);


--
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: file_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);


--
-- Name: file_widget_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY file_widget
    ADD CONSTRAINT file_widget_pkey PRIMARY KEY (id);


--
-- Name: goose_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY goose_db_version
    ADD CONSTRAINT goose_db_version_pkey PRIMARY KEY (id);


--
-- Name: menu_label_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_label_key UNIQUE (label);


--
-- Name: menu_name_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_name_key UNIQUE (name);


--
-- Name: menu_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: page_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- Name: page_title_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY page
    ADD CONSTRAINT page_title_key UNIQUE (title);


--
-- Name: page_widget_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY page_widget
    ADD CONSTRAINT page_widget_pkey PRIMARY KEY (id);


--
-- Name: post_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: product_category_name_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY product_category
    ADD CONSTRAINT product_category_name_key UNIQUE (name);


--
-- Name: product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product_model_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_model_key UNIQUE (model);


--
-- Name: product_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: role_id_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_id_key UNIQUE (id);


--
-- Name: settings_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: subscriber_account_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber_account
    ADD CONSTRAINT subscriber_account_pkey PRIMARY KEY (id);


--
-- Name: subscriber_email_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber
    ADD CONSTRAINT subscriber_email_key UNIQUE (email);


--
-- Name: subscriber_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber
    ADD CONSTRAINT subscriber_pkey PRIMARY KEY (id);


--
-- Name: subscriber_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber_transaction
    ADD CONSTRAINT subscriber_transaction_pkey PRIMARY KEY (id);


--
-- Name: tag_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: temp_users_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY temp_users
    ADD CONSTRAINT temp_users_pkey PRIMARY KEY (id);


--
-- Name: template_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY template
    ADD CONSTRAINT template_pkey PRIMARY KEY (id);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: widget_name_key; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY widget
    ADD CONSTRAINT widget_name_key UNIQUE (name);


--
-- Name: widget_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY widget
    ADD CONSTRAINT widget_pkey PRIMARY KEY (id);


--
-- Name: widget_type_pkey; Type: CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY widget_type
    ADD CONSTRAINT widget_type_pkey PRIMARY KEY (id);


--
-- Name: account_recovery_selector_idx; Type: INDEX; Schema: public; Owner: orbdba
--

CREATE INDEX account_recovery_selector_idx ON account_recovery USING btree (selector);


--
-- Name: post_title_idx; Type: INDEX; Schema: public; Owner: orbdba
--

CREATE INDEX post_title_idx ON post USING btree (title);


--
-- Name: product_name_idx; Type: INDEX; Schema: public; Owner: orbdba
--

CREATE INDEX product_name_idx ON product USING btree (name);


--
-- Name: widget_type_type_idx; Type: INDEX; Schema: public; Owner: orbdba
--

CREATE INDEX widget_type_type_idx ON widget_type USING btree (type);


--
-- Name: comment_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_post_id_fkey FOREIGN KEY (post_id) REFERENCES post(id);


--
-- Name: comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES temp_users(id);


--
-- Name: post_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_author_id_fkey FOREIGN KEY (author_id) REFERENCES users(id);


--
-- Name: post_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_category_id_fkey FOREIGN KEY (category_id) REFERENCES blog_category(id);


--
-- Name: product_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_file_id_fkey FOREIGN KEY (file_id) REFERENCES file(id);


--
-- Name: product_product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_product_category_id_fkey FOREIGN KEY (product_category_id) REFERENCES product_category(id);


--
-- Name: subscriber_account_subscriber_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber_account
    ADD CONSTRAINT subscriber_account_subscriber_id_fkey FOREIGN KEY (subscriber_id) REFERENCES subscriber(id);


--
-- Name: subscriber_transaction_subscriber_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY subscriber_transaction
    ADD CONSTRAINT subscriber_transaction_subscriber_id_fkey FOREIGN KEY (subscriber_id) REFERENCES subscriber(id);


--
-- Name: users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: orbdba
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES role(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

