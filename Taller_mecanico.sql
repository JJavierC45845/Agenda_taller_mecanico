--
-- PostgreSQL database dump
--

\restrict nXzX2lv78HNlimliz8rALVwMXcVRzeZQKRImBzdNuh5NvnyTPPnlhff7JD3rH21

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-11-24 21:19:22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 244 (class 1255 OID 16770)
-- Name: update_fecha_actualizacion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_fecha_actualizacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.fecha_actualizacion = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_fecha_actualizacion() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 16645)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16644)
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_id_seq OWNER TO postgres;

--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 227
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- TOC entry 236 (class 1259 OID 16704)
-- Name: cita_servicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cita_servicios (
    id integer NOT NULL,
    cita_id integer NOT NULL,
    servicio_id integer NOT NULL
);


ALTER TABLE public.cita_servicios OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16703)
-- Name: cita_servicios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cita_servicios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cita_servicios_id_seq OWNER TO postgres;

--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 235
-- Name: cita_servicios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cita_servicios_id_seq OWNED BY public.cita_servicios.id;


--
-- TOC entry 234 (class 1259 OID 16684)
-- Name: citas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citas (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    moto_id integer NOT NULL,
    telefono character varying(15) NOT NULL,
    email character varying(100),
    kilometros integer,
    fecha_cita date NOT NULL,
    hora_llegada time without time zone NOT NULL,
    estado character varying(50) DEFAULT 'En diagnóstico'::character varying,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT citas_estado_check CHECK (((estado)::text = ANY (ARRAY[('En diagnóstico'::character varying)::text, ('En reparación / Servicio'::character varying)::text, ('Esperando refacciones / Productos'::character varying)::text, ('Lista para entregar'::character varying)::text, ('completada'::character varying)::text])))
);


ALTER TABLE public.citas OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16683)
-- Name: citas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citas_id_seq OWNER TO postgres;

--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 233
-- Name: citas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citas_id_seq OWNED BY public.citas.id;


--
-- TOC entry 224 (class 1259 OID 16617)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    telefono character varying(15) NOT NULL,
    rol_id integer NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16616)
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_seq OWNER TO postgres;

--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 223
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- TOC entry 222 (class 1259 OID 16604)
-- Name: empleados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleados (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    rol_id integer NOT NULL,
    "contraseña" character varying(255) NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.empleados OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16603)
-- Name: empleados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empleados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empleados_id_seq OWNER TO postgres;

--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 221
-- Name: empleados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empleados_id_seq OWNED BY public.empleados.id;


--
-- TOC entry 240 (class 1259 OID 16744)
-- Name: factura_detalles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura_detalles (
    id integer NOT NULL,
    factura_id integer NOT NULL,
    tipo character varying(10) NOT NULL,
    servicio_id integer,
    producto_id integer,
    descripcion text NOT NULL,
    cantidad integer DEFAULT 1 NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    CONSTRAINT factura_detalles_check CHECK (((((tipo)::text = 'servicio'::text) AND (servicio_id IS NOT NULL) AND (producto_id IS NULL)) OR (((tipo)::text = 'producto'::text) AND (producto_id IS NOT NULL) AND (servicio_id IS NULL)))),
    CONSTRAINT factura_detalles_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['servicio'::character varying, 'producto'::character varying])::text[])))
);


ALTER TABLE public.factura_detalles OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16743)
-- Name: factura_detalles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_detalles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factura_detalles_id_seq OWNER TO postgres;

--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 239
-- Name: factura_detalles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_detalles_id_seq OWNED BY public.factura_detalles.id;


--
-- TOC entry 238 (class 1259 OID 16721)
-- Name: facturas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facturas (
    id integer NOT NULL,
    numero_factura character varying(50) NOT NULL,
    cliente_id integer NOT NULL,
    moto_id integer,
    fecha_emision timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total numeric(12,2) DEFAULT 0 NOT NULL,
    estado character varying(20) DEFAULT 'pendiente'::character varying,
    empleado_id integer,
    CONSTRAINT facturas_estado_check CHECK (((estado)::text = ANY ((ARRAY['pendiente'::character varying, 'pagada'::character varying, 'cancelada'::character varying])::text[])))
);


ALTER TABLE public.facturas OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16720)
-- Name: facturas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facturas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facturas_id_seq OWNER TO postgres;

--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 237
-- Name: facturas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facturas_id_seq OWNED BY public.facturas.id;


--
-- TOC entry 230 (class 1259 OID 16656)
-- Name: inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventario (
    id integer NOT NULL,
    codigo_producto character varying(50) NOT NULL,
    nombre character varying(100) NOT NULL,
    categoria_id integer NOT NULL,
    cantidad integer DEFAULT 0 NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.inventario OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16655)
-- Name: inventario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventario_id_seq OWNER TO postgres;

--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 229
-- Name: inventario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventario_id_seq OWNED BY public.inventario.id;


--
-- TOC entry 226 (class 1259 OID 16630)
-- Name: motos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motos (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    modelo character varying(100) NOT NULL,
    placa character varying(20),
    ano integer,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.motos OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16629)
-- Name: motos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.motos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.motos_id_seq OWNER TO postgres;

--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 225
-- Name: motos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.motos_id_seq OWNED BY public.motos.id;


--
-- TOC entry 220 (class 1259 OID 16595)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16594)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 232 (class 1259 OID 16673)
-- Name: servicios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    costo_general numeric(10,2) NOT NULL,
    descripcion text,
    duracion_estimada integer
);


ALTER TABLE public.servicios OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16672)
-- Name: servicios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servicios_id_seq OWNER TO postgres;

--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 231
-- Name: servicios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicios_id_seq OWNED BY public.servicios.id;


--
-- TOC entry 243 (class 1259 OID 16815)
-- Name: vista_citas_detalladas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_citas_detalladas AS
 SELECT c.id AS cita_id,
    c.fecha_cita,
    c.hora_llegada,
    c.estado AS estado_cita,
    cl.nombre AS nombre_cliente,
    cl.telefono AS telefono_cliente,
    m.modelo AS modelo_moto,
    m.placa
   FROM ((public.citas c
     JOIN public.clientes cl ON ((c.cliente_id = cl.id)))
     JOIN public.motos m ON ((c.moto_id = m.id)))
  ORDER BY c.fecha_cita, c.hora_llegada;


ALTER VIEW public.vista_citas_detalladas OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16808)
-- Name: vista_estado_inventario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_estado_inventario AS
 SELECT i.id,
    i.codigo_producto,
    i.nombre AS nombre_producto,
    c.nombre AS categoria,
    i.cantidad,
    i.precio_unitario,
        CASE
            WHEN (i.cantidad = 0) THEN 'Sin stock'::text
            WHEN (i.cantidad <= 10) THEN 'Stock bajo'::text
            ELSE 'En stock'::text
        END AS estado_stock
   FROM (public.inventario i
     JOIN public.categorias c ON ((i.categoria_id = c.id)));


ALTER VIEW public.vista_estado_inventario OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16798)
-- Name: vista_factura_completa; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_factura_completa AS
 SELECT f.id AS factura_id,
    f.numero_factura,
    f.fecha_emision,
    f.estado AS estado_factura,
    f.total,
    cl.nombre AS nombre_cliente,
    fd.id AS detalle_id,
    fd.tipo,
    COALESCE(s.nombre, i.nombre) AS descripcion_item,
    fd.cantidad,
    fd.precio_unitario,
    fd.subtotal
   FROM ((((public.facturas f
     JOIN public.clientes cl ON ((f.cliente_id = cl.id)))
     JOIN public.factura_detalles fd ON ((f.id = fd.factura_id)))
     LEFT JOIN public.servicios s ON (((fd.servicio_id = s.id) AND ((fd.tipo)::text = 'servicio'::text))))
     LEFT JOIN public.inventario i ON (((fd.producto_id = i.id) AND ((fd.tipo)::text = 'producto'::text))));


ALTER VIEW public.vista_factura_completa OWNER TO postgres;

--
-- TOC entry 4814 (class 2604 OID 16648)
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 16707)
-- Name: cita_servicios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita_servicios ALTER COLUMN id SET DEFAULT nextval('public.cita_servicios_id_seq'::regclass);


--
-- TOC entry 4820 (class 2604 OID 16687)
-- Name: citas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas ALTER COLUMN id SET DEFAULT nextval('public.citas_id_seq'::regclass);


--
-- TOC entry 4810 (class 2604 OID 16620)
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 16607)
-- Name: empleados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados ALTER COLUMN id SET DEFAULT nextval('public.empleados_id_seq'::regclass);


--
-- TOC entry 4828 (class 2604 OID 16747)
-- Name: factura_detalles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_detalles ALTER COLUMN id SET DEFAULT nextval('public.factura_detalles_id_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 16724)
-- Name: facturas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas ALTER COLUMN id SET DEFAULT nextval('public.facturas_id_seq'::regclass);


--
-- TOC entry 4815 (class 2604 OID 16659)
-- Name: inventario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario ALTER COLUMN id SET DEFAULT nextval('public.inventario_id_seq'::regclass);


--
-- TOC entry 4812 (class 2604 OID 16633)
-- Name: motos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motos ALTER COLUMN id SET DEFAULT nextval('public.motos_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 16598)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4819 (class 2604 OID 16676)
-- Name: servicios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios ALTER COLUMN id SET DEFAULT nextval('public.servicios_id_seq'::regclass);


--
-- TOC entry 5040 (class 0 OID 16645)
-- Dependencies: 228
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nombre, descripcion) FROM stdin;
1	Lubricantes	Aceites y grasas para motor
2	Refacciones	Partes y piezas de repuesto
3	Accesorios	Accesorios para motocicletas
4	Herramientas	Herramientas para mantenimiento
5	Aceites de Motor	Aceites sintéticos, semi-sintéticos y minerales para motor de moto
6	Aceites de Transmisión	Aceites especializados para caja de cambios de motocicletas
7	Filtros de Aire	Filtros de aire de papel, espuma y algodón para diferentes modelos
8	Filtros de Aceite	Filtros de aceite para motos de todas las marcas y cilindrajes
9	Filtros de Combustible	Filtros de gasolina para sistemas con carburador e inyección
10	Bujías	Bujías convencionales, de platino e iridio para motores de moto
11	Pastillas de Freno Delanteras	Pastillas de freno para rueda delantera de diferentes compuestos
12	Pastillas de Freno Traseras	Pastillas de freno para rueda trasera de diversos materiales
13	Discos de Freno	Discos de freno delanteros y traseros originales y aftermarket
14	Líquido de Frenos	Líquido de frenos DOT 4, DOT 5.1 para sistema hidráulico
15	Kit de Cadena	Juegos completos de cadena y sprockets de transmisión
16	Cadenas	Cadenas de rodillos O-ring, X-ring y estándar
17	Sprockets	Piñones y coronas de diferentes dientes y materiales
18	Neumáticos Delanteros	Llantas delanteras para moto de carretera, off-road y mixtas
19	Neumáticos Traseros	Llantas traseras para diversos tipos de uso y condiciones
20	Cámaras de Aire	Cámaras de aire para llantas con y sin rin
21	Baterías	Baterías de gel, AGM y líquido para sistemas eléctricos
22	Fusibles	Fusibles de diferentes amperajes para protección eléctrica
23	Amortiguadores Traseros	Amortiguadores traseros estándar y de suspensión progresiva
24	Horquillas Delanteras	Componentes y kits de reparación para horquilla delantera
25	Retenes de Suspensión	Retenes y guardapolvos para suspensión delantera y trasera
26	Aceite de Suspensión	Aceites especializados para suspensión de diferentes viscosidades
27	Kit de Juntas de Motor	Juegos de juntas para reconstrucción de motor completo
28	Juntas de Culata	Juntas de culata originales y de alta compresión
29	Anillos de Pistón	Juegos de anillos para pistones de diferentes medidas
30	Pistones	Pistones estándar y oversize para reconstrucción de motor
31	Cilindros	Cilindros originales, oversize y de reparación
32	Bielas	Bielas completas y componentes para cigüeñal
33	Cojinetes de Motor	Rodamientos y baleros para motor y transmisión
34	Árbol de Levas	Árboles de levas estándar y de alto rendimiento
35	Cadena de Distribución	Cadenas de distribución y kits de tensores
36	Bomba de Aceite	Bombas de aceite mecánicas y componentes
37	Radiadores	Radiadores de refrigeración originales y aftermarket
38	Mangueras de Refrigeración	Mangueras y conexiones para sistema de refrigeración
39	Ventiladores	Ventiladores de radiador y motores eléctricos
40	Termostatos	Termostatos para control de temperatura del motor
41	Sensores de Temperatura	Sensores de temperatura para motor y refrigerante
42	Carburadores	Carburadores completos y kits de reparación
43	Kit de Reconstrucción Carburador	Juegos de juntas, flotadores y agujas para carburador
44	Inyectores	Inyectores de combustible para sistemas de inyección
45	Bomba de Combustible	Bombas de combustible eléctricas y mecánicas
46	Reguladores de Presión	Reguladores de presión de combustible
47	Bombillos Faros	Focos halógenos, LED y HID para sistema de iluminación
48	Lentes de Faros	Lentes y cubiertas para faros delanteros y traseros
49	Direccionales	Luces direccionales delanteras, traseras y laterales
50	Intermitentes	Unidades de intermitencia y relays para direccionales
51	Espejos Retrovisores	Espejos laterales originales y universales
52	Manijas	Manijas de acelerador, clutch y freno
53	Palancas de Freno	Palancas de freno delantero y clutch
54	Asientos	Asientos individuales y dobles para motocicleta
55	Tanques de Gasolina	Tanques de combustible originales y aftermarket
56	Carenes	Carenes y carenados deportivos
57	Guardafangos	Guardafangos delanteros y traseros
58	Portamatrículas	Portamatrículas traseros y kits de modificación
59	Sistemas de Escape	Escapes completos y silenciadores aftermarket
60	Header Pipes	Tubos de escape primarios y colectores
61	Silenciadores	Silenciadores deportivos y de reemplazo
62	Sensores de Oxígeno	Sensores lambda para sistema de emisiones
63	Convertidores Catalíticos	Catalizadores para control de emisiones
64	Sensores de Velocidad	Sensores de velocidad para rueda y transmisión
65	Sensores de RPM	Sensores de revoluciones para motor
66	Alternadores	Alternadores y componentes de carga eléctrica
67	Arranques	Motores de arranque y componentes
68	Bobinas de Encendido	Bobinas para sistema de encendido electrónico
69	Cables de Bujía	Cables de alta tensión para bujías
70	Unidades de Control	ECUs y módulos de control electrónico
71	Relays	Relays para diversos sistemas eléctricos
72	Interruptores	Interruptores de manubrio y panel
73	Cableado	Harnesses de cableado y cables individuales
74	Portaequipajes	Portaequipajes traseros y laterales
75	Bacacas	Bacacas y sistemas de sujeción
76	Maletas	Maletas laterales y top cases
77	Sistemas de Navegación	Soportes para GPS y navegadores
78	Cargadores USB	Cargadores y tomas de USB para dispositivos
79	Alarmas	Sistemas de alarma y antirrobo
80	Candados	Candados de disco, U-lock y cadenas
81	Cubiertas para Moto	Cubiertas y fundas de protección
168	Sistemas de Carga Solar	Cargadores solares para dispositivos
82	Lubricantes Especializados	Grasas, lubricantes de cadena y productos especiales
83	Líquido Refrigerante	Anticongelante y refrigerante para moto
84	Aditivos de Combustible	Aditivos para gasolina y limpiadores de inyectores
85	Limpiadores y Degrasantes	Productos de limpieza y mantenimiento
86	Herramientas de Mano	Llaves, destornilladores y herramientas básicas
87	Juegos de Llaves	Juegos de llaves de vaso y combinadas
88	Torquímetros	Llaves de torque para apriete preciso
89	Juegos de Destornilladores	Destornilladores de diferentes tipos y medidas
90	Alicates y Pinzas	Alicates, pinzas y herramientas de sujeción
91	Juegos de Herramientas	Kits completos de herramientas para moto
92	Herramientas Especializadas	Herramientas específicas para marcas y modelos
93	Extractores	Extractores de tornillos y rodamientos
94	Prensas	Prensas para rodamientos y componentes
95	Medidores de Compresión	Medidores de compresión para motor
96	Multímetros	Multímetros digitales para diagnóstico eléctrico
97	Scanner de Diagnóstico	Scanners para sistemas de inyección electrónica
98	Manómetros	Medidores de presión para diversos sistemas
99	Calibradores	Calibradores y medidores de espesor
100	Equipo de Soldadura	Soldadores y equipos de soldadura básicos
101	Gatos Hidráulicos	Gatos para elevación de motocicletas
102	Caballetes	Caballetes laterales y centrales
103	Soportes para Ruedas	Soportes para desmontar ruedas
104	Bancos de Trabajo	Mesas de trabajo para reparaciones
105	Organizadores de Herramientas	Cajas y organizadores para herramientas
106	Equipo de Protección Personal	Cascos, guantes y equipo de seguridad
107	Cascos Integrales	Cascos cerrados de protección completa
108	Cascos Modulares	Cascos con mentonera abatible
109	Cascos Abiertos	Cascos tipo jet para uso urbano
110	Viseras	Viseras transparentes, tintadas y anti-empaño
111	Guantes de Moto	Guantes de cuero, textiles y con protección
112	Chamarras de Moto	Chamarras con protecciones y armadura
113	Pantalones de Moto	Pantalones con protecciones para rodillas
114	Botas de Moto	Botas de protección para tobillo y pie
115	Impermeables	Trajes impermeables para lluvia
116	Mochilas para Moto	Mochilas especializadas para motociclistas
117	Intercomunicadores	Sistemas de comunicación para cascos
118	Accesorios de Seguridad	Elementos reflectantes y de visibilidad
119	Aceites para Frenos	Aceites minerales y sintéticos para frenos
120	Grasas Especializadas	Grasas para rodamientos, suspensiones y componentes
121	Líquidos Hidráulicos	Líquidos para sistemas hidráulicos diversos
122	Sprays Penetrantes	Sprays para liberar componentes oxidados
123	Selladores	Selladores de rosca y juntas
124	Adhesivos	Adhesivos especializados para moto
125	Cintas Especiales	Cintas aislantes y de alta temperatura
126	Tornillería	Tornillos, tuercas y espárragos especiales
128	Arandelas	Arandelas de seguridad y planas
129	Pasadores	Pasadores de seguridad y chavetas
130	Retenes	Retenes de aceite para motor y transmisión
131	Rodamientos de Rueda	Rodamientos para rueda delantera y trasera
132	Rodamientos de Dirección	Rodamientos para cabeza de horquilla
133	Bujes	Bujes de suspensión y chasis
134	Silentblocs	Silentblocs para motor y basculante
135	Resortes de Suspensión	Resortes para suspensión delantera y trasera
136	Cartuchos de Suspensión	Cartuchos para actualización de suspensión
137	Válvulas de Suspensión	Válvulas para ajuste de suspensión
138	Manguitos de Freno	Manguitos y latiguillos de freno
139	Cilindros de Rueda	Cilindros de rueda para frenos de tambor
140	Cilindros Maestros	Cilindros maestros de freno y clutch
141	Bombines de Freno	Bombines para frenos traseros
142	Sensores ABS	Sensores para sistema antibloqueo de frenos
143	Anillos de Pistón Especiales	Anillos de alto rendimiento y competición
144	Bujías de Rango Caliente	Bujías para motores modificados y alto rendimiento
145	Bujías de Rango Frío	Bujías para uso intensivo y alta temperatura
146	Cables de Alta Energía	Cables de bujía de baja resistencia
147	Bobinas de Alto Voltaje	Bobinas de encendido de alto rendimiento
148	Reguladores de Voltaje	Reguladores para sistema de carga
149	Rectificadores	Rectificadores de corriente alterna
150	Condensadores	Condensadores para sistema eléctrico
151	Fusibles de Cartucho	Fusibles de cartucho para sistemas de alta corriente
152	Breakers	Interruptores automáticos rearmables
153	Barras de Distribución	Barras para distribución eléctrica
154	Terminales Eléctricos	Terminales y conectores eléctricos
155	Fundas para Cableado	Fundas termoretráctiles y trenzadas
156	Baterías de Litio	Baterías de ion-litio de alto rendimiento
157	Mantenimiento de Baterías	Cargadores y mantenedores de batería
158	Sistemas de Arranque Rápido	Sistemas para arranque en frío
159	Calentadores de Manijas	Kits de manijas calefaccionadas
160	Sistemas de Calefacción	Sistemas de calefacción para ropa
161	Porta Celulares	Soportes para teléfonos inteligentes
162	Cámaras de Acción	Soportes para cámaras deportivas
163	Sistemas de Audio	Sistemas de audio para casco y moto
164	Bocinas	Bocinas de alta y baja frecuencia
165	Amplificadores	Amplificadores para sistemas de audio
166	Subwoofers	Subwoofers para audio en moto
167	Pantallas de Navegación	Pantallas montables para GPS y video
169	Inversores de Corriente	Inversores de 12V a 110V/220V
170	Luces Auxiliares	Luces LED adicionales para mejor visibilidad
171	Luces de Niebla	Luces especiales para condiciones de baja visibilidad
172	Kits de Señalización	Kits de luces adicionales para seguridad
173	Sistemas de Frenos Antibloqueo	Componentes para sistemas ABS
174	Modulos de Control ABS	Módulos electrónicos para sistema ABS
175	Sensores de Inclinación	Sensores para sistemas de seguridad
176	Sistemas de Control de Tracción	Componentes para control de tracción
177	Modos de Conducción	Módulos para modos de conducción electrónicos
178	Sistemas de Inmovilizador	Sistemas de inmovilización electrónica
179	Llaves de Repuesto	Llaves originales y programación
180	Sistemas de Alarma GPS	Alarmas con localización GPS
181	Sensores de Movimiento	Sensores para sistemas de seguridad
182	Sirenas	Sirenas para sistemas de alarma
183	Candados con Alarma	Candados con sistema de alarma incorporado
184	Sistemas de Rastreo	Sistemas de rastreo satelital
185	Protecciones para Motor	Barras de protección y sliders
186	Protectores de Manubrio	Protectores y ends para manubrio
187	Protectores de Radiador	Rejillas y protectores para radiador
188	Protectores de Tanque	Protectores magnéticos y adhesivos para tanque
189	Fundas para Asiento	Fundas protectoras y de comfort para asiento
190	Repelentes de Agua	Tratamientos hidrofóbicos para carenados
191	Cerámicos para Pintura	Protectores cerámicos para pintura
192	Pulidores	Pulidores y compuestos para acabado
193	Ceras	Ceras para protección de pintura
194	Limpiadores de Llantas	Productos especializados para limpieza de llantas
195	Limpiadores de Cadena	Limpiadores y desengrasantes para cadena
196	Protectores de Plástico	Protectores y renovadores de plástico
197	Limpiadores de Frenos	Limpiadores sin residuos para frenos
198	Desengrasantes	Desengrasantes potentes para motor
199	Lubricantes de Cadena	Lubricantes secos y húmedos para cadena
200	Sprays de Silicona	Sprays de silicona para juntas y plásticos
201	Aceites Penetrantes	Aceites para liberación de componentes
202	Grasas de Cobre	Grasas anti-seizure para alta temperatura
203	Grasas de Litio	Grasas multipropósito de litio
204	Grasas de Silicona	Grasas para juntas y conexiones
205	Compuestos para Asientos	Compuestos para pulido de asientos de válvula
206	Paste para Frenos	Paste antisqueal para pastillas de freno
207	Compuestos de Montaje	Compuestos para montaje de neumáticos
208	Selladores de Neumáticos	Selladores para reparación de pinchazos
209	Aditivos para Refrigerante	Aditivos para sistema de refrigeración
210	Condicionadores de Gomas	Protectores para juntas y gomas
211	Herramientas para Neumáticos	Herramientas específicas para cambio de llantas
212	Desmontadoras de Neumáticos	Desmontadoras manuales y mecánicas
213	Equilibradoras de Ruedas	Equipos para balanceo de ruedas
214	Medidores de Presión	Medidores digitales y analógicos de presión
215	Infladores	Infladores eléctricos y manuales
216	Kits de Reparación de Pinchazos	Kits para reparación temporal de neumáticos
217	Parches para Neumáticos	Parches y materiales para reparación
218	Válvulas para Neumáticos	Válvulas de repuesto y de alto flujo
219	Tapas para Válvulas	Tapas decorativas y de seguridad
220	Extensores de Válvulas	Extensores para válvulas de difícil acceso
221	Herramientas para Cadena	Herramientas para medir y ajustar cadena
222	Tronchadores de Cadena	Tronchadores para cadena de transmisión
223	Remachadores de Cadena	Remachadores para eslabones de cadena
224	Medidores de Desgaste	Medidores para desgaste de cadena y sprockets
225	Lavadoras de Cadena	Lavadoras automáticas para cadena
226	Kits de Engrase	Kits para lubricación de cadena
227	Herramientas para Suspensión	Herramientas específicas para suspensión
228	Compresores de Suspensión	Compresores para resortes de suspensión
229	Herramientas para Válvulas	Herramientas para ajuste de válvulas
230	Calibradores de Válvulas	Calibradores para juego de válvulas
231	Gatos para Suspensión	Gatos específicos para trabajo en suspensión
232	Herramientas para Motor	Herramientas específicas para desarmado de motor
233	Extractores de Piston	Extractores para anillos de pistón
234	Insertadores de Piston	Insertadores para montaje de pistones
235	Torquímetros Digitales	Torquímetros digitales de alta precisión
236	Medidores de Holgura	Medidores para holguras de motor
237	Micrómetros	Micrómetros para medición precisa
238	Calibradores Vernier	Calibradores para medición externa e interna
239	Galgas de Espesor	Galgas para medición de holguras
240	Indicadores de Gota	Indicadores de carrera para medición
241	Compresómetros	Medidores de compresión avanzados
242	Vacuómetros	Medidores de vacío para carburadores
243	Flow Meters	Medidores de flujo para inyectores
244	Osciloscopios	Osciloscopios para diagnóstico electrónico
245	Generadores de Señal	Generadores para pruebas de sensores
246	Simuladores de Sensor	Simuladores para pruebas de ECU
247	Programadores de ECU	Herramientas para programación de ECU
248	Interfaces de Diagnóstico	Interfaces para conexión con computadora
249	Software de Diagnóstico	Software especializado para diagnóstico
250	Kits de Prueba de Combustible	Kits para prueba de presión de combustible
251	Manómetros de Combustible	Manómetros para sistema de combustible
252	Bombas de Vacío	Bombas para pruebas de vacío y presión
253	Fugas de Vacío	Detectores de fugas de vacío
254	Estetoscopios Mecánicos	Estetoscopios para diagnóstico de ruidos
255	Termómetros Infrarrojos	Termómetros para medición de temperatura
256	Anemómetros	Medidores de flujo de aire
257	Manómetros de Aceite	Manómetros para presión de aceite
258	Bancos de Prueba	Bancos para prueba de componentes
259	Probadores de Bujías	Probadores para bujías y sistema de encendido
260	Probadores de Alternador	Probadores para sistema de carga
261	Probadores de Arranque	Probadores para motor de arranque
262	Probadores de Batería	Probadores de carga y capacidad de batería
263	Analizadores de Gases	Analizadores para gases de escape
264	Opacímetros	Medidores de opacidad para diesel
265	Sistemas de Limpieza	Sistemas para limpieza de inyectores
266	Máquinas de Ultrasonido	Máquinas de limpieza por ultrasonido
267	Lavadoras de Piezas	Lavadoras para componentes mecánicos
268	Cepillos Industriales	Cepillos para limpieza de componentes
269	Pistolas de Vapor	Pistolas de vapor para limpieza profunda
270	Aspiradoras Industriales	Aspiradoras para taller mecánico
271	Sistemas de Almacenamiento	Sistemas de almacenamiento para repuestos
272	Estanterías	Estanterías para taller y almacén
273	Carros de Herramientas	Carros móviles para herramientas
274	Gabinetes	Gabinetes de almacenamiento seguro
275	Organizadores de Tornillería	Organizadores para tornillos y pequeños componentes
276	Sistemas de Etiquetado	Sistemas para identificación de componentes
277	Contenedores	Contenedores para líquidos y productos
278	Bidones	Bidones para aceite y combustibles
279	Embudos	Embudos para llenado de líquidos
280	Jeringas	Jeringas para medición precisa de líquidos
281	Básculas	Básculas para pesaje de componentes
282	Dinamómetros	Dinamómetros para medición de potencia
283	Sistemas de Medición de Potencia	Sistemas completos para medición de performance
284	Analizadores de Combustión	Analizadores para eficiencia de combustión
285	Sistemas de Adquisición de Datos	Sistemas para registro de parámetros
286	Cámaras de Inspección	Cámaras para inspección interna
287	Endoscopios	Endoscopios para motores y componentes
288	Lupas de Inspección	Lupas para inspección detallada
289	Lámparas de Trabajo	Lámparas para iluminación de trabajo
290	Espejos de Inspección	Espejos para áreas de difícil acceso
291	Imanes de Recuperación	Imanes para recuperación de componentes
292	Soportes para Líquidos	Soportes para contenedores de líquidos
293	Bombas de Transferencia	Bombas para transferencia de líquidos
294	Filtros para Líquidos	Filtros para aceite y otros líquidos
295	Separadores de Agua	Separadores de agua para aire comprimido
296	Secadores de Aire	Secadores para sistemas de aire comprimido
297	Lubricadores de Aire	Lubricadores para herramientas neumáticas
298	Reguladores de Aire	Reguladores para presión de aire
299	Mangueras de Aire	Mangueras para aire comprimido
300	Acoples Rápidos	Acoples para herramientas neumáticas
301	Pistolas de Aire	Pistolas para limpieza con aire
302	Llaves Neumáticas	Llaves de impacto neumáticas
303	Lijadoras Neumáticas	Lijadoras y pulidoras neumáticas
304	Taladros Neumáticos	Taladros de aire comprimido
305	Sistemas de Pintura	Sistemas para pintura y acabado
306	Pistolas de Pintura	Pistolas para aplicación de pintura
307	Compresores de Aire	Compresores para taller
308	Tanques de Aire	Tanques de almacenamiento de aire
309	Sistemas de Filtrado	Sistemas de filtrado para pintura
310	Cabinas de Pintura	Cabinas para aplicación de pintura
311	Secadores de Pintura	Secadores para acabado de pintura
312	Pulidoras	Pulidoras eléctricas y neumáticas
313	Buffers	Buffers para acabado de pintura
314	Compuestos de Pulido	Compuestos para diferentes etapas de pulido
315	Lijas	Lijas de diferentes granos para preparación
316	Masillas	Masillas para reparación de superficies
317	Primers	Primers para preparación de superficie
318	Pinturas Especializadas	Pinturas para moto y alta temperatura
319	Clear Coats	Barnices de protección para pintura
320	Decals y Calcomanías	Calcomanías y gráficos para moto
321	Kits de Personalización	Kits para personalización estética
322	Asientos Personalizados	Asientos de diseño y comfort mejorado
323	Manubrios Deportivos	Manubrios de diferentes alturas y diseños
324	Pegs Deportivos	Estribos deportivos y reubicables
325	Levas de Cambio	Levas de cambio deportivas y ajustables
326	Pedales Deportivos	Pedales de freno y cambio deportivos
327	Sistemas de Escape Deportivos	Escapes de alto rendimiento
328	Filtros de Aire Deportivos	Filtros de alto flujo para performance
329	Kits de Relación	Kits de relación corta para aceleración
330	Sistemas de Refrigeración Mejorada	Sistemas de refrigeración de alto rendimiento
331	Bombas de Agua Deportivas	Bombas de agua de alto flujo
332	Radiadores Mejorados	Radiadores de aluminio y mayor capacidad
333	Ventiladores de Alto Rendimiento	Ventiladores de mayor flujo de aire
334	Termostatos de Apertura Rápida	Termostatos para mejor control térmico
335	Sistemas de Inyección Mejorada	Componentes para inyección de alto rendimiento
336	Bombas de Combustible de Alto Flujo	Bombas para motores modificados
337	Reguladores de Presión Ajustables	Reguladores para ajuste de presión
338	Rails de Combustible	Rails de combustible de mayor capacidad
339	Inyectores de Alto Flujo	Inyectores para mayor potencia
340	Sensores de Amplio Rango	Sensores para sistemas modificados
341	ECUs Programables	ECUs para tuning y modificación
342	Kits de Turbo	Kits completos para turboalimentación
343	Kits de Supercargador	Kits para sobrealimentación mecánica
344	Intercoolers	Intercoolers para sistemas turbo
345	Válvulas Blow-Off	Válvulas para sistemas turbo
346	Wastegates	Válvulas wastegate para control de boost
347	Boost Controllers	Controladores de boost electrónicos
348	Sistemas de Inyección de Agua/Metanol	Sistemas para enfriamiento de carga
349	Kits de Óxido Nitroso	Kits para inyección de NOS
350	Sistemas de Encendido Mejorado	Sistemas de encendido de alta energía
351	Distribuidores Deportivos	Distribuidores de alto rendimiento
352	Avanzadores de Encendido	Avanzadores para optimización de encendido
353	Sistemas de Admisión Mejorada	Sistemas de admisión de aire frío
354	Colectores de Admisión	Colectores de admisión de alto flujo
355	Bodies de Mariposa	Bodies de mariposa de mayor diámetro
356	Sistemas de Escape Completo	Sistemas de escape header-to-muffler
357	Headers de Alto Flujo	Headers para mejor extracción de gases
358	Colectores de Escape	Colectores para sistemas de escape
359	Silenciadores Deportivos	Silenciadores de menor restricción
360	Sistemas de Emisiones	Componentes para control de emisiones
361	Sensores de Emisiones	Sensores para sistemas de emisiones
362	Válvulas EGR	Válvulas de recirculación de gases
363	Sistemas PCV	Sistemas de ventilación positiva del cárter
364	Canisters	Canisters para evaporación de combustible
365	Sensores EVAP	Sensores para sistema de evaporación
366	Sistemas de Diagnóstico Avanzado	Sistemas para diagnóstico complejo
367	Equipos de Alineación	Equipos para alineación de ruedas
368	Sistemas de Balanceo	Sistemas para balanceo dinámico
369	Medidores de Ángulo	Medidores para ángulo de giro
370	Sistemas de Medición de Chasis	Sistemas para verificación de chasis
371	Herramientas para Cuadro	Herramientas específicas para chasis
372	Sistemas de Enderezado	Sistemas para enderezado de cuadro
373	Puntos de Anclaje	Puntos de anclaje para trabajo en chasis
374	Soportes para Motor	Soportes para extracción de motor
375	Polipastos	Polipastos para manejo de motores
376	Mesas Elevadoras	Mesas para elevación de motocicletas
377	Sistemas de Sujeción	Sistemas para sujeción segura de motos
378	Rodillos para Trabajo	Rodillos para movimiento de motos
379	Protecciones para Taller	Protecciones para piso y áreas de trabajo
380	Señalización de Seguridad	Señales para áreas de taller
381	Extintores	Extintores para taller mecánico
382	Kits de Primeros Auxilios	Kits de emergencia para taller
383	Equipo de Limpieza	Equipo para limpieza de taller
384	Sistemas de Ventilación	Sistemas de ventilación para taller
385	Iluminación de Taller	Sistemas de iluminación profesional
386	Sistemas de Energía	Sistemas de energía para herramientas
387	Regletas de Conexión	Regletas para conexión eléctrica
388	Transformadores	Transformadores para diferentes voltajes
389	Estabilizadores de Voltaje	Estabilizadores para equipo sensible
390	Sistemas de Tierra	Sistemas de puesta a tierra para taller
391	Equipo de Comunicación	Equipo para comunicación en taller
392	Sistemas de Gestión	Sistemas de gestión para taller
393	Software de Taller	Software para administración de taller
394	Sistemas de Inventario	Sistemas para control de inventario
395	Equipo de Oficina	Equipo para área administrativa
396	Mobiliario de Taller	Mobiliario para áreas de trabajo
397	Equipo de Descanso	Equipo para áreas de descanso
398	Sistemas de Climatización	Sistemas de aire acondicionado y calefacción
399	Equipo de Lavado	Equipo para lavado y detailing de motos
400	Sistemas de Secado	Sistemas para secado de motos
401	Productos de Detailing	Productos para acabado profesional
402	Pulidores Profesionales	Pulidores de alta calidad para detailing
403	Selladores Profesionales	Selladores para protección duradera
404	Tratamientos de Pintura	Tratamientos especializados para pintura
405	Restauradores de Plástico	Productos para restauración de plásticos
406	Tratamientos de Cuero	Productos para cuidado de asientos de cuero
407	Protectores de Metal	Protectores para partes metálicas
408	Renovadores de Goma	Productos para renovación de gomas
409	Limpiadores de Alfombras	Productos para limpieza de alfombrillas
410	Desinfectantes	Desinfectantes para áreas de contacto
411	Ambientadores	Ambientadores para taller y motos
412	Productos de Mantenimiento Interior	Productos para limpieza interior
413	Kits de Limpieza	Kits completos para limpieza y detailing
414	Sistemas de Almacenamiento de Productos	Sistemas para organización de productos
415	Exhibidores	Exhibidores para productos y repuestos
416	Material POP	Material punto de venta para productos
417	Sistemas de Etiquetado de Productos	Sistemas para etiquetado en góndola
418	Embalajes	Embalajes para envío y almacenamiento
419	Material de Seguridad	Material para seguridad en manejo de productos
420	Equipo de Transporte	Equipo para transporte de mercancía
421	Sistemas de Logística	Sistemas para gestión logística
422	Software de Ventas	Software para punto de venta y facturación
423	Terminales Punto de Venta	Terminales para procesamiento de ventas
424	Sistemas de Pago	Sistemas para aceptación de pagos
425	Equipo de Cobro	Equipo para gestión de cobranza
426	Sistemas de Fidelización	Sistemas para programas de fidelidad
427	Material de Mercadotecnia	Material para promoción y marketing
428	Sistemas de Atención a Clientes	Sistemas para servicio al cliente
429	Equipo de Comunicación con Clientes	Equipo para comunicación con clientes
430	Sistemas de Cita Previa	Sistemas para gestión de citas
431	Software de Agenda	Software para programación de trabajo
432	Sistemas de Recordatorio	Sistemas para recordatorios a clientes
433	Equipo de Encuestas	Equipo para evaluación de satisfacción
434	Sistemas de Garantía	Sistemas para gestión de garantías
435	Software de Servicio Técnico	Software para gestión de servicio técnico
436	Sistemas de Historial	Sistemas para historial de vehículos
437	Equipo de Diagnóstico Remoto	Equipo para diagnóstico a distancia
438	Sistemas de Consulta Técnica	Sistemas para consulta de información técnica
439	Bases de Datos Técnicas	Bases de datos con información técnica
440	Manuales de Servicio	Manuales para reparación y mantenimiento
441	Diagramas Eléctricos	Diagramas para sistemas eléctricos
442	Esquemas de Partes	Esquemas para identificación de componentes
443	Software de Diagramas	Software para visualización de esquemas
444	Sistemas de Actualización	Sistemas para actualización de información
445	Equipo de Capacitación	Equipo para entrenamiento técnico
446	Material de Entrenamiento	Material para programas de capacitación
447	Simuladores	Simuladores para entrenamiento técnico
448	Kits de Práctica	Kits para prácticas de aprendizaje
449	Sistemas de Evaluación	Sistemas para evaluación de habilidades
450	Certificaciones	Material para programas de certificación
451	Equipo de Demostración	Equipo para demostraciones técnicas
452	Sistemas de Presentación	Sistemas para presentaciones técnicas
453	Material de Referencia	Material de referencia técnica
454	Biblioteca Técnica	Sistemas para biblioteca técnica
455	Sistemas de Consulta Rápida	Sistemas para consulta rápida de datos
456	Equipo de Medición Avanzada	Equipo para medición de precisión
457	Sistemas de Calibración	Sistemas para calibración de equipo
458	Patrones de Referencia	Patrones para verificación de mediciones
459	Equipo de Metrología	Equipo para ciencia de medición
460	Sistemas de Trazabilidad	Sistemas para trazabilidad de mediciones
461	Equipo de Control de Calidad	Equipo para control de calidad
462	Sistemas de Inspección	Sistemas para inspección de componentes
463	Equipo de Pruebas No Destructivas	Equipo para pruebas NDT
464	Sistemas de Documentación	Sistemas para documentación de calidad
465	Software de Calidad	Software para gestión de calidad
466	Sistemas de Auditoría	Sistemas para auditorías de calidad
467	Equipo de Medición Ambiental	Equipo para medición ambiental
468	Sistemas de Monitoreo	Sistemas para monitoreo de condiciones
469	Equipo de Seguridad Industrial	Equipo para seguridad en taller
470	Sistemas de Protección Personal	Sistemas EPP para taller
471	Equipo de Emergencia	Equipo para situaciones de emergencia
472	Sistemas de Alarma de Taller	Sistemas de alarma para instalaciones
473	Equipo de Monitoreo de Seguridad	Equipo para vigilancia de taller
474	Sistemas de Control de Acceso	Sistemas para control de acceso
475	Equipo de Comunicación Interna	Equipo para comunicación interna
476	Sistemas de Gestión de Taller	Sistemas integrales para taller
477	Software de Productividad	Software para mejora de productividad
478	Sistemas de Automatización	Sistemas para automatización de procesos
479	Equipo de Digitalización	Equipo para digitalización de taller
480	Sistemas de IoT	Sistemas de Internet de las Cosas para taller
481	Equipo de Realidad Aumentada	Equipo AR para asistencia en reparaciones
482	Sistemas de Visión Artificial	Sistemas para inspección automatizada
483	Robots de Taller	Robots para tareas repetitivas
484	Sistemas de Transporte Automatizado	Sistemas para movimiento de componentes
485	Equipo de Impresión 3D	Equipo para fabricación de repuestos
486	Sistemas de CAD/CAM	Sistemas para diseño y fabricación
487	Software de Diseño	Software para diseño técnico
488	Equipo de Prototipado	Equipo para creación de prototipos
489	Sistemas de Pruebas Virtuales	Sistemas para simulaciones
490	Equipo de Análisis Estructural	Equipo para análisis de componentes
491	Sistemas de Ingeniería Inversa	Sistemas para reproducción de piezas
492	Equipo de Medición 3D	Equipo para escaneo tridimensional
493	Sistemas de Documentación 3D	Sistemas para modelado tridimensional
494	Software de Gestión de Proyectos	Software para proyectos especiales
495	Sistemas de Colaboración	Sistemas para trabajo en equipo
496	Equipo de Videoconferencia	Equipo para reuniones técnicas
497	Sistemas de Compartición	Sistemas para compartición de datos
498	Plataformas Cloud	Plataformas en la nube para taller
499	Sistemas de Backup	Sistemas para respaldo de información
500	Equipo de Ciberseguridad	Equipo para protección de datos
501	Sistemas de Red	Sistemas de red para conectividad
502	Equipo de Telecomunicaciones	Equipo para comunicaciones avanzadas
503	Sistemas de Energía Ininterrumpida	Sistemas UPS para equipo crítico
504	Equipo de Mantenimiento Preventivo	Equipo para mantenimiento de instalaciones
505	Rines	Rines de diferentes motos
127	Abrazadera	Abrazaderas para mangueras y tuberías
\.


--
-- TOC entry 5048 (class 0 OID 16704)
-- Dependencies: 236
-- Data for Name: cita_servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cita_servicios (id, cita_id, servicio_id) FROM stdin;
3	3	152
5	5	102
7	7	322
8	1008	2
\.


--
-- TOC entry 5046 (class 0 OID 16684)
-- Dependencies: 234
-- Data for Name: citas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.citas (id, cliente_id, moto_id, telefono, email, kilometros, fecha_cita, hora_llegada, estado, fecha_creacion) FROM stdin;
1008	509	517	5611464178		30000	2025-11-20	16:05:00	completada	2025-11-20 16:50:49.968783
3	502	9	5487986854		50000	2025-10-30	15:06:00	Lista para entregar	2025-10-30 15:07:06.649276
5	504	11	5658595457		5000	2025-11-05	14:32:00	Lista para entregar	2025-11-05 14:32:46.547016
7	507	15	556856		10	2025-11-12	14:40:00	En diagnóstico	2025-11-12 14:40:20.330019
508	109	79	555-2720	cliente29@example.com	52452	2023-01-11	11:14:34.299179	En reparación / Servicio	2023-07-26 15:51:29.066248
509	416	79	555-9862	cliente216@example.com	30857	2024-05-18	08:34:39.487769	Esperando refacciones / Productos	2024-09-10 15:50:28.260813
510	428	79	555-7987	\N	50920	2024-08-28	10:48:46.391043	En reparación / Servicio	2024-06-10 16:16:40.742952
511	485	79	555-1802	cliente152@example.com	66929	2024-02-24	14:14:51.872149	Esperando refacciones / Productos	2025-08-06 15:18:51.651072
512	61	79	555-7541	cliente147@example.com	21464	2023-11-02	16:02:32.320197	Esperando refacciones / Productos	2023-08-24 14:50:39.855961
513	378	79	555-5583	cliente363@example.com	14558	2024-12-17	11:21:57.233019	En diagnóstico	2023-04-07 15:44:03.546301
514	284	79	555-5151	\N	17866	2025-05-23	14:04:16.494666	Esperando refacciones / Productos	2023-05-25 16:25:19.772897
515	302	79	555-1515	cliente177@example.com	33619	2025-03-02	17:59:45.414237	En diagnóstico	2023-10-26 16:17:36.400359
516	43	79	555-3431	\N	32370	2023-11-11	17:42:49.688708	Lista para entregar	2023-05-06 16:11:24.696026
517	176	79	555-5310	cliente34@example.com	49503	2023-07-25	10:04:52.144235	Esperando refacciones / Productos	2024-09-03 15:03:16.30604
518	191	79	555-8142	cliente3@example.com	16758	2024-08-28	11:33:37.544748	Esperando refacciones / Productos	2023-07-30 16:22:58.378033
519	381	79	555-6282	\N	42087	2023-03-14	16:43:46.121073	En diagnóstico	2024-03-18 16:16:03.097676
520	300	79	555-6309	cliente477@example.com	26377	2023-09-14	15:27:56.851675	Esperando refacciones / Productos	2024-01-15 16:25:06.895628
521	239	79	555-1645	\N	43481	2023-10-08	15:25:57.325929	Esperando refacciones / Productos	2024-06-20 16:02:51.822923
522	161	79	555-5576	\N	10816	2024-10-30	13:51:51.847086	En diagnóstico	2024-07-08 15:02:33.984502
523	241	79	555-1606	\N	33981	2023-09-26	16:17:46.814629	En reparación / Servicio	2024-12-10 15:36:04.795551
524	111	79	555-8208	cliente76@example.com	63287	2023-09-15	17:11:49.6819	Esperando refacciones / Productos	2024-11-22 15:49:55.816857
525	500	79	555-1863	cliente373@example.com	39085	2024-02-09	10:31:30.16943	Esperando refacciones / Productos	2023-03-05 15:44:20.668012
526	121	79	555-5958	\N	21346	2025-04-04	15:31:45.051267	En reparación / Servicio	2023-10-20 15:39:29.553427
527	115	79	555-8504	cliente376@example.com	42489	2023-11-12	16:55:15.273081	En diagnóstico	2025-05-29 16:18:31.668096
528	92	79	555-8069	\N	36618	2025-09-03	14:00:40.653413	En diagnóstico	2025-01-25 16:29:54.088189
529	333	79	555-5605	cliente82@example.com	53313	2025-06-03	16:39:15.966555	Esperando refacciones / Productos	2023-09-21 15:40:34.880243
530	348	79	555-5231	cliente274@example.com	17831	2025-10-24	14:00:17.145254	Esperando refacciones / Productos	2024-07-10 16:47:56.574388
531	130	79	555-1972	\N	74669	2024-07-15	14:13:21.361122	En diagnóstico	2024-01-15 15:32:13.911547
532	9	79	555-6686	cliente38@example.com	8285	2023-01-26	12:34:49.451724	En reparación / Servicio	2025-09-16 16:42:02.206803
533	49	79	555-5670	cliente418@example.com	35758	2025-05-15	13:25:32.43005	Esperando refacciones / Productos	2023-06-22 16:18:38.351959
534	476	79	555-3430	cliente34@example.com	36662	2023-06-04	15:42:30.531013	Esperando refacciones / Productos	2023-05-28 15:01:14.461569
535	24	79	555-3117	cliente70@example.com	4667	2025-05-20	17:20:03.661874	En diagnóstico	2023-11-23 16:45:56.687706
536	105	79	555-8499	cliente291@example.com	76813	2025-06-14	13:17:44.353859	En diagnóstico	2023-12-14 16:45:41.340507
537	383	79	555-1704	cliente426@example.com	53265	2024-08-11	15:01:04.719293	En reparación / Servicio	2024-03-17 16:19:03.310416
538	18	79	555-1875	\N	60785	2023-04-27	17:30:13.519637	En reparación / Servicio	2022-12-16 15:02:12.777848
539	156	79	555-2361	cliente71@example.com	6665	2024-09-12	11:50:16.270203	En reparación / Servicio	2023-11-12 15:09:29.982779
540	318	79	555-4512	cliente398@example.com	76225	2024-02-27	10:47:33.481819	En diagnóstico	2023-12-06 15:22:00.617807
541	106	79	555-9741	\N	28059	2023-04-03	16:47:36.711951	Esperando refacciones / Productos	2024-05-05 15:58:36.157868
542	186	79	555-2342	\N	14912	2024-10-13	08:48:54.805392	En diagnóstico	2025-02-01 16:49:02.316344
543	78	79	555-5275	\N	63126	2023-03-11	13:18:12.30879	Lista para entregar	2023-05-25 15:57:10.434083
544	109	79	555-4794	cliente397@example.com	55047	2025-03-31	16:37:41.934554	Lista para entregar	2025-07-16 15:46:53.566366
545	174	79	555-1958	cliente388@example.com	68899	2024-05-11	15:18:46.218638	En diagnóstico	2023-09-06 15:53:01.967472
546	1	79	555-8021	cliente265@example.com	15565	2023-05-09	14:40:53.789685	En reparación / Servicio	2023-02-08 14:54:24.058572
547	282	79	555-4607	cliente275@example.com	20234	2024-01-08	10:13:35.20402	Esperando refacciones / Productos	2023-03-02 14:59:44.78119
548	13	79	555-2872	cliente166@example.com	32284	2023-01-03	15:08:45.134505	Lista para entregar	2025-08-13 15:43:42.283718
549	271	79	555-6812	cliente181@example.com	6640	2024-05-23	17:07:21.863384	En diagnóstico	2023-12-13 15:20:46.698483
550	315	79	555-7786	cliente157@example.com	22835	2025-03-29	13:58:41.13496	Esperando refacciones / Productos	2023-12-23 15:02:22.975617
551	225	79	555-9261	cliente489@example.com	12980	2025-10-29	12:31:28.050476	En reparación / Servicio	2024-10-19 15:03:22.927898
552	140	79	555-1585	cliente168@example.com	1331	2025-10-27	11:42:01.110909	En reparación / Servicio	2024-11-04 14:58:46.040398
553	192	79	555-6553	cliente32@example.com	17966	2025-02-12	14:11:12.185053	En diagnóstico	2025-07-18 15:55:14.784225
554	212	79	555-2127	cliente63@example.com	51431	2024-03-26	15:53:10.337257	Esperando refacciones / Productos	2024-08-19 15:15:02.922572
555	455	79	555-8317	cliente81@example.com	52148	2023-07-09	12:58:02.41628	Esperando refacciones / Productos	2023-01-03 15:51:49.675977
556	260	79	555-2586	cliente164@example.com	51930	2024-06-19	17:21:14.720834	En reparación / Servicio	2023-03-28 16:06:27.489625
557	369	79	555-3611	\N	23012	2025-09-15	17:55:01.315756	Esperando refacciones / Productos	2023-10-05 16:05:15.434134
558	291	79	555-5793	cliente363@example.com	77890	2024-05-30	11:47:56.224797	En diagnóstico	2023-03-21 16:17:15.223218
559	338	79	555-5817	\N	76680	2025-01-10	08:46:42.809174	En diagnóstico	2023-05-02 16:22:39.364587
560	357	79	555-2327	\N	74591	2023-07-06	08:39:26.299993	En reparación / Servicio	2024-01-01 16:07:07.232658
561	299	79	555-3708	\N	4636	2023-11-17	13:22:10.155039	En reparación / Servicio	2024-02-18 15:53:46.270935
562	100	79	555-9807	\N	4246	2023-11-12	08:43:23.82375	En reparación / Servicio	2023-07-31 15:47:39.43062
563	403	79	555-7879	cliente376@example.com	39941	2025-09-09	16:58:44.597662	En reparación / Servicio	2025-03-06 16:48:39.353899
564	32	79	555-8902	\N	78781	2025-09-02	15:53:44.963181	En diagnóstico	2024-04-18 16:15:52.624483
565	311	79	555-2346	\N	54425	2024-07-21	10:03:47.806702	En reparación / Servicio	2023-01-21 16:31:38.571492
566	306	79	555-9927	\N	51651	2023-04-20	12:31:47.792749	En diagnóstico	2024-01-07 16:06:11.795377
567	65	79	555-3091	cliente90@example.com	48952	2025-01-17	16:28:27.563348	En diagnóstico	2025-09-15 16:22:17.514861
568	93	79	555-8383	cliente134@example.com	15813	2025-03-26	16:25:15.181508	En diagnóstico	2023-07-18 15:49:05.137934
569	330	79	555-9271	cliente172@example.com	36866	2025-08-20	11:12:34.646219	Esperando refacciones / Productos	2023-04-10 16:47:54.362515
570	239	79	555-9653	cliente102@example.com	44506	2024-08-10	08:56:27.942678	En reparación / Servicio	2023-12-29 16:23:31.127633
571	349	79	555-4733	cliente424@example.com	69877	2024-08-06	09:35:48.838334	En reparación / Servicio	2024-09-17 14:59:42.409421
572	369	79	555-1770	cliente231@example.com	51626	2023-12-11	10:16:35.25159	Esperando refacciones / Productos	2023-09-01 15:32:32.755778
573	274	79	555-1472	cliente277@example.com	38804	2023-12-18	09:15:46.305219	En diagnóstico	2024-10-23 16:22:53.631905
574	104	79	555-5961	cliente178@example.com	7690	2023-02-09	09:50:47.029633	En reparación / Servicio	2025-01-30 15:00:10.585554
575	207	79	555-2333	\N	51729	2024-10-21	10:16:30.68765	En diagnóstico	2023-02-21 16:33:37.244285
576	263	79	555-6196	\N	8573	2025-01-05	14:33:40.353062	Lista para entregar	2024-06-07 15:57:08.979043
577	168	79	555-5646	cliente83@example.com	5091	2024-03-23	15:36:08.959104	Esperando refacciones / Productos	2024-08-26 16:20:10.38276
578	427	79	555-9434	cliente231@example.com	53841	2023-03-02	13:32:43.418966	En reparación / Servicio	2025-05-25 16:02:22.67211
579	498	79	555-2360	\N	40361	2025-07-04	15:35:40.130759	Esperando refacciones / Productos	2024-04-03 15:43:11.981316
580	432	79	555-7784	cliente196@example.com	18849	2023-10-15	10:21:12.657102	Esperando refacciones / Productos	2025-04-28 16:10:12.708525
581	172	79	555-1354	cliente203@example.com	17663	2023-05-19	09:51:51.672405	Esperando refacciones / Productos	2023-03-21 15:50:16.683318
582	434	79	555-6385	cliente31@example.com	30314	2023-05-25	13:34:32.967739	Esperando refacciones / Productos	2024-07-15 15:47:41.716243
583	479	79	555-8370	cliente238@example.com	61143	2024-06-23	12:15:57.170974	En diagnóstico	2023-10-11 15:24:35.516074
584	350	79	555-2468	\N	24472	2025-03-27	11:56:09.876077	En reparación / Servicio	2024-11-09 16:31:56.719077
585	94	79	555-1021	cliente69@example.com	76059	2025-02-26	08:22:31.147187	En diagnóstico	2025-09-10 15:40:19.17299
586	277	79	555-2936	\N	38625	2024-12-18	17:09:27.516578	En diagnóstico	2023-08-20 15:00:24.528849
587	343	79	555-3738	cliente393@example.com	74845	2024-07-28	13:01:55.199896	En diagnóstico	2025-05-04 16:26:25.588759
588	88	79	555-6794	\N	19100	2023-02-01	14:50:30.096511	En diagnóstico	2024-04-22 16:39:06.190827
589	171	79	555-4088	cliente357@example.com	2700	2024-07-08	15:31:39.466372	En diagnóstico	2025-08-10 16:26:26.243146
590	164	79	555-2827	\N	55809	2023-08-22	09:35:55.491396	Lista para entregar	2024-08-04 15:25:41.504378
591	71	79	555-4726	cliente415@example.com	67002	2025-04-15	08:46:10.012694	En reparación / Servicio	2025-01-20 15:20:56.365642
592	345	79	555-5205	cliente447@example.com	61781	2024-12-15	14:06:38.091473	En reparación / Servicio	2023-09-08 15:42:41.483668
593	363	79	555-3650	cliente296@example.com	3653	2025-09-05	11:11:42.379573	En reparación / Servicio	2025-09-07 14:56:44.247062
594	293	79	555-2179	\N	3742	2024-07-08	16:53:10.244388	En reparación / Servicio	2024-10-15 16:45:20.17763
595	373	79	555-8360	cliente262@example.com	20218	2025-01-16	10:55:07.602061	En reparación / Servicio	2024-05-30 15:50:30.532214
596	69	79	555-1075	\N	42265	2023-11-07	08:29:13.442086	Esperando refacciones / Productos	2025-07-06 15:53:12.378817
597	75	79	555-7712	cliente419@example.com	25285	2023-09-03	08:00:51.581824	En reparación / Servicio	2025-10-27 16:01:37.328933
598	325	79	555-5280	\N	64468	2023-08-10	16:27:21.288549	En diagnóstico	2023-09-02 15:50:00.887041
599	379	79	555-5515	\N	12607	2022-11-28	12:22:37.97738	En diagnóstico	2024-03-07 14:55:55.41325
600	123	79	555-1357	\N	41324	2024-08-12	11:29:49.697167	En diagnóstico	2023-06-29 16:28:52.981219
601	145	79	555-3612	cliente180@example.com	17012	2023-05-17	09:54:58.468854	En reparación / Servicio	2025-01-04 16:25:32.700844
602	333	79	555-4990	cliente19@example.com	72694	2024-06-26	08:01:06.166544	En diagnóstico	2023-12-04 15:33:44.222783
603	165	79	555-3045	\N	2354	2022-12-23	08:58:15.541282	En reparación / Servicio	2025-01-07 15:20:51.607301
604	373	79	555-7893	\N	21069	2025-07-27	15:27:47.816949	En reparación / Servicio	2025-07-17 15:40:15.896188
605	426	79	555-2645	\N	53448	2023-06-24	17:52:51.610342	En diagnóstico	2023-02-05 15:37:08.497031
606	337	79	555-3696	cliente146@example.com	19361	2023-09-18	09:33:30.166335	En diagnóstico	2024-06-25 15:59:48.581079
607	136	79	555-1580	\N	22038	2024-09-05	14:24:00.395258	Esperando refacciones / Productos	2024-01-22 15:52:11.640197
608	116	79	555-1270	cliente421@example.com	42260	2024-03-27	11:04:43.306323	Esperando refacciones / Productos	2023-12-18 16:43:38.790938
609	195	79	555-8244	cliente436@example.com	77336	2024-09-03	08:24:38.018006	Lista para entregar	2023-03-22 16:39:31.890888
610	232	79	555-4562	cliente384@example.com	77987	2024-10-28	11:05:54.312279	En reparación / Servicio	2023-09-28 15:55:40.07073
611	290	79	555-8187	cliente142@example.com	32684	2023-07-30	17:18:20.205745	En reparación / Servicio	2023-10-16 15:51:49.899907
612	422	79	555-7070	cliente430@example.com	79098	2022-11-22	11:08:33.328252	Esperando refacciones / Productos	2025-11-09 16:11:11.849481
613	13	79	555-8349	\N	39631	2025-10-13	15:03:09.11126	En reparación / Servicio	2025-07-10 15:53:11.536173
614	240	79	555-7458	\N	44609	2024-12-01	09:01:32.782557	Esperando refacciones / Productos	2025-02-06 16:13:16.702282
615	212	79	555-1816	cliente291@example.com	56698	2025-06-26	11:46:29.633572	En reparación / Servicio	2023-12-24 16:13:54.501245
616	333	79	555-3005	cliente184@example.com	20216	2023-05-30	09:37:19.106597	En reparación / Servicio	2025-10-22 15:09:45.947048
617	379	79	555-1120	cliente250@example.com	30909	2025-09-02	10:47:13.050473	Esperando refacciones / Productos	2024-01-16 15:10:52.82005
618	446	79	555-6459	cliente192@example.com	58800	2023-01-06	09:00:49.140428	Esperando refacciones / Productos	2024-04-15 15:48:11.7753
619	163	79	555-7734	cliente111@example.com	10528	2023-07-30	17:05:26.532729	Esperando refacciones / Productos	2024-02-22 16:16:56.372707
620	125	79	555-1735	\N	67986	2023-09-16	16:13:35.630322	En reparación / Servicio	2023-11-25 15:27:06.583892
621	20	79	555-9273	\N	20701	2023-05-17	10:10:39.712066	En reparación / Servicio	2023-09-28 15:04:03.733501
622	106	79	555-5240	cliente89@example.com	6307	2023-05-27	13:53:38.60689	En diagnóstico	2025-07-20 16:28:11.597214
623	193	79	555-5772	cliente420@example.com	78021	2025-06-18	16:44:49.041906	En diagnóstico	2024-05-03 15:04:59.024974
624	58	79	555-8591	cliente341@example.com	13997	2025-04-13	08:15:41.77375	En reparación / Servicio	2025-05-11 16:47:03.362621
625	144	79	555-9455	cliente218@example.com	39067	2024-02-28	16:48:23.966389	En reparación / Servicio	2024-06-30 15:22:44.640752
626	464	79	555-9433	cliente51@example.com	27262	2024-08-05	12:19:17.063689	Esperando refacciones / Productos	2023-01-20 15:28:08.852871
627	437	79	555-5632	cliente39@example.com	15092	2024-04-29	10:03:23.802503	Esperando refacciones / Productos	2025-02-25 15:43:23.155691
628	3	79	555-1423	cliente293@example.com	63314	2024-05-27	11:14:43.859929	En reparación / Servicio	2023-12-29 15:35:38.106683
629	406	79	555-8563	cliente18@example.com	57697	2025-08-06	09:49:39.279836	En reparación / Servicio	2024-04-14 16:20:33.237369
630	175	79	555-2869	cliente343@example.com	45326	2023-10-25	17:41:35.345949	Esperando refacciones / Productos	2022-12-02 15:33:14.134777
631	443	79	555-3994	cliente132@example.com	18581	2025-02-02	12:44:21.925787	En diagnóstico	2025-05-25 15:51:16.60024
632	9	79	555-9446	\N	35058	2024-11-29	15:59:01.934971	En reparación / Servicio	2024-10-01 15:46:56.595888
633	75	79	555-1111	cliente177@example.com	53797	2025-10-20	11:19:57.435792	Esperando refacciones / Productos	2025-06-14 15:22:06.87122
634	86	79	555-4613	\N	32269	2023-06-16	10:45:48.048112	En reparación / Servicio	2023-02-20 15:01:06.249235
635	11	79	555-6689	\N	47480	2025-10-12	10:43:46.884128	En reparación / Servicio	2025-06-11 15:48:33.530041
636	163	79	555-5791	cliente286@example.com	11520	2025-09-16	13:13:33.993058	En reparación / Servicio	2024-03-11 16:47:32.259728
637	124	79	555-6534	cliente201@example.com	53659	2022-12-31	10:54:30.962949	Lista para entregar	2025-04-27 14:58:30.090166
638	310	79	555-5523	cliente296@example.com	5220	2023-02-28	09:54:25.263834	En diagnóstico	2024-08-19 16:14:46.351459
639	302	79	555-2754	cliente131@example.com	79570	2025-03-25	09:03:35.242451	Esperando refacciones / Productos	2025-06-21 15:34:55.273801
640	123	79	555-5835	cliente2@example.com	2075	2024-05-07	12:27:05.979045	Esperando refacciones / Productos	2023-05-04 15:10:08.146305
641	225	79	555-5660	cliente103@example.com	49396	2025-02-25	08:54:08.10795	En diagnóstico	2024-04-09 15:07:03.095842
642	422	79	555-6961	\N	11687	2023-06-09	08:52:17.181328	En reparación / Servicio	2024-08-27 15:20:42.467086
643	336	79	555-1194	cliente403@example.com	5847	2025-11-13	12:38:26.839836	Lista para entregar	2023-03-16 15:02:22.748027
644	251	79	555-1992	cliente140@example.com	70858	2024-02-04	15:24:13.098833	Esperando refacciones / Productos	2024-05-12 15:36:13.41675
645	195	79	555-9589	\N	50273	2024-10-09	10:41:41.385375	En reparación / Servicio	2023-05-05 15:00:25.106295
646	366	79	555-2869	\N	45163	2023-11-10	08:11:49.077075	En diagnóstico	2024-02-06 16:25:32.575837
647	226	79	555-4792	cliente421@example.com	31950	2025-10-25	08:33:42.537529	Esperando refacciones / Productos	2025-09-04 16:23:03.176859
648	349	79	555-6814	\N	20436	2025-08-23	17:22:56.890048	En reparación / Servicio	2023-10-25 15:59:42.758837
649	376	79	555-2373	cliente351@example.com	12964	2024-06-05	09:55:54.218151	Lista para entregar	2025-10-16 16:29:03.655107
650	163	79	555-6027	cliente405@example.com	34688	2025-02-13	10:55:42.864795	En diagnóstico	2023-10-21 16:21:50.865806
651	254	79	555-7043	cliente83@example.com	62694	2024-07-08	09:52:33.021891	En diagnóstico	2025-02-05 15:01:14.889502
652	422	79	555-1200	cliente89@example.com	41864	2025-05-26	16:02:12.948036	En diagnóstico	2024-04-08 16:03:26.949515
653	201	79	555-8378	cliente499@example.com	4321	2024-10-27	16:24:27.020159	En diagnóstico	2024-04-28 15:30:33.998438
654	263	79	555-7536	\N	67705	2023-01-05	12:31:46.445389	En reparación / Servicio	2023-11-27 16:04:27.17114
655	44	79	555-8875	\N	74234	2023-01-06	09:08:38.419119	En reparación / Servicio	2024-02-28 16:35:54.300532
656	465	79	555-5706	cliente454@example.com	45363	2025-10-12	13:52:32.141771	En diagnóstico	2025-01-13 15:26:44.95824
657	280	79	555-4136	\N	23171	2025-10-03	14:07:08.382658	En diagnóstico	2024-04-09 14:55:33.791546
658	289	79	555-9154	\N	51072	2023-07-30	16:12:38.377495	Esperando refacciones / Productos	2024-12-14 16:01:41.901431
659	29	79	555-6051	cliente52@example.com	39809	2024-05-23	17:08:44.050805	En diagnóstico	2023-02-19 15:20:47.762117
660	298	79	555-8665	\N	64187	2022-12-10	16:53:00.336945	En reparación / Servicio	2024-02-03 15:19:30.425749
661	441	79	555-8682	cliente202@example.com	59122	2025-03-01	12:03:50.047657	En reparación / Servicio	2023-10-09 15:52:12.155252
662	413	79	555-5293	cliente428@example.com	8861	2024-10-02	17:23:53.246546	En reparación / Servicio	2024-07-09 16:09:48.458988
663	371	79	555-3007	\N	54603	2024-10-08	12:59:49.836828	En diagnóstico	2023-08-06 15:20:09.410038
664	362	79	555-3258	cliente401@example.com	52265	2025-11-13	15:33:31.039087	En reparación / Servicio	2025-08-02 15:56:09.763233
665	331	79	555-7169	cliente268@example.com	75348	2025-02-19	14:52:35.254632	En reparación / Servicio	2025-09-27 15:33:02.502653
666	215	79	555-9784	cliente373@example.com	36182	2025-09-28	10:24:29.796795	En reparación / Servicio	2025-08-01 16:06:30.709084
667	205	79	555-4871	cliente425@example.com	9818	2023-12-01	11:35:29.467222	Lista para entregar	2024-01-14 16:42:04.38342
668	426	79	555-4732	cliente394@example.com	63147	2023-12-23	12:23:48.257374	En reparación / Servicio	2023-05-04 14:54:11.157015
669	79	79	555-6309	cliente275@example.com	53047	2025-01-11	11:48:56.820461	En diagnóstico	2024-04-23 15:37:17.574671
670	303	79	555-9845	cliente200@example.com	35475	2025-11-08	12:40:45.328243	En reparación / Servicio	2025-02-07 16:12:55.576535
671	49	79	555-7760	\N	11280	2023-07-24	14:38:29.856102	Esperando refacciones / Productos	2025-09-05 15:09:14.026733
672	472	79	555-9124	cliente412@example.com	63157	2025-06-10	13:19:47.28497	En reparación / Servicio	2024-02-11 14:56:15.832345
673	492	79	555-4044	cliente1@example.com	44085	2024-07-08	15:02:03.895022	Lista para entregar	2023-11-30 16:20:23.703873
674	268	79	555-3186	cliente257@example.com	48556	2024-03-22	08:25:38.554656	Esperando refacciones / Productos	2025-10-11 15:41:54.462981
675	275	79	555-7380	\N	35908	2025-01-28	16:50:43.020649	Lista para entregar	2023-04-22 15:01:09.006646
676	414	79	555-2389	cliente154@example.com	14340	2023-09-26	16:39:59.073248	Esperando refacciones / Productos	2025-10-20 15:26:26.37447
677	360	79	555-5545	cliente483@example.com	27447	2024-01-09	12:17:20.745498	En diagnóstico	2024-12-19 15:42:25.148277
678	451	79	555-1699	cliente65@example.com	65552	2024-07-18	11:38:02.981167	En reparación / Servicio	2025-08-30 16:17:27.964955
679	324	79	555-7630	cliente110@example.com	29405	2023-05-18	11:57:30.213484	Esperando refacciones / Productos	2025-02-19 14:50:12.858923
680	481	79	555-9224	cliente147@example.com	38200	2022-12-07	11:35:09.029588	Esperando refacciones / Productos	2023-09-29 15:28:17.150925
681	170	79	555-3537	cliente485@example.com	23682	2024-06-18	11:46:33.473024	Esperando refacciones / Productos	2024-09-05 16:49:34.483842
682	483	79	555-6571	cliente91@example.com	34357	2024-09-20	16:13:06.647173	En reparación / Servicio	2024-07-20 16:21:29.281341
683	363	79	555-1858	cliente304@example.com	22223	2025-02-25	14:18:30.675261	En reparación / Servicio	2024-02-10 15:59:59.890476
684	467	79	555-9822	\N	56968	2025-06-14	14:49:04.956599	En reparación / Servicio	2023-07-15 15:50:18.187997
685	454	79	555-9953	cliente266@example.com	58565	2023-07-14	11:33:08.312995	Lista para entregar	2025-06-23 15:03:57.245006
686	496	79	555-2229	cliente204@example.com	78593	2025-03-19	16:26:22.089789	En reparación / Servicio	2025-10-30 15:37:52.220586
687	108	79	555-7416	cliente10@example.com	40737	2023-02-12	08:41:43.59979	En diagnóstico	2025-09-23 16:23:00.422994
688	402	79	555-3708	cliente182@example.com	42284	2024-02-09	15:02:32.83025	En reparación / Servicio	2023-07-22 15:33:23.507051
689	192	79	555-9119	cliente66@example.com	41255	2024-09-04	12:13:00.013201	En reparación / Servicio	2024-08-06 15:14:11.90685
690	327	79	555-3174	cliente206@example.com	50373	2025-11-16	11:31:41.937874	Esperando refacciones / Productos	2024-09-04 15:51:24.042578
691	494	79	555-2708	cliente377@example.com	17218	2024-11-15	08:18:43.150517	En reparación / Servicio	2025-07-25 14:52:55.780075
692	394	79	555-8309	cliente379@example.com	54264	2024-11-06	10:30:07.55681	En diagnóstico	2024-02-11 16:09:22.514778
693	255	79	555-9294	cliente494@example.com	73651	2023-04-23	14:42:37.371623	En diagnóstico	2024-03-14 16:25:49.694315
694	418	79	555-1941	\N	33632	2023-05-01	16:32:11.279448	En diagnóstico	2022-12-05 15:08:39.799015
695	175	79	555-8356	cliente140@example.com	21685	2025-03-01	11:20:47.012663	En diagnóstico	2023-04-02 15:53:37.809802
696	282	79	555-7508	cliente132@example.com	73453	2023-06-20	08:16:06.212887	Esperando refacciones / Productos	2024-11-05 15:28:32.4682
697	393	79	555-3694	cliente2@example.com	67962	2025-08-18	09:37:39.395239	En diagnóstico	2025-04-20 16:47:25.684605
698	93	79	555-4126	cliente353@example.com	58992	2023-11-25	10:20:12.752441	En diagnóstico	2024-12-08 16:41:57.002405
699	413	79	555-2261	cliente3@example.com	74649	2023-03-17	11:13:18.386651	En reparación / Servicio	2024-06-03 15:31:19.135626
700	417	79	555-2646	cliente296@example.com	46459	2024-02-13	14:16:11.80868	Lista para entregar	2023-07-01 16:25:14.361489
701	172	79	555-8675	cliente294@example.com	34888	2024-04-25	12:54:23.501426	En diagnóstico	2023-01-04 15:15:21.490896
702	394	79	555-6882	cliente378@example.com	69604	2025-06-28	13:51:52.274944	Esperando refacciones / Productos	2023-07-03 15:19:38.816702
703	108	79	555-1841	cliente466@example.com	32753	2023-03-12	14:14:03.533834	Esperando refacciones / Productos	2023-02-10 14:58:13.694405
704	184	79	555-1011	cliente487@example.com	25627	2025-04-04	12:59:17.041218	En diagnóstico	2025-05-24 16:33:34.297356
705	44	79	555-7827	cliente481@example.com	22911	2023-01-08	12:26:41.763298	Esperando refacciones / Productos	2024-10-17 15:29:36.06241
706	174	79	555-5155	\N	78639	2024-08-17	17:17:47.109866	En reparación / Servicio	2025-03-15 14:49:55.702217
707	175	79	555-5482	cliente71@example.com	25580	2024-09-21	16:29:09.087921	En reparación / Servicio	2025-08-21 15:07:05.683143
708	381	79	555-6766	cliente60@example.com	32344	2023-05-15	13:55:20.709031	En diagnóstico	2025-04-24 14:53:51.224317
709	476	79	555-6878	cliente309@example.com	40113	2025-09-08	16:53:07.21036	En reparación / Servicio	2023-05-16 16:09:14.936975
710	310	79	555-7726	cliente458@example.com	18656	2024-08-05	12:39:54.184677	Esperando refacciones / Productos	2023-12-28 15:53:42.105804
711	61	79	555-5347	\N	60227	2025-03-07	17:50:36.185511	En diagnóstico	2025-11-11 16:27:18.935157
712	100	79	555-9970	\N	6379	2024-05-23	12:20:39.943983	En diagnóstico	2024-08-07 15:57:59.943706
713	501	79	555-6363	cliente31@example.com	4025	2023-06-17	16:34:59.995285	En reparación / Servicio	2025-04-12 15:29:51.226415
714	334	79	555-5913	cliente282@example.com	40041	2024-12-28	16:22:04.086503	En reparación / Servicio	2023-11-06 16:11:03.209721
715	216	79	555-9055	cliente268@example.com	74344	2025-02-18	16:29:07.569927	En reparación / Servicio	2023-08-31 16:29:52.854753
716	456	79	555-6191	cliente266@example.com	13079	2024-08-06	08:28:41.288499	En diagnóstico	2024-12-05 16:03:31.115259
717	214	79	555-5124	cliente416@example.com	76290	2025-11-17	11:38:11.256464	En diagnóstico	2024-02-27 14:51:47.076054
718	154	79	555-1437	\N	23800	2023-06-19	14:40:39.913259	En diagnóstico	2023-03-03 16:04:53.753506
719	65	79	555-3633	cliente197@example.com	30838	2023-01-26	12:02:16.306507	En diagnóstico	2023-01-04 16:38:18.950012
720	484	79	555-1764	cliente450@example.com	39602	2023-09-03	10:14:45.254793	En reparación / Servicio	2023-08-08 15:25:31.815077
721	171	79	555-8702	cliente297@example.com	41057	2025-10-15	10:05:10.33802	Lista para entregar	2023-11-03 15:55:11.958833
722	431	79	555-9040	cliente481@example.com	23915	2023-09-14	09:44:43.273469	En diagnóstico	2024-06-24 16:40:46.874817
723	455	79	555-9793	\N	59595	2023-12-13	09:44:46.413858	En reparación / Servicio	2023-02-03 15:56:28.717114
724	42	79	555-4437	cliente57@example.com	63348	2023-02-03	08:19:43.802423	Esperando refacciones / Productos	2024-07-15 14:51:01.456203
725	395	79	555-4925	cliente166@example.com	35289	2025-11-17	16:02:19.787542	En diagnóstico	2025-08-16 16:05:52.625665
726	65	79	555-5164	cliente454@example.com	64111	2024-03-21	13:20:12.796652	En reparación / Servicio	2025-09-01 16:39:20.027516
727	441	79	555-5649	\N	73877	2024-01-29	17:22:58.086148	En reparación / Servicio	2024-08-31 15:59:09.881531
728	67	79	555-8094	cliente245@example.com	61865	2025-04-29	12:27:32.458168	Esperando refacciones / Productos	2023-10-11 16:16:13.123088
729	214	79	555-3982	cliente289@example.com	16581	2024-05-19	12:55:37.98378	En reparación / Servicio	2024-12-01 15:04:26.629289
730	403	79	555-9282	cliente179@example.com	46631	2025-01-16	08:51:33.782246	En reparación / Servicio	2023-11-04 14:52:28.496539
731	352	79	555-1761	cliente227@example.com	58720	2023-10-02	12:48:19.083217	Esperando refacciones / Productos	2023-10-07 16:21:15.824845
732	311	79	555-5343	cliente330@example.com	4273	2024-12-25	10:51:27.496379	En diagnóstico	2023-01-07 14:57:14.23354
733	107	79	555-8171	cliente436@example.com	75969	2025-08-01	08:50:32.29217	En diagnóstico	2023-02-22 15:07:26.202157
734	468	79	555-9612	cliente171@example.com	76874	2024-10-31	11:41:35.832815	En diagnóstico	2024-05-24 15:02:46.96092
735	152	79	555-2973	\N	46235	2025-02-15	17:34:29.675868	Esperando refacciones / Productos	2023-10-31 16:31:34.352711
736	78	79	555-9883	cliente95@example.com	5791	2025-10-01	10:19:20.575216	Lista para entregar	2023-01-12 15:15:25.606643
737	251	79	555-4001	cliente42@example.com	15920	2023-08-23	16:54:58.177964	En diagnóstico	2024-09-26 15:07:53.880474
738	184	79	555-1610	cliente249@example.com	30946	2025-04-17	14:58:02.841208	Esperando refacciones / Productos	2025-06-15 15:28:56.009765
739	153	79	555-8622	cliente25@example.com	47606	2023-06-06	08:31:03.189395	En diagnóstico	2023-03-21 15:58:08.729973
740	43	79	555-2298	cliente162@example.com	67761	2024-07-19	10:22:13.745894	Esperando refacciones / Productos	2025-07-20 15:14:25.736224
741	120	79	555-7523	\N	60906	2024-01-22	11:32:29.560403	En reparación / Servicio	2022-11-28 15:15:24.614143
742	211	79	555-5451	\N	1078	2025-02-21	17:04:12.089807	Lista para entregar	2023-07-12 16:41:57.469319
743	127	79	555-3519	\N	68080	2025-08-07	13:45:36.548647	En diagnóstico	2022-12-14 15:30:22.085792
744	474	79	555-6035	\N	25607	2025-05-01	08:56:00.764601	En diagnóstico	2024-12-31 16:23:03.129295
745	65	79	555-9799	cliente311@example.com	36432	2024-09-09	16:31:09.016882	En reparación / Servicio	2023-10-29 16:13:41.291976
746	222	79	555-1006	cliente234@example.com	6010	2023-07-12	12:45:38.138072	En reparación / Servicio	2023-08-05 16:02:00.844229
747	445	79	555-1579	\N	63940	2025-02-26	15:14:03.676958	Esperando refacciones / Productos	2023-02-15 16:22:32.555139
748	437	79	555-1194	\N	73152	2023-11-07	17:18:49.57775	En reparación / Servicio	2023-01-20 15:59:25.077043
749	318	79	555-5862	cliente430@example.com	3290	2023-03-13	14:15:57.114778	En diagnóstico	2025-04-27 16:31:36.596166
750	110	79	555-3642	cliente413@example.com	19768	2024-12-01	08:41:08.284203	En reparación / Servicio	2025-10-04 16:17:34.752943
751	324	79	555-7267	cliente402@example.com	38229	2023-11-17	10:07:14.639031	Lista para entregar	2024-09-20 15:54:20.506381
752	263	79	555-5158	\N	35229	2023-07-23	14:09:52.766959	En diagnóstico	2023-07-16 15:40:04.654224
753	107	79	555-5447	cliente20@example.com	23492	2023-12-22	09:27:03.270405	Esperando refacciones / Productos	2022-12-17 15:00:40.305056
754	122	79	555-3743	cliente193@example.com	54535	2022-11-30	10:52:06.98002	En reparación / Servicio	2025-09-11 16:28:53.060359
755	474	79	555-5708	cliente453@example.com	74605	2023-09-15	17:39:12.847995	Lista para entregar	2023-06-13 16:24:32.237892
756	333	79	555-3996	cliente456@example.com	73797	2024-05-07	17:31:58.24325	Esperando refacciones / Productos	2025-01-06 15:46:04.596895
757	120	79	555-2504	cliente176@example.com	60046	2022-12-26	11:24:48.328203	Esperando refacciones / Productos	2023-07-09 15:49:39.285977
758	361	79	555-1723	\N	17119	2025-07-20	13:52:49.638535	En diagnóstico	2025-08-18 15:00:27.596115
759	482	79	555-2840	cliente301@example.com	67162	2023-06-01	13:31:34.129276	En diagnóstico	2024-10-25 16:38:23.119223
760	73	79	555-6761	\N	20341	2022-12-22	16:35:42.608257	Lista para entregar	2024-02-05 15:56:52.690567
761	30	79	555-4331	cliente264@example.com	59070	2023-06-01	16:17:49.03084	En diagnóstico	2023-09-10 15:15:27.941105
762	125	79	555-4201	\N	11168	2024-08-07	17:42:45.567402	En reparación / Servicio	2025-10-14 16:43:20.391065
763	252	79	555-8704	\N	22284	2024-12-20	11:19:36.030139	En reparación / Servicio	2024-08-10 15:36:53.890892
764	233	79	555-5563	cliente248@example.com	61182	2023-02-19	13:18:45.456422	En diagnóstico	2025-08-25 15:06:39.390665
765	19	79	555-1622	cliente110@example.com	68787	2023-03-15	08:53:49.448104	En reparación / Servicio	2025-02-21 15:23:34.314973
766	441	79	555-3202	cliente242@example.com	6827	2024-04-07	11:02:26.302619	Esperando refacciones / Productos	2023-08-20 16:19:51.488613
767	183	79	555-4349	\N	6433	2024-01-10	15:26:43.677419	En reparación / Servicio	2025-01-17 15:42:17.381207
768	298	79	555-4991	cliente450@example.com	9002	2025-04-19	16:44:22.771286	En diagnóstico	2023-08-07 16:39:21.316511
769	106	79	555-8313	cliente379@example.com	5612	2025-03-05	08:18:32.860749	Esperando refacciones / Productos	2024-10-01 16:16:57.874506
770	182	79	555-1693	cliente498@example.com	21553	2023-12-22	15:59:03.647395	Esperando refacciones / Productos	2023-05-28 16:32:23.863348
771	395	79	555-4025	cliente200@example.com	62523	2023-05-11	16:05:07.595948	Esperando refacciones / Productos	2024-04-27 16:38:17.029497
772	308	79	555-4298	\N	21021	2023-09-05	14:45:25.437206	En reparación / Servicio	2022-12-19 15:18:48.157963
773	422	79	555-9479	cliente435@example.com	58005	2022-12-03	13:05:10.259819	En diagnóstico	2025-07-09 16:27:40.94251
774	222	79	555-7232	cliente469@example.com	19059	2022-12-10	12:03:14.960849	En reparación / Servicio	2023-06-19 15:50:03.187232
775	189	79	555-1178	cliente68@example.com	79900	2025-04-14	12:53:34.266209	Esperando refacciones / Productos	2025-02-01 16:35:10.580834
776	275	79	555-4719	cliente381@example.com	68864	2023-09-23	14:46:48.513493	En reparación / Servicio	2023-08-07 16:00:15.960127
777	417	79	555-3536	\N	37987	2024-06-16	16:46:29.383608	En diagnóstico	2025-08-06 15:28:39.061444
778	459	79	555-6740	\N	45907	2023-06-22	09:37:47.211671	En reparación / Servicio	2023-03-28 16:35:25.945754
779	364	79	555-7742	cliente205@example.com	36206	2024-05-28	10:57:58.691991	Esperando refacciones / Productos	2024-12-27 14:54:13.39455
780	168	79	555-3243	cliente138@example.com	78718	2022-12-31	16:37:02.897524	Esperando refacciones / Productos	2024-06-27 15:00:17.434894
781	498	79	555-2826	cliente99@example.com	70152	2025-02-27	12:56:12.801843	Esperando refacciones / Productos	2024-07-25 14:56:39.698726
782	144	79	555-6792	cliente420@example.com	24932	2024-06-20	09:02:44.303868	En diagnóstico	2024-10-02 16:32:15.627905
783	399	79	555-4179	cliente67@example.com	76596	2023-03-03	17:48:08.179079	En diagnóstico	2023-08-16 15:38:11.933716
784	383	79	555-2523	cliente63@example.com	30091	2024-06-15	13:35:55.350758	En diagnóstico	2024-08-18 15:50:59.079508
785	90	79	555-4603	cliente408@example.com	54910	2023-04-07	09:04:12.625462	En diagnóstico	2024-08-15 15:20:00.577152
786	458	79	555-6230	cliente213@example.com	45735	2024-06-19	12:44:28.711556	Esperando refacciones / Productos	2024-03-16 14:56:52.405157
787	118	79	555-7060	cliente151@example.com	67942	2024-01-30	10:48:51.800631	En reparación / Servicio	2024-07-13 15:44:54.59067
788	171	79	555-1094	\N	6153	2023-04-14	17:15:45.830194	Esperando refacciones / Productos	2024-08-05 14:58:29.404647
789	92	79	555-3949	cliente140@example.com	9387	2024-12-27	11:22:50.607398	Esperando refacciones / Productos	2024-04-04 15:39:57.833059
790	140	79	555-9099	cliente377@example.com	17556	2025-07-26	15:54:26.280805	En reparación / Servicio	2024-08-30 16:27:08.562243
791	214	79	555-7924	\N	7415	2025-05-20	09:49:22.830487	En diagnóstico	2023-05-11 16:10:28.64954
792	328	79	555-5277	cliente387@example.com	76753	2024-08-27	15:38:01.043545	Esperando refacciones / Productos	2022-12-04 16:15:48.86825
793	173	79	555-8879	cliente110@example.com	56677	2024-08-01	13:49:38.615543	En reparación / Servicio	2023-09-11 16:18:55.908639
794	227	79	555-6084	cliente493@example.com	63905	2024-01-16	16:17:00.481482	Esperando refacciones / Productos	2025-03-09 16:37:43.175207
795	180	79	555-2794	cliente153@example.com	42638	2024-10-25	11:31:04.315307	En reparación / Servicio	2023-10-10 16:45:33.611091
796	405	79	555-2875	\N	53302	2025-03-29	14:59:31.77946	En reparación / Servicio	2025-10-01 16:11:30.534719
797	127	79	555-5246	\N	22933	2022-12-18	17:03:54.673882	En diagnóstico	2025-10-25 15:35:40.888462
798	384	79	555-5759	\N	57187	2022-12-13	12:11:20.742123	En reparación / Servicio	2025-06-14 15:11:23.224087
799	485	79	555-6160	cliente467@example.com	58455	2023-01-30	14:35:51.598228	En diagnóstico	2023-02-27 16:39:42.775716
800	299	79	555-2928	\N	11635	2025-01-26	14:00:33.843349	completada	2025-07-27 15:30:02.784353
801	400	79	555-1032	cliente215@example.com	54824	2023-06-01	12:29:36.382907	completada	2025-03-13 16:12:05.542365
802	293	79	555-3100	cliente403@example.com	19537	2025-08-10	16:26:29.318209	En diagnóstico	2025-11-10 14:52:06.531218
803	206	79	555-2534	\N	78156	2024-09-06	16:32:03.55909	Lista para entregar	2024-10-30 16:11:54.632477
804	77	79	555-6302	cliente319@example.com	60724	2023-07-23	14:40:08.421232	Lista para entregar	2025-06-05 15:56:03.516089
805	234	79	555-8487	cliente108@example.com	20160	2025-06-11	15:34:02.562086	Esperando refacciones / Productos	2024-05-05 15:42:14.437835
806	267	79	555-7552	\N	68054	2023-05-19	14:22:52.209328	En reparación / Servicio	2025-01-29 16:17:39.634854
807	80	79	555-4965	\N	68958	2025-03-29	14:53:39.638023	Lista para entregar	2025-07-29 16:15:34.352641
808	407	79	555-9452	cliente488@example.com	76210	2025-10-20	11:10:53.379569	En reparación / Servicio	2025-05-24 16:12:44.95729
809	443	79	555-9491	\N	23902	2025-05-30	15:29:54.219415	En diagnóstico	2023-02-21 16:16:59.763657
810	338	79	555-6032	cliente489@example.com	30773	2024-03-01	17:31:26.871863	En reparación / Servicio	2024-11-20 16:04:40.64588
811	11	79	555-8521	cliente146@example.com	64094	2024-02-10	10:26:43.032066	En diagnóstico	2025-01-19 15:50:33.281281
812	17	79	555-6937	cliente425@example.com	55589	2024-01-24	17:40:13.724944	En reparación / Servicio	2023-10-01 15:29:00.830073
813	420	79	555-9110	cliente332@example.com	7738	2024-06-11	11:40:56.452062	Esperando refacciones / Productos	2024-10-08 15:41:33.626209
814	111	79	555-2612	cliente213@example.com	22783	2023-04-23	10:45:50.655785	Esperando refacciones / Productos	2023-09-10 16:28:00.998399
815	444	79	555-6375	cliente294@example.com	52140	2025-11-03	08:22:18.439082	En diagnóstico	2023-04-04 15:23:37.787789
816	343	79	555-5392	cliente497@example.com	45867	2024-05-04	17:12:07.398284	En diagnóstico	2025-03-25 16:40:01.373894
817	485	79	555-7592	\N	11008	2025-04-27	13:10:17.369317	Esperando refacciones / Productos	2024-03-04 15:57:10.713749
818	387	79	555-8047	cliente368@example.com	11016	2024-03-28	08:59:43.084375	En diagnóstico	2025-10-05 16:31:18.60103
819	457	79	555-1342	cliente290@example.com	1444	2023-08-05	13:23:01.974331	En diagnóstico	2024-02-16 16:37:25.829694
820	507	79	555-4467	cliente444@example.com	15387	2024-10-31	10:22:48.245958	En reparación / Servicio	2024-03-04 16:11:41.372186
821	188	79	555-3512	\N	50029	2024-12-14	10:41:01.731044	En diagnóstico	2023-05-07 16:41:24.579738
822	13	79	555-1369	cliente481@example.com	31203	2023-07-27	09:38:09.026844	En diagnóstico	2025-11-08 15:38:15.045726
823	270	79	555-2632	cliente255@example.com	59752	2023-10-04	16:04:56.740205	Esperando refacciones / Productos	2025-08-15 16:29:23.315671
824	170	79	555-8844	\N	39037	2023-02-18	14:59:46.640922	En diagnóstico	2025-06-08 16:33:38.904829
825	152	79	555-7097	cliente363@example.com	79237	2023-06-26	15:34:36.547439	En reparación / Servicio	2023-10-14 15:48:45.762459
826	43	79	555-2420	cliente112@example.com	9326	2024-10-12	15:34:17.412866	En diagnóstico	2025-09-20 15:05:46.235163
827	61	79	555-3878	\N	24636	2023-02-12	13:16:10.365651	En diagnóstico	2025-05-20 15:44:01.536242
828	209	79	555-3954	cliente95@example.com	60668	2023-04-19	08:29:15.831946	En reparación / Servicio	2025-07-03 16:38:34.258551
829	502	79	555-9922	cliente372@example.com	43963	2025-10-20	14:34:00.455346	En diagnóstico	2023-03-16 16:26:31.652751
830	315	79	555-7865	\N	35249	2024-11-04	17:11:29.251409	Esperando refacciones / Productos	2025-04-09 15:39:41.489774
831	85	79	555-6516	cliente416@example.com	66811	2023-04-11	09:49:11.264135	Esperando refacciones / Productos	2023-10-13 16:19:38.287963
832	470	79	555-9541	cliente211@example.com	28978	2023-07-16	14:40:57.250903	Lista para entregar	2024-03-06 15:42:48.024974
833	221	79	555-1556	cliente71@example.com	24264	2023-11-30	16:48:53.090454	En reparación / Servicio	2023-10-26 16:34:25.492258
834	366	79	555-5917	\N	24134	2025-07-12	13:19:12.137092	En diagnóstico	2025-04-23 15:42:22.585525
835	125	79	555-6575	cliente96@example.com	48231	2022-12-31	10:38:22.300283	Esperando refacciones / Productos	2023-01-20 16:00:20.442817
836	334	79	555-6127	cliente470@example.com	15204	2025-09-17	12:41:35.115884	En reparación / Servicio	2023-06-15 16:17:46.299627
837	115	79	555-2896	\N	40721	2024-05-18	09:59:33.659639	Esperando refacciones / Productos	2024-07-20 15:52:50.698464
838	157	79	555-7908	cliente88@example.com	43550	2025-10-18	15:46:42.9632	Lista para entregar	2024-11-29 16:10:47.474434
839	495	79	555-1249	\N	45912	2023-09-06	11:17:58.003237	En reparación / Servicio	2024-10-02 15:35:58.637022
840	458	79	555-1887	\N	77574	2025-06-28	13:50:55.93452	En reparación / Servicio	2023-02-24 15:46:05.634825
841	9	79	555-3677	cliente257@example.com	9033	2023-07-24	12:52:43.668811	Esperando refacciones / Productos	2024-08-06 15:09:18.077955
842	242	79	555-1792	cliente153@example.com	20599	2024-07-20	13:53:46.033799	En diagnóstico	2025-06-13 16:30:56.027342
843	239	79	555-4103	cliente474@example.com	63808	2023-10-28	15:52:37.162645	Esperando refacciones / Productos	2024-11-27 15:09:44.936979
844	37	79	555-3763	\N	51615	2024-03-09	09:37:20.380083	Esperando refacciones / Productos	2023-05-19 15:57:59.667454
845	403	79	555-4317	\N	62154	2023-02-25	16:03:31.778885	En reparación / Servicio	2024-12-31 16:16:33.046587
846	61	79	555-4999	\N	30693	2025-09-17	17:11:17.276014	Esperando refacciones / Productos	2025-08-15 14:52:13.054114
847	141	79	555-5467	cliente94@example.com	23834	2022-11-27	10:42:57.843138	En diagnóstico	2023-09-14 15:09:35.421537
848	88	79	555-4699	cliente192@example.com	13567	2024-08-01	16:08:17.033559	Esperando refacciones / Productos	2025-07-07 15:28:48.642206
849	67	79	555-3355	cliente41@example.com	58627	2024-12-11	09:07:05.244256	En reparación / Servicio	2024-04-18 15:49:29.948592
850	260	79	555-3905	cliente175@example.com	79366	2025-02-18	09:15:08.957924	En diagnóstico	2023-10-13 16:06:03.185738
851	429	79	555-8755	cliente208@example.com	50175	2024-09-27	14:14:32.579983	En reparación / Servicio	2025-05-12 16:40:58.450682
852	455	79	555-4566	cliente233@example.com	30439	2025-08-21	15:43:53.332844	Esperando refacciones / Productos	2023-08-31 15:54:44.28854
853	473	79	555-8278	cliente370@example.com	17542	2025-04-22	17:51:50.767241	En reparación / Servicio	2024-02-02 16:12:51.040235
854	337	79	555-1715	cliente481@example.com	59209	2025-02-25	14:34:02.368027	Esperando refacciones / Productos	2025-03-07 16:21:29.224832
855	18	79	555-4277	cliente195@example.com	44802	2025-07-07	17:14:44.346846	Esperando refacciones / Productos	2023-10-06 15:13:14.385367
856	202	79	555-4557	\N	75548	2023-09-13	09:45:27.160102	En diagnóstico	2023-09-22 16:34:12.855778
857	75	79	555-9158	cliente457@example.com	32568	2025-02-28	12:17:28.767323	En diagnóstico	2024-11-17 15:51:51.071807
858	179	79	555-8994	\N	43839	2023-06-04	14:41:15.485633	En reparación / Servicio	2023-11-26 15:38:21.287846
859	174	79	555-1672	cliente499@example.com	31616	2024-08-20	13:43:04.963302	Esperando refacciones / Productos	2024-02-07 16:37:37.362613
860	364	79	555-9705	cliente430@example.com	28836	2025-01-15	10:23:20.466721	Esperando refacciones / Productos	2025-04-27 15:59:25.921453
861	15	79	555-1271	cliente201@example.com	39067	2023-03-25	13:30:18.504159	En reparación / Servicio	2024-07-10 15:45:15.515875
862	66	79	555-6288	\N	45122	2023-03-15	08:57:11.716489	En reparación / Servicio	2024-04-14 15:30:52.367469
863	138	79	555-3943	cliente465@example.com	72465	2025-04-09	16:34:01.09422	En diagnóstico	2024-08-21 15:57:59.115217
864	139	79	555-2292	cliente185@example.com	49430	2024-01-27	13:47:24.962486	Lista para entregar	2024-06-03 14:56:58.023417
865	28	79	555-8531	\N	1251	2024-12-27	14:55:37.008052	En diagnóstico	2024-12-11 15:23:19.047957
866	477	79	555-5549	cliente38@example.com	66373	2024-06-17	13:29:53.176782	Esperando refacciones / Productos	2023-03-19 15:16:17.407981
867	388	79	555-5589	\N	53974	2024-12-10	12:57:55.854665	En reparación / Servicio	2023-01-27 15:38:52.905253
868	316	79	555-7863	cliente284@example.com	13034	2024-09-04	16:38:37.762147	En reparación / Servicio	2025-05-12 16:32:33.28316
869	439	79	555-2260	cliente35@example.com	63898	2024-01-01	13:37:49.046747	En reparación / Servicio	2023-06-08 16:00:21.957425
870	131	79	555-5983	cliente470@example.com	75754	2023-08-11	16:38:16.536751	En reparación / Servicio	2023-12-07 16:42:36.521352
871	495	79	555-3956	cliente446@example.com	58628	2025-01-02	17:39:37.922699	En diagnóstico	2025-05-27 15:43:57.984162
872	432	79	555-1080	cliente139@example.com	6468	2022-12-26	08:30:51.787767	En reparación / Servicio	2023-06-26 15:26:30.029163
873	264	79	555-4047	\N	26732	2025-07-11	08:19:16.875249	Lista para entregar	2025-07-17 15:54:29.563988
874	389	79	555-9265	cliente271@example.com	41070	2024-05-15	16:48:21.442707	Esperando refacciones / Productos	2024-09-19 15:32:34.574018
875	118	79	555-6131	cliente13@example.com	47295	2023-11-18	17:09:58.555319	En reparación / Servicio	2023-10-11 16:21:40.892039
876	369	79	555-4229	\N	34687	2025-08-23	10:30:58.908674	En diagnóstico	2025-11-11 15:34:25.725153
877	259	79	555-3077	cliente495@example.com	31452	2024-10-31	17:06:28.628785	Esperando refacciones / Productos	2024-07-22 15:07:14.14711
878	8	79	555-3356	cliente425@example.com	55315	2025-02-12	12:48:35.746894	En reparación / Servicio	2024-08-04 15:22:30.964936
879	33	79	555-2315	cliente145@example.com	11719	2024-08-21	15:43:33.530318	Lista para entregar	2025-02-01 15:35:21.792795
880	189	79	555-5705	cliente318@example.com	5575	2024-06-27	13:41:23.941876	En diagnóstico	2023-05-14 15:16:46.102436
881	182	79	555-7552	cliente209@example.com	22421	2023-01-01	16:31:19.910377	En diagnóstico	2022-12-07 16:11:15.090884
882	175	79	555-4003	cliente226@example.com	75399	2024-06-03	13:12:00.783261	En diagnóstico	2023-05-25 15:19:15.049022
883	90	79	555-3880	\N	30650	2024-09-08	15:51:25.453892	completada	2024-12-04 16:31:04.29612
884	137	79	555-5295	cliente337@example.com	6222	2024-08-10	12:55:54.466932	En diagnóstico	2025-01-05 16:42:14.560648
885	485	79	555-1519	\N	22498	2024-07-20	17:11:22.652172	En reparación / Servicio	2025-06-30 16:24:02.885518
886	226	79	555-7075	cliente449@example.com	57300	2023-04-16	17:46:14.524328	En diagnóstico	2024-02-18 16:09:36.4257
887	61	79	555-8252	cliente438@example.com	34116	2025-09-18	14:08:15.674776	En reparación / Servicio	2025-05-29 15:27:07.223258
888	203	79	555-7559	cliente287@example.com	48991	2024-12-26	14:15:04.756362	En diagnóstico	2025-05-12 14:58:12.653634
889	450	79	555-7415	cliente203@example.com	8469	2024-06-18	11:07:48.441378	Esperando refacciones / Productos	2025-02-22 15:51:15.529712
890	55	79	555-3140	\N	30410	2023-03-24	11:49:27.681086	Lista para entregar	2025-05-20 15:08:30.320877
891	234	79	555-1415	\N	11395	2024-12-09	13:54:31.154212	En diagnóstico	2024-03-18 15:43:10.800204
892	86	79	555-6350	\N	65020	2024-04-11	13:05:35.874333	Lista para entregar	2023-10-16 15:02:47.607866
893	473	79	555-6512	\N	28195	2024-09-25	09:42:09.840933	En diagnóstico	2023-01-17 15:45:22.396241
894	84	79	555-9817	cliente352@example.com	41665	2024-03-31	10:45:59.117761	En reparación / Servicio	2024-08-06 14:54:45.665088
895	103	79	555-2575	cliente140@example.com	57847	2024-03-03	09:37:48.252946	En diagnóstico	2023-03-24 15:02:06.741206
896	364	79	555-9716	cliente81@example.com	20145	2025-06-15	14:53:06.181974	Lista para entregar	2025-02-09 16:09:50.91445
897	423	79	555-6258	cliente262@example.com	73075	2024-11-13	11:10:25.88822	Esperando refacciones / Productos	2024-06-08 14:55:00.158845
898	273	79	555-4406	cliente273@example.com	12878	2024-11-03	17:42:21.095124	Lista para entregar	2025-08-27 16:36:21.058727
899	239	79	555-8848	cliente497@example.com	19915	2023-06-23	10:53:40.474684	En reparación / Servicio	2024-12-12 16:18:08.916061
900	299	79	555-3953	cliente78@example.com	54902	2024-04-25	13:38:48.744918	En diagnóstico	2025-05-08 15:15:32.666784
901	121	79	555-1823	cliente170@example.com	55670	2025-07-25	09:32:27.40672	Esperando refacciones / Productos	2024-08-16 14:52:07.895879
902	285	79	555-5372	\N	27487	2024-12-28	08:01:10.378959	En diagnóstico	2025-06-22 15:48:15.664619
903	456	79	555-3442	cliente257@example.com	17186	2024-10-11	08:09:08.357896	Lista para entregar	2023-06-04 15:26:28.544911
904	385	79	555-9281	cliente8@example.com	26462	2024-07-22	12:43:52.168081	En reparación / Servicio	2024-11-21 16:33:52.620889
905	302	79	555-8183	\N	37737	2025-09-13	08:53:08.172581	En diagnóstico	2023-11-18 15:33:07.496806
906	505	79	555-4711	cliente244@example.com	33863	2024-03-24	10:41:47.229738	En reparación / Servicio	2025-07-13 16:03:01.522279
907	301	79	555-5718	cliente438@example.com	37712	2024-09-15	14:26:53.496667	Esperando refacciones / Productos	2025-05-26 16:38:32.725236
908	429	79	555-4954	\N	71707	2024-03-06	12:22:32.665962	Esperando refacciones / Productos	2025-09-27 15:44:35.175029
909	122	79	555-7052	cliente201@example.com	61677	2024-07-18	11:23:23.030969	Esperando refacciones / Productos	2023-10-16 16:08:54.535385
910	60	79	555-5847	cliente451@example.com	22178	2024-01-09	17:37:24.328017	En reparación / Servicio	2024-01-20 16:40:32.332992
911	389	79	555-6037	cliente126@example.com	36183	2023-04-27	14:01:56.868559	Esperando refacciones / Productos	2024-02-05 14:51:31.297797
912	80	79	555-6870	cliente468@example.com	21633	2023-05-19	13:34:38.209295	Esperando refacciones / Productos	2025-09-17 15:32:53.371329
913	156	79	555-8392	\N	8014	2023-10-19	16:55:48.382604	En reparación / Servicio	2024-06-22 14:53:37.826312
914	296	79	555-1059	cliente361@example.com	6083	2025-08-15	09:16:37.052646	En diagnóstico	2025-08-01 16:38:45.605658
915	178	79	555-4693	\N	73955	2025-07-24	11:31:22.958992	En reparación / Servicio	2023-03-27 15:18:52.284113
916	339	79	555-7996	cliente433@example.com	79783	2025-01-12	16:47:26.885767	En diagnóstico	2025-01-14 15:46:49.037941
917	266	79	555-2312	\N	22466	2025-02-16	16:53:01.555384	Lista para entregar	2025-02-18 16:12:11.107032
918	115	79	555-1433	\N	35907	2024-09-01	09:11:30.59024	En reparación / Servicio	2024-02-05 15:14:33.028257
919	261	79	555-6043	cliente137@example.com	24425	2024-11-01	13:42:37.41696	En reparación / Servicio	2023-01-22 15:34:18.622723
920	6	79	555-5712	cliente80@example.com	40265	2023-09-05	14:10:28.9497	En diagnóstico	2023-07-28 14:52:18.18991
921	493	79	555-6866	\N	13101	2023-03-21	17:28:19.679945	Esperando refacciones / Productos	2023-12-08 15:32:19.959725
922	126	79	555-6919	cliente151@example.com	1302	2022-11-23	13:58:48.790691	En diagnóstico	2023-08-02 15:57:23.929219
923	433	79	555-4848	\N	54324	2025-06-11	11:02:47.306897	En diagnóstico	2024-03-13 15:58:33.120774
924	339	79	555-7863	cliente117@example.com	62201	2024-06-22	11:17:35.931149	Esperando refacciones / Productos	2024-06-15 16:30:05.159845
925	251	79	555-1910	\N	48928	2024-04-24	09:38:52.912635	En reparación / Servicio	2025-02-10 15:58:46.004227
926	123	79	555-4082	\N	44024	2024-10-20	13:14:23.614482	En diagnóstico	2025-10-26 14:53:57.850951
927	1	79	555-9118	\N	37202	2023-03-27	16:27:22.911449	En diagnóstico	2024-01-03 15:39:01.93421
928	360	79	555-7690	cliente109@example.com	69701	2024-06-29	10:45:45.055165	En reparación / Servicio	2025-07-15 15:38:28.814927
929	224	79	555-8871	cliente80@example.com	72257	2023-01-19	16:07:40.672646	En diagnóstico	2024-03-07 16:02:38.501735
930	357	79	555-1345	cliente252@example.com	68992	2023-09-07	14:22:19.794231	En diagnóstico	2025-03-30 16:00:11.789439
931	283	79	555-9114	cliente107@example.com	8328	2024-01-29	17:26:44.384404	Lista para entregar	2025-11-02 15:08:17.898588
932	137	79	555-2757	\N	23904	2025-02-01	13:51:38.757878	En reparación / Servicio	2023-11-03 15:53:48.892275
933	127	79	555-2444	cliente139@example.com	2570	2023-06-07	11:46:15.995431	En diagnóstico	2023-01-23 16:16:44.29458
934	102	79	555-8118	\N	20260	2023-03-20	14:49:40.639153	En reparación / Servicio	2025-07-24 15:36:47.879908
935	260	79	555-1353	cliente370@example.com	16134	2024-06-02	11:22:34.178234	En diagnóstico	2023-10-09 15:26:22.087139
936	151	79	555-3633	cliente444@example.com	60615	2023-04-21	13:41:23.234703	En diagnóstico	2023-01-23 16:15:49.089585
937	438	79	555-5781	cliente8@example.com	4426	2024-10-22	16:07:54.365308	Esperando refacciones / Productos	2023-08-26 16:27:46.682085
938	343	79	555-6953	cliente59@example.com	64420	2024-06-01	10:38:37.573757	En diagnóstico	2025-01-29 15:14:08.423443
939	451	79	555-2379	cliente438@example.com	7171	2025-02-10	10:48:21.079812	Esperando refacciones / Productos	2023-08-20 15:54:10.493593
940	365	79	555-6921	cliente15@example.com	48599	2024-06-16	16:58:23.831771	Esperando refacciones / Productos	2024-10-08 15:41:50.704621
941	333	79	555-2573	cliente125@example.com	14539	2024-08-19	14:54:40.415019	En reparación / Servicio	2025-07-12 14:55:45.313322
942	391	79	555-6810	\N	14753	2025-04-09	12:53:49.876673	En reparación / Servicio	2025-09-28 14:58:32.504764
943	103	79	555-1441	\N	34779	2024-01-20	08:44:55.062388	En reparación / Servicio	2023-10-14 16:29:48.110858
944	300	79	555-8894	cliente269@example.com	33670	2025-04-16	10:38:14.515372	Esperando refacciones / Productos	2023-07-06 15:59:35.634777
945	115	79	555-5887	cliente308@example.com	35757	2023-01-03	15:56:55.262356	Esperando refacciones / Productos	2024-06-15 15:24:19.306217
946	93	79	555-3661	cliente471@example.com	56225	2025-10-19	12:45:29.940888	En diagnóstico	2023-08-21 16:47:32.046819
947	218	79	555-6380	cliente329@example.com	62732	2025-07-22	14:17:54.319377	En reparación / Servicio	2025-06-07 16:24:29.504642
948	458	79	555-7465	cliente115@example.com	62428	2024-09-18	09:05:26.742026	En reparación / Servicio	2024-02-27 15:42:47.602162
949	390	79	555-9337	cliente12@example.com	30601	2024-09-20	13:35:10.310601	En diagnóstico	2023-04-11 16:35:56.114499
950	171	79	555-9320	\N	60409	2025-02-07	17:56:49.339129	En reparación / Servicio	2025-08-11 15:43:02.207567
951	179	79	555-8937	cliente147@example.com	50536	2025-09-17	14:12:22.578496	En diagnóstico	2023-05-08 16:25:14.365572
952	321	79	555-9552	\N	72992	2025-03-17	11:06:44.508514	En reparación / Servicio	2023-11-01 16:02:56.801772
953	423	79	555-5641	cliente389@example.com	52195	2023-07-10	08:51:42.574811	En diagnóstico	2025-04-02 14:51:36.344211
954	147	79	555-2625	cliente49@example.com	8405	2024-01-10	16:17:57.871009	En diagnóstico	2023-08-30 16:19:55.395285
955	317	79	555-4024	cliente76@example.com	40139	2025-10-26	09:32:34.767236	En reparación / Servicio	2025-08-04 15:48:42.507639
956	291	79	555-9029	\N	25653	2025-10-30	08:51:37.056565	En reparación / Servicio	2025-08-17 16:09:44.186413
957	318	79	555-7851	cliente302@example.com	61138	2024-03-09	08:21:56.531791	Esperando refacciones / Productos	2023-07-22 15:54:11.179621
958	137	79	555-3354	cliente3@example.com	42305	2023-06-14	14:43:32.475263	En reparación / Servicio	2024-03-11 15:32:23.163825
959	178	79	555-4380	cliente150@example.com	24351	2025-04-13	08:22:41.181811	Esperando refacciones / Productos	2025-01-10 16:10:31.801242
960	465	79	555-4576	cliente169@example.com	31888	2024-08-01	09:43:23.30668	completada	2023-08-30 14:50:39.84186
961	105	79	555-6491	cliente81@example.com	6319	2025-11-17	08:27:26.349531	En reparación / Servicio	2025-05-20 15:02:57.796596
962	297	79	555-5500	cliente308@example.com	78353	2023-06-24	11:26:27.153416	En reparación / Servicio	2024-09-10 14:56:07.87835
963	394	79	555-3807	cliente189@example.com	56156	2023-02-16	14:52:34.61814	En diagnóstico	2025-11-02 16:34:20.332387
964	230	79	555-6816	\N	64581	2024-09-17	15:42:26.120786	Esperando refacciones / Productos	2025-06-25 15:44:54.342824
965	341	79	555-6248	\N	16743	2024-08-18	14:57:58.699895	En diagnóstico	2025-05-30 16:07:16.942909
966	268	79	555-9544	cliente78@example.com	13253	2024-06-22	16:12:44.210933	En reparación / Servicio	2025-03-31 16:37:17.946883
967	398	79	555-8627	cliente404@example.com	23748	2023-02-21	17:39:05.152977	En diagnóstico	2023-01-30 16:31:03.015725
968	413	79	555-4274	cliente269@example.com	20840	2024-09-26	08:16:00.281943	En reparación / Servicio	2023-03-06 15:45:55.752989
969	181	79	555-9513	\N	7979	2023-05-03	10:40:09.125233	Esperando refacciones / Productos	2024-03-12 16:06:22.052382
970	132	79	555-6503	cliente197@example.com	52947	2023-04-03	09:07:37.273272	En reparación / Servicio	2023-06-28 16:29:26.638732
971	326	79	555-9703	cliente474@example.com	36618	2023-02-21	10:42:11.588064	En reparación / Servicio	2024-04-06 15:48:55.04124
972	82	79	555-1823	\N	65039	2023-03-03	08:49:18.046938	Esperando refacciones / Productos	2025-07-26 15:58:34.529092
973	25	79	555-3545	cliente139@example.com	38071	2023-07-15	15:30:08.649208	En diagnóstico	2024-10-03 15:04:52.880164
974	223	79	555-6807	cliente471@example.com	22620	2023-11-02	09:58:07.731881	En diagnóstico	2023-05-08 16:47:09.784159
975	31	79	555-9659	cliente146@example.com	45444	2023-02-12	11:31:35.701245	En reparación / Servicio	2024-09-28 15:36:21.703614
976	121	79	555-9110	cliente264@example.com	36489	2023-01-29	11:35:23.761473	En diagnóstico	2024-04-18 15:57:20.787563
977	419	79	555-8359	cliente210@example.com	31089	2023-04-05	11:57:18.22776	En reparación / Servicio	2024-10-11 16:08:46.494644
978	439	79	555-1477	cliente207@example.com	31304	2025-02-24	12:10:45.050283	En diagnóstico	2023-02-11 16:06:07.76005
979	368	79	555-8198	\N	41938	2025-08-12	15:43:31.995712	En diagnóstico	2025-04-27 16:41:31.638959
980	292	79	555-4674	cliente40@example.com	29942	2024-09-17	11:20:57.28911	En reparación / Servicio	2024-04-13 15:26:22.25732
981	476	79	555-5762	cliente429@example.com	52343	2025-09-03	17:18:49.893011	En diagnóstico	2023-03-22 16:12:41.860985
982	480	79	555-7375	\N	43059	2025-01-21	08:27:20.992977	En reparación / Servicio	2023-02-03 16:23:40.190687
983	338	79	555-3818	cliente424@example.com	7717	2025-11-07	13:06:36.829456	En diagnóstico	2024-10-14 15:52:30.821296
984	143	79	555-5834	cliente412@example.com	46638	2025-03-21	09:36:35.979231	En reparación / Servicio	2025-09-24 15:33:08.197126
985	65	79	555-9232	cliente267@example.com	63938	2023-06-17	12:43:54.927171	Esperando refacciones / Productos	2025-11-11 16:21:12.538572
986	336	79	555-9227	cliente39@example.com	75743	2024-08-20	10:18:30.257906	En reparación / Servicio	2024-04-05 15:04:52.557066
987	348	79	555-6249	\N	72081	2024-03-11	16:13:34.540916	En diagnóstico	2025-09-09 16:45:17.462609
988	467	79	555-3565	cliente314@example.com	27626	2023-06-24	15:15:02.652849	Esperando refacciones / Productos	2023-05-09 16:35:00.318811
989	201	79	555-4278	\N	39515	2024-04-22	15:23:55.229406	En reparación / Servicio	2025-05-26 14:52:11.375287
990	391	79	555-1084	cliente415@example.com	3356	2024-12-30	15:10:20.707118	En diagnóstico	2023-08-20 16:28:01.80153
991	73	79	555-9813	cliente427@example.com	18749	2025-10-21	14:38:02.565093	En reparación / Servicio	2023-10-06 15:48:43.12556
992	39	79	555-1382	cliente495@example.com	53445	2024-07-27	14:22:03.14528	Lista para entregar	2025-11-13 15:21:33.74003
993	177	79	555-5683	cliente62@example.com	62457	2024-05-17	10:02:57.043818	En diagnóstico	2025-08-17 16:14:30.425821
994	21	79	555-5457	cliente59@example.com	38095	2025-07-04	08:01:42.253915	En reparación / Servicio	2023-06-05 15:03:07.676234
995	452	79	555-6709	cliente391@example.com	9549	2024-10-16	10:58:18.470037	En diagnóstico	2023-12-01 15:16:52.06735
996	233	79	555-7033	cliente466@example.com	36698	2024-08-25	10:18:04.546096	completada	2025-07-26 16:14:16.226757
997	192	79	555-2411	cliente315@example.com	54047	2025-04-02	16:51:45.82738	completada	2023-02-09 16:38:14.407804
998	187	79	555-3857	cliente312@example.com	19781	2024-04-30	08:33:04.637352	En diagnóstico	2022-12-12 15:30:50.979101
999	333	79	555-4076	cliente215@example.com	68379	2024-03-08	13:06:26.983626	En reparación / Servicio	2024-02-05 15:02:51.61599
1000	32	79	555-1219	cliente435@example.com	78521	2025-09-22	17:46:09.810903	En reparación / Servicio	2024-07-20 14:54:40.903035
1001	123	79	555-8178	cliente238@example.com	57408	2025-09-25	08:56:40.915787	Esperando refacciones / Productos	2025-04-23 16:13:32.972837
1002	498	79	555-8042	cliente247@example.com	77273	2023-11-27	10:01:23.629548	En reparación / Servicio	2022-11-28 15:15:57.540166
1003	178	79	555-2701	\N	41028	2023-01-02	14:52:42.452209	En reparación / Servicio	2024-01-21 15:34:53.390272
1004	369	79	555-6334	cliente143@example.com	33616	2025-03-24	13:53:50.004418	Lista para entregar	2025-05-15 16:06:46.881401
1005	383	79	555-3487	cliente126@example.com	65538	2023-11-09	12:34:55.349245	En reparación / Servicio	2023-08-11 15:53:57.834421
1006	286	79	555-1929	cliente155@example.com	43612	2023-08-20	09:18:55.781963	Esperando refacciones / Productos	2025-05-21 15:46:14.356093
1007	445	79	555-5551	cliente299@example.com	49095	2023-04-02	15:50:45.924642	En diagnóstico	2025-10-22 16:42:38.365252
\.


--
-- TOC entry 5036 (class 0 OID 16617)
-- Dependencies: 224
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id, nombre, telefono, rol_id, fecha_creacion) FROM stdin;
1	Ana García López	555-0101	3	2023-01-15 09:30:00
2	Carlos Rodríguez Méndez	555-0102	3	2023-01-16 10:15:00
3	María Fernández Castro	555-0103	3	2023-01-17 11:20:00
4	Javier Martínez Ruiz	555-0104	3	2023-01-18 12:45:00
5	Laura González Silva	555-0105	3	2023-01-19 14:30:00
6	Miguel Pérez Ortega	555-0106	3	2023-01-20 16:15:00
7	Elena Sánchez Vargas	555-0107	3	2023-01-21 08:45:00
8	David Ramírez Herrera	555-0108	3	2023-01-22 09:30:00
9	Sofía Díaz Mendoza	555-0109	3	2023-01-23 10:15:00
10	Alejandro Castro Ríos	555-0110	3	2023-01-24 11:00:00
11	Isabel Morales Jiménez	555-0111	3	2023-01-25 12:20:00
12	Pedro Ruiz Navarro	555-0112	3	2023-01-26 13:45:00
13	Carmen Vargas Soto	555-0113	3	2023-01-27 14:30:00
14	Francisco Ortega Reyes	555-0114	3	2023-01-28 15:15:00
15	Andrea Mendoza Paredes	555-0115	3	2023-01-29 16:00:00
16	José Silva Campos	555-0116	3	2023-01-30 08:20:00
17	Patricia Núñez Rojas	555-0117	3	2023-01-31 09:10:00
18	Ricardo Herrera Peña	555-0118	3	2023-02-01 10:05:00
19	Gabriela Rojas Castillo	555-0119	3	2023-02-02 11:30:00
20	Daniel Peña Romero	555-0120	3	2023-02-03 12:45:00
21	Adriana Castillo Torres	555-0121	3	2023-02-04 13:20:00
22	Roberto Romero Flores	555-0122	3	2023-02-05 14:15:00
23	Claudia Torres Gutiérrez	555-0123	3	2023-02-06 15:40:00
24	Fernando Flores Medina	555-0124	3	2023-02-07 16:25:00
25	Verónica Gutiérrez Guerrero	555-0125	3	2023-02-08 08:50:00
26	Sergio Medina Paredes	555-0126	3	2023-02-09 09:35:00
27	Diana Guerrero Ríos	555-0127	3	2023-02-10 10:40:00
28	Arturo Paredes Vega	555-0128	3	2023-02-11 11:55:00
29	Rosa Vega Campos	555-0129	3	2023-02-12 12:30:00
30	Guillermo Ríos Salazar	555-0130	3	2023-02-13 13:45:00
31	Margarita Campos Orozco	555-0131	3	2023-02-14 14:20:00
32	Héctor Salazar Acosta	555-0132	3	2023-02-15 15:10:00
33	Lucía Orozco Miranda	555-0133	3	2023-02-16 16:05:00
34	Oscar Acosta Santana	555-0134	3	2023-02-17 08:15:00
35	Silvia Miranda Mejía	555-0135	3	2023-02-18 09:25:00
36	Jorge Santana León	555-0136	3	2023-02-19 10:35:00
37	Angélica Mejía Orozco	555-0137	3	2023-02-20 11:45:00
38	Raúl León Cervantes	555-0138	3	2023-02-21 12:55:00
39	Teresa Cervantes Espinoza	555-0139	3	2023-02-22 13:40:00
40	Alberto Espinoza Montoya	555-0140	3	2023-02-23 14:50:00
41	Beatriz Montoya Delgado	555-0141	3	2023-02-24 15:30:00
42	Felipe Delgado Rangel	555-0142	3	2023-02-25 16:20:00
43	Elena Rangel Márquez	555-0143	3	2023-02-26 08:40:00
44	Rodrigo Márquez Solís	555-0144	3	2023-02-27 09:50:00
45	Isabel Solís Aguilar	555-0145	3	2023-02-28 10:25:00
46	Mauricio Aguilar Cordero	555-0146	3	2023-03-01 11:35:00
47	Lourdes Cordero Valdez	555-0147	3	2023-03-02 12:45:00
48	César Valdez Franco	555-0148	3	2023-03-03 13:20:00
49	Alicia Franco Ibarra	555-0149	3	2023-03-04 14:30:00
50	René Ibarra Gallegos	555-0150	3	2023-03-05 15:40:00
51	Olivia Gallegos Lozano	555-0151	3	2023-03-06 16:15:00
52	Salvador Lozano Serrano	555-0152	3	2023-03-07 08:25:00
53	Ximena Serrano Velázquez	555-0153	3	2023-03-08 09:35:00
54	Emilio Velázquez Méndez	555-0154	3	2023-03-09 10:45:00
55	Marisol Méndez Téllez	555-0155	3	2023-03-10 11:55:00
56	Gerardo Téllez Cabrera	555-0156	3	2023-03-11 12:30:00
57	Liliana Cabrera Vázquez	555-0157	3	2023-03-12 13:40:00
58	Armando Vázquez Pacheco	555-0158	3	2023-03-13 14:50:00
59	Karina Pacheco Rivas	555-0159	3	2023-03-14 15:25:00
60	Rogelio Rivas Juárez	555-0160	3	2023-03-15 16:35:00
61	Perla Juárez Macías	555-0161	3	2023-03-16 08:45:00
62	Samuel Macías Bernal	555-0162	3	2023-03-17 09:20:00
63	Yolanda Bernal Salas	555-0163	3	2023-03-18 10:30:00
64	César Salas Ayala	555-0164	3	2023-03-19 11:40:00
65	Nora Ayala Zamora	555-0165	3	2023-03-20 12:50:00
66	Federico Zamora Carrillo	555-0166	3	2023-03-21 13:25:00
67	Esmeralda Carrillo Escobar	555-0167	3	2023-03-22 14:35:00
68	Leonardo Escobar Valencia	555-0168	3	2023-03-23 15:45:00
69	Jimena Valencia Correa	555-0169	3	2023-03-24 16:20:00
70	Hugo Correa Osorio	555-0170	3	2023-03-25 08:30:00
71	Rebeca Osorio Quintero	555-0171	3	2023-03-26 09:40:00
72	Marcos Quintero Palacios	555-0172	3	2023-03-27 10:50:00
73	Elvira Palacios Murillo	555-0173	3	2023-03-28 11:25:00
74	Agustín Murillo Cárdenas	555-0174	3	2023-03-29 12:35:00
75	Leticia Cárdenas Barrios	555-0175	3	2023-03-30 13:45:00
76	Pablo Barrios Villanueva	555-0176	3	2023-03-31 14:55:00
77	Aurora Villanueva Treviño	555-0177	3	2023-04-01 15:30:00
78	Saúl Treviño Salgado	555-0178	3	2023-04-02 16:40:00
79	Consuelo Salgado Navarro	555-0179	3	2023-04-03 08:50:00
80	Ramiro Navarro Molina	555-0180	3	2023-04-04 09:35:00
81	Miriam Molina Robles	555-0181	3	2023-04-05 10:45:00
82	Esteban Robles Rueda	555-0182	3	2023-04-06 11:55:00
83	Selena Rueda Bustos	555-0183	3	2023-04-07 12:40:00
84	Ulises Bustos Lara	555-0184	3	2023-04-08 13:50:00
85	Noemí Lara Montes	555-0185	3	2023-04-09 14:25:00
86	Eduardo Montes Sosa	555-0186	3	2023-04-10 15:35:00
87	Brenda Sosa Peralta	555-0187	3	2023-04-11 16:45:00
88	Victoriano Peralta Contreras	555-0188	3	2023-04-12 08:55:00
89	Susana Contreras Roa	555-0189	3	2023-04-13 09:40:00
90	Abigail Roa Ávila	555-0190	3	2023-04-14 10:50:00
91	Humberto Ávila Lugo	555-0191	3	2023-04-15 11:30:00
92	Iván Lugo Figueroa	555-0192	3	2023-04-16 12:40:00
93	Lourdes Figueroa Mora	555-0193	3	2023-04-17 13:50:00
94	Tomás Mora Zúñiga	555-0194	3	2023-04-18 14:25:00
95	Magdalena Zúñiga Rosales	555-0195	3	2023-04-19 15:35:00
96	Jaime Rosales De La Cruz	555-0196	3	2023-04-20 16:45:00
97	Araceli De La Cruz Camacho	555-0197	3	2023-04-21 08:35:00
98	Ismael Camacho Sepúlveda	555-0198	3	2023-04-22 09:45:00
99	Griselda Sepúlveda Venegas	555-0199	3	2023-04-23 10:55:00
100	Feliciano Venegas Rico	555-0200	3	2023-04-24 11:40:00
101	Dorotea Rico Bustamante	555-0201	3	2023-04-25 12:50:00
102	Teodoro Bustamante Pineda	555-0202	3	2023-04-26 13:35:00
103	Josefina Pineda Salcedo	555-0203	3	2023-04-27 14:45:00
104	Anastacio Salcedo Alvarado	555-0204	3	2023-04-28 15:55:00
105	Florencia Alvarado Roldán	555-0205	3	2023-04-29 16:30:00
106	Leopoldo Roldán Escamilla	555-0206	3	2023-04-30 08:40:00
107	Rosalía Escamilla Barragán	555-0207	3	2023-05-01 09:50:00
108	Bonifacio Barragán Cepeda	555-0208	3	2023-05-02 10:25:00
109	Eugenia Cepeda Ballesteros	555-0209	3	2023-05-03 11:35:00
110	Celestino Ballesteros Arredondo	555-0210	3	2023-05-04 12:45:00
111	Marcela Arredondo Collado	555-0211	3	2023-05-05 13:20:00
112	Severiano Collado Bahena	555-0212	3	2023-05-06 14:30:00
113	Benita Bahena Arriaga	555-0213	3	2023-05-07 15:40:00
114	Eligio Arriaga Amador	555-0214	3	2023-05-08 16:15:00
115	Simona Amador Alarcón	555-0215	3	2023-05-09 08:25:00
116	Fidel Alarcón Anguiano	555-0216	3	2023-05-10 09:35:00
117	Palmira Anguiano Arellano	555-0217	3	2023-05-11 10:45:00
118	Gumersindo Arellano Armenta	555-0218	3	2023-05-12 11:55:00
119	Trinidad Armenta Aparicio	555-0219	3	2023-05-13 12:30:00
120	Eusebio Aparicio Arguello	555-0220	3	2023-05-14 13:40:00
121	Jovita Arguello Arzate	555-0221	3	2023-05-15 14:50:00
122	Nicanor Arzate Baca	555-0222	3	2023-05-16 15:25:00
123	Otilia Baca Badillo	555-0223	3	2023-05-17 16:35:00
124	Plácido Badillo Báez	555-0224	3	2023-05-18 08:45:00
125	Querubín Báez Banda	555-0225	3	2023-05-19 09:20:00
126	Rafaela Banda Barrios	555-0226	3	2023-05-20 10:30:00
127	Saturnino Barrios Batista	555-0227	3	2023-05-21 11:40:00
128	Tadeo Batista Becerra	555-0228	3	2023-05-22 12:50:00
129	Úrsula Becerra Beltrán	555-0229	3	2023-05-23 13:25:00
130	Vicenta Beltrán Benavides	555-0230	3	2023-05-24 14:35:00
131	Wenceslao Benavides Benítez	555-0231	3	2023-05-25 15:45:00
132	Xóchitl Benítez Bermúdez	555-0232	3	2023-05-26 16:20:00
133	Yamel Bermúdez Bernabe	555-0233	3	2023-05-27 08:30:00
134	Zacarías Bernabe Betancourt	555-0234	3	2023-05-28 09:40:00
135	Amada Betancourt Blanco	555-0235	3	2023-05-29 10:50:00
136	Bartolomé Blanco Bonilla	555-0236	3	2023-05-30 11:25:00
137	Casandra Bonilla Borja	555-0237	3	2023-05-31 12:35:00
138	Demetrio Borja Bravo	555-0238	3	2023-06-01 13:45:00
139	Edelmira Bravo Briones	555-0239	3	2023-06-02 14:55:00
140	Fabio Briones Bueno	555-0240	3	2023-06-03 15:30:00
141	Genoveva Bueno Burgos	555-0241	3	2023-06-04 16:40:00
142	Herminio Burgos Bustos	555-0242	3	2023-06-05 08:50:00
143	Ignacia Bustos Caballero	555-0243	3	2023-06-06 09:35:00
144	Jacinto Caballero Cabañas	555-0244	3	2023-06-07 10:45:00
145	Karla Cabañas Calderón	555-0245	3	2023-06-08 11:55:00
146	Lorenza Calderón Calvo	555-0246	3	2023-06-09 12:40:00
147	Macario Calvo Camarena	555-0247	3	2023-06-10 13:50:00
148	Nereida Camarena Campoy	555-0248	3	2023-06-11 14:25:00
149	Oswaldo Campoy Canales	555-0249	3	2023-06-12 15:35:00
150	Petrona Canales Cantú	555-0250	3	2023-06-13 16:45:00
151	Quintín Cantú Carbajal	555-0251	3	2023-06-14 08:55:00
152	Raymundo Carbajal Cárdenas	555-0252	3	2023-06-15 09:40:00
153	Sabina Cárdenas Carmona	555-0253	3	2023-06-16 10:50:00
154	Tiburcio Carmona Carranza	555-0254	3	2023-06-17 11:30:00
155	Ubaldo Carranza Carrasco	555-0255	3	2023-06-18 12:40:00
156	Venancia Carrasco Casas	555-0256	3	2023-06-19 13:50:00
157	Wilfrido Casas Castañeda	555-0257	3	2023-06-20 14:25:00
158	Yolanda Castañeda Castellanos	555-0258	3	2023-06-21 15:35:00
159	Zenaida Castellanos Castillo	555-0259	3	2023-06-22 16:45:00
160	Abelardo Castillo Castro	555-0260	3	2023-06-23 08:35:00
161	Berta Castro Cervantes	555-0261	3	2023-06-24 09:45:00
162	Cipriano Cervantes Chacón	555-0262	3	2023-06-25 10:55:00
163	Dulce Chacón Chavarría	555-0263	3	2023-06-26 11:40:00
164	Eleuterio Chavarría Cisneros	555-0264	3	2023-06-27 12:50:00
165	Fidencia Cisneros Colunga	555-0265	3	2023-06-28 13:35:00
166	Geronimo Colunga Corral	555-0266	3	2023-06-29 14:45:00
167	Heriberta Corral Cortés	555-0267	3	2023-06-30 15:55:00
168	Inocencio Cortés Corvera	555-0268	3	2023-07-01 16:30:00
169	Jazmín Corvera Covarrubias	555-0269	3	2023-07-02 08:40:00
170	Kristian Covarrubias Crespo	555-0270	3	2023-07-03 09:50:00
171	Leocadia Crespo Cuellar	555-0271	3	2023-07-04 10:25:00
172	Mateo Cuellar Cuenca	555-0272	3	2023-07-05 11:35:00
173	Nicolasa Cuenca Del Río	555-0273	3	2023-07-06 12:45:00
174	Onésimo Del Río Duarte	555-0274	3	2023-07-07 13:20:00
175	Pascuala Duarte Dueñas	555-0275	3	2023-07-08 14:30:00
176	Rigoberto Dueñas Durán	555-0276	3	2023-07-09 15:40:00
177	Socorro Durán Enríquez	555-0277	3	2023-07-10 16:15:00
178	Teófila Enríquez Escobedo	555-0278	3	2023-07-11 08:25:00
179	Urbano Escobedo Esparza	555-0279	3	2023-07-12 09:35:00
180	Violeta Esparza Estévez	555-0280	3	2023-07-13 10:45:00
181	Wolfgang Estévez Fajardo	555-0281	3	2023-07-14 11:55:00
182	Yajaira Fajardo Fierro	555-0282	3	2023-07-15 12:30:00
183	Zulema Fierro Figueroa	555-0283	3	2023-07-16 13:40:00
184	Adán Figueroa Fraga	555-0284	3	2023-07-17 14:50:00
185	Baldomero Fraga Frías	555-0285	3	2023-07-18 15:25:00
186	Candelaria Frías Galván	555-0286	3	2023-07-19 16:35:00
187	Damián Galván Gamboa	555-0287	3	2023-07-20 08:45:00
188	Edgar Gamboa Garay	555-0288	3	2023-07-21 09:20:00
189	Faustino Garay García	555-0289	3	2023-07-22 10:30:00
190	Gloria García Garrido	555-0290	3	2023-07-23 11:40:00
191	Honorio Garrido Gámez	555-0291	3	2023-07-24 12:50:00
192	Irene Gámez Gil	555-0292	3	2023-07-25 13:25:00
193	Jerónimo Gil Godínez	555-0293	3	2023-07-26 14:35:00
194	Katia Godínez González	555-0294	3	2023-07-27 15:45:00
195	Lázaro González Guadalupe	555-0295	3	2023-07-28 16:20:00
196	Mireya Guadalupe Guerra	555-0296	3	2023-07-29 08:30:00
197	Néstor Guerra Gutiérrez	555-0297	3	2023-07-30 09:40:00
198	Octavio Gutiérrez Guzmán	555-0298	3	2023-07-31 10:50:00
199	Pablo Guzmán Haro	555-0299	3	2023-08-01 11:25:00
200	Quetzal Haro Henríquez	555-0300	3	2023-08-02 12:35:00
201	Rosa Henríquez Heredia	555-0301	3	2023-08-03 13:45:00
202	Salomón Heredia Hermosillo	555-0302	3	2023-08-04 14:55:00
203	Teresita Hermosillo Hidalgo	555-0303	3	2023-08-05 15:30:00
204	Uriel Hidalgo Huerta	555-0304	3	2023-08-06 16:40:00
205	Valentina Huerta Ibarra	555-0305	3	2023-08-07 08:50:00
206	Wendy Ibarra Icaza	555-0306	3	2023-08-08 09:35:00
207	Xavier Icaza Infante	555-0307	3	2023-08-09 10:45:00
208	Yadira Infante Islas	555-0308	3	2023-08-10 11:55:00
209	Zacarías Islas Jaramillo	555-0309	3	2023-08-11 12:40:00
210	Amador Jaramillo Jasso	555-0310	3	2023-08-12 13:50:00
211	Brígida Jasso Jiménez	555-0311	3	2023-08-13 14:25:00
212	Custodio Jiménez Jurado	555-0312	3	2023-08-14 15:35:00
213	Debora Jurado Ledesma	555-0313	3	2023-08-15 16:45:00
214	Efraín Ledesma Leal	555-0314	3	2023-08-16 08:35:00
215	Flavia Leal Lemus	555-0315	3	2023-08-17 09:45:00
216	Griselda Lemus León	555-0316	3	2023-08-18 10:55:00
217	Hilario León Linares	555-0317	3	2023-08-19 11:40:00
218	Iliana Linares Lira	555-0318	3	2023-08-20 12:50:00
219	Jacobo Lira Llamas	555-0319	3	2023-08-21 13:35:00
220	Kenia Llamas Lozano	555-0320	3	2023-08-22 14:45:00
221	Lisandro Lozano Luque	555-0321	3	2023-08-23 15:55:00
222	Mónica Luque Macías	555-0322	3	2023-08-24 16:30:00
223	Natalio Macías Madrid	555-0323	3	2023-08-25 08:40:00
224	Odalys Madrid Maldonado	555-0324	3	2023-08-26 09:50:00
225	Pánfilo Maldonado Marín	555-0325	3	2023-08-27 10:25:00
226	Quechol Marín Marroquín	555-0326	3	2023-08-28 11:35:00
227	Ramiro Marroquín Mata	555-0327	3	2023-08-29 12:45:00
228	Sabino Mata Medrano	555-0328	3	2023-08-30 13:20:00
229	Tadea Medrano Meza	555-0329	3	2023-08-31 14:30:00
230	Ursulina Meza Mireles	555-0330	3	2023-09-01 15:40:00
231	Vianey Mireles Mojica	555-0331	3	2023-09-02 16:15:00
232	Wendolin Mojica Monroy	555-0332	3	2023-09-03 08:25:00
233	Ximena Monroy Montaño	555-0333	3	2023-09-04 09:35:00
234	Yair Montaño Montes	555-0334	3	2023-09-05 10:45:00
235	Zaira Montes Mora	555-0335	3	2023-09-06 11:55:00
236	Abel Mora Munguía	555-0336	3	2023-09-07 12:30:00
237	Betsabé Munguía Murillo	555-0337	3	2023-09-08 13:40:00
238	Caleb Murillo Nájera	555-0338	3	2023-09-09 14:50:00
239	Danae Nájera Navarro	555-0339	3	2023-09-10 15:25:00
240	Eder Navarro Nava	555-0340	3	2023-09-11 16:35:00
241	Fabiola Nava Neri	555-0341	3	2023-09-12 08:45:00
242	Gaspar Neri Nieto	555-0342	3	2023-09-13 09:20:00
243	Heliodoro Nieto Núñez	555-0343	3	2023-09-14 10:30:00
244	Ifigenia Núñez Ocampo	555-0344	3	2023-09-15 11:40:00
245	Jonás Ocampo Ochoa	555-0345	3	2023-09-16 12:50:00
246	Karla Ochoa Oliva	555-0346	3	2023-09-17 13:25:00
247	Lino Oliva Olivares	555-0347	3	2023-09-18 14:35:00
248	Maité Olivares Olmos	555-0348	3	2023-09-19 15:45:00
249	Nahum Olmos Ontiveros	555-0349	3	2023-09-20 16:20:00
250	Obdulia Ontiveros Orozco	555-0350	3	2023-09-21 08:30:00
251	Paco Orozco Ortega	555-0351	3	2023-09-22 09:40:00
252	Quirino Ortega Ortiz	555-0352	3	2023-09-23 10:50:00
253	Rita Ortiz Osorio	555-0353	3	2023-09-24 11:25:00
254	Salvador Osorio Otero	555-0354	3	2023-09-25 12:35:00
255	Tadeo Otero Pabón	555-0355	3	2023-09-26 13:45:00
256	Úrsula Pabón Padilla	555-0356	3	2023-09-27 14:55:00
257	Vicente Padilla Padrón	555-0357	3	2023-09-28 15:30:00
258	Wálter Padrón Palacios	555-0358	3	2023-09-29 16:40:00
259	Xenia Palacios Parra	555-0359	3	2023-09-30 08:50:00
260	Yahir Parra Pascual	555-0360	3	2023-10-01 09:35:00
261	Zaida Pascual Pedraza	555-0361	3	2023-10-02 10:45:00
263	Belen Peguero Pelayo	555-0363	3	2023-10-04 12:40:00
264	Ciro Pelayo Peñaloza	555-0364	3	2023-10-05 13:50:00
265	Dulce Peñaloza Peralta	555-0365	3	2023-10-06 14:25:00
266	Emanuel Peralta Pichardo	555-0366	3	2023-10-07 15:35:00
267	Flora Pichardo Piedra	555-0367	3	2023-10-08 16:45:00
268	Gerardo Piedra Pineda	555-0368	3	2023-10-09 08:55:00
269	Herminia Pineda Pizarro	555-0369	3	2023-10-10 09:40:00
270	Iván Pizarro Polanco	555-0370	3	2023-10-11 10:50:00
271	Jazmín Polanco Porras	555-0371	3	2023-10-12 11:30:00
272	Kevin Porras Prado	555-0372	3	2023-10-13 12:40:00
273	Lilia Prado Prieto	555-0373	3	2023-10-14 13:50:00
274	Mauro Prieto Puente	555-0374	3	2023-10-15 14:25:00
275	Nadia Puente Puga	555-0375	3	2023-10-16 15:35:00
276	Óscar Puga Quezada	555-0376	3	2023-10-17 16:45:00
277	Patricia Quezada Quintero	555-0377	3	2023-10-18 08:35:00
278	Quinto Quintero Quiroz	555-0378	3	2023-10-19 09:45:00
279	Rocío Quiroz Ramírez	555-0379	3	2023-10-20 10:55:00
280	Samantha Ramírez Rangel	555-0380	3	2023-10-21 11:40:00
281	Teobaldo Rangel Razo	555-0381	3	2023-10-22 12:50:00
282	Ubaldo Razo Regalado	555-0382	3	2023-10-23 13:35:00
283	Valeria Regalado Rendón	555-0383	3	2023-10-24 14:45:00
284	Wilberto Rendón Reséndez	555-0384	3	2023-10-25 15:55:00
285	Ximena Reséndez Reyes	555-0385	3	2023-10-26 16:30:00
286	Yurem Reyes Ríos	555-0386	3	2023-10-27 08:40:00
287	Zoe Ríos Rivas	555-0387	3	2023-10-28 09:50:00
288	Amir Rivas Rivera	555-0388	3	2023-10-29 10:25:00
289	Brianda Rivera Robles	555-0389	3	2023-10-30 11:35:00
290	César Robles Rocha	555-0390	3	2023-10-31 12:45:00
291	Danna Rocha Rodarte	555-0391	3	2023-11-01 13:20:00
292	Efraín Rodarte Rodríguez	555-0392	3	2023-11-02 14:30:00
293	Fabio Rodríguez Rojas	555-0393	3	2023-11-03 15:40:00
294	Gabriela Rojas Romero	555-0394	3	2023-11-04 16:15:00
295	Héctor Romero Rosado	555-0395	3	2023-11-05 08:25:00
296	Irene Rosado Rosales	555-0396	3	2023-11-06 09:35:00
297	Josué Rosales Rosas	555-0397	3	2023-11-07 10:45:00
298	Karla Rosas Rubio	555-0398	3	2023-11-08 11:55:00
299	Leonardo Rubio Ruíz	555-0399	3	2023-11-09 12:30:00
300	Mónica Ruíz Saavedra	555-0400	3	2023-11-10 13:40:00
301	Nicolás Saavedra Salas	555-0401	3	2023-11-11 14:50:00
302	Olivia Salas Salazar	555-0402	3	2023-11-12 15:25:00
303	Pablo Salazar Saldívar	555-0403	3	2023-11-13 16:35:00
304	Quintín Saldívar Salgado	555-0404	3	2023-11-14 08:45:00
305	Raquel Salgado Salinas	555-0405	3	2023-11-15 09:20:00
306	Santiago Salinas Samaniego	555-0406	3	2023-11-16 10:30:00
307	Tania Samaniego Sanabria	555-0407	3	2023-11-17 11:40:00
308	Úrsula Sanabria Sánchez	555-0408	3	2023-11-18 12:50:00
309	Víctor Sánchez Sandoval	555-0409	3	2023-11-19 13:25:00
310	Wendy Sandoval Santa Cruz	555-0410	3	2023-11-20 14:35:00
311	Xavier Santa Cruz Santana	555-0411	3	2023-11-21 15:45:00
312	Yara Santana Santos	555-0412	3	2023-11-22 16:20:00
313	Zacarías Santos Sierra	555-0413	3	2023-11-23 08:30:00
314	Abigail Sierra Silva	555-0414	3	2023-11-24 09:40:00
315	Benjamín Silva Solano	555-0415	3	2023-11-25 10:50:00
316	Camila Solano Solís	555-0416	3	2023-11-26 11:25:00
317	Daniel Solís Sosa	555-0417	3	2023-11-27 12:35:00
318	Esteban Sosa Sotelo	555-0418	3	2023-11-28 13:45:00
319	Fernanda Sotelo Tafoya	555-0419	3	2023-11-29 14:55:00
320	Gabriel Tafoya Tamayo	555-0420	3	2023-11-30 15:30:00
321	Hortensia Tamayo Tapia	555-0421	3	2023-12-01 16:40:00
322	Ignacio Tapia Tejada	555-0422	3	2023-12-02 08:50:00
323	Jimena Tejada Téllez	555-0423	3	2023-12-03 09:35:00
324	Kevin Téllez Terán	555-0424	3	2023-12-04 10:45:00
325	Laura Terán Terrazas	555-0425	3	2023-12-05 11:55:00
326	Manuel Terrazas Tirado	555-0426	3	2023-12-06 12:40:00
327	Natalia Tirado Toledo	555-0427	3	2023-12-07 13:50:00
328	Óscar Toledo Torres	555-0428	3	2023-12-08 14:25:00
329	Paola Torres Trejo	555-0429	3	2023-12-09 15:35:00
330	Ricardo Trejo Treviño	555-0430	3	2023-12-10 16:45:00
331	Sara Treviño Trujillo	555-0431	3	2023-12-11 08:55:00
332	Tomás Trujillo Uribe	555-0432	3	2023-12-12 09:40:00
333	Úrsula Uribe Urrutia	555-0433	3	2023-12-13 10:50:00
334	Vicente Urrutia Vaca	555-0434	3	2023-12-14 11:30:00
335	Wendy Vaca Valadez	555-0435	3	2023-12-15 12:40:00
336	Ximena Valadez Valdés	555-0436	3	2023-12-16 13:50:00
337	Yahir Valdés Valencia	555-0437	3	2023-12-17 14:25:00
338	Zoe Valencia Valenzuela	555-0438	3	2023-12-18 15:35:00
339	Aaron Valenzuela Varela	555-0439	3	2023-12-19 16:45:00
340	Brenda Varela Vargas	555-0440	3	2023-12-20 08:35:00
341	Cristian Vargas Vázquez	555-0441	3	2023-12-21 09:45:00
342	Diana Vázquez Vega	555-0442	3	2023-12-22 10:55:00
343	Eduardo Vega Velasco	555-0443	3	2023-12-23 11:40:00
344	Fabiola Velasco Velázquez	555-0444	3	2023-12-24 12:50:00
345	Gonzalo Velázquez Venegas	555-0445	3	2023-12-25 13:35:00
346	Helena Venegas Vera	555-0446	3	2023-12-26 14:45:00
347	Iker Vera Vergara	555-0447	3	2023-12-27 15:55:00
348	Jazmín Vergara Villalobos	555-0448	3	2023-12-28 16:30:00
349	Kevin Villalobos Villanueva	555-0449	3	2023-12-29 08:40:00
350	Laura Villanueva Villarreal	555-0450	3	2023-12-30 09:50:00
351	Miguel Villarreal Yáñez	555-0451	3	2023-12-31 10:25:00
352	Nadia Yáñez Zamora	555-0452	3	2024-01-01 11:35:00
353	Oscar Zamora Zepeda	555-0453	3	2024-01-02 12:45:00
354	Patricia Zepeda Zúñiga	555-0454	3	2024-01-03 13:20:00
355	Roberto Zúñiga Acuña	555-0455	3	2024-01-04 14:30:00
356	Sandra Acuña Aguirre	555-0456	3	2024-01-05 15:40:00
357	Tania Aguirre Almeida	555-0457	3	2024-01-06 16:15:00
358	Uriel Almeida Andrade	555-0458	3	2024-01-07 08:25:00
359	Verónica Andrade Arévalo	555-0459	3	2024-01-08 09:35:00
360	William Arévalo Arroyo	555-0460	3	2024-01-09 10:45:00
361	Ximena Arroyo Avilés	555-0461	3	2024-01-10 11:55:00
362	Yahir Avilés Bello	555-0462	3	2024-01-11 12:30:00
363	Zara Bello Bernal	555-0463	3	2024-01-12 13:40:00
364	Alan Bernal Cabrera	555-0464	3	2024-01-13 14:50:00
365	Bianca Cabrera Cadena	555-0465	3	2024-01-14 15:25:00
366	César Cadena Callejas	555-0466	3	2024-01-15 16:35:00
367	Danna Callejas Cardona	555-0467	3	2024-01-16 08:45:00
368	Erick Cardona Carrillo	555-0468	3	2024-01-17 09:20:00
369	Fabiola Carrillo Casillas	555-0469	3	2024-01-18 10:30:00
370	Gerardo Casillas Ceballos	555-0470	3	2024-01-19 11:40:00
371	Helen Ceballos Cepeda	555-0471	3	2024-01-20 12:50:00
372	Iván Cepeda Cerda	555-0472	3	2024-01-21 13:25:00
373	Jackeline Cerda Cervantes	555-0473	3	2024-01-22 14:35:00
374	Kevin Cervantes Chávez	555-0474	3	2024-01-23 15:45:00
375	Laura Chávez Córdoba	555-0475	3	2024-01-24 16:20:00
376	Mauricio Córdoba Cornejo	555-0476	3	2024-01-25 08:30:00
377	Natalia Cornejo Cortés	555-0477	3	2024-01-26 09:40:00
378	Óscar Cortés Crespo	555-0478	3	2024-01-27 10:50:00
379	Paola Crespo Cruz	555-0479	3	2024-01-28 11:25:00
380	Roberto Cruz De La Fuente	555-0480	3	2024-01-29 12:35:00
381	Sara De La Fuente Delgado	555-0481	3	2024-01-30 13:45:00
382	Tomás Delgado Díaz	555-0482	3	2024-01-31 14:55:00
383	Úrsula Díaz Domínguez	555-0483	3	2024-02-01 15:30:00
384	Víctor Domínguez Duarte	555-0484	3	2024-02-02 16:40:00
385	Wendy Duarte Enríquez	555-0485	3	2024-02-03 08:50:00
386	Xavier Enríquez Escobar	555-0486	3	2024-02-04 09:35:00
387	Yara Escobar Esparza	555-0487	3	2024-02-05 10:45:00
388	Zacarías Esparza Estrada	555-0488	3	2024-02-06 11:55:00
389	Ana Estrada Fajardo	555-0489	3	2024-02-07 12:40:00
390	Bruno Fajardo Flores	555-0490	3	2024-02-08 13:50:00
391	Carla Flores Franco	555-0491	3	2024-02-09 14:25:00
392	David Franco Galindo	555-0492	3	2024-02-10 15:35:00
393	Elena Galindo García	555-0493	3	2024-02-11 16:45:00
394	Fernando García Garza	555-0494	3	2024-02-12 08:55:00
395	Gabriela Garza Gónzalez	555-0495	3	2024-02-13 09:40:00
396	Héctor Gónzalez Guerrero	555-0496	3	2024-02-14 10:50:00
397	Irene Guerrero Gutiérrez	555-0497	3	2024-02-15 11:30:00
398	Javier Gutiérrez Hernández	555-0498	3	2024-02-16 12:40:00
399	Karen Hernández Herrera	555-0499	3	2024-02-17 13:50:00
400	Luis Herrera Ibáñez	555-0500	3	2024-02-18 14:25:00
401	María Ibáñez Jiménez	555-0501	3	2024-02-19 15:35:00
402	Nicolás Jiménez Juárez	555-0502	3	2024-02-20 16:45:00
403	Olivia Juárez Lara	555-0503	3	2024-02-21 08:35:00
404	Pedro Lara López	555-0504	3	2024-02-22 09:45:00
405	Quetzal López Martínez	555-0505	3	2024-02-23 10:55:00
406	Rosa Martínez Medina	555-0506	3	2024-02-24 11:40:00
407	Sergio Medina Méndez	555-0507	3	2024-02-25 12:50:00
408	Tania Méndez Molina	555-0508	3	2024-02-26 13:35:00
409	Ulises Molina Morales	555-0509	3	2024-02-27 14:45:00
410	Valeria Morales Moreno	555-0510	3	2024-02-28 15:55:00
411	Walter Moreno Muñoz	555-0511	3	2024-02-29 16:30:00
412	Ximena Muñoz Nava	555-0512	3	2024-03-01 08:40:00
413	Yahir Nava Navarro	555-0513	3	2024-03-02 09:50:00
414	Zara Navarro Ochoa	555-0514	3	2024-03-03 10:25:00
415	Alan Ochoa Olvera	555-0515	3	2024-03-04 11:35:00
416	Brenda Olvera Ortega	555-0516	3	2024-03-05 12:45:00
417	Carlos Ortega Ortiz	555-0517	3	2024-03-06 13:20:00
418	Diana Ortiz Palma	555-0518	3	2023-03-07 14:30:00
419	Eduardo Palma Paredes	555-0519	3	2023-03-08 15:40:00
420	Fabiola Paredes Parra	555-0520	3	2023-03-09 16:15:00
421	Gabriel Parra Peña	555-0521	3	2023-03-10 08:25:00
422	Helena Peña Pérez	555-0522	3	2023-03-11 09:35:00
423	Iván Pérez Ramírez	555-0523	3	2023-03-12 10:45:00
424	Jackeline Ramírez Reyes	555-0524	3	2023-03-13 11:55:00
425	Kevin Reyes Ríos	555-0525	3	2023-03-14 12:30:00
426	Laura Ríos Rodríguez	555-0526	3	2023-03-15 13:40:00
427	Manuel Rodríguez Romero	555-0527	3	2023-03-16 14:50:00
428	Natalia Romero Ruiz	555-0528	3	2023-03-17 15:25:00
429	Óscar Ruiz Salazar	555-0529	3	2023-03-18 16:35:00
430	Paola Salazar Sánchez	555-0530	3	2023-03-19 08:45:00
431	Roberto Sánchez Silva	555-0531	3	2023-03-20 09:20:00
432	Sara Silva Solís	555-0532	3	2023-03-21 10:30:00
433	Tomás Solís Soto	555-0533	3	2023-03-22 11:40:00
434	Úrsula Soto Suárez	555-0534	3	2023-03-23 12:50:00
435	Víctor Suárez Tapia	555-0535	3	2023-03-24 13:25:00
436	Wendy Tapia Torres	555-0536	3	2023-03-25 14:35:00
437	Xavier Torres Valencia	555-0537	3	2023-03-26 15:45:00
438	Yara Valencia Vargas	555-0538	3	2023-03-27 16:20:00
439	Zacarías Vargas Vázquez	555-0539	3	2023-03-28 08:30:00
440	Ana Vázquez Velasco	555-0540	3	2023-03-29 09:40:00
441	Bruno Velasco Vega	555-0541	3	2023-03-30 10:50:00
442	Carla Vega Villalobos	555-0542	3	2023-03-31 11:25:00
443	David Villalobos Villanueva	555-0543	3	2023-04-01 12:35:00
444	Elena Villanueva Villarreal	555-0544	3	2023-04-02 13:45:00
445	Fernando Villarreal Yáñez	555-0545	3	2023-04-03 14:55:00
446	Gabriela Yáñez Zamora	555-0546	3	2023-04-04 15:30:00
447	Héctor Zamora Zepeda	555-0547	3	2023-04-05 16:40:00
448	Irene Zepeda Zúñiga	555-0548	3	2023-04-06 08:50:00
449	Javier Zúñiga Acosta	555-0549	3	2023-04-07 09:35:00
450	Karen Acosta Aguilar	555-0550	3	2023-04-08 10:45:00
451	Luis Aguilar Álvarez	555-0551	3	2023-04-09 11:55:00
452	María Álvarez Ávila	555-0552	3	2023-04-10 12:40:00
453	Nicolás Ávila Bravo	555-0553	3	2023-04-11 13:50:00
454	Olivia Bravo Camacho	555-0554	3	2023-04-12 14:25:00
455	Pedro Camacho Campos	555-0555	3	2023-04-13 15:35:00
456	Quetzal Campos Cantú	555-0556	3	2023-04-14 16:45:00
457	Rosa Cantú Carrasco	555-0557	3	2023-04-15 08:55:00
458	Sergio Carrasco Castellanos	555-0558	3	2023-04-16 09:40:00
459	Tania Castellanos Cervantes	555-0559	3	2023-04-17 10:50:00
460	Ulises Cervantes Chávez	555-0560	3	2023-04-18 11:30:00
461	Valeria Chávez Córdova	555-0561	3	2023-04-19 12:40:00
462	Walter Córdova Corral	555-0562	3	2023-04-20 13:50:00
463	Ximena Corral Delgado	555-0563	3	2023-04-21 14:25:00
464	Yahir Delgado Díaz	555-0564	3	2023-04-22 15:35:00
465	Zara Díaz Durán	555-0565	3	2023-04-23 16:45:00
466	Alan Durán Escobar	555-0566	3	2023-04-24 08:35:00
467	Brenda Escobar Espinoza	555-0567	3	2023-04-25 09:45:00
468	Carlos Espinoza Fernández	555-0568	3	2023-04-26 10:55:00
469	Diana Fernández Flores	555-0569	3	2023-04-27 11:40:00
470	Eduardo Flores Fuentes	555-0570	3	2023-04-28 12:50:00
471	Fabiola Fuentes García	555-0571	3	2023-04-29 13:35:00
472	Gabriel García Gómez	555-0572	3	2023-04-30 14:45:00
473	Helena Gómez González	555-0573	3	2023-05-01 15:55:00
474	Iván González Guerrero	555-0574	3	2023-05-02 16:30:00
475	Jackeline Guerrero Gutiérrez	555-0575	3	2023-05-03 08:40:00
476	Kevin Gutiérrez Hernández	555-0576	3	2023-05-04 09:50:00
477	Laura Hernández Herrera	555-0577	3	2023-05-05 10:25:00
478	Manuel Herrera Ibáñez	555-0578	3	2023-05-06 11:35:00
479	Natalia Ibáñez Jiménez	555-0579	3	2023-05-07 12:45:00
480	Óscar Jiménez Juárez	555-0580	3	2023-05-08 13:20:00
481	Paola Juárez Lara	555-0581	3	2023-05-09 14:30:00
482	Roberto Lara López	555-0582	3	2023-05-10 15:40:00
483	Sara López Martínez	555-0583	3	2023-05-11 16:15:00
484	Tomás Martínez Medina	555-0584	3	2023-05-12 08:25:00
485	Úrsula Medina Méndez	555-0585	3	2023-05-13 09:35:00
486	Víctor Méndez Molina	555-0586	3	2023-05-14 10:45:00
487	Wendy Molina Morales	555-0587	3	2023-05-15 11:55:00
488	Xavier Morales Moreno	555-0588	3	2023-05-16 12:30:00
489	Yara Moreno Muñoz	555-0589	3	2023-05-17 13:40:00
490	Zacarías Muñoz Nava	555-0590	3	2023-05-18 14:50:00
491	Ana Nava Navarro	555-0591	3	2023-05-19 15:25:00
492	Bruno Navarro Ochoa	555-0592	3	2023-05-20 16:35:00
493	Carla Ochoa Olvera	555-0593	3	2023-05-21 08:45:00
494	David Olvera Ortega	555-0594	3	2023-05-22 09:20:00
495	Elena Ortega Ortiz	555-0595	3	2023-05-23 10:30:00
496	Fernando Ortiz Palma	555-0596	3	2023-05-24 11:40:00
497	Gabriela Palma Paredes	555-0597	3	2023-05-25 12:50:00
498	Héctor Paredes Parra	555-0598	3	2023-05-26 13:25:00
499	Irene Parra Peña	555-0599	3	2023-05-27 14:35:00
500	Javier Peña Pérez	555-0600	3	2023-05-28 15:45:00
501	Javiers	56114641	3	2025-10-24 19:21:46.645538
502	Jose Javier Cano	5487986854	3	2025-10-30 15:07:06.649276
503	Jose Javier Cano Garcia	5897966462	3	2025-10-30 18:55:29.951248
504	Eric Ivan	5658595457	3	2025-11-05 14:32:46.547016
505	Ivan	54789857	3	2025-11-05 14:37:14.421247
507	jjk	556856	3	2025-11-12 14:40:20.330019
509	Jose Javier Cano Garcia	5611464178	3	2025-11-20 16:50:49.968783
262	Aaron Pedraza Peguero	555-0362	3	2023-10-03 11:55:00
510	Francisco Javier	3781106454	3	2025-11-24 17:42:17.549672
\.


--
-- TOC entry 5034 (class 0 OID 16604)
-- Dependencies: 222
-- Data for Name: empleados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleados (id, nombre, rol_id, "contraseña", fecha_creacion) FROM stdin;
1	Admin	1	$2y$10$G3wUb61bTy.rJAJgsc8VVu3tA4xtO3nv9L5aeD/gGlbo5Nq10YV1a	2025-09-15 00:00:00
3	Javier	2	$2y$10$/sKQHW4kAOX2Byd8Cp.SE.QuW/zRxG.JclfFptZLM.3g8uTgQ7gna	2025-09-15 23:31:39.5076
4	Rocio	2	$2y$10$zb9u3R5dMIseGtk86BhjOe94FtJHs.o4E0KU04f8bd1X6tckxx6d2	2025-09-18 14:08:46.116848
5	Rosa	2	$2y$10$XfPZr3uH/eDLv0/VT814v.X0jFuveOB0BtI//64je6Lm9Hw7lhD1q	2025-09-19 18:24:15.30179
6	Laura Hernández	2	cGFzc3dvcmQ2	2023-01-20 16:15:00
7	Miguel Sánchez	2	cGFzc3dvcmQ3	2023-01-21 08:45:00
8	Elena Ramírez	2	cGFzc3dvcmQ4	2023-01-22 09:30:00
9	Jorge Díaz	2	cGFzc3dvcmQ5	2023-01-23 10:15:00
10	Sofia Castro	2	cGFzc3dvcmQxMA==	2023-01-24 11:00:00
11	Diego Morales	2	cGFzc3dvcmQxMQ==	2023-01-25 12:20:00
12	Carmen Ruiz	2	cGFzc3dvcmQxMg==	2023-01-26 13:45:00
13	Fernando Vargas	2	cGFzc3dvcmQxMw==	2023-01-27 14:30:00
14	Isabel Ortega	2	cGFzc3dvcmQxNA==	2023-01-28 15:15:00
15	Ricardo Mendoza	2	cGFzc3dvcmQxNQ==	2023-01-29 16:00:00
16	Patricia Silva	2	cGFzc3dvcmQxNg==	2023-01-30 08:20:00
17	Roberto Núñez	2	cGFzc3dvcmQxNw==	2023-01-31 09:10:00
18	Adriana Rojas	2	cGFzc3dvcmQxOA==	2023-02-01 10:05:00
19	Gabriel Peña	2	cGFzc3dvcmQxOQ==	2023-02-02 11:30:00
20	Daniela Herrera	2	cGFzc3dvcmQyMA==	2023-02-03 12:45:00
21	Luis González	2	cGFzc3dvcmQyMQ==	2023-02-04 13:20:00
22	Andrea Castillo	2	cGFzc3dvcmQyMg==	2023-02-05 14:15:00
23	José Romero	2	cGFzc3dvcmQyMw==	2023-02-06 15:40:00
24	Valeria Torres	2	cGFzc3dvcmQyNA==	2023-02-07 16:25:00
25	Francisco Reyes	2	cGFzc3dvcmQyNQ==	2023-02-08 08:50:00
26	Natalia Flores	2	cGFzc3dvcmQyNg==	2023-02-09 09:35:00
27	Alejandro Gutiérrez	2	cGFzc3dvcmQyNw==	2023-02-10 10:40:00
28	Verónica Medina	2	cGFzc3dvcmQyOA==	2023-02-11 11:55:00
29	Raúl Guerrero	2	cGFzc3dvcmQyOQ==	2023-02-12 12:30:00
30	Monica Paredes	2	cGFzc3dvcmQzMA==	2023-02-13 13:45:00
31	Sergio Ríos	2	cGFzc3dvcmQzMQ==	2023-02-14 14:20:00
32	Teresa Vega	2	cGFzc3dvcmQzMg==	2023-02-15 15:10:00
33	Arturo Campos	2	cGFzc3dvcmQzMw==	2023-02-16 16:05:00
34	Rosa Salazar	2	cGFzc3dvcmQzNA==	2023-02-17 08:15:00
35	Manuel Acosta	2	cGFzc3dvcmQzNQ==	2023-02-18 09:25:00
36	Lucía Ponce	2	cGFzc3dvcmQzNg==	2023-02-19 10:35:00
37	Oscar Miranda	2	cGFzc3dvcmQzNw==	2023-02-20 11:45:00
38	Claudia Santana	2	cGFzc3dvcmQzOA==	2023-02-21 12:55:00
39	Alberto Mejía	2	cGFzc3dvcmQzOQ==	2023-02-22 13:40:00
40	Beatriz León	2	cGFzc3dvcmQ0MA==	2023-02-23 14:50:00
41	Guillermo Orozco	2	cGFzc3dvcmQ0MQ==	2023-02-24 15:30:00
42	Margarita Cervantes	2	cGFzc3dvcmQ0Mg==	2023-02-25 16:20:00
43	Rodrigo Espinoza	2	cGFzc3dvcmQ0Mw==	2023-02-26 08:40:00
44	Silvia Montoya	2	cGFzc3dvcmQ0NA==	2023-02-27 09:50:00
45	Héctor Delgado	2	cGFzc3dvcmQ0NQ==	2023-02-28 10:25:00
46	Lorena Rangel	2	cGFzc3dvcmQ0Ng==	2023-03-01 11:35:00
47	Felipe Márquez	2	cGFzc3dvcmQ0Nw==	2023-03-02 12:45:00
48	Estela Solís	2	cGFzc3dvcmQ0OA==	2023-03-03 13:20:00
49	Mario Aguilar	2	cGFzc3dvcmQ0OQ==	2023-03-04 14:30:00
50	Diana Cordero	2	cGFzc3dvcmQ1MA==	2023-03-05 15:40:00
51	Enrique Valdez	2	cGFzc3dvcmQ1MQ==	2023-03-06 16:15:00
52	Alicia Franco	2	cGFzc3dvcmQ1Mg==	2023-03-07 08:25:00
53	Gustavo Ibarra	2	cGFzc3dvcmQ1Mw==	2023-03-08 09:35:00
54	Ruth Gallegos	2	cGFzc3dvcmQ1NA==	2023-03-09 10:45:00
55	Javier Lozano	2	cGFzc3dvcmQ1NQ==	2023-03-10 11:55:00
56	Paulina Serrano	2	cGFzc3dvcmQ1Ng==	2023-03-11 12:30:00
57	Alfonso Velázquez	2	cGFzc3dvcmQ1Nw==	2023-03-12 13:40:00
58	Cecilia Mendez	2	cGFzc3dvcmQ1OA==	2023-03-13 14:50:00
59	René Téllez	2	cGFzc3dvcmQ1OQ==	2023-03-14 15:25:00
60	Olivia Cabrera	2	cGFzc3dvcmQ2MA==	2023-03-15 16:35:00
61	Salvador Vázquez	2	cGFzc3dvcmQ2MQ==	2023-03-16 08:45:00
62	Ximena Pacheco	2	cGFzc3dvcmQ2Mg==	2023-03-17 09:20:00
63	Emilio Rivas	2	cGFzc3dvcmQ2Mw==	2023-03-18 10:30:00
64	Marisol Juárez	2	cGFzc3dvcmQ2NA==	2023-03-19 11:40:00
65	Gerardo Macías	2	cGFzc3dvcmQ2NQ==	2023-03-20 12:50:00
66	Liliana Bernal	2	cGFzc3dvcmQ2Ng==	2023-03-21 13:25:00
67	Armando Salas	2	cGFzc3dvcmQ2Nw==	2023-03-22 14:35:00
68	Karina Ayala	2	cGFzc3dvcmQ2OA==	2023-03-23 15:45:00
69	Rogelio Zamora	2	cGFzc3dvcmQ2OQ==	2023-03-24 16:20:00
70	Perla Carrillo	2	cGFzc3dvcmQ3MA==	2023-03-25 08:30:00
71	Samuel Escobar	2	cGFzc3dvcmQ3MQ==	2023-03-26 09:40:00
72	Yolanda Valencia	2	cGFzc3dvcmQ3Mg==	2023-03-27 10:50:00
73	César Correa	2	cGFzc3dvcmQ3Mw==	2023-03-28 11:25:00
74	Nora Osorio	2	cGFzc3dvcmQ3NA==	2023-03-29 12:35:00
75	Federico Quintero	2	cGFzc3dvcmQ3NQ==	2023-03-30 13:45:00
76	Esmeralda Palacios	2	cGFzc3dvcmQ3Ng==	2023-03-31 14:55:00
77	Leonardo Murillo	2	cGFzc3dvcmQ3Nw==	2023-04-01 15:30:00
78	Jimena Cárdenas	2	cGFzc3dvcmQ3OA==	2023-04-02 16:40:00
79	Hugo Barrios	2	cGFzc3dvcmQ3OQ==	2023-04-03 08:50:00
80	Rebeca Villanueva	2	cGFzc3dvcmQ4MA==	2023-04-04 09:35:00
81	Marcos Treviño	2	cGFzc3dvcmQ4MQ==	2023-04-05 10:45:00
82	Elvira Salgado	2	cGFzc3dvcmQ4Mg==	2023-04-06 11:55:00
83	Agustín Navarro	2	cGFzc3dvcmQ4Mw==	2023-04-07 12:40:00
84	Leticia Molina	2	cGFzc3dvcmQ4NA==	2023-04-08 13:50:00
85	Pablo Robles	2	cGFzc3dvcmQ4NQ==	2023-04-09 14:25:00
86	Aurora Rueda	2	cGFzc3dvcmQ4Ng==	2023-04-10 15:35:00
87	Saúl Bustos	2	cGFzc3dvcmQ4Nw==	2023-04-11 16:45:00
88	Consuelo Lara	2	cGFzc3dvcmQ4OA==	2023-04-12 08:55:00
89	Ramiro Montes	2	cGFzc3dvcmQ4OQ==	2023-04-13 09:40:00
90	Miriam Sosa	2	cGFzc3dvcmQ5MA==	2023-04-14 10:50:00
91	Esteban Peralta	2	cGFzc3dvcmQ5MQ==	2023-04-15 11:30:00
92	Selena Contreras	2	cGFzc3dvcmQ5Mg==	2023-04-16 12:40:00
93	Ulises Roa	2	cGFzc3dvcmQ5Mw==	2023-04-17 13:50:00
94	Noemí Ávila	2	cGFzc3dvcmQ5NA==	2023-04-18 14:25:00
95	Eduardo Lugo	2	cGFzc3dvcmQ5NQ==	2023-04-19 15:35:00
96	Brenda Figueroa	2	cGFzc3dvcmQ5Ng==	2023-04-20 16:45:00
97	Victoriano Mora	2	cGFzc3dvcmQ5Nw==	2023-04-21 08:35:00
98	Susana Zúñiga	2	cGFzc3dvcmQ5OA==	2023-04-22 09:45:00
99	Abigail Rosales	2	cGFzc3dvcmQ5OQ==	2023-04-23 10:55:00
100	Humberto De La Cruz	2	cGFzc3dvcmQxMDA=	2023-04-24 11:40:00
101	Iván Camacho	2	cGFzc3dvcmQxMDE=	2023-04-25 12:50:00
102	Lourdes Sepúlveda	2	cGFzc3dvcmQxMDI=	2023-04-26 13:35:00
103	Tomás Venegas	2	cGFzc3dvcmQxMDM=	2023-04-27 14:45:00
104	Magdalena Rico	2	cGFzc3dvcmQxMDQ=	2023-04-28 15:55:00
105	Jaime Bustamante	2	cGFzc3dvcmQxMDU=	2023-04-29 16:30:00
107	Ismael Salcedo	2	cGFzc3dvcmQxMDc=	2023-05-01 09:50:00
108	Griselda Alvarado	2	cGFzc3dvcmQxMDg=	2023-05-02 10:25:00
109	Feliciano Roldán	2	cGFzc3dvcmQxMDk=	2023-05-03 11:35:00
110	Dorotea Escamilla	2	cGFzc3dvcmQxMTA=	2023-05-04 12:45:00
111	Teodoro Barragán	2	cGFzc3dvcmQxMTE=	2023-05-05 13:20:00
112	Josefina Cepeda	2	cGFzc3dvcmQxMTI=	2023-05-06 14:30:00
113	Anastacio Ballesteros	2	cGFzc3dvcmQxMTM=	2023-05-07 15:40:00
114	Florencia Arredondo	2	cGFzc3dvcmQxMTQ=	2023-05-08 16:15:00
115	Leopoldo Collado	2	cGFzc3dvcmQxMTU=	2023-05-09 08:25:00
116	Rosalía Bahena	2	cGFzc3dvcmQxMTY=	2023-05-10 09:35:00
117	Bonifacio Arriaga	2	cGFzc3dvcmQxMTc=	2023-05-11 10:45:00
118	Eugenia Amador	2	cGFzc3dvcmQxMTg=	2023-05-12 11:55:00
119	Celestino Alarcón	2	cGFzc3dvcmQxMTk=	2023-05-13 12:30:00
120	Marcela Anguiano	2	cGFzc3dvcmQxMjA=	2023-05-14 13:40:00
121	Severiano Arellano	2	cGFzc3dvcmQxMjE=	2023-05-15 14:50:00
122	Benita Armenta	2	cGFzc3dvcmQxMjI=	2023-05-16 15:25:00
123	Eligio Aparicio	2	cGFzc3dvcmQxMjM=	2023-05-17 16:35:00
124	Simona Arguello	2	cGFzc3dvcmQxMjQ=	2023-05-18 08:45:00
125	Fidel Arzate	2	cGFzc3dvcmQxMjU=	2023-05-19 09:20:00
126	Palmira Baca	2	cGFzc3dvcmQxMjY=	2023-05-20 10:30:00
127	Gumersindo Badillo	2	cGFzc3dvcmQxMjc=	2023-05-21 11:40:00
128	Trinidad Báez	2	cGFzc3dvcmQxMjg=	2023-05-22 12:50:00
129	Eusebio Banda	2	cGFzc3dvcmQxMjk=	2023-05-23 13:25:00
130	Jovita Barrios	2	cGFzc3dvcmQxMzA=	2023-05-24 14:35:00
131	Nicanor Batista	2	cGFzc3dvcmQxMzE=	2023-05-25 15:45:00
132	Otilia Becerra	2	cGFzc3dvcmQxMzI=	2023-05-26 16:20:00
133	Plácido Beltrán	2	cGFzc3dvcmQxMzM=	2023-05-27 08:30:00
134	Querubín Benavides	2	cGFzc3dvcmQxMzQ=	2023-05-28 09:40:00
135	Rafaela Benítez	2	cGFzc3dvcmQxMzU=	2023-05-29 10:50:00
136	Saturnino Bermúdez	2	cGFzc3dvcmQxMzY=	2023-05-30 11:25:00
137	Tadeo Bernabe	2	cGFzc3dvcmQxMzc=	2023-05-31 12:35:00
138	Úrsula Betancourt	2	cGFzc3dvcmQxMzg=	2023-06-01 13:45:00
139	Vicenta Blanco	2	cGFzc3dvcmQxMzk=	2023-06-02 14:55:00
140	Wenceslao Bonilla	2	cGFzc3dvcmQxNDA=	2023-06-03 15:30:00
141	Xóchitl Borja	2	cGFzc3dvcmQxNDE=	2023-06-04 16:40:00
142	Yamel Bravo	2	cGFzc3dvcmQxNDI=	2023-06-05 08:50:00
143	Zacarías Briones	2	cGFzc3dvcmQxNDM=	2023-06-06 09:35:00
144	Amada Bueno	2	cGFzc3dvcmQxNDQ=	2023-06-07 10:45:00
145	Bartolomé Burgos	2	cGFzc3dvcmQxNDU=	2023-06-08 11:55:00
146	Casandra Bustos	2	cGFzc3dvcmQxNDY=	2023-06-09 12:40:00
147	Demetrio Caballero	2	cGFzc3dvcmQxNDc=	2023-06-10 13:50:00
148	Edelmira Cabañas	2	cGFzc3dvcmQxNDg=	2023-06-11 14:25:00
149	Fabio Calderón	2	cGFzc3dvcmQxNDk=	2023-06-12 15:35:00
150	Genoveva Calvo	2	cGFzc3dvcmQxNTA=	2023-06-13 16:45:00
151	Herminio Camarena	2	cGFzc3dvcmQxNTE=	2023-06-14 08:55:00
152	Ignacia Campoy	2	cGFzc3dvcmQxNTI=	2023-06-15 09:40:00
153	Jacinto Canales	2	cGFzc3dvcmQxNTM=	2023-06-16 10:50:00
154	Karla Cantú	2	cGFzc3dvcmQxNTQ=	2023-06-17 11:30:00
155	Lorenza Carbajal	2	cGFzc3dvcmQxNTU=	2023-06-18 12:40:00
156	Macario Cárdenas	2	cGFzc3dvcmQxNTY=	2023-06-19 13:50:00
157	Nereida Carmona	2	cGFzc3dvcmQxNTc=	2023-06-20 14:25:00
158	Oswaldo Carranza	2	cGFzc3dvcmQxNTg=	2023-06-21 15:35:00
159	Petrona Carrasco	2	cGFzc3dvcmQxNTk=	2023-06-22 16:45:00
160	Quintín Casas	2	cGFzc3dvcmQxNjA=	2023-06-23 08:35:00
161	Raymundo Castañeda	2	cGFzc3dvcmQxNjE=	2023-06-24 09:45:00
162	Sabina Castellanos	2	cGFzc3dvcmQxNjI=	2023-06-25 10:55:00
163	Tiburcio Castillo	2	cGFzc3dvcmQxNjM=	2023-06-26 11:40:00
164	Ubaldo Castro	2	cGFzc3dvcmQxNjQ=	2023-06-27 12:50:00
165	Venancia Cervantes	2	cGFzc3dvcmQxNjU=	2023-06-28 13:35:00
166	Wilfrido Chacón	2	cGFzc3dvcmQxNjY=	2023-06-29 14:45:00
167	Yolanda Chavarría	2	cGFzc3dvcmQxNjc=	2023-06-30 15:55:00
168	Zenaida Cisneros	2	cGFzc3dvcmQxNjg=	2023-07-01 16:30:00
169	Abelardo Colunga	2	cGFzc3dvcmQxNjk=	2023-07-02 08:40:00
170	Berta Corral	2	cGFzc3dvcmQxNzA=	2023-07-03 09:50:00
171	Cipriano Cortés	2	cGFzc3dvcmQxNzE=	2023-07-04 10:25:00
172	Dulce Corvera	2	cGFzc3dvcmQxNzI=	2023-07-05 11:35:00
173	Eleuterio Covarrubias	2	cGFzc3dvcmQxNzM=	2023-07-06 12:45:00
174	Fidencia Crespo	2	cGFzc3dvcmQxNzQ=	2023-07-07 13:20:00
175	Geronimo Cuellar	2	cGFzc3dvcmQxNzU=	2023-07-08 14:30:00
176	Heriberta Cuenca	2	cGFzc3dvcmQxNzY=	2023-07-09 15:40:00
177	Inocencio Del Río	2	cGFzc3dvcmQxNzc=	2023-07-10 16:15:00
178	Jazmín Duarte	2	cGFzc3dvcmQxNzg=	2023-07-11 08:25:00
179	Kristian Dueñas	2	cGFzc3dvcmQxNzk=	2023-07-12 09:35:00
180	Leocadia Durán	2	cGFzc3dvcmQxODA=	2023-07-13 10:45:00
181	Mateo Enríquez	2	cGFzc3dvcmQxODE=	2023-07-14 11:55:00
182	Nicolasa Escobedo	2	cGFzc3dvcmQxODI=	2023-07-15 12:30:00
183	Onésimo Esparza	2	cGFzc3dvcmQxODM=	2023-07-16 13:40:00
184	Pascuala Estévez	2	cGFzc3dvcmQxODQ=	2023-07-17 14:50:00
185	Rigoberto Fajardo	2	cGFzc3dvcmQxODU=	2023-07-18 15:25:00
186	Socorro Fierro	2	cGFzc3dvcmQxODY=	2023-07-19 16:35:00
187	Teófila Figueroa	2	cGFzc3dvcmQxODc=	2023-07-20 08:45:00
188	Urbano Fraga	2	cGFzc3dvcmQxODg=	2023-07-21 09:20:00
189	Violeta Frías	2	cGFzc3dvcmQxODk=	2023-07-22 10:30:00
190	Wolfgang Galván	2	cGFzc3dvcmQxOTA=	2023-07-23 11:40:00
191	Yajaira Gamboa	2	cGFzc3dvcmQxOTE=	2023-07-24 12:50:00
192	Zulema Garay	2	cGFzc3dvcmQxOTI=	2023-07-25 13:25:00
193	Adán García	2	cGFzc3dvcmQxOTM=	2023-07-26 14:35:00
194	Baldomero Garrido	2	cGFzc3dvcmQxOTQ=	2023-07-27 15:45:00
195	Candelaria Gámez	2	cGFzc3dvcmQxOTU=	2023-07-28 16:20:00
196	Damián Gil	2	cGFzc3dvcmQxOTY=	2023-07-29 08:30:00
197	Edgar Godínez	2	cGFzc3dvcmQxOTc=	2023-07-30 09:40:00
198	Faustino González	2	cGFzc3dvcmQxOTg=	2023-07-31 10:50:00
199	Gloria Guadalupe	2	cGFzc3dvcmQxOTk=	2023-08-01 11:25:00
200	Honorio Guerra	2	cGFzc3dvcmQyMDA=	2023-08-02 12:35:00
201	Irene Gutiérrez	2	cGFzc3dvcmQyMDE=	2023-08-03 13:45:00
202	Jerónimo Guzmán	2	cGFzc3dvcmQyMDI=	2023-08-04 14:55:00
203	Katia Haro	2	cGFzc3dvcmQyMDM=	2023-08-05 15:30:00
204	Lázaro Henríquez	2	cGFzc3dvcmQyMDQ=	2023-08-06 16:40:00
205	Mireya Heredia	2	cGFzc3dvcmQyMDU=	2023-08-07 08:50:00
206	Néstor Hermosillo	2	cGFzc3dvcmQyMDY=	2023-08-08 09:35:00
207	Octavio Hidalgo	2	cGFzc3dvcmQyMDc=	2023-08-09 10:45:00
208	Pablo Huerta	2	cGFzc3dvcmQyMDg=	2023-08-10 11:55:00
209	Quetzal Ibarra	2	cGFzc3dvcmQyMDk=	2023-08-11 12:40:00
210	Rosa Icaza	2	cGFzc3dvcmQyMTA=	2023-08-12 13:50:00
211	Salomón Infante	2	cGFzc3dvcmQyMTE=	2023-08-13 14:25:00
212	Teresita Islas	2	cGFzc3dvcmQyMTI=	2023-08-14 15:35:00
213	Uriel Jaramillo	2	cGFzc3dvcmQyMTM=	2023-08-15 16:45:00
214	Valentina Jasso	2	cGFzc3dvcmQyMTQ=	2023-08-16 08:55:00
215	Wendy Jiménez	2	cGFzc3dvcmQyMTU=	2023-08-17 09:40:00
216	Xavier Jurado	2	cGFzc3dvcmQyMTY=	2023-08-18 10:50:00
217	Yadira Ledesma	2	cGFzc3dvcmQyMTc=	2023-08-19 11:30:00
218	Zacarías Leal	2	cGFzc3dvcmQyMTg=	2023-08-20 12:40:00
219	Amador Lemus	2	cGFzc3dvcmQyMTk=	2023-08-21 13:50:00
220	Brígida León	2	cGFzc3dvcmQyMjA=	2023-08-22 14:25:00
221	Custodio Linares	2	cGFzc3dvcmQyMjE=	2023-08-23 15:35:00
222	Debora Lira	2	cGFzc3dvcmQyMjI=	2023-08-24 16:45:00
223	Efraín Llamas	2	cGFzc3dvcmQyMjM=	2023-08-25 08:35:00
224	Flavia Lozano	2	cGFzc3dvcmQyMjQ=	2023-08-26 09:45:00
225	Griselda Luque	2	cGFzc3dvcmQyMjU=	2023-08-27 10:55:00
226	Hilario Macías	2	cGFzc3dvcmQyMjY=	2023-08-28 11:40:00
227	Iliana Madrid	2	cGFzc3dvcmQyMjc=	2023-08-29 12:50:00
228	Jacobo Maldonado	2	cGFzc3dvcmQyMjg=	2023-08-30 13:35:00
229	Kenia Marín	2	cGFzc3dvcmQyMjk=	2023-08-31 14:45:00
230	Lisandro Marroquín	2	cGFzc3dvcmQyMzA=	2023-09-01 15:55:00
231	Mónica Mata	2	cGFzc3dvcmQyMzE=	2023-09-02 16:30:00
232	Natalio Medrano	2	cGFzc3dvcmQyMzI=	2023-09-03 08:40:00
233	Odalys Meza	2	cGFzc3dvcmQyMzM=	2023-09-04 09:50:00
234	Pánfilo Mireles	2	cGFzc3dvcmQyMzQ=	2023-09-05 10:25:00
235	Quechol Mojica	2	cGFzc3dvcmQyMzU=	2023-09-06 11:35:00
236	Ramiro Monroy	2	cGFzc3dvcmQyMzY=	2023-09-07 12:45:00
237	Sabino Montaño	2	cGFzc3dvcmQyMzc=	2023-09-08 13:20:00
238	Tadea Montes	2	cGFzc3dvcmQyMzg=	2023-09-09 14:30:00
239	Ursulina Mora	2	cGFzc3dvcmQyMzk=	2023-09-10 15:40:00
240	Vianey Munguía	2	cGFzc3dvcmQyNDA=	2023-09-11 16:15:00
241	Wendolin Murillo	2	cGFzc3dvcmQyNDE=	2023-09-12 08:25:00
242	Ximena Nájera	2	cGFzc3dvcmQyNDI=	2023-09-13 09:35:00
243	Yair Navarro	2	cGFzc3dvcmQyNDM=	2023-09-14 10:45:00
244	Zaira Nava	2	cGFzc3dvcmQyNDQ=	2023-09-15 11:55:00
245	Abel Neri	2	cGFzc3dvcmQyNDU=	2023-09-16 12:30:00
246	Betsabé Nieto	2	cGFzc3dvcmQyNDY=	2023-09-17 13:40:00
247	Caleb Núñez	2	cGFzc3dvcmQyNDc=	2023-09-18 14:50:00
248	Danae Ocampo	2	cGFzc3dvcmQyNDg=	2023-09-19 15:25:00
249	Eder Ochoa	2	cGFzc3dvcmQyNDk=	2023-09-20 16:35:00
250	Fabiola Oliva	2	cGFzc3dvcmQyNTA=	2023-09-21 08:45:00
251	Gaspar Olivares	2	cGFzc3dvcmQyNTE=	2023-09-22 09:20:00
252	Heliodoro Olmos	2	cGFzc3dvcmQyNTI=	2023-09-23 10:30:00
253	Ifigenia Ontiveros	2	cGFzc3dvcmQyNTM=	2023-09-24 11:40:00
254	Jonás Orozco	2	cGFzc3dvcmQyNTQ=	2023-09-25 12:50:00
255	Karla Ortega	2	cGFzc3dvcmQyNTU=	2023-09-26 13:25:00
256	Lino Ortiz	2	cGFzc3dvcmQyNTY=	2023-09-27 14:35:00
257	Maité Osorio	2	cGFzc3dvcmQyNTc=	2023-09-28 15:45:00
258	Nahum Otero	2	cGFzc3dvcmQyNTg=	2023-09-29 16:20:00
259	Obdulia Pabón	2	cGFzc3dvcmQyNTk=	2023-09-30 08:30:00
260	Paco Padilla	2	cGFzc3dvcmQyNjA=	2023-10-01 09:40:00
261	Quirino Padrón	2	cGFzc3dvcmQyNjE=	2023-10-02 10:50:00
262	Rita Palacios	2	cGFzc3dvcmQyNjI=	2023-10-03 11:25:00
263	Salvador Paredes	2	cGFzc3dvcmQyNjM=	2023-10-04 12:35:00
264	Tadeo Parra	2	cGFzc3dvcmQyNjQ=	2023-10-05 13:45:00
265	Úrsula Pascual	2	cGFzc3dvcmQyNjU=	2023-10-06 14:55:00
266	Vicente Pedraza	2	cGFzc3dvcmQyNjY=	2023-10-07 15:30:00
267	Wálter Peguero	2	cGFzc3dvcmQyNjc=	2023-10-08 16:40:00
268	Xenia Pelayo	2	cGFzc3dvcmQyNjg=	2023-10-09 08:50:00
269	Yahir Peñaloza	2	cGFzc3dvcmQyNjk=	2023-10-10 09:35:00
270	Zaida Peralta	2	cGFzc3dvcmQyNzA=	2023-10-11 10:45:00
272	Belen Piedra	2	cGFzc3dvcmQyNzI=	2023-10-13 12:40:00
273	Ciro Pineda	2	cGFzc3dvcmQyNzM=	2023-10-14 13:50:00
274	Dulce Pizarro	2	cGFzc3dvcmQyNzQ=	2023-10-15 14:25:00
275	Emanuel Polanco	2	cGFzc3dvcmQyNzU=	2023-10-16 15:35:00
276	Flora Porras	2	cGFzc3dvcmQyNzY=	2023-10-17 16:45:00
277	Gerardo Prado	2	cGFzc3dvcmQyNzc=	2023-10-18 08:55:00
278	Herminia Prieto	2	cGFzc3dvcmQyNzg=	2023-10-19 09:40:00
279	Iván Puente	2	cGFzc3dvcmQyNzk=	2023-10-20 10:50:00
280	Jazmín Puga	2	cGFzc3dvcmQyODA=	2023-10-21 11:30:00
281	Kevin Quezada	2	cGFzc3dvcmQyODE=	2023-10-22 12:40:00
282	Lilia Quintero	2	cGFzc3dvcmQyODI=	2023-10-23 13:50:00
283	Mauro Quiroz	2	cGFzc3dvcmQyODM=	2023-10-24 14:25:00
284	Nadia Ramírez	2	cGFzc3dvcmQyODQ=	2023-10-25 15:35:00
285	Óscar Rangel	2	cGFzc3dvcmQyODU=	2023-10-26 16:45:00
286	Patricia Razo	2	cGFzc3dvcmQyODY=	2023-10-27 08:35:00
287	Quinto Regalado	2	cGFzc3dvcmQyODc=	2023-10-28 09:45:00
288	Rocío Rendón	2	cGFzc3dvcmQyODg=	2023-10-29 10:55:00
289	Samantha Reséndez	2	cGFzc3dvcmQyODk=	2023-10-30 11:40:00
290	Teobaldo Reyes	2	cGFzc3dvcmQyOTA=	2023-10-31 12:50:00
291	Ubaldo Ríos	2	cGFzc3dvcmQyOTE=	2023-11-01 13:35:00
292	Valeria Rivas	2	cGFzc3dvcmQyOTI=	2023-11-02 14:45:00
293	Wilberto Rivera	2	cGFzc3dvcmQyOTM=	2023-11-03 15:55:00
294	Ximena Robles	2	cGFzc3dvcmQyOTQ=	2023-11-04 16:30:00
295	Yurem Rocha	2	cGFzc3dvcmQyOTU=	2023-11-05 08:40:00
296	Zoe Rodarte	2	cGFzc3dvcmQyOTY=	2023-11-06 09:50:00
297	Amir Rodríguez	2	cGFzc3dvcmQyOTc=	2023-11-07 10:25:00
298	Brianda Rojas	2	cGFzc3dvcmQyOTg=	2023-11-08 11:35:00
299	César Romero	2	cGFzc3dvcmQyOTk=	2023-11-09 12:45:00
300	Danna Rosado	2	cGFzc3dvcmQzMDA=	2023-11-10 13:20:00
301	Efraín Rosales	2	cGFzc3dvcmQzMDE=	2023-11-11 14:30:00
302	Fabio Rosas	2	cGFzc3dvcmQzMDI=	2023-11-12 15:40:00
303	Gabriela Rubio	2	cGFzc3dvcmQzMDM=	2023-11-13 16:15:00
304	Héctor Ruíz	2	cGFzc3dvcmQzMDQ=	2023-11-14 08:25:00
305	Irene Saavedra	2	cGFzc3dvcmQzMDU=	2023-11-15 09:35:00
306	Josué Salas	2	cGFzc3dvcmQzMDY=	2023-11-16 10:45:00
307	Karla Salazar	2	cGFzc3dvcmQzMDc=	2023-11-17 11:55:00
308	Leonardo Salcedo	2	cGFzc3dvcmQzMDg=	2023-11-18 12:30:00
309	Mónica Saldívar	2	cGFzc3dvcmQzMDk=	2023-11-19 13:40:00
310	Nicolás Salgado	2	cGFzc3dvcmQzMTA=	2023-11-20 14:50:00
311	Olivia Salinas	2	cGFzc3dvcmQzMTE=	2023-11-21 15:25:00
312	Pablo Samaniego	2	cGFzc3dvcmQzMTI=	2023-11-22 16:35:00
313	Quintín Sanabria	2	cGFzc3dvcmQzMTM=	2023-11-23 08:45:00
314	Raquel Sánchez	2	cGFzc3dvcmQzMTQ=	2023-11-24 09:20:00
315	Santiago Sandoval	2	cGFzc3dvcmQzMTU=	2023-11-25 10:30:00
316	Tania Santa Cruz	2	cGFzc3dvcmQzMTY=	2023-11-26 11:40:00
317	Úrsula Santana	2	cGFzc3dvcmQzMTc=	2023-11-27 12:50:00
318	Víctor Santos	2	cGFzc3dvcmQzMTg=	2023-11-28 13:25:00
319	Wendy Sierra	2	cGFzc3dvcmQzMTk=	2023-11-29 14:35:00
320	Xavier Silva	2	cGFzc3dvcmQzMjA=	2023-11-30 15:45:00
321	Yara Solano	2	cGFzc3dvcmQzMjE=	2023-12-01 16:20:00
322	Zacarías Solís	2	cGFzc3dvcmQzMjI=	2023-12-02 08:30:00
323	Abigail Sosa	2	cGFzc3dvcmQzMjM=	2023-12-03 09:40:00
324	Benjamín Sotelo	2	cGFzc3dvcmQzMjQ=	2023-12-04 10:50:00
325	Camila Tafoya	2	cGFzc3dvcmQzMjU=	2023-12-05 11:25:00
326	Daniel Tamayo	2	cGFzc3dvcmQzMjY=	2023-12-06 12:35:00
327	Esteban Tapia	2	cGFzc3dvcmQzMjc=	2023-12-07 13:45:00
328	Fernanda Tejada	2	cGFzc3dvcmQzMjg=	2023-12-08 14:55:00
329	Gabriel Téllez	2	cGFzc3dvcmQzMjk=	2023-12-09 15:30:00
330	Hortensia Terán	2	cGFzc3dvcmQzMzA=	2023-12-10 16:40:00
331	Ignacio Terrazas	2	cGFzc3dvcmQzMzE=	2023-12-11 08:50:00
332	Jimena Tirado	2	cGFzc3dvcmQzMzI=	2023-12-12 09:35:00
333	Kevin Toledo	2	cGFzc3dvcmQzMzM=	2023-12-13 10:45:00
334	Laura Torres	2	cGFzc3dvcmQzMzQ=	2023-12-14 11:55:00
335	Manuel Trejo	2	cGFzc3dvcmQzMzU=	2023-12-15 12:40:00
336	Natalia Treviño	2	cGFzc3dvcmQzMzY=	2023-12-16 13:50:00
337	Óscar Trujillo	2	cGFzc3dvcmQzMzc=	2023-12-17 14:25:00
338	Paola Uribe	2	cGFzc3dvcmQzMzg=	2023-12-18 15:35:00
339	Ricardo Urrutia	2	cGFzc3dvcmQzMzk=	2023-12-19 16:45:00
340	Sara Vaca	2	cGFzc3dvcmQzNDA=	2023-12-20 08:55:00
341	Tomás Valadez	2	cGFzc3dvcmQzNDE=	2023-12-21 09:40:00
342	Úrsula Valdés	2	cGFzc3dvcmQzNDI=	2023-12-22 10:50:00
343	Vicente Valencia	2	cGFzc3dvcmQzNDM=	2023-12-23 11:30:00
344	Wendy Valenzuela	2	cGFzc3dvcmQzNDQ=	2023-12-24 12:40:00
345	Ximena Varela	2	cGFzc3dvcmQzNDU=	2023-12-25 13:50:00
346	Yahir Vargas	2	cGFzc3dvcmQzNDY=	2023-12-26 14:25:00
347	Zoe Vázquez	2	cGFzc3dvcmQzNDc=	2023-12-27 15:35:00
349	Brenda Velasco	2	cGFzc3dvcmQzNDk=	2023-12-29 08:35:00
350	Cristian Velázquez	2	cGFzc3dvcmQzNTA=	2023-12-30 09:45:00
351	Diana Venegas	2	cGFzc3dvcmQzNTE=	2023-12-31 10:55:00
352	Eduardo Vera	2	cGFzc3dvcmQzNTI=	2024-01-01 11:40:00
353	Fabiola Vergara	2	cGFzc3dvcmQzNTM=	2024-01-02 12:50:00
354	Gonzalo Villalobos	2	cGFzc3dvcmQzNTQ=	2024-01-03 13:35:00
355	Helena Villanueva	2	cGFzc3dvcmQzNTU=	2024-01-04 14:45:00
356	Iker Villarreal	2	cGFzc3dvcmQzNTY=	2024-01-05 15:55:00
357	Jazmín Yáñez	2	cGFzc3dvcmQzNTc=	2024-01-06 16:30:00
358	Kevin Zamora	2	cGFzc3dvcmQzNTg=	2024-01-07 08:40:00
359	Laura Zepeda	2	cGFzc3dvcmQzNTk=	2024-01-08 09:50:00
360	Miguel Zúñiga	2	cGFzc3dvcmQzNjA=	2024-01-09 10:25:00
361	Nadia Acuña	2	cGFzc3dvcmQzNjE=	2024-01-10 11:35:00
362	Oscar Aguirre	2	cGFzc3dvcmQzNjI=	2024-01-11 12:45:00
363	Patricia Almeida	2	cGFzc3dvcmQzNjM=	2024-01-12 13:20:00
364	Roberto Andrade	2	cGFzc3dvcmQzNjQ=	2024-01-13 14:30:00
365	Sandra Arévalo	2	cGFzc3dvcmQzNjU=	2024-01-14 15:40:00
366	Tania Arroyo	2	cGFzc3dvcmQzNjY=	2024-01-15 16:15:00
367	Uriel Avilés	2	cGFzc3dvcmQzNjc=	2024-01-16 08:25:00
368	Verónica Bello	2	cGFzc3dvcmQzNjg=	2024-01-17 09:35:00
369	William Bernal	2	cGFzc3dvcmQzNjk=	2024-01-18 10:45:00
370	Ximena Cabrera	2	cGFzc3dvcmQzNzA=	2024-01-19 11:55:00
371	Yahir Cadena	2	cGFzc3dvcmQzNzE=	2024-01-20 12:30:00
372	Zara Callejas	2	cGFzc3dvcmQzNzI=	2024-01-21 13:40:00
373	Alan Cardona	2	cGFzc3dvcmQzNzM=	2024-01-22 14:50:00
374	Bianca Carrillo	2	cGFzc3dvcmQzNzQ=	2024-01-23 15:25:00
375	César Casillas	2	cGFzc3dvcmQzNzU=	2024-01-24 16:35:00
376	Danna Ceballos	2	cGFzc3dvcmQzNzY=	2024-01-25 08:45:00
377	Erick Cepeda	2	cGFzc3dvcmQzNzc=	2024-01-26 09:20:00
378	Fabiola Cerda	2	cGFzc3dvcmQzNzg=	2024-01-27 10:30:00
379	Gerardo Cervantes	2	cGFzc3dvcmQzNzk=	2024-01-28 11:40:00
380	Helen Chávez	2	cGFzc3dvcmQzODA=	2024-01-29 12:50:00
381	Iván Córdoba	2	cGFzc3dvcmQzODE=	2024-01-30 13:25:00
382	Jackeline Cornejo	2	cGFzc3dvcmQzODI=	2024-01-31 14:35:00
383	Kevin Cortés	2	cGFzc3dvcmQzODM=	2024-02-01 15:45:00
384	Laura Crespo	2	cGFzc3dvcmQzODQ=	2024-02-02 16:20:00
385	Mauricio Cruz	2	cGFzc3dvcmQzODU=	2024-02-03 08:30:00
386	Natalia De La Fuente	2	cGFzc3dvcmQzODY=	2024-02-04 09:40:00
387	Óscar Delgado	2	cGFzc3dvcmQzODc=	2024-02-05 10:50:00
388	Paola Díaz	2	cGFzc3dvcmQzODg=	2024-02-06 11:25:00
389	Roberto Domínguez	2	cGFzc3dvcmQzODk=	2024-02-07 12:35:00
390	Sara Duarte	2	cGFzc3dvcmQzOTA=	2024-02-08 13:45:00
391	Tomás Enríquez	2	cGFzc3dvcmQzOTE=	2024-02-09 14:55:00
392	Úrsula Escobar	2	cGFzc3dvcmQzOTI=	2024-02-10 15:30:00
393	Víctor Esparza	2	cGFzc3dvcmQzOTM=	2024-02-11 16:40:00
394	Wendy Estrada	2	cGFzc3dvcmQzOTQ=	2024-02-12 08:50:00
395	Xavier Fajardo	2	cGFzc3dvcmQzOTU=	2024-02-13 09:35:00
396	Yara Flores	2	cGFzc3dvcmQzOTY=	2024-02-14 10:45:00
397	Zacarías Franco	2	cGFzc3dvcmQzOTc=	2024-02-15 11:55:00
398	Ana Galindo	2	cGFzc3dvcmQzOTg=	2024-02-16 12:40:00
399	Bruno García	2	cGFzc3dvcmQzOTk=	2024-02-17 13:50:00
400	Carla Garza	2	cGFzc3dvcmQ0MDA=	2024-02-18 14:25:00
401	David Gónzalez	2	cGFzc3dvcmQ0MDE=	2024-02-19 15:35:00
402	Elena Guerrero	2	cGFzc3dvcmQ0MDI=	2024-02-20 16:45:00
403	Fernando Gutiérrez	2	cGFzc3dvcmQ0MDM=	2024-02-21 08:55:00
404	Gabriela Hernández	2	cGFzc3dvcmQ0MDQ=	2024-02-22 09:40:00
405	Héctor Herrera	2	cGFzc3dvcmQ0MDU=	2024-02-23 10:50:00
406	Irene Ibáñez	2	cGFzc3dvcmQ0MDY=	2024-02-24 11:30:00
407	Javier Jiménez	2	cGFzc3dvcmQ0MDc=	2024-02-25 12:40:00
408	Karen Juárez	2	cGFzc3dvcmQ0MDg=	2024-02-26 13:50:00
409	Luis Lara	2	cGFzc3dvcmQ0MDk=	2024-02-27 14:25:00
410	María López	2	cGFzc3dvcmQ0MTA=	2024-02-28 15:35:00
411	Nicolás Martínez	2	cGFzc3dvcmQ0MTE=	2024-02-29 16:45:00
412	Olivia Medina	2	cGFzc3dvcmQ0MTI=	2024-03-01 08:35:00
413	Pedro Méndez	2	cGFzc3dvcmQ0MTM=	2024-03-02 09:45:00
414	Quetzal Molina	2	cGFzc3dvcmQ0MTQ=	2024-03-03 10:55:00
415	Rosa Montero	2	cGFzc3dvcmQ0MTU=	2024-03-04 11:40:00
416	Sergio Morales	2	cGFzc3dvcmQ0MTY=	2024-03-05 12:50:00
417	Tania Moreno	2	cGFzc3dvcmQ0MTc=	2024-03-06 13:35:00
418	Ulises Muñoz	2	cGFzc3dvcmQ0MTg=	2024-03-07 14:45:00
419	Valeria Nava	2	cGFzc3dvcmQ0MTk=	2024-03-08 15:55:00
420	Walter Navarro	2	cGFzc3dvcmQ0MjA=	2024-03-09 16:30:00
421	Ximena Ochoa	2	cGFzc3dvcmQ0MjE=	2024-03-10 08:40:00
422	Yahir Olvera	2	cGFzc3dvcmQ0MjI=	2024-03-11 09:50:00
423	Zara Ortega	2	cGFzc3dvcmQ0MjM=	2024-03-12 10:25:00
424	Alan Ortiz	2	cGFzc3dvcmQ0MjQ=	2024-03-13 11:35:00
425	Brenda Pacheco	2	cGFzc3dvcmQ0MjU=	2024-03-14 12:45:00
426	Carlos Padilla	2	cGFzc3dvcmQ0MjY=	2024-03-15 13:20:00
427	Diana Palma	2	cGFzc3dvcmQ0Mjc=	2024-03-16 14:30:00
428	Eduardo Paredes	2	cGFzc3dvcmQ0Mjg=	2024-03-17 15:40:00
429	Fabiola Parra	2	cGFzc3dvcmQ0Mjk=	2024-03-18 16:15:00
430	Gabriel Peña	2	cGFzc3dvcmQ0MzA=	2024-03-19 08:25:00
431	Helena Pérez	2	cGFzc3dvcmQ0MzE=	2024-03-20 09:35:00
432	Iván Ramírez	2	cGFzc3dvcmQ0MzI=	2024-03-21 10:45:00
433	Jackeline Reyes	2	cGFzc3dvcmQ0MzM=	2024-03-22 11:55:00
434	Kevin Ríos	2	cGFzc3dvcmQ0MzQ=	2024-03-23 12:30:00
435	Laura Rodríguez	2	cGFzc3dvcmQ0MzU=	2024-03-24 13:40:00
436	Manuel Romero	2	cGFzc3dvcmQ0MzY=	2024-03-25 14:50:00
437	Natalia Ruiz	2	cGFzc3dvcmQ0Mzc=	2024-03-26 15:25:00
438	Óscar Salazar	2	cGFzc3dvcmQ0Mzg=	2024-03-27 16:35:00
439	Paola Sánchez	2	cGFzc3dvcmQ0Mzk=	2024-03-28 08:45:00
440	Roberto Silva	2	cGFzc3dvcmQ0NDA=	2024-03-29 09:20:00
441	Sara Solís	2	cGFzc3dvcmQ0NDE=	2024-03-30 10:30:00
442	Tomás Soto	2	cGFzc3dvcmQ0NDI=	2024-03-31 11:40:00
443	Úrsula Suárez	2	cGFzc3dvcmQ0NDM=	2024-04-01 12:50:00
444	Víctor Tapia	2	cGFzc3dvcmQ0NDQ=	2024-04-02 13:25:00
445	Wendy Torres	2	cGFzc3dvcmQ0NDU=	2024-04-03 14:35:00
446	Xavier Valencia	2	cGFzc3dvcmQ0NDY=	2024-04-04 15:45:00
447	Yara Vargas	2	cGFzc3dvcmQ0NDc=	2024-04-05 16:20:00
448	Zacarías Vázquez	2	cGFzc3dvcmQ0NDg=	2024-04-06 08:30:00
449	Ana Velasco	2	cGFzc3dvcmQ0NDk=	2024-04-07 09:40:00
450	Bruno Vega	2	cGFzc3dvcmQ0NTA=	2024-04-08 10:50:00
451	Carla Villalobos	2	cGFzc3dvcmQ0NTE=	2024-04-09 11:25:00
452	David Villanueva	2	cGFzc3dvcmQ0NTI=	2024-04-10 12:35:00
453	Elena Villarreal	2	cGFzc3dvcmQ0NTM=	2024-04-11 13:45:00
454	Fernando Yáñez	2	cGFzc3dvcmQ0NTQ=	2024-04-12 14:55:00
455	Gabriela Zamora	2	cGFzc3dvcmQ0NTU=	2024-04-13 15:30:00
456	Héctor Zepeda	2	cGFzc3dvcmQ0NTY=	2024-04-14 16:40:00
457	Irene Zúñiga	2	cGFzc3dvcmQ0NTc=	2024-04-15 08:50:00
458	Javier Acosta	2	cGFzc3dvcmQ0NTg=	2024-04-16 09:35:00
459	Karen Aguilar	2	cGFzc3dvcmQ0NTk=	2024-04-17 10:45:00
460	Luis Álvarez	2	cGFzc3dvcmQ0NjA=	2024-04-18 11:55:00
461	María Ávila	2	cGFzc3dvcmQ0NjE=	2024-04-19 12:40:00
462	Nicolás Bravo	2	cGFzc3dvcmQ0NjI=	2024-04-20 13:50:00
463	Olivia Camacho	2	cGFzc3dvcmQ0NjM=	2024-04-21 14:25:00
464	Pedro Campos	2	cGFzc3dvcmQ0NjQ=	2024-04-22 15:35:00
465	Quetzal Cantú	2	cGFzc3dvcmQ0NjU=	2024-04-23 16:45:00
466	Rosa Carrasco	2	cGFzc3dvcmQ0NjY=	2024-04-24 08:55:00
467	Sergio Castellanos	2	cGFzc3dvcmQ0Njc=	2024-04-25 09:40:00
468	Tania Cervantes	2	cGFzc3dvcmQ0Njg=	2024-04-26 10:50:00
469	Ulises Chávez	2	cGFzc3dvcmQ0Njk=	2024-04-27 11:30:00
470	Valeria Córdova	2	cGFzc3dvcmQ0NzA=	2024-04-28 12:40:00
471	Walter Corral	2	cGFzc3dvcmQ0NzE=	2024-04-29 13:50:00
472	Ximena Delgado	2	cGFzc3dvcmQ0NzI=	2024-04-30 14:25:00
473	Yahir Díaz	2	cGFzc3dvcmQ0NzM=	2024-05-01 15:35:00
474	Zara Durán	2	cGFzc3dvcmQ0NzQ=	2024-05-02 16:45:00
475	Alan Escobar	2	cGFzc3dvcmQ0NzU=	2024-05-03 08:35:00
476	Brenda Espinoza	2	cGFzc3dvcmQ0NzY=	2024-05-04 09:45:00
477	Carlos Fernández	2	cGFzc3dvcmQ0Nzc=	2024-05-05 10:55:00
478	Diana Flores	2	cGFzc3dvcmQ0Nzg=	2024-05-06 11:40:00
479	Eduardo Fuentes	2	cGFzc3dvcmQ0Nzk=	2024-05-07 12:50:00
480	Fabiola García	2	cGFzc3dvcmQ0ODA=	2024-05-08 13:35:00
481	Gabriel Gómez	2	cGFzc3dvcmQ0ODE=	2024-05-09 14:45:00
482	Helena González	2	cGFzc3dvcmQ0ODI=	2024-05-10 15:55:00
483	Iván Guerrero	2	cGFzc3dvcmQ0ODM=	2024-05-11 16:30:00
484	Jackeline Gutiérrez	2	cGFzc3dvcmQ0ODQ=	2024-05-12 08:40:00
485	Kevin Hernández	2	cGFzc3dvcmQ0ODU=	2024-05-13 09:50:00
486	Laura Herrera	2	cGFzc3dvcmQ0ODY=	2024-05-14 10:25:00
487	Manuel Ibáñez	2	cGFzc3dvcmQ0ODc=	2024-05-15 11:35:00
488	Natalia Jiménez	2	cGFzc3dvcmQ0ODg=	2024-05-16 12:45:00
489	Óscar Juárez	2	cGFzc3dvcmQ0ODk=	2024-05-17 13:20:00
490	Paola Lara	2	cGFzc3dvcmQ0OTA=	2024-05-18 14:30:00
491	Roberto López	2	cGFzc3dvcmQ0OTE=	2024-05-19 15:40:00
492	Sara Martínez	2	cGFzc3dvcmQ0OTI=	2024-05-20 16:15:00
493	Tomás Medina	2	cGFzc3dvcmQ0OTM=	2024-05-21 08:25:00
494	Úrsula Méndez	2	cGFzc3dvcmQ0OTQ=	2024-05-22 09:35:00
495	Víctor Molina	2	cGFzc3dvcmQ0OTU=	2024-05-23 10:45:00
496	Wendy Morales	2	cGFzc3dvcmQ0OTY=	2024-05-24 11:55:00
497	Xavier Moreno	2	cGFzc3dvcmQ0OTc=	2024-05-25 12:30:00
498	Yara Muñoz	2	cGFzc3dvcmQ0OTg=	2024-05-26 13:40:00
499	Zacarías Nava	2	cGFzc3dvcmQ0OTk=	2024-05-27 14:50:00
500	Ana Navarro	2	cGFzc3dvcmQ1MDA=	2024-05-28 15:25:00
501	María González	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
502	Carlos Rodríguez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
503	Ana Martínez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
504	José López	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
505	Laura Hernández	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
506	Miguel García	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
507	Isabel Pérez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
508	David Sánchez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
509	Elena Ramírez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
510	Javier Torres	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
511	Carmen Flores	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
512	Francisco Díaz	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
513	Patricia Cruz	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
514	Antonio Morales	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
515	Rosa Vargas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
516	Juan Castillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
517	Sandra Reyes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
518	Pedro Ortega	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
519	Teresa Mendoza	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
520	Alejandro Rojas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
521	Mónica Silva	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
522	Roberto Navarro	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
523	Lucía Castro	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
524	Fernando Romero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
525	Gabriela Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
526	Ricardo Salazar	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
527	Adriana Guzmán	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
528	Eduardo Méndez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
529	Verónica Ríos	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
530	Daniel Herrera	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
531	Beatriz Vega	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
532	Sergio Campos	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
533	Olga Cordero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
534	Raúl Peña	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
535	Claudia Miranda	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
536	Alberto Núñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
537	Lorena Solís	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
538	Guillermo Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
539	Silvia Valdez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
540	Arturo Ponce	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
541	Raquel Montoya	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
542	Oscar Santana	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
543	Irene Delgado	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
544	Manuel Cabrera	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
545	Eva Rangel	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
546	Héctor Medina	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
547	Angélica Juárez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
548	Felipe Espinoza	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
549	Diana Orozco	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
550	Jorge Valenzuela	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
551	Paola Tapia	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
552	Rodrigo Bustos	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
553	Marcela Salas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
554	Mauricio Cárdenas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
555	Leticia Franco	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
556	Gustavo Rivas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
557	Natalia Pacheco	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
558	Andrés Lara	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
559	Jimena Montes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
560	Víctor Aguirre	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
561	Karina Cervantes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
562	René Segura	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
563	Vanessa Moya	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
564	César Bravo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
565	Ximena Carrillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
566	Hugo Valencia	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
567	Daniela Osorio	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
568	Gerardo Zúñiga	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
569	Paulina Arellano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
570	Samuel Cortés	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
571	Marisol Escobar	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
572	Rafael Gallegos	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
573	Alicia Serrano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
574	Emilio Villanueva	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
575	Luz Ávila	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
576	Alfonso Ibarra	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
577	Rocío Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
578	Óscar Rosales	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
579	Esteban Solano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
580	Rebeca Peralta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
581	Federico Montes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
582	Cecilia Rueda	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
583	Leonardo Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
584	Yolanda Barrios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
585	Saúl Ceballos	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
586	Gladys Palacios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
587	Marcos Bernal	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
588	Miriam Escamilla	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
589	Rubén Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
590	Lourdes Lozano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
591	Tomás Carrasco	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
592	Aurora Mejía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
593	Agustín Roa	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
594	Concepción Pizarro	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
595	Domingo Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
596	Esperanza Venegas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
597	Feliciano Zavala	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
598	Gloria Casas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
599	Horacio Lira	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
600	Inés Figueroa	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
601	Jacinto Alarcón	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
602	Karla Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
603	Leandro Orellana	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
604	Margarita Baños	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
605	Nicolás Coronel	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
606	Octavio Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
607	Pilar Carrera	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
608	Quirino Samaniego	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
609	Rosario Barragán	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
610	Salvador Córdova	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
611	Trinidad Arredondo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
612	Ubaldo Casillas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
613	Valentina De La Cruz	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
614	Wilfrido Esparza	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
615	Yvette Fajardo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
616	Zacarías Gallardo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
617	Amalia Haro	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
618	Benito Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
619	Candelaria Leyva	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
620	Damián Macías	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
621	Elvira Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
622	Florencio Ocampo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
623	Graciela Partida	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
624	Heriberto Quezada	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
625	Irma Rentería	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
626	Jonás Sierra	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
627	Katia Trujillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
628	Leopoldo Ulloa	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
629	Matilde Varela	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
630	Néstor Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
631	Odalys Zepeda	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
632	Pascual Abraham	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
633	Quetzal Báez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
634	Rufino Cadena	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
635	Sabina Dávila	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
636	Teódulo Escobedo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
637	Úrsula Fuentes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
638	Vicente Gaitán	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
639	Wendy Hinojosa	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
640	Xavier Iñiguez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
641	Yolanda Jasso	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
642	Zenón Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
643	Abigail Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
644	Baltazar Muro	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
645	Clotilde Neri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
646	Donato Ochoa	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
647	Edith Pantoja	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
648	Fidel Quiroz	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
649	Griselda Rascón	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
650	Hilario Sosa	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
651	Iván Tovar	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
652	Jazmín Ulibarri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
653	Kevin Vázquez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
654	Liliana Wong	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
655	Moisés Xicoténcatl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
656	Nadia Ybarra	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
657	Óscar Zapata	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
658	Perla Aguilera	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
659	Quintín Bello	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
660	Rosa Cazares	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
661	Simón Del Río	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
662	Tania Estrada	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
663	Ulises Fierro	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
664	Virginia Gamboa	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
665	Walter Hidalgo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
666	Xóchitl Iturbide	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
667	Yahir Jáquez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
668	Zulema Kano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
669	Ángel Llamas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
670	Berenice Mena	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
671	Ciro Nájera	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
672	Dulce Orozco	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
673	Efraín Portillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
674	Fabiola Quesada	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
675	Gregorio Ruelas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
676	Helena Salcedo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
677	Ignacio Tapia	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
678	Julieta Urías	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
679	Lorenzo Vela	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
680	Marta Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
681	Noé Xoconostle	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
682	Oralia Yánez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
683	Pablo Zamarripa	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
684	Quecho Alamilla	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
685	Ramiro Barraza	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
686	Sofia Cepeda	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
687	Tadeo Durán	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
688	Ursulina Enríquez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
689	Violeta Fabela	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
690	Wenceslao Grijalva	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
691	Ximena Huerta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
692	Yair Ibarra	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
693	Zaida Jerez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
694	Abelardo Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
695	Blanca Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
696	Cecilio Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
697	Dora Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
698	Ernesto Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
699	Flora Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
700	Geraldo Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
701	Hilda Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
702	Ismael Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
703	Jovita Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
704	Klever Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
705	Lidia Vargas	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
706	Mauro Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
707	Nelly Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
708	Oswaldo Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
709	Petra Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
710	Quirino Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
711	Rita Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
712	Salomón Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
713	Teresa Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
714	Uriel Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
715	Verónica Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
716	Wilberto Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
717	Ximena Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
718	Yolanda Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
719	Zacarías Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
720	Amparo Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
721	Bonifacio Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
722	Clementina Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
723	Dámaso Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
724	Esmeralda Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
725	Froilán Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
726	Guadalupe Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
727	Hermelinda Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
728	Ignacia Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
729	Jacinto Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
730	Karina Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
731	Leobardo Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
732	Marcela Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
733	Nicolás Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
734	Ofelia Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
735	Pánfilo Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
736	Querubín Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
737	Rosalba Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
738	Severiano Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
739	Tomasa Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
740	Urbano Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
741	Vicenta Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
742	Wendy Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
743	Xavier Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
744	Yajaira Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
745	Zenaida Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
746	Alonso Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
747	Brígida Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
748	Cirilo Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
749	Dorotea Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
750	Eligio Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
751	Fabiana Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
752	Griselda Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
753	Humberto Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
754	Ivette Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
755	Josué Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
756	Kristel Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
757	Leonel Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
758	Mireya Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
759	Norberto Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
760	Odalys Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
761	Pascuala Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
762	Quintín Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
763	Rocío Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
764	Sabino Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
765	Tadeo Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
766	Úrsula Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
767	Valentín Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
768	Wendolin Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
769	Xóchitl Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
770	Yazmín Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
771	Zacarías Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
772	Adela Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
773	Benjamín Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
774	Candelaria Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
775	Demetrio Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
776	Elisa Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
777	Fabián Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
778	Gabriela Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
779	Héctor Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
780	Irene Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
781	José Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
782	Karen Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
783	Luis Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
784	María Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
785	Natalia Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
786	Óscar Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
787	Patricia Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
788	Raúl Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
789	Sara Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
790	Tomás Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
791	Úrsula Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
792	Víctor Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
793	Wendy Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
794	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
795	Yolanda Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
796	Zacarías Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
797	Ana Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
798	Bruno Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
799	Clara Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
800	David Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
801	Elena Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
802	Fernando Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
803	Gabriela Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
804	Hugo Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
805	Isabel Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
806	Javier Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
807	Karla Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
808	Luis Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
809	Mónica Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
810	Nicolás Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
811	Olivia Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
812	Pedro Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
813	Queta Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
814	Ramón Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
815	Sofia Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
816	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
817	Ulises Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
818	Valeria Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
819	Walter Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
820	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
821	Yahir Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
822	Zara Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
823	Alberto Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
824	Beatriz Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
825	Carlos Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
826	Diana Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
827	Ernesto Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
828	Francisca Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
829	Gerardo Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
830	Helena Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
831	Iván Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
832	Julia Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
833	Kevin Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
834	Laura Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
835	Miguel Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
836	Nora Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
837	Óscar Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
838	Patricia Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
839	Quique Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
840	Rosa Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
841	Sergio Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
842	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
843	Uriel Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
844	Valentina Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
845	William Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
846	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
847	Yolanda Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
848	Zacarías Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
849	Ana Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
850	Bruno Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
851	Clara Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
852	David Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
853	Elena Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
854	Fernando Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
855	Gabriela Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
856	Hugo Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
857	Isabel Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
858	Javier Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
859	Karla Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
860	Luis Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
861	Mónica Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
862	Nicolás Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
863	Olivia Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
864	Pedro Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
865	Queta Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
866	Ramón Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
867	Sofia Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
868	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
869	Ulises Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
870	Valeria Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
871	Walter Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
872	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
873	Yahir Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
874	Zara Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
875	Alberto Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
876	Beatriz Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
877	Carlos Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
878	Diana Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
879	Ernesto Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
880	Francisca Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
881	Gerardo Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
882	Helena Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
883	Iván Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
884	Julia Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
885	Kevin Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
886	Laura Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
887	Miguel Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
888	Nora Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
889	Óscar Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
890	Patricia Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
891	Quique Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
892	Rosa Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
893	Sergio Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
894	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
895	Uriel Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
896	Valentina Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
897	William Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
898	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
899	Yolanda Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
900	Zacarías Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
901	Ana Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
902	Bruno Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
903	Clara Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
904	David Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
905	Elena Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
906	Fernando Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
907	Gabriela Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
908	Hugo Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
909	Isabel Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
910	Javier Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
911	Karla Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
912	Luis Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
913	Mónica Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
914	Nicolás Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
915	Olivia Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
916	Pedro Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
917	Queta Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
918	Ramón Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
919	Sofia Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
920	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
921	Ulises Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
922	Valeria Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
923	Walter Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
924	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
925	Yahir Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
926	Zara Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
927	Alberto Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
928	Beatriz Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
929	Carlos Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
930	Diana Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
931	Ernesto Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
932	Francisca Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
933	Gerardo Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
934	Helena Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
935	Iván Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
936	Julia Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
937	Kevin Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
938	Laura Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
939	Miguel Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
940	Nora Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
941	Óscar Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
942	Patricia Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
943	Quique Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
944	Rosa Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
945	Sergio Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
946	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
947	Uriel Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
948	Valentina Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
949	William Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
950	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
951	Yolanda Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
952	Zacarías Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
953	Ana Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
954	Bruno Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
955	Clara Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
956	David Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
957	Elena Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
958	Fernando Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
959	Gabriela Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
960	Hugo Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
961	Isabel Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
962	Javier Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
963	Karla Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
964	Luis Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
965	Mónica Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
966	Nicolás Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
967	Olivia Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
968	Pedro Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
969	Queta Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
970	Ramón Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
971	Sofia Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
972	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
973	Ulises Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
974	Valeria Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
975	Walter Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
976	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
977	Yahir Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
978	Zara Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
979	Alberto Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
980	Beatriz Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
981	Carlos Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
982	Diana Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
983	Ernesto Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
984	Francisca Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
985	Gerardo Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
986	Helena Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
987	Iván Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
988	Julia Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
989	Kevin Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
990	Laura Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
991	Miguel Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
992	Nora Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
993	Óscar Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
994	Patricia Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
995	Quique Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
996	Rosa Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
997	Sergio Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
998	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
999	Uriel Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1000	Valentina Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1001	William Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1002	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1003	Yolanda Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1004	Zacarías Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1005	Ana Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1006	Bruno Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1007	Clara Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1008	David Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1009	Elena Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1010	Fernando Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1011	Gabriela Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1012	Hugo Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1013	Isabel Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1014	Javier Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1015	Karla Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1016	Luis Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1017	Mónica Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1018	Nicolás Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1019	Olivia Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1020	Pedro Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1021	Queta Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1022	Ramón Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1023	Sofia Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1024	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1025	Ulises Duarte	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1026	Valeria Escalante	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1027	Walter Fierros	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1028	Ximena Gámez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1029	Yahir Holguín	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1030	Zara Iribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1031	Alberto Jaramillo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1032	Beatriz Kuri	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1033	Carlos Luevano	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1034	Diana Munguía	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1035	Ernesto Nava	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1036	Francisca Oquendo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1037	Gerardo Paredes	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1038	Helena Quintero	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1039	Iván Rios	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1040	Julia Sotelo	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1041	Kevin Téllez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1042	Laura Uribe	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1043	Miguel Varg	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1044	Nora Willys	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1045	Óscar Xochitl	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1046	Patricia Yáñez	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1047	Quique Zamora	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1048	Rosa Acosta	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1049	Sergio Bautista	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1050	Tania Camacho	2	$2a$10$rS5.8wMcV5W1eG5qQGq5.OV7lGLjKu3V6QkQZJXkXp8X8dXpYp5Ym	2025-10-24 15:20:09.940499
1051	Empleado	2	$2y$10$eDAJrRJR0I6xbcUsxmRqJuPozPAyqjDt1vY.N9xz5bHd5pQUSTP/a	2025-10-24 19:12:41.909736
1052	Javier Garcia	2	$2y$10$8ki9GZoJc/n1RgMod171pO9KhRopnOax.Rk1l9HGqR3P4aQ8MH3/G	2025-10-24 19:12:57.027335
1054	JJJ	1	$2y$10$sIfQfMHWAnJ6lrTPqmi6jOlk57pquBKXbTlkU.e3GxKLJd8Fj8vIS	2025-11-17 23:20:10.450092
271	Aaron Pichardo	2	$2y$10$8iXSo8fwg1MjoCtErEFXuuyeT5aeQktjqS4ReS4uGCxud/Z3KyJLO	2023-10-12 11:55:00
\.


--
-- TOC entry 5052 (class 0 OID 16744)
-- Dependencies: 240
-- Data for Name: factura_detalles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura_detalles (id, factura_id, tipo, servicio_id, producto_id, descripcion, cantidad, precio_unitario, subtotal) FROM stdin;
1514	4519	servicio	2	\N	Favor de regresar a los 5 mil kilómetros para realizar de nuevo la revisión de aceite	1	200.00	200.00
1515	4519	producto	\N	1006	Aceite Motul 300V 15W50 1L	1	220.00	220.00
8	13	servicio	272	\N	Ajuste de angle bracket	1	40.00	40.00
9	14	producto	\N	92	Aceite Penetrante Kroil	1	85.00	85.00
10	15	producto	\N	7	Aceite Repsol Moto Racing 20W50 1L	1	160.00	160.00
11	16	producto	\N	1	Aceite sintético 10W-40	1	25.00	25.00
12	17	producto	\N	441	Acople Rápido 1/2	1	35.00	35.00
13	4018	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
14	4019	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
15	4020	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
16	4021	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
17	4022	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
18	4023	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
19	4024	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
20	4025	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
21	4026	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
22	4027	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
23	4028	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
24	4029	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
25	4030	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
26	4031	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
27	4032	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
28	4033	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
29	4034	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
30	4035	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
31	4036	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
32	4037	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
33	4038	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
34	4039	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
35	4040	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
36	4041	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
37	4042	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
38	4043	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
39	4044	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
40	4045	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
41	4046	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
42	4047	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
43	4048	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
44	4049	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
45	4050	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
46	4051	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
47	4052	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
48	4053	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
49	4054	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
50	4055	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
51	4056	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
52	4057	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
53	4058	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
54	4059	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
55	4060	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
56	4061	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
57	4062	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
58	4063	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
59	4064	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
60	4065	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
61	4066	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
62	4067	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
63	4068	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
64	4069	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
65	4070	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
66	4071	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
67	4072	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
68	4073	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
69	4074	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
70	4075	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
71	4076	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
72	4077	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
73	4078	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
74	4079	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
75	4080	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
76	4081	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
77	4082	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
78	4083	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
79	4084	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
80	4085	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
81	4086	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
82	4087	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
83	4088	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
84	4089	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
85	4090	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
86	4091	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
87	4092	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
88	4093	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
89	4094	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
90	4095	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
91	4096	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
92	4097	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
93	4098	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
94	4099	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
95	4100	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
96	4101	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
97	4102	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
98	4103	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
99	4104	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
100	4105	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
101	4106	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
102	4107	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
103	4108	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
104	4109	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
105	4110	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
106	4111	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
107	4112	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
108	4113	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
109	4114	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
110	4115	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
111	4116	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
112	4117	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
113	4118	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
114	4119	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
115	4120	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
116	4121	producto	\N	331	Sistema Calibración Patrones	5	12500.00	62500.00
117	4122	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
118	4123	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
119	4124	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
120	4125	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
121	4126	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
122	4127	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
123	4128	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
124	4129	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
125	4130	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
126	4131	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
127	4132	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
128	4133	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
129	4134	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
130	4135	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
131	4136	producto	\N	331	Sistema Calibración Patrones	1	12500.00	62500.00
132	4137	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
133	4138	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
134	4139	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
135	4140	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
136	4141	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
137	4142	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
138	4143	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
139	4144	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
140	4145	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
141	4146	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
142	4147	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
143	4148	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
144	4149	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
145	4150	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
146	4151	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
147	4152	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
148	4153	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
149	4154	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
150	4155	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
152	4157	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
153	4158	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
154	4159	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
155	4160	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
156	4161	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
157	4162	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
158	4163	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
159	4164	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
160	4165	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
161	4166	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
162	4167	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
163	4168	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
164	4169	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
165	4170	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
166	4171	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
167	4172	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
168	4173	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
169	4174	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
170	4175	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
171	4176	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
172	4177	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
173	4178	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
174	4179	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
175	4180	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
176	4181	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
177	4182	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
178	4183	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
179	4184	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
180	4185	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
181	4186	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
182	4187	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
183	4188	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
184	4189	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
185	4190	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
186	4191	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
187	4192	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
188	4193	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
189	4194	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
190	4195	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
191	4196	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
192	4197	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
193	4198	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
194	4199	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
195	4200	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
196	4201	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
197	4202	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
198	4203	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
199	4204	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
200	4205	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
201	4206	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
202	4207	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
203	4208	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
204	4209	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
205	4210	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
206	4211	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
207	4212	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
208	4213	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
209	4214	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
210	4215	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
211	4216	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
212	4217	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
213	4218	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
214	4219	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
215	4220	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
216	4221	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
217	4222	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
218	4223	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
219	4224	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
220	4225	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
221	4226	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
222	4227	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
223	4228	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
224	4229	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
225	4230	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
226	4231	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
227	4232	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
228	4233	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
229	4234	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
230	4235	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
231	4236	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
232	4237	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
233	4238	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
234	4239	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
235	4240	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
236	4241	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
237	4242	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
238	4243	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
239	4244	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
240	4245	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
241	4246	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
242	4247	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
243	4248	producto	\N	331	Sistema Calibración Patrones	5	12500.00	62500.00
244	4249	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
245	4250	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
246	4251	producto	\N	331	Sistema Calibración Patrones	1	12500.00	62500.00
247	4252	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
248	4253	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
249	4254	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
250	4255	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
251	4256	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
252	4257	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
253	4258	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
254	4259	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
255	4260	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
256	4261	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
257	4262	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
258	4263	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
259	4264	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
260	4265	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
261	4266	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
262	4267	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
263	4268	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
264	4269	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
265	4270	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
266	4271	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
267	4272	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
268	4273	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
269	4274	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
270	4275	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
271	4276	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
272	4277	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
273	4278	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
274	4279	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
275	4280	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
276	4281	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
277	4282	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
278	4283	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
279	4284	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
280	4285	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
281	4286	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
282	4287	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
283	4288	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
284	4289	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
285	4290	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
286	4291	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
287	4292	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
288	4293	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
289	4294	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
290	4295	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
291	4296	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
292	4297	producto	\N	331	Sistema Calibración Patrones	5	12500.00	62500.00
293	4298	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
294	4299	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
295	4300	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
296	4301	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
297	4302	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
298	4303	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
299	4304	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
300	4305	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
301	4306	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
302	4307	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
303	4308	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
304	4309	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
305	4310	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
306	4311	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
307	4312	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
308	4313	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
309	4314	producto	\N	331	Sistema Calibración Patrones	1	12500.00	62500.00
310	4315	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
311	4316	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
312	4317	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
313	4318	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
314	4319	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
315	4320	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
316	4321	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
317	4322	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
318	4323	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
319	4324	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
320	4325	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
321	4326	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
322	4327	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
323	4328	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
324	4329	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
325	4330	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
326	4331	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
327	4332	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
328	4333	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
329	4334	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
330	4335	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
331	4336	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
332	4337	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
333	4338	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
334	4339	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
335	4340	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
336	4341	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
337	4342	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
338	4343	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
339	4344	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
340	4345	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
341	4346	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
342	4347	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
343	4348	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
344	4349	producto	\N	331	Sistema Calibración Patrones	1	12500.00	62500.00
345	4350	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
346	4351	producto	\N	331	Sistema Calibración Patrones	4	12500.00	12500.00
347	4352	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
348	4353	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
349	4354	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
350	4355	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
351	4356	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
352	4357	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
353	4358	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
354	4359	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
355	4360	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
356	4361	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
357	4362	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
358	4363	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
359	4364	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
360	4365	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
361	4366	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
362	4367	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
363	4368	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
364	4369	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
365	4370	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
366	4371	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
367	4372	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
368	4373	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
369	4374	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
370	4375	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
371	4376	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
372	4377	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
373	4378	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
374	4379	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
375	4380	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
376	4381	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
377	4382	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
378	4383	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
379	4384	producto	\N	331	Sistema Calibración Patrones	1	12500.00	62500.00
380	4385	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
381	4386	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
382	4387	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
383	4388	producto	\N	331	Sistema Calibración Patrones	1	12500.00	62500.00
384	4389	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
385	4390	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
386	4391	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
387	4392	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
388	4393	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
389	4394	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
390	4395	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
391	4396	producto	\N	331	Sistema Calibración Patrones	5	12500.00	62500.00
392	4397	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
393	4398	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
394	4399	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
395	4400	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
396	4401	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
397	4402	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
398	4403	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
399	4404	producto	\N	331	Sistema Calibración Patrones	5	12500.00	62500.00
400	4405	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
401	4406	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
402	4407	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
403	4408	producto	\N	331	Sistema Calibración Patrones	1	12500.00	62500.00
404	4409	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
405	4410	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
406	4411	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
407	4412	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
408	4413	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
409	4414	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
410	4415	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
411	4416	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
412	4417	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
413	4418	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
414	4419	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
415	4420	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
416	4421	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
417	4422	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
418	4423	producto	\N	331	Sistema Calibración Patrones	5	12500.00	62500.00
419	4424	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
420	4425	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
421	4426	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
422	4427	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
423	4428	producto	\N	331	Sistema Calibración Patrones	5	12500.00	12500.00
424	4429	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
425	4430	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
426	4431	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
427	4432	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
428	4433	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
429	4434	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
430	4435	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
431	4436	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
432	4437	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
433	4438	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
434	4439	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
435	4440	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
436	4441	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
437	4442	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
438	4443	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
439	4444	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
440	4445	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
441	4446	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
442	4447	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
443	4448	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
444	4449	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
445	4450	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
446	4451	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
447	4452	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
448	4453	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
449	4454	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
450	4455	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
451	4456	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
452	4457	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
453	4458	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
454	4459	producto	\N	331	Sistema Calibración Patrones	1	12500.00	62500.00
455	4460	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
456	4461	producto	\N	331	Sistema Calibración Patrones	3	12500.00	12500.00
457	4462	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
458	4463	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
459	4464	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
460	4465	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
461	4466	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
462	4467	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
463	4468	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
464	4469	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
465	4470	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
466	4471	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
467	4472	producto	\N	331	Sistema Calibración Patrones	3	12500.00	25000.00
468	4473	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
469	4474	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
470	4475	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
471	4476	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
472	4477	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
473	4478	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
474	4479	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
475	4480	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
476	4481	producto	\N	331	Sistema Calibración Patrones	5	12500.00	50000.00
477	4482	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
478	4483	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
479	4484	producto	\N	331	Sistema Calibración Patrones	1	12500.00	37500.00
480	4485	producto	\N	331	Sistema Calibración Patrones	4	12500.00	62500.00
481	4486	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
482	4487	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
483	4488	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
484	4489	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
485	4490	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
486	4491	producto	\N	331	Sistema Calibración Patrones	2	12500.00	25000.00
487	4492	producto	\N	331	Sistema Calibración Patrones	4	12500.00	50000.00
488	4493	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
489	4494	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
490	4495	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
491	4496	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
492	4497	producto	\N	331	Sistema Calibración Patrones	5	12500.00	25000.00
493	4498	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
494	4499	producto	\N	331	Sistema Calibración Patrones	1	12500.00	25000.00
495	4500	producto	\N	331	Sistema Calibración Patrones	3	12500.00	37500.00
496	4501	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
497	4502	producto	\N	331	Sistema Calibración Patrones	5	12500.00	37500.00
498	4503	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
499	4504	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
500	4505	producto	\N	331	Sistema Calibración Patrones	2	12500.00	50000.00
501	4506	producto	\N	331	Sistema Calibración Patrones	3	12500.00	62500.00
502	4507	producto	\N	331	Sistema Calibración Patrones	5	12500.00	62500.00
503	4508	producto	\N	331	Sistema Calibración Patrones	2	12500.00	12500.00
504	4509	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
505	4510	producto	\N	331	Sistema Calibración Patrones	2	12500.00	62500.00
506	4511	producto	\N	331	Sistema Calibración Patrones	1	12500.00	50000.00
507	4512	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
508	4513	producto	\N	331	Sistema Calibración Patrones	1	12500.00	12500.00
509	4514	producto	\N	331	Sistema Calibración Patrones	3	12500.00	50000.00
510	4515	producto	\N	331	Sistema Calibración Patrones	2	12500.00	37500.00
511	4516	producto	\N	331	Sistema Calibración Patrones	4	12500.00	37500.00
512	4517	producto	\N	331	Sistema Calibración Patrones	4	12500.00	25000.00
513	4018	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
514	4019	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
515	4020	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
516	4021	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
517	4022	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
518	4023	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
519	4024	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
520	4025	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
521	4026	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
522	4027	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
523	4028	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
524	4029	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
525	4030	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
526	4031	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
527	4032	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
528	4033	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
529	4034	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
530	4035	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
531	4036	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
532	4037	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
533	4038	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
534	4039	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
535	4040	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
536	4041	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
537	4042	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
538	4043	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
539	4044	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
540	4045	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
541	4046	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
542	4047	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
543	4048	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
544	4049	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
545	4050	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
546	4051	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	5550.00
547	4052	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
548	4053	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
549	4054	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
550	4055	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
551	4056	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
552	4057	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
553	4058	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
554	4059	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
555	4060	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
556	4061	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
557	4062	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
558	4063	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
559	4064	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
560	4065	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
561	4066	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
562	4067	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	9250.00
563	4068	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
564	4069	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
565	4070	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
566	4071	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
567	4072	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
568	4073	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
569	4074	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
570	4075	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
571	4076	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
572	4077	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
573	4078	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
574	4079	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
575	4080	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
576	4081	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
577	4082	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
578	4083	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
579	4084	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
580	4085	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
581	4086	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
582	4087	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
583	4088	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
584	4089	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
585	4090	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
586	4091	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
587	4092	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
588	4093	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
589	4094	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
590	4095	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
591	4096	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
592	4097	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
593	4098	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
594	4099	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
595	4100	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
596	4101	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
597	4102	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
598	4103	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
599	4104	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
600	4105	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
601	4106	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
602	4107	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
603	4108	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
604	4109	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
605	4110	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
606	4111	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
607	4112	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
608	4113	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
609	4114	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
610	4115	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
611	4116	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
612	4117	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	9250.00
613	4118	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
614	4119	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
615	4120	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
616	4121	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
617	4122	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
618	4123	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
619	4124	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
620	4125	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
621	4126	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
622	4127	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
623	4128	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
624	4129	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
625	4130	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
626	4131	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
627	4132	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
628	4133	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
629	4134	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
630	4135	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
631	4136	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
632	4137	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
633	4138	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
634	4139	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
635	4140	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
636	4141	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
637	4142	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
638	4143	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
639	4144	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
640	4145	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
641	4146	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
642	4147	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
643	4148	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
644	4149	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
645	4150	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
646	4151	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
647	4152	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
648	4153	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
649	4154	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
650	4155	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
652	4157	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
653	4158	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
654	4159	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
655	4160	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
656	4161	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
657	4162	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
658	4163	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
659	4164	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
660	4165	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
661	4166	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
662	4167	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	5550.00
663	4168	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
664	4169	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
665	4170	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
666	4171	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
667	4172	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
668	4173	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
669	4174	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
670	4175	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
671	4176	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
672	4177	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
673	4178	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
674	4179	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
675	4180	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
676	4181	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
677	4182	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
678	4183	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
679	4184	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
680	4185	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	9250.00
681	4186	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
682	4187	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
683	4188	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
684	4189	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
685	4190	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
686	4191	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
687	4192	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
688	4193	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	5550.00
689	4194	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
690	4195	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
691	4196	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
692	4197	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
693	4198	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
694	4199	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
695	4200	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
696	4201	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
697	4202	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
698	4203	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
699	4204	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
700	4205	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
701	4206	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
702	4207	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
703	4208	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
704	4209	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
705	4210	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
706	4211	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
707	4212	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
708	4213	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
709	4214	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
710	4215	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
711	4216	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
712	4217	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
713	4218	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
714	4219	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
715	4220	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
716	4221	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
717	4222	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
718	4223	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
719	4224	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
720	4225	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
721	4226	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
722	4227	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
723	4228	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
724	4229	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
725	4230	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
726	4231	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
727	4232	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
728	4233	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
729	4234	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
730	4235	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
731	4236	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
732	4237	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
733	4238	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
734	4239	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	9250.00
735	4240	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
736	4241	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
737	4242	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
738	4243	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
739	4244	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
740	4245	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
741	4246	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
742	4247	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
743	4248	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
744	4249	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
745	4250	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
746	4251	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
747	4252	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
748	4253	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
749	4254	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
750	4255	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
751	4256	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
752	4257	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	5550.00
753	4258	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
754	4259	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
755	4260	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
756	4261	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
757	4262	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
758	4263	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
759	4264	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
760	4265	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
761	4266	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
762	4267	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
763	4268	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
764	4269	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
765	4270	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
766	4271	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
767	4272	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
768	4273	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
769	4274	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
770	4275	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
771	4276	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
772	4277	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
773	4278	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
774	4279	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
775	4280	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
776	4281	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
777	4282	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
778	4283	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
779	4284	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
780	4285	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
781	4286	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
782	4287	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
783	4288	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	5550.00
784	4289	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
785	4290	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
786	4291	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
787	4292	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
788	4293	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
789	4294	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
790	4295	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
791	4296	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
792	4297	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
793	4298	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
794	4299	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
795	4300	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
796	4301	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
797	4302	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
798	4303	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
799	4304	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
800	4305	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
801	4306	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
802	4307	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
803	4308	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
804	4309	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
805	4310	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
806	4311	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
807	4312	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
808	4313	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
809	4314	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
810	4315	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
811	4316	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
812	4317	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
813	4318	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
814	4319	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
815	4320	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
816	4321	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
817	4322	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
818	4323	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
819	4324	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
820	4325	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
821	4326	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
822	4327	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
823	4328	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
824	4329	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
825	4330	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
826	4331	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
827	4332	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
828	4333	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
829	4334	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
830	4335	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
831	4336	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
832	4337	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
833	4338	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
834	4339	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
835	4340	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
836	4341	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
837	4342	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
838	4343	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	9250.00
839	4344	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
840	4345	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
841	4346	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
842	4347	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
843	4348	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
844	4349	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
845	4350	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
846	4351	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
847	4352	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
848	4353	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
849	4354	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
850	4355	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
851	4356	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
852	4357	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
853	4358	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
854	4359	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
855	4360	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
856	4361	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
857	4362	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
858	4363	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
859	4364	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
860	4365	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
861	4366	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
862	4367	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
863	4368	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
864	4369	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
865	4370	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
866	4371	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
867	4372	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
868	4373	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
869	4374	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
870	4375	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
871	4376	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
872	4377	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
873	4378	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
874	4379	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
875	4380	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
876	4381	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
877	4382	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
878	4383	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
879	4384	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
880	4385	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
881	4386	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
882	4387	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
883	4388	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
884	4389	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
885	4390	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
886	4391	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
887	4392	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
888	4393	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
889	4394	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
890	4395	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
891	4396	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
892	4397	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
893	4398	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	7400.00
894	4399	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
895	4400	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
896	4401	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
897	4402	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	5550.00
898	4403	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
899	4404	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
900	4405	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
901	4406	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
902	4407	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
903	4408	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
904	4409	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
905	4410	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
906	4411	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
907	4412	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
908	4413	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
909	4414	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
910	4415	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
911	4416	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
912	4417	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
913	4418	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
914	4419	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
915	4420	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
916	4421	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
917	4422	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
918	4423	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
919	4424	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
920	4425	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
921	4426	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
922	4427	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
923	4428	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
924	4429	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
925	4430	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
926	4431	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
927	4432	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
928	4433	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
929	4434	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
930	4435	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
931	4436	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
932	4437	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
933	4438	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
934	4439	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
935	4440	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
936	4441	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
937	4442	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
938	4443	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
939	4444	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
940	4445	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
941	4446	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
942	4447	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
943	4448	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
944	4449	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
945	4450	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
946	4451	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	1850.00
947	4452	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
948	4453	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
949	4454	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
950	4455	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
951	4456	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
952	4457	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
953	4458	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
954	4459	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
955	4460	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
956	4461	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
957	4462	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
958	4463	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
959	4464	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
960	4465	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	1850.00
961	4466	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
962	4467	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
963	4468	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	7400.00
964	4469	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
965	4470	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
966	4471	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
967	4472	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
968	4473	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
969	4474	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
970	4475	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
971	4476	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
972	4477	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
973	4478	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
974	4479	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
975	4480	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
976	4481	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	9250.00
977	4482	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
978	4483	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
979	4484	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
980	4485	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
981	4486	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	9250.00
982	4487	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	3700.00
983	4488	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
984	4489	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	3700.00
985	4490	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
986	4491	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
987	4492	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
988	4493	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
989	4494	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	5550.00
990	4495	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	1850.00
991	4496	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	5550.00
992	4497	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
993	4498	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	5550.00
994	4499	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	7400.00
995	4500	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	1850.00
996	4501	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
997	4502	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
998	4503	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	9250.00
999	4504	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	7400.00
1000	4505	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	3700.00
1001	4506	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
1002	4507	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	5550.00
1003	4508	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
1004	4509	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	9250.00
1005	4510	producto	\N	401	Banco Prueba Eléctrico	5	1850.00	5550.00
1006	4511	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	5550.00
1007	4512	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
1008	4513	producto	\N	401	Banco Prueba Eléctrico	1	1850.00	7400.00
1009	4514	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
1010	4515	producto	\N	401	Banco Prueba Eléctrico	4	1850.00	3700.00
1011	4516	producto	\N	401	Banco Prueba Eléctrico	3	1850.00	3700.00
1012	4517	producto	\N	401	Banco Prueba Eléctrico	2	1850.00	1850.00
1013	4018	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1014	4019	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1015	4020	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1016	4021	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1017	4022	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1018	4023	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1019	4024	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1020	4025	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1021	4026	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1022	4027	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1023	4028	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	1850.00
1024	4029	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1025	4030	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1026	4031	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1027	4032	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1028	4033	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1029	4034	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1030	4035	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1031	4036	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1032	4037	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1033	4038	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1034	4039	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1035	4040	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1036	4041	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1037	4042	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1038	4043	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	9250.00
1039	4044	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1040	4045	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1041	4046	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1042	4047	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1043	4048	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1044	4049	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1045	4050	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1046	4051	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1047	4052	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1048	4053	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1049	4054	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1050	4055	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1051	4056	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1052	4057	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1053	4058	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1054	4059	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1055	4060	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	9250.00
1056	4061	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1057	4062	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1058	4063	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1059	4064	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1060	4065	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1061	4066	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1062	4067	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1063	4068	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1064	4069	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1065	4070	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1066	4071	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1067	4072	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1068	4073	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1069	4074	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1070	4075	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1071	4076	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1072	4077	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1073	4078	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	9250.00
1074	4079	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1075	4080	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1076	4081	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1077	4082	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1078	4083	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1079	4084	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1080	4085	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1081	4086	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1082	4087	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1083	4088	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1084	4089	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1085	4090	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1086	4091	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1087	4092	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1088	4093	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	9250.00
1089	4094	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1090	4095	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1091	4096	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	1850.00
1092	4097	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1093	4098	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1094	4099	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1095	4100	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1096	4101	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1097	4102	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1098	4103	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1099	4104	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1100	4105	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1101	4106	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	1850.00
1102	4107	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1103	4108	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1104	4109	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1105	4110	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1106	4111	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1107	4112	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1108	4113	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1109	4114	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1110	4115	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1111	4116	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1112	4117	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1113	4118	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1114	4119	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1115	4120	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1116	4121	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1117	4122	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1118	4123	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1119	4124	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1120	4125	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1121	4126	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1122	4127	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1123	4128	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1124	4129	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1125	4130	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1126	4131	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1127	4132	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1128	4133	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1129	4134	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1130	4135	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1131	4136	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1132	4137	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1133	4138	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1134	4139	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1135	4140	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1136	4141	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1137	4142	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1138	4143	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1139	4144	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1140	4145	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1141	4146	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1142	4147	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1143	4148	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1144	4149	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1145	4150	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1146	4151	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1147	4152	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1148	4153	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1149	4154	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1150	4155	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1152	4157	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1153	4158	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1154	4159	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1155	4160	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1156	4161	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1157	4162	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1158	4163	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1159	4164	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1160	4165	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1161	4166	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1162	4167	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1163	4168	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1164	4169	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1165	4170	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1166	4171	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1167	4172	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1168	4173	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1169	4174	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1170	4175	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	1850.00
1171	4176	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1172	4177	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1173	4178	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1174	4179	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1175	4180	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1176	4181	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1177	4182	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1178	4183	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1179	4184	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1180	4185	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1181	4186	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1182	4187	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1183	4188	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1184	4189	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1185	4190	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	9250.00
1186	4191	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1187	4192	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1188	4193	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1189	4194	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1190	4195	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1191	4196	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1192	4197	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1193	4198	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1194	4199	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1195	4200	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1196	4201	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1197	4202	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1198	4203	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1199	4204	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1200	4205	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1201	4206	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1202	4207	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1203	4208	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1204	4209	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1205	4210	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1206	4211	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1207	4212	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1208	4213	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1209	4214	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1210	4215	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1211	4216	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1212	4217	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1213	4218	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1214	4219	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	9250.00
1215	4220	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1216	4221	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1217	4222	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1218	4223	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1219	4224	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1220	4225	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1221	4226	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1222	4227	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1223	4228	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1224	4229	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1225	4230	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1226	4231	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1227	4232	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1228	4233	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1229	4234	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1230	4235	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1231	4236	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1232	4237	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1233	4238	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1234	4239	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1235	4240	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1236	4241	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1237	4242	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1238	4243	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1239	4244	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	9250.00
1240	4245	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1241	4246	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1242	4247	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1243	4248	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1244	4249	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1245	4250	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1246	4251	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1247	4252	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1248	4253	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1249	4254	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1250	4255	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1251	4256	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1252	4257	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1253	4258	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1254	4259	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1255	4260	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1256	4261	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	9250.00
1257	4262	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1258	4263	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1259	4264	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1260	4265	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1261	4266	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1262	4267	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1263	4268	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1264	4269	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1265	4270	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1266	4271	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1267	4272	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1268	4273	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1269	4274	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1270	4275	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1271	4276	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1272	4277	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1273	4278	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1274	4279	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1275	4280	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1276	4281	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	9250.00
1277	4282	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1278	4283	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1279	4284	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1280	4285	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1281	4286	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1282	4287	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1283	4288	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1284	4289	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1285	4290	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1286	4291	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1287	4292	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1288	4293	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1289	4294	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1290	4295	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1291	4296	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1292	4297	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1293	4298	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1294	4299	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1295	4300	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1296	4301	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1297	4302	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1298	4303	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1299	4304	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1300	4305	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1301	4306	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1302	4307	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1303	4308	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1304	4309	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1305	4310	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1306	4311	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1307	4312	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1308	4313	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1309	4314	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1310	4315	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1311	4316	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1312	4317	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1313	4318	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1314	4319	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1315	4320	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1316	4321	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1317	4322	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1318	4323	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1319	4324	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1320	4325	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1321	4326	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1322	4327	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1323	4328	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1324	4329	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1325	4330	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1326	4331	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1327	4332	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1328	4333	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1329	4334	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1330	4335	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	1850.00
1331	4336	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1332	4337	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1333	4338	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1334	4339	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1335	4340	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1336	4341	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1337	4342	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1338	4343	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1339	4344	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1340	4345	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1341	4346	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1342	4347	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1343	4348	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1344	4349	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1345	4350	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1346	4351	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1347	4352	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1348	4353	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1349	4354	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1350	4355	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1351	4356	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1352	4357	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1353	4358	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1354	4359	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1355	4360	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1356	4361	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1357	4362	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1358	4363	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1359	4364	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1360	4365	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1361	4366	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1362	4367	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1363	4368	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1364	4369	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1365	4370	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1366	4371	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1367	4372	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1368	4373	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1369	4374	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1370	4375	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1371	4376	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1372	4377	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1373	4378	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1374	4379	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1375	4380	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1376	4381	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1377	4382	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1378	4383	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1379	4384	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1380	4385	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1381	4386	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1382	4387	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1383	4388	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1384	4389	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1385	4390	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1386	4391	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1387	4392	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1388	4393	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1389	4394	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1390	4395	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1391	4396	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1392	4397	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1393	4398	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1394	4399	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1395	4400	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1396	4401	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1397	4402	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1398	4403	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1399	4404	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1400	4405	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	9250.00
1401	4406	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1402	4407	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1403	4408	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1404	4409	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1405	4410	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1406	4411	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1407	4412	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1408	4413	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1409	4414	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1410	4415	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	9250.00
1411	4416	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1412	4417	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1413	4418	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1414	4419	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1415	4420	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1416	4421	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1417	4422	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1418	4423	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1419	4424	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1420	4425	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1421	4426	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1422	4427	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1423	4428	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	9250.00
1424	4429	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1425	4430	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1426	4431	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1427	4432	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1428	4433	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1429	4434	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1430	4435	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	1850.00
1431	4436	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1432	4437	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1433	4438	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1434	4439	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1435	4440	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1436	4441	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1437	4442	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1438	4443	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1439	4444	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1440	4445	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1441	4446	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	5550.00
1442	4447	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1443	4448	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1444	4449	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1445	4450	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1446	4451	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1447	4452	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1448	4453	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1449	4454	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1450	4455	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1451	4456	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	9250.00
1452	4457	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1453	4458	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1454	4459	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1455	4460	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	1850.00
1456	4461	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1457	4462	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1458	4463	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1459	4464	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1460	4465	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1461	4466	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	9250.00
1462	4467	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1463	4468	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	1850.00
1464	4469	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1465	4470	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1466	4471	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1467	4472	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1468	4473	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1469	4474	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	9250.00
1470	4475	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1471	4476	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1472	4477	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1473	4478	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1474	4479	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1475	4480	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1476	4481	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	7400.00
1477	4482	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1478	4483	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1479	4484	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1480	4485	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1481	4486	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1482	4487	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1483	4488	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	3700.00
1484	4489	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1485	4490	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	3700.00
1486	4491	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1487	4492	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1488	4493	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	9250.00
1489	4494	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	1850.00
1490	4495	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1491	4496	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1492	4497	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	7400.00
1493	4498	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	5550.00
1494	4499	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	5550.00
1495	4500	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1496	4501	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	7400.00
1497	4502	producto	\N	52	Chamarra Dainese Carro Armor	5	1850.00	3700.00
1498	4503	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	1850.00
1499	4504	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	5550.00
1500	4505	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	5550.00
1501	4506	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1502	4507	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1503	4508	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	9250.00
1504	4509	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1505	4510	producto	\N	52	Chamarra Dainese Carro Armor	3	1850.00	7400.00
1506	4511	producto	\N	52	Chamarra Dainese Carro Armor	4	1850.00	3700.00
1507	4512	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1508	4513	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	7400.00
1509	4514	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	9250.00
1510	4515	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1511	4516	producto	\N	52	Chamarra Dainese Carro Armor	1	1850.00	1850.00
1512	4517	producto	\N	52	Chamarra Dainese Carro Armor	2	1850.00	3700.00
1513	4518	producto	\N	920	Abrazadera Manguera 50-60mm	1	12.00	12.00
\.


--
-- TOC entry 5050 (class 0 OID 16721)
-- Dependencies: 238
-- Data for Name: facturas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facturas (id, numero_factura, cliente_id, moto_id, fecha_emision, total, estado, empleado_id) FROM stdin;
4519	F1764031736	90	105	2025-11-24 18:48:56.169493	420.00	pagada	1
13	F1762278789	502	9	2025-11-04 11:53:09.512419	40.00	pendiente	1
14	F1762278806	502	\N	2025-11-04 11:53:26.154445	85.00	pendiente	1
15	F1762296549	262	\N	2025-11-04 16:49:09.679376	160.00	pagada	1
16	F1762373010	236	\N	2025-11-05 14:03:30.090616	25.00	pagada	1
17	F1762376076	160	\N	2025-11-05 14:54:36.242204	35.00	pagada	3
4517	FAC-2023-10-1500	209	\N	2023-10-06 00:00:00	30550.00	pagada	8
4018	FAC-2023-08-1001	479	\N	2023-08-02 00:00:00	55550.00	pendiente	859
4201	FAC-2024-07-1184	337	\N	2024-07-16 00:00:00	59250.00	pagada	84
4192	FAC-2023-01-1175	135	\N	2023-01-03 00:00:00	32400.00	cancelada	498
4512	FAC-2025-03-1495	187	\N	2025-03-12 00:00:00	61100.00	pagada	290
4105	FAC-2024-12-1088	112	\N	2024-12-26 00:00:00	21750.00	pagada	625
4019	FAC-2025-07-1002	313	\N	2025-07-23 00:00:00	75450.00	pendiente	465
4299	FAC-2024-12-1282	237	\N	2024-12-13 00:00:00	57400.00	pendiente	855
4062	FAC-2024-03-1045	33	\N	2024-03-19 00:00:00	34250.00	pagada	214
4304	FAC-2024-07-1287	99	\N	2024-07-17 00:00:00	30550.00	pagada	269
4504	FAC-2025-06-1487	176	\N	2025-06-11 00:00:00	37950.00	pendiente	1054
4326	FAC-2025-08-1309	418	\N	2025-08-18 00:00:00	23600.00	pagada	289
4449	FAC-2024-12-1432	128	\N	2024-12-07 00:00:00	36100.00	pagada	931
4321	FAC-2023-08-1304	453	\N	2023-08-10 00:00:00	61100.00	pagada	676
4288	FAC-2025-03-1271	118	\N	2025-03-29 00:00:00	34250.00	pagada	427
4056	FAC-2024-07-1039	372	\N	2024-07-24 00:00:00	64800.00	cancelada	925
4176	FAC-2022-12-1159	397	\N	2022-12-14 00:00:00	21750.00	pagada	372
4044	FAC-2024-05-1027	90	\N	2024-05-10 00:00:00	21750.00	pagada	541
4348	FAC-2024-02-1331	376	\N	2024-02-02 00:00:00	41650.00	pagada	243
4344	FAC-2023-09-1327	342	\N	2023-09-14 00:00:00	64800.00	pagada	125
4284	FAC-2025-06-1267	381	\N	2025-06-01 00:00:00	68050.00	pendiente	738
4258	FAC-2025-04-1241	269	\N	2025-04-24 00:00:00	64800.00	pagada	366
4120	FAC-2023-03-1103	402	\N	2023-03-09 00:00:00	64800.00	cancelada	466
4223	FAC-2023-02-1206	367	\N	2023-02-25 00:00:00	44900.00	pendiente	557
4047	FAC-2024-10-1030	117	\N	2024-10-06 00:00:00	59250.00	pagada	780
4234	FAC-2025-05-1217	342	\N	2025-05-20 00:00:00	48600.00	pagada	971
4316	FAC-2025-03-1299	509	\N	2025-03-30 00:00:00	62950.00	pagada	998
4424	FAC-2024-02-1407	422	\N	2024-02-22 00:00:00	18050.00	pagada	975
4347	FAC-2022-12-1330	128	\N	2022-12-06 00:00:00	32400.00	pagada	870
4255	FAC-2025-11-1238	11	\N	2025-11-01 00:00:00	52300.00	pagada	846
4036	FAC-2022-12-1019	24	\N	2022-12-22 00:00:00	57400.00	pendiente	776
4138	FAC-2025-02-1121	129	\N	2025-02-24 00:00:00	52300.00	pendiente	579
4116	FAC-2023-04-1099	260	\N	2023-04-23 00:00:00	62950.00	pagada	178
4020	FAC-2025-05-1003	195	\N	2025-05-26 00:00:00	59250.00	cancelada	775
4448	FAC-2024-09-1431	14	\N	2024-09-26 00:00:00	44900.00	pagada	109
4189	FAC-2024-11-1172	234	\N	2024-11-29 00:00:00	36100.00	pagada	1018
4446	FAC-2025-09-1429	422	\N	2025-09-20 00:00:00	57400.00	cancelada	672
4221	FAC-2024-08-1204	256	\N	2024-08-22 00:00:00	69900.00	pagada	993
4038	FAC-2023-11-1021	144	\N	2023-11-22 00:00:00	46750.00	pagada	561
4269	FAC-2025-09-1252	458	\N	2025-09-10 00:00:00	37950.00	pendiente	191
4499	FAC-2024-01-1482	209	\N	2024-01-08 00:00:00	37950.00	pagada	242
4175	FAC-2025-09-1158	154	\N	2025-09-04 00:00:00	19900.00	pagada	270
4481	FAC-2025-07-1464	66	\N	2025-07-13 00:00:00	66650.00	pagada	151
4188	FAC-2025-04-1171	294	\N	2025-04-11 00:00:00	36100.00	pendiente	215
4160	FAC-2025-04-1143	373	\N	2025-04-25 00:00:00	25450.00	pagada	215
4407	FAC-2024-02-1390	120	\N	2024-02-18 00:00:00	37950.00	pagada	982
4208	FAC-2024-11-1191	73	\N	2024-11-21 00:00:00	32400.00	pendiente	399
4435	FAC-2025-10-1418	310	\N	2025-10-13 00:00:00	55550.00	pagada	669
4182	FAC-2024-10-1165	419	\N	2024-10-28 00:00:00	48600.00	pagada	141
4095	FAC-2023-03-1078	461	\N	2023-03-17 00:00:00	48600.00	pagada	1
4289	FAC-2024-03-1272	259	\N	2024-03-05 00:00:00	59250.00	pagada	716
4417	FAC-2025-01-1400	117	\N	2025-01-05 00:00:00	77300.00	pagada	940
4452	FAC-2025-05-1435	101	\N	2025-05-17 00:00:00	61100.00	pendiente	878
4190	FAC-2025-10-1173	17	\N	2025-10-29 00:00:00	56000.00	pagada	809
4239	FAC-2023-03-1222	71	\N	2023-03-01 00:00:00	41650.00	pagada	736
4294	FAC-2025-03-1277	287	\N	2025-03-27 00:00:00	50450.00	pagada	152
4306	FAC-2023-04-1289	470	\N	2023-04-26 00:00:00	25450.00	pagada	792
4480	FAC-2024-07-1463	307	\N	2024-07-23 00:00:00	25450.00	pagada	755
4051	FAC-2024-12-1034	449	\N	2024-12-24 00:00:00	59250.00	pendiente	869
4470	FAC-2025-05-1453	134	\N	2025-05-18 00:00:00	52300.00	pagada	260
4066	FAC-2024-01-1049	239	\N	2024-01-09 00:00:00	50450.00	pagada	427
4419	FAC-2023-05-1402	61	\N	2023-05-23 00:00:00	39800.00	pagada	709
4307	FAC-2023-04-1290	57	\N	2023-04-22 00:00:00	39800.00	pendiente	486
4464	FAC-2024-05-1447	197	\N	2024-05-29 00:00:00	57400.00	pagada	820
4048	FAC-2023-12-1031	134	\N	2023-12-29 00:00:00	44900.00	pagada	834
4154	FAC-2023-03-1137	498	\N	2023-03-27 00:00:00	19900.00	pagada	394
4142	FAC-2025-05-1125	83	\N	2025-05-15 00:00:00	34250.00	pagada	116
4091	FAC-2025-05-1074	158	\N	2025-05-13 00:00:00	61100.00	pendiente	629
4078	FAC-2023-10-1061	319	\N	2023-10-25 00:00:00	50450.00	pagada	915
4357	FAC-2023-05-1340	273	\N	2023-05-26 00:00:00	44900.00	pagada	587
4427	FAC-2024-12-1410	192	\N	2024-12-13 00:00:00	43050.00	pagada	1029
4373	FAC-2025-05-1356	89	\N	2025-05-03 00:00:00	37950.00	pendiente	811
4144	FAC-2023-03-1127	73	\N	2023-03-05 00:00:00	36100.00	pagada	435
4425	FAC-2024-09-1408	95	\N	2024-09-05 00:00:00	34250.00	pagada	516
4022	FAC-2023-09-1005	352	\N	2023-09-23 00:00:00	48600.00	pagada	336
4248	FAC-2025-04-1231	172	\N	2025-04-10 00:00:00	75450.00	pendiente	869
4085	FAC-2024-02-1068	284	\N	2024-02-01 00:00:00	43050.00	pagada	890
4128	FAC-2025-04-1111	502	\N	2025-04-03 00:00:00	77300.00	pagada	885
4252	FAC-2023-06-1235	153	\N	2023-06-30 00:00:00	37950.00	pagada	917
4271	FAC-2024-09-1254	407	\N	2024-09-20 00:00:00	36100.00	pagada	923
4246	FAC-2025-04-1229	379	\N	2025-04-04 00:00:00	43050.00	pagada	441
4317	FAC-2023-10-1300	296	\N	2023-10-09 00:00:00	59250.00	pagada	366
4099	FAC-2024-06-1082	103	\N	2024-06-15 00:00:00	46750.00	pendiente	114
4506	FAC-2024-07-1489	345	\N	2024-07-25 00:00:00	69900.00	pendiente	310
4058	FAC-2024-12-1041	63	\N	2024-12-13 00:00:00	75450.00	pagada	1025
4356	FAC-2024-10-1339	269	\N	2024-10-04 00:00:00	34250.00	pagada	118
4123	FAC-2022-12-1106	268	\N	2022-12-18 00:00:00	62950.00	pendiente	626
4298	FAC-2022-12-1281	55	\N	2022-12-10 00:00:00	59250.00	pagada	812
4457	FAC-2024-04-1440	392	\N	2024-04-29 00:00:00	62950.00	pendiente	748
4314	FAC-2024-01-1297	109	\N	2024-01-30 00:00:00	75450.00	cancelada	551
4161	FAC-2023-03-1144	12	\N	2023-03-10 00:00:00	48600.00	pagada	501
4278	FAC-2025-09-1261	124	\N	2025-09-01 00:00:00	59250.00	pendiente	980
4332	FAC-2025-02-1315	32	\N	2025-02-13 00:00:00	21750.00	pagada	515
4394	FAC-2022-12-1377	185	\N	2022-12-22 00:00:00	57400.00	pagada	51
4277	FAC-2025-01-1260	64	\N	2025-01-18 00:00:00	62950.00	pagada	700
4079	FAC-2024-02-1062	115	\N	2024-02-14 00:00:00	59250.00	pagada	591
4197	FAC-2023-07-1180	131	\N	2023-07-06 00:00:00	57400.00	pagada	703
4025	FAC-2025-03-1008	292	\N	2025-03-20 00:00:00	39800.00	pagada	367
4406	FAC-2024-03-1389	17	\N	2024-03-27 00:00:00	57400.00	pagada	214
4111	FAC-2023-09-1094	422	\N	2023-09-26 00:00:00	73600.00	pagada	638
4507	FAC-2024-03-1490	177	\N	2024-03-07 00:00:00	77300.00	pendiente	670
4479	FAC-2024-06-1462	359	\N	2024-06-28 00:00:00	66650.00	pagada	45
4333	FAC-2024-06-1316	209	\N	2024-06-03 00:00:00	29150.00	pagada	606
4474	FAC-2025-07-1457	262	\N	2025-07-24 00:00:00	61100.00	pagada	36
4369	FAC-2023-06-1352	39	\N	2023-06-14 00:00:00	55550.00	pagada	168
4323	FAC-2024-05-1306	360	\N	2024-05-29 00:00:00	37950.00	pagada	292
4167	FAC-2023-11-1150	509	\N	2023-11-28 00:00:00	25450.00	pendiente	440
4164	FAC-2025-02-1147	278	\N	2025-02-20 00:00:00	71750.00	pendiente	305
4034	FAC-2024-09-1017	351	\N	2024-09-27 00:00:00	36100.00	pendiente	135
4473	FAC-2024-01-1456	225	\N	2024-01-09 00:00:00	57400.00	pagada	838
4241	FAC-2025-04-1224	122	\N	2025-04-15 00:00:00	48600.00	pendiente	613
4104	FAC-2024-04-1087	357	\N	2024-04-27 00:00:00	44900.00	pagada	1007
4386	FAC-2023-12-1369	40	\N	2023-12-08 00:00:00	48600.00	pagada	565
4139	FAC-2023-11-1122	215	\N	2023-11-02 00:00:00	48600.00	pagada	115
4451	FAC-2024-04-1434	279	\N	2024-04-13 00:00:00	48600.00	pendiente	687
4500	FAC-2025-06-1483	72	\N	2025-06-18 00:00:00	46750.00	pagada	996
4202	FAC-2025-08-1185	413	\N	2025-08-18 00:00:00	39800.00	cancelada	334
4027	FAC-2024-10-1010	394	\N	2024-10-24 00:00:00	64800.00	pagada	287
4511	FAC-2024-07-1494	442	\N	2024-07-04 00:00:00	59250.00	pagada	224
4398	FAC-2023-09-1381	42	\N	2023-09-05 00:00:00	48600.00	pendiente	155
4485	FAC-2023-06-1468	361	\N	2023-06-19 00:00:00	73600.00	pagada	696
4390	FAC-2022-12-1373	424	\N	2022-12-19 00:00:00	71750.00	cancelada	62
4210	FAC-2023-09-1193	362	\N	2023-09-25 00:00:00	37950.00	pagada	32
4204	FAC-2024-04-1187	329	\N	2024-04-30 00:00:00	50450.00	pagada	555
4351	FAC-2023-04-1334	2	\N	2023-04-12 00:00:00	19900.00	pagada	476
4206	FAC-2025-06-1189	34	\N	2025-06-19 00:00:00	55550.00	pagada	320
4068	FAC-2023-01-1051	375	\N	2023-01-21 00:00:00	34250.00	pagada	324
4362	FAC-2025-01-1345	323	\N	2025-01-21 00:00:00	71750.00	pagada	587
4102	FAC-2024-11-1085	150	\N	2024-11-30 00:00:00	59250.00	pagada	782
4137	FAC-2024-05-1120	233	\N	2024-05-24 00:00:00	48600.00	pendiente	993
4166	FAC-2025-04-1149	77	\N	2025-04-20 00:00:00	48600.00	pendiente	136
4265	FAC-2023-12-1248	273	\N	2023-12-21 00:00:00	48600.00	pendiente	1017
4274	FAC-2024-03-1257	501	\N	2024-03-06 00:00:00	54150.00	pagada	30
4453	FAC-2024-01-1436	426	\N	2024-01-02 00:00:00	36100.00	pagada	56
4508	FAC-2023-01-1491	104	\N	2023-01-02 00:00:00	27300.00	pagada	109
4199	FAC-2023-05-1182	223	\N	2023-05-31 00:00:00	57400.00	pagada	322
4031	FAC-2024-11-1014	38	\N	2024-11-27 00:00:00	68500.00	pendiente	796
4502	FAC-2025-05-1485	144	\N	2025-05-13 00:00:00	48600.00	pagada	964
4461	FAC-2022-12-1444	122	\N	2022-12-27 00:00:00	23600.00	pagada	675
4229	FAC-2024-05-1212	120	\N	2024-05-06 00:00:00	55550.00	pagada	574
4140	FAC-2025-09-1123	236	\N	2025-09-04 00:00:00	48600.00	pendiente	725
4250	FAC-2023-12-1233	485	\N	2023-12-09 00:00:00	34250.00	pagada	39
4081	FAC-2023-09-1064	103	\N	2023-09-06 00:00:00	48600.00	pendiente	856
4108	FAC-2025-10-1091	472	\N	2025-10-03 00:00:00	37950.00	pagada	885
4052	FAC-2023-06-1035	461	\N	2023-06-27 00:00:00	75450.00	pagada	813
4214	FAC-2022-12-1197	361	\N	2022-12-27 00:00:00	69900.00	pendiente	923
4426	FAC-2025-04-1409	22	\N	2025-04-16 00:00:00	68050.00	pendiente	879
4385	FAC-2023-03-1368	79	\N	2023-03-13 00:00:00	34250.00	pagada	509
4329	FAC-2023-01-1312	346	\N	2023-01-10 00:00:00	48600.00	pagada	780
4466	FAC-2025-09-1449	151	\N	2025-09-09 00:00:00	48600.00	pagada	167
4147	FAC-2023-01-1130	454	\N	2023-01-06 00:00:00	32400.00	pendiente	1031
4070	FAC-2025-08-1053	504	\N	2025-08-05 00:00:00	37950.00	pagada	619
4263	FAC-2024-06-1246	311	\N	2024-06-04 00:00:00	66650.00	pagada	192
4443	FAC-2025-10-1426	151	\N	2025-10-04 00:00:00	36100.00	pendiente	691
4133	FAC-2024-11-1116	147	\N	2024-11-30 00:00:00	54150.00	pagada	644
4268	FAC-2024-09-1251	112	\N	2024-09-18 00:00:00	48600.00	pendiente	551
4193	FAC-2023-05-1176	457	\N	2023-05-13 00:00:00	62950.00	pagada	146
4150	FAC-2023-05-1133	470	\N	2023-05-16 00:00:00	28700.00	pendiente	789
4134	FAC-2024-06-1117	11	\N	2024-06-16 00:00:00	61100.00	pendiente	835
4217	FAC-2025-10-1200	193	\N	2025-10-14 00:00:00	64800.00	pagada	29
4060	FAC-2022-12-1043	68	\N	2022-12-25 00:00:00	62950.00	pagada	851
4041	FAC-2025-08-1024	358	\N	2025-08-27 00:00:00	30550.00	pendiente	659
4360	FAC-2025-07-1343	366	\N	2025-07-13 00:00:00	30550.00	pagada	659
4465	FAC-2022-12-1448	22	\N	2022-12-09 00:00:00	43050.00	pagada	13
4482	FAC-2023-01-1465	90	\N	2023-01-23 00:00:00	50450.00	pagada	732
4040	FAC-2024-11-1023	405	\N	2024-11-16 00:00:00	25450.00	pagada	123
4215	FAC-2024-08-1198	60	\N	2024-08-22 00:00:00	29150.00	pagada	257
4059	FAC-2024-06-1042	425	\N	2024-06-19 00:00:00	43050.00	pendiente	1008
4358	FAC-2023-04-1341	487	\N	2023-04-01 00:00:00	48600.00	cancelada	941
4436	FAC-2025-08-1419	405	\N	2025-08-25 00:00:00	57400.00	pendiente	1039
4393	FAC-2024-04-1376	70	\N	2024-04-02 00:00:00	34250.00	pendiente	630
4392	FAC-2024-05-1375	71	\N	2024-05-27 00:00:00	55550.00	pagada	553
4209	FAC-2023-06-1192	1	\N	2023-06-21 00:00:00	34250.00	pendiente	750
4130	FAC-2025-02-1113	135	\N	2025-02-11 00:00:00	19900.00	pendiente	480
4171	FAC-2023-12-1154	271	\N	2023-12-17 00:00:00	71750.00	pendiente	798
4371	FAC-2023-04-1354	227	\N	2023-04-03 00:00:00	23600.00	pagada	321
4259	FAC-2023-11-1242	325	\N	2023-11-26 00:00:00	57400.00	pagada	666
4486	FAC-2025-04-1469	182	\N	2025-04-07 00:00:00	52300.00	pagada	621
4410	FAC-2025-08-1393	275	\N	2025-08-02 00:00:00	25450.00	pagada	441
4087	FAC-2025-02-1070	341	\N	2025-02-16 00:00:00	64800.00	pagada	816
4430	FAC-2023-02-1413	317	\N	2023-02-06 00:00:00	59250.00	pagada	690
4300	FAC-2024-11-1283	377	\N	2024-11-27 00:00:00	27300.00	pendiente	521
4186	FAC-2025-03-1169	384	\N	2025-03-05 00:00:00	59250.00	pendiente	188
4355	FAC-2023-06-1338	452	\N	2023-06-07 00:00:00	46750.00	pagada	450
4429	FAC-2025-07-1412	205	\N	2025-07-14 00:00:00	54150.00	pagada	541
4028	FAC-2023-03-1011	45	\N	2023-03-01 00:00:00	41200.00	pagada	925
4309	FAC-2023-07-1292	4	\N	2023-07-05 00:00:00	44900.00	pendiente	844
4148	FAC-2025-04-1131	188	\N	2025-04-06 00:00:00	37950.00	pagada	129
4113	FAC-2023-05-1096	94	\N	2023-05-17 00:00:00	36100.00	pendiente	773
4320	FAC-2024-08-1303	69	\N	2024-08-17 00:00:00	37950.00	pagada	1045
4438	FAC-2023-06-1421	110	\N	2023-06-09 00:00:00	59250.00	pendiente	455
4334	FAC-2022-12-1317	209	\N	2022-12-10 00:00:00	46750.00	pendiente	919
4312	FAC-2023-02-1295	489	\N	2023-02-13 00:00:00	23600.00	pendiente	989
4247	FAC-2023-09-1230	430	\N	2023-09-19 00:00:00	21750.00	pendiente	624
4170	FAC-2024-10-1153	4	\N	2024-10-01 00:00:00	23600.00	pagada	98
4285	FAC-2024-12-1268	376	\N	2024-12-20 00:00:00	34250.00	pagada	224
4235	FAC-2024-03-1218	354	\N	2024-03-28 00:00:00	48600.00	pendiente	626
4135	FAC-2023-01-1118	156	\N	2023-01-17 00:00:00	44900.00	pendiente	541
4084	FAC-2024-11-1067	127	\N	2024-11-18 00:00:00	37950.00	pagada	620
4308	FAC-2023-04-1291	426	\N	2023-04-06 00:00:00	27300.00	pagada	604
4126	FAC-2024-06-1109	95	\N	2024-06-16 00:00:00	43050.00	pendiente	489
4101	FAC-2024-04-1084	391	\N	2024-04-19 00:00:00	48600.00	pendiente	645
4412	FAC-2025-01-1395	27	\N	2025-01-13 00:00:00	23600.00	pagada	822
4174	FAC-2023-12-1157	153	\N	2023-12-01 00:00:00	57400.00	pagada	643
4387	FAC-2023-08-1370	197	\N	2023-08-19 00:00:00	36100.00	pagada	618
4342	FAC-2023-06-1325	457	\N	2023-06-26 00:00:00	36100.00	pendiente	114
4361	FAC-2024-08-1344	495	\N	2024-08-31 00:00:00	55550.00	pendiente	696
4230	FAC-2023-05-1213	236	\N	2023-05-13 00:00:00	23600.00	pendiente	860
4380	FAC-2025-03-1363	73	\N	2025-03-20 00:00:00	36100.00	pagada	890
4237	FAC-2025-01-1220	332	\N	2025-01-19 00:00:00	59250.00	pagada	127
4302	FAC-2024-04-1285	143	\N	2024-04-24 00:00:00	50450.00	pagada	960
4281	FAC-2023-05-1264	19	\N	2023-05-19 00:00:00	62950.00	pendiente	674
4469	FAC-2024-12-1452	65	\N	2024-12-06 00:00:00	36100.00	pagada	719
4118	FAC-2024-05-1101	467	\N	2024-05-19 00:00:00	62950.00	pagada	788
4341	FAC-2024-01-1324	370	\N	2024-01-04 00:00:00	37950.00	pagada	818
4178	FAC-2025-04-1161	436	\N	2025-04-08 00:00:00	34250.00	pendiente	360
4494	FAC-2025-08-1477	468	\N	2025-08-07 00:00:00	32400.00	pagada	775
4510	FAC-2025-07-1493	342	\N	2025-07-21 00:00:00	75450.00	pagada	541
4411	FAC-2025-01-1394	14	\N	2025-01-05 00:00:00	27300.00	pagada	568
4475	FAC-2023-02-1458	230	\N	2023-02-14 00:00:00	62950.00	pagada	168
4467	FAC-2024-01-1450	292	\N	2024-01-01 00:00:00	36100.00	pagada	919
4368	FAC-2023-11-1351	99	\N	2023-11-08 00:00:00	61100.00	pendiente	318
4343	FAC-2023-09-1326	194	\N	2023-09-04 00:00:00	25450.00	pagada	861
4200	FAC-2024-05-1183	482	\N	2024-05-03 00:00:00	62950.00	pagada	998
4127	FAC-2024-01-1110	51	\N	2024-01-25 00:00:00	73600.00	pendiente	738
4492	FAC-2023-06-1475	47	\N	2023-06-11 00:00:00	64800.00	pendiente	704
4379	FAC-2023-11-1362	39	\N	2023-11-30 00:00:00	61100.00	pagada	986
4086	FAC-2023-07-1069	489	\N	2023-07-23 00:00:00	50450.00	pagada	520
4515	FAC-2023-03-1498	271	\N	2023-03-28 00:00:00	44900.00	pendiente	112
4428	FAC-2023-05-1411	498	\N	2023-05-09 00:00:00	29150.00	pagada	691
4280	FAC-2024-03-1263	223	\N	2024-03-17 00:00:00	39800.00	pagada	76
4074	FAC-2024-04-1057	62	\N	2024-04-07 00:00:00	25450.00	cancelada	820
4391	FAC-2024-01-1374	12	\N	2024-01-06 00:00:00	57400.00	pendiente	618
4498	FAC-2024-09-1481	260	\N	2024-09-12 00:00:00	48600.00	pendiente	558
4157	FAC-2024-10-1140	335	\N	2024-10-27 00:00:00	57400.00	pendiente	68
4322	FAC-2024-09-1305	143	\N	2024-09-07 00:00:00	23600.00	pagada	431
4096	FAC-2024-07-1079	438	\N	2024-07-09 00:00:00	16200.00	pendiente	366
4377	FAC-2025-06-1360	74	\N	2025-06-21 00:00:00	48600.00	pendiente	958
4103	FAC-2024-03-1086	75	\N	2024-03-07 00:00:00	62950.00	pendiente	967
4287	FAC-2023-08-1270	379	\N	2023-08-17 00:00:00	57400.00	pagada	519
4261	FAC-2023-09-1244	278	\N	2023-09-12 00:00:00	54150.00	pagada	899
4152	FAC-2023-04-1135	417	\N	2023-04-19 00:00:00	61100.00	pagada	237
4121	FAC-2024-09-1104	220	\N	2024-09-15 00:00:00	75450.00	pendiente	593
4143	FAC-2025-08-1126	395	\N	2025-08-11 00:00:00	71750.00	pagada	235
4389	FAC-2023-12-1372	221	\N	2023-12-22 00:00:00	23600.00	pendiente	878
4049	FAC-2023-03-1032	351	\N	2023-03-02 00:00:00	71750.00	pagada	573
4149	FAC-2022-11-1132	282	\N	2022-11-23 00:00:00	61100.00	pagada	544
4225	FAC-2025-08-1208	427	\N	2025-08-26 00:00:00	37950.00	pagada	382
4194	FAC-2024-12-1177	367	\N	2024-12-21 00:00:00	21750.00	pagada	854
4220	FAC-2024-04-1203	174	\N	2024-04-08 00:00:00	46750.00	pendiente	269
4065	FAC-2023-03-1048	330	\N	2023-03-26 00:00:00	50450.00	pagada	607
4181	FAC-2024-06-1164	74	\N	2024-06-17 00:00:00	37950.00	pagada	8
4463	FAC-2023-06-1446	366	\N	2023-06-09 00:00:00	59250.00	pagada	217
4293	FAC-2025-01-1276	466	\N	2025-01-15 00:00:00	23600.00	pendiente	347
4402	FAC-2025-02-1385	260	\N	2025-02-25 00:00:00	37950.00	pagada	439
4256	FAC-2024-11-1239	174	\N	2024-11-16 00:00:00	37950.00	pagada	126
4141	FAC-2024-01-1124	104	\N	2024-01-14 00:00:00	25450.00	pagada	9
4054	FAC-2023-05-1037	306	\N	2023-05-27 00:00:00	44900.00	pendiente	85
4311	FAC-2024-07-1294	163	\N	2024-07-14 00:00:00	61100.00	pagada	706
4082	FAC-2025-06-1065	442	\N	2025-06-04 00:00:00	39800.00	pagada	310
4400	FAC-2024-08-1383	498	\N	2024-08-28 00:00:00	50450.00	pagada	864
4315	FAC-2025-07-1298	351	\N	2025-07-01 00:00:00	21750.00	pagada	152
4050	FAC-2023-03-1033	450	\N	2023-03-29 00:00:00	34250.00	pagada	1002
4455	FAC-2024-08-1438	122	\N	2024-08-06 00:00:00	79150.00	pagada	552
4109	FAC-2025-02-1092	89	\N	2025-02-19 00:00:00	30550.00	pagada	1054
4359	FAC-2025-04-1342	260	\N	2025-04-10 00:00:00	52300.00	pagada	901
4030	FAC-2023-12-1013	468	\N	2023-12-11 00:00:00	62950.00	pagada	923
4071	FAC-2023-10-1054	487	\N	2023-10-22 00:00:00	61100.00	pagada	981
4196	FAC-2023-04-1179	180	\N	2023-04-14 00:00:00	37950.00	pendiente	643
4055	FAC-2023-03-1038	121	\N	2023-03-02 00:00:00	75450.00	pagada	218
4459	FAC-2023-11-1442	460	\N	2023-11-15 00:00:00	75450.00	pagada	98
4415	FAC-2025-01-1398	462	\N	2025-01-01 00:00:00	29150.00	pendiente	842
4395	FAC-2025-08-1378	444	\N	2025-08-31 00:00:00	48600.00	pendiente	863
4173	FAC-2024-02-1156	221	\N	2024-02-01 00:00:00	56000.00	cancelada	486
4416	FAC-2022-12-1399	456	\N	2022-12-14 00:00:00	34250.00	pagada	333
4242	FAC-2025-07-1225	250	\N	2025-07-17 00:00:00	32400.00	pagada	385
4422	FAC-2024-12-1405	15	\N	2024-12-10 00:00:00	48600.00	pagada	751
4216	FAC-2023-11-1199	165	\N	2023-11-10 00:00:00	36100.00	pagada	964
4151	FAC-2023-03-1134	236	\N	2023-03-04 00:00:00	46750.00	pendiente	529
4490	FAC-2025-07-1473	106	\N	2025-07-18 00:00:00	36100.00	pagada	434
4313	FAC-2025-04-1296	156	\N	2025-04-12 00:00:00	16200.00	cancelada	884
4433	FAC-2023-10-1416	402	\N	2023-10-19 00:00:00	34250.00	pagada	52
4046	FAC-2024-02-1029	342	\N	2024-02-21 00:00:00	64800.00	pagada	268
4487	FAC-2023-03-1470	42	\N	2023-03-01 00:00:00	44900.00	pagada	362
4155	FAC-2024-04-1138	238	\N	2024-04-30 00:00:00	61100.00	pagada	1031
4064	FAC-2023-04-1047	414	\N	2023-04-13 00:00:00	79150.00	pendiente	284
4305	FAC-2025-07-1288	345	\N	2025-07-04 00:00:00	62950.00	pendiente	31
4094	FAC-2023-11-1077	227	\N	2023-11-13 00:00:00	62950.00	pagada	116
4275	FAC-2024-04-1258	12	\N	2024-04-02 00:00:00	48600.00	pagada	737
4073	FAC-2024-07-1056	201	\N	2024-07-03 00:00:00	46750.00	pagada	914
4381	FAC-2022-12-1364	202	\N	2022-12-10 00:00:00	30550.00	pagada	354
4303	FAC-2023-10-1286	317	\N	2023-10-25 00:00:00	34250.00	pagada	717
4432	FAC-2023-01-1415	329	\N	2023-01-14 00:00:00	46750.00	pendiente	497
4264	FAC-2025-10-1247	43	\N	2025-10-28 00:00:00	34250.00	pagada	257
4114	FAC-2024-02-1097	3	\N	2024-02-29 00:00:00	50450.00	pagada	441
4441	FAC-2025-04-1424	324	\N	2025-04-02 00:00:00	43050.00	pagada	724
4257	FAC-2022-12-1240	111	\N	2022-12-30 00:00:00	59250.00	pagada	813
4403	FAC-2024-05-1386	3	\N	2024-05-02 00:00:00	55550.00	pendiente	962
4291	FAC-2023-02-1274	177	\N	2023-02-19 00:00:00	34250.00	pendiente	425
4276	FAC-2023-02-1259	464	\N	2023-02-27 00:00:00	30550.00	pagada	357
4450	FAC-2024-03-1433	397	\N	2024-03-05 00:00:00	36100.00	pendiente	928
4290	FAC-2024-08-1273	124	\N	2024-08-25 00:00:00	32400.00	pagada	553
4445	FAC-2024-05-1428	71	\N	2024-05-19 00:00:00	59250.00	pagada	389
4349	FAC-2025-08-1332	97	\N	2025-08-28 00:00:00	73600.00	pendiente	887
4032	FAC-2023-07-1015	256	\N	2023-07-25 00:00:00	71750.00	pagada	849
4110	FAC-2023-08-1093	367	\N	2023-08-01 00:00:00	46750.00	pagada	654
4125	FAC-2023-09-1108	429	\N	2023-09-11 00:00:00	34250.00	pagada	667
4267	FAC-2023-03-1250	240	\N	2023-03-29 00:00:00	34250.00	pagada	1036
4112	FAC-2025-11-1095	186	\N	2025-11-18 00:00:00	19900.00	pagada	226
4365	FAC-2023-10-1348	281	\N	2023-10-10 00:00:00	44900.00	pendiente	990
4238	FAC-2023-12-1221	354	\N	2023-12-08 00:00:00	34250.00	pendiente	710
4129	FAC-2025-02-1112	112	\N	2025-02-07 00:00:00	59250.00	pendiente	872
4324	FAC-2023-02-1307	167	\N	2023-02-02 00:00:00	57400.00	cancelada	72
4431	FAC-2025-04-1414	128	\N	2025-04-24 00:00:00	59250.00	pendiente	749
4273	FAC-2024-11-1256	427	\N	2024-11-20 00:00:00	62950.00	pagada	16
4509	FAC-2024-05-1492	205	\N	2024-05-02 00:00:00	54150.00	pagada	899
4179	FAC-2025-01-1162	153	\N	2025-01-28 00:00:00	37950.00	cancelada	849
4295	FAC-2022-12-1278	425	\N	2022-12-18 00:00:00	30550.00	cancelada	770
4232	FAC-2024-09-1215	38	\N	2024-09-10 00:00:00	52300.00	pendiente	21
4249	FAC-2022-12-1232	11	\N	2022-12-22 00:00:00	73600.00	pagada	293
4236	FAC-2023-12-1219	127	\N	2023-12-13 00:00:00	50450.00	pagada	648
4484	FAC-2025-11-1467	270	\N	2025-11-04 00:00:00	50450.00	pagada	832
4319	FAC-2024-07-1302	151	\N	2024-07-06 00:00:00	41200.00	pagada	336
4418	FAC-2025-10-1401	408	\N	2025-10-29 00:00:00	50450.00	pendiente	526
4496	FAC-2024-07-1479	251	\N	2024-07-03 00:00:00	61100.00	pendiente	794
4243	FAC-2023-08-1226	488	\N	2023-08-31 00:00:00	46750.00	pendiente	972
4100	FAC-2024-02-1083	106	\N	2024-02-03 00:00:00	36100.00	pagada	93
4458	FAC-2023-05-1441	371	\N	2023-05-02 00:00:00	37950.00	cancelada	954
4405	FAC-2024-02-1388	111	\N	2024-02-09 00:00:00	64800.00	pagada	915
4260	FAC-2024-04-1243	317	\N	2024-04-20 00:00:00	61100.00	pagada	894
4493	FAC-2024-10-1476	300	\N	2024-10-19 00:00:00	52300.00	pagada	143
4434	FAC-2025-02-1417	268	\N	2025-02-21 00:00:00	66650.00	pagada	740
4413	FAC-2024-05-1396	404	\N	2024-05-21 00:00:00	50450.00	cancelada	807
4033	FAC-2024-10-1016	10	\N	2024-10-20 00:00:00	32400.00	pendiente	721
4195	FAC-2025-01-1178	252	\N	2025-01-28 00:00:00	61100.00	pagada	378
4471	FAC-2023-03-1454	234	\N	2023-03-17 00:00:00	39800.00	pendiente	867
4163	FAC-2024-06-1146	198	\N	2024-06-15 00:00:00	57400.00	pendiente	914
4021	FAC-2025-06-1004	179	\N	2025-06-18 00:00:00	36100.00	pendiente	482
4396	FAC-2023-08-1379	239	\N	2023-08-16 00:00:00	77300.00	pendiente	233
4495	FAC-2025-05-1478	118	\N	2025-05-03 00:00:00	59250.00	pendiente	547
4325	FAC-2025-02-1308	302	\N	2025-02-09 00:00:00	23600.00	pagada	642
4122	FAC-2024-03-1105	455	\N	2024-03-21 00:00:00	34250.00	pagada	777
4318	FAC-2023-06-1301	389	\N	2023-06-22 00:00:00	61100.00	pagada	178
4454	FAC-2024-07-1437	455	\N	2024-07-23 00:00:00	50450.00	pagada	350
4279	FAC-2025-05-1262	256	\N	2025-05-31 00:00:00	77300.00	pendiente	300
4266	FAC-2024-05-1249	433	\N	2024-05-05 00:00:00	66650.00	pagada	184
4219	FAC-2023-10-1202	72	\N	2023-10-05 00:00:00	77300.00	pendiente	275
4440	FAC-2024-03-1423	265	\N	2024-03-15 00:00:00	32400.00	pagada	680
4098	FAC-2025-05-1081	141	\N	2025-05-07 00:00:00	48600.00	pagada	90
4254	FAC-2025-04-1237	9	\N	2025-04-10 00:00:00	37950.00	pagada	869
4346	FAC-2023-04-1329	327	\N	2023-04-21 00:00:00	62950.00	pagada	833
4187	FAC-2023-08-1170	339	\N	2023-08-25 00:00:00	55550.00	pagada	889
4240	FAC-2024-11-1223	59	\N	2024-11-26 00:00:00	59250.00	pagada	580
4069	FAC-2025-08-1052	4	\N	2025-08-15 00:00:00	48600.00	pagada	732
4106	FAC-2024-12-1089	150	\N	2024-12-23 00:00:00	44900.00	pagada	254
4172	FAC-2023-09-1155	189	\N	2023-09-04 00:00:00	34250.00	pendiente	454
4136	FAC-2023-06-1119	411	\N	2023-06-30 00:00:00	75450.00	pagada	333
4131	FAC-2024-08-1114	99	\N	2024-08-05 00:00:00	50450.00	pagada	137
4119	FAC-2024-06-1102	280	\N	2024-06-08 00:00:00	61100.00	pendiente	1029
4516	FAC-2022-12-1499	42	\N	2022-12-18 00:00:00	43050.00	pagada	834
4228	FAC-2023-03-1211	440	\N	2023-03-14 00:00:00	37950.00	pagada	317
4212	FAC-2025-09-1195	38	\N	2025-09-12 00:00:00	50450.00	pagada	855
4245	FAC-2024-06-1228	241	\N	2024-06-29 00:00:00	39800.00	pagada	860
4352	FAC-2024-06-1335	231	\N	2024-06-04 00:00:00	50450.00	pagada	272
4211	FAC-2023-03-1194	85	\N	2023-03-08 00:00:00	54150.00	pagada	1013
4185	FAC-2023-04-1168	70	\N	2023-04-06 00:00:00	41650.00	pagada	511
4310	FAC-2022-12-1293	177	\N	2022-12-26 00:00:00	73600.00	pagada	730
4408	FAC-2025-01-1391	440	\N	2025-01-30 00:00:00	69900.00	pagada	512
4477	FAC-2022-12-1460	145	\N	2022-12-07 00:00:00	41200.00	pagada	509
4338	FAC-2022-12-1321	145	\N	2022-12-19 00:00:00	21750.00	pagada	296
4198	FAC-2023-09-1181	24	\N	2023-09-11 00:00:00	21750.00	pagada	284
4331	FAC-2022-12-1314	444	\N	2022-12-07 00:00:00	46750.00	pendiente	970
4472	FAC-2025-05-1455	287	\N	2025-05-14 00:00:00	34250.00	pagada	517
4383	FAC-2025-10-1366	475	\N	2025-10-18 00:00:00	62950.00	pagada	661
4224	FAC-2024-06-1207	397	\N	2024-06-13 00:00:00	23600.00	pagada	953
4447	FAC-2025-05-1430	316	\N	2025-05-22 00:00:00	75450.00	pendiente	164
4401	FAC-2023-04-1384	416	\N	2023-04-10 00:00:00	59250.00	pagada	228
4399	FAC-2025-01-1382	454	\N	2025-01-19 00:00:00	32400.00	pagada	509
4503	FAC-2024-09-1486	48	\N	2024-09-29 00:00:00	36100.00	pagada	56
4296	FAC-2025-01-1279	295	\N	2025-01-07 00:00:00	62950.00	pagada	81
4203	FAC-2023-03-1186	402	\N	2023-03-06 00:00:00	21750.00	pagada	204
4442	FAC-2024-06-1425	126	\N	2024-06-04 00:00:00	59250.00	pendiente	346
4097	FAC-2025-01-1080	200	\N	2025-01-04 00:00:00	36100.00	pendiente	964
4023	FAC-2023-12-1006	400	\N	2023-12-07 00:00:00	34250.00	pagada	686
4029	FAC-2023-05-1012	142	\N	2023-05-19 00:00:00	32400.00	pagada	199
4483	FAC-2025-09-1466	486	\N	2025-09-03 00:00:00	59250.00	pagada	319
4169	FAC-2025-01-1152	71	\N	2025-01-06 00:00:00	50450.00	pagada	755
4045	FAC-2025-04-1028	19	\N	2025-04-07 00:00:00	39800.00	pagada	1052
4092	FAC-2024-05-1075	341	\N	2024-05-16 00:00:00	34250.00	pagada	224
4414	FAC-2024-06-1397	98	\N	2024-06-28 00:00:00	46750.00	pagada	697
4489	FAC-2025-11-1472	97	\N	2025-11-19 00:00:00	43050.00	pendiente	619
4460	FAC-2023-02-1443	343	\N	2023-02-05 00:00:00	55550.00	cancelada	23
4180	FAC-2024-02-1163	248	\N	2024-02-19 00:00:00	44900.00	pagada	917
4488	FAC-2024-08-1471	198	\N	2024-08-12 00:00:00	46750.00	pagada	550
4292	FAC-2024-07-1275	203	\N	2024-07-22 00:00:00	79150.00	pagada	312
4513	FAC-2025-07-1496	262	\N	2025-07-26 00:00:00	27300.00	pagada	538
4083	FAC-2025-02-1066	450	\N	2025-02-14 00:00:00	73600.00	pagada	434
4437	FAC-2024-12-1420	259	\N	2024-12-13 00:00:00	19900.00	pagada	399
4226	FAC-2023-06-1209	26	\N	2023-06-05 00:00:00	37950.00	pagada	815
4340	FAC-2023-03-1323	241	\N	2023-03-06 00:00:00	62950.00	pagada	1006
4270	FAC-2023-12-1253	22	\N	2023-12-12 00:00:00	43050.00	pendiente	78
4053	FAC-2023-08-1036	400	\N	2023-08-19 00:00:00	64800.00	pendiente	189
4462	FAC-2024-05-1445	423	\N	2024-05-10 00:00:00	66650.00	pagada	389
4497	FAC-2025-06-1480	281	\N	2025-06-03 00:00:00	39800.00	pagada	678
4153	FAC-2025-09-1136	292	\N	2025-09-06 00:00:00	57400.00	pendiente	911
4231	FAC-2025-07-1214	146	\N	2025-07-18 00:00:00	50450.00	pagada	307
4205	FAC-2025-04-1188	485	\N	2025-04-18 00:00:00	34250.00	pagada	596
4404	FAC-2025-09-1387	409	\N	2025-09-17 00:00:00	66200.00	pagada	125
4382	FAC-2023-12-1365	360	\N	2023-12-12 00:00:00	55550.00	pagada	315
4072	FAC-2023-12-1055	297	\N	2023-12-25 00:00:00	37950.00	pagada	690
4165	FAC-2025-06-1148	26	\N	2025-06-05 00:00:00	23600.00	pagada	238
4233	FAC-2023-01-1216	333	\N	2023-01-15 00:00:00	71750.00	pendiente	291
4439	FAC-2023-09-1422	37	\N	2023-09-25 00:00:00	57400.00	pagada	202
4376	FAC-2023-11-1359	486	\N	2023-11-01 00:00:00	69900.00	pendiente	328
4077	FAC-2024-09-1060	239	\N	2024-09-27 00:00:00	34250.00	pendiente	601
4168	FAC-2025-10-1151	193	\N	2025-10-11 00:00:00	50450.00	pagada	338
4478	FAC-2024-02-1461	150	\N	2024-02-02 00:00:00	55550.00	pagada	276
4456	FAC-2023-04-1439	34	\N	2023-04-18 00:00:00	50450.00	pagada	134
4162	FAC-2023-12-1145	291	\N	2023-12-12 00:00:00	77300.00	pagada	747
4124	FAC-2024-01-1107	65	\N	2024-01-12 00:00:00	36100.00	pendiente	898
4505	FAC-2024-11-1488	95	\N	2024-11-02 00:00:00	59250.00	cancelada	71
4218	FAC-2023-06-1201	351	\N	2023-06-25 00:00:00	37950.00	pendiente	345
4339	FAC-2023-05-1322	306	\N	2023-05-22 00:00:00	34250.00	pagada	269
4075	FAC-2023-06-1058	234	\N	2023-06-30 00:00:00	46750.00	pagada	292
4026	FAC-2025-04-1009	295	\N	2025-04-07 00:00:00	52300.00	pendiente	853
4024	FAC-2023-11-1007	407	\N	2023-11-21 00:00:00	73600.00	pagada	652
4409	FAC-2023-06-1392	431	\N	2023-06-22 00:00:00	57400.00	pagada	1018
4397	FAC-2023-09-1380	373	\N	2023-09-07 00:00:00	79150.00	pagada	474
4088	FAC-2023-06-1071	477	\N	2023-06-17 00:00:00	36100.00	pagada	1017
4476	FAC-2024-01-1459	426	\N	2024-01-13 00:00:00	59250.00	pagada	416
4370	FAC-2025-07-1353	318	\N	2025-07-01 00:00:00	66650.00	pendiente	246
4337	FAC-2024-12-1320	486	\N	2024-12-27 00:00:00	48600.00	pagada	207
4335	FAC-2023-12-1318	403	\N	2023-12-22 00:00:00	36100.00	pendiente	315
4301	FAC-2023-01-1284	86	\N	2023-01-27 00:00:00	79150.00	pagada	574
4501	FAC-2024-08-1484	347	\N	2024-08-31 00:00:00	39800.00	pagada	934
4283	FAC-2025-07-1266	505	\N	2025-07-22 00:00:00	68050.00	pagada	797
4354	FAC-2024-06-1337	425	\N	2024-06-18 00:00:00	37950.00	pendiente	7
4090	FAC-2024-05-1073	252	\N	2024-05-08 00:00:00	59250.00	pendiente	873
4117	FAC-2022-12-1100	71	\N	2022-12-05 00:00:00	52300.00	pagada	468
4374	FAC-2024-06-1357	374	\N	2024-06-26 00:00:00	25450.00	pagada	643
4076	FAC-2023-08-1059	457	\N	2023-08-01 00:00:00	30550.00	pagada	917
4327	FAC-2023-05-1310	283	\N	2023-05-31 00:00:00	28700.00	pagada	1034
4107	FAC-2023-06-1090	276	\N	2023-06-22 00:00:00	30550.00	pagada	382
4372	FAC-2025-03-1355	78	\N	2025-03-16 00:00:00	59250.00	pendiente	47
4067	FAC-2023-07-1050	192	\N	2023-07-13 00:00:00	66650.00	pendiente	814
4286	FAC-2025-10-1269	60	\N	2025-10-27 00:00:00	75450.00	pagada	916
4468	FAC-2025-08-1451	340	\N	2025-08-30 00:00:00	59250.00	pendiente	477
4350	FAC-2025-10-1333	307	\N	2025-10-12 00:00:00	46750.00	pendiente	1009
4207	FAC-2022-12-1190	485	\N	2022-12-02 00:00:00	23600.00	pendiente	477
4251	FAC-2023-04-1234	492	\N	2023-04-11 00:00:00	81000.00	pagada	108
4423	FAC-2024-09-1406	28	\N	2024-09-10 00:00:00	77300.00	pagada	334
4042	FAC-2023-03-1025	438	\N	2023-03-08 00:00:00	37950.00	pagada	263
4063	FAC-2025-01-1046	110	\N	2025-01-07 00:00:00	59250.00	pendiente	303
4364	FAC-2025-03-1347	408	\N	2025-03-03 00:00:00	28700.00	pendiente	244
4146	FAC-2024-05-1129	198	\N	2024-05-16 00:00:00	32400.00	pendiente	605
4384	FAC-2023-02-1367	340	\N	2023-02-04 00:00:00	77300.00	pagada	797
4282	FAC-2023-02-1265	5	\N	2023-02-27 00:00:00	73600.00	pendiente	1028
4253	FAC-2024-08-1236	217	\N	2024-08-31 00:00:00	64800.00	pendiente	1042
4420	FAC-2024-09-1403	497	\N	2024-09-22 00:00:00	52300.00	pendiente	372
4227	FAC-2024-07-1210	76	\N	2024-07-31 00:00:00	48600.00	pagada	796
4057	FAC-2025-06-1040	59	\N	2025-06-17 00:00:00	39800.00	pendiente	599
4388	FAC-2024-07-1371	114	\N	2024-07-29 00:00:00	68050.00	pagada	131
4363	FAC-2024-02-1346	19	\N	2024-02-10 00:00:00	34250.00	pagada	64
4222	FAC-2024-03-1205	206	\N	2024-03-25 00:00:00	43050.00	pagada	363
4378	FAC-2025-01-1361	311	\N	2025-01-17 00:00:00	44900.00	pagada	1029
4080	FAC-2024-04-1063	310	\N	2024-04-25 00:00:00	59250.00	pagada	750
4089	FAC-2024-09-1072	440	\N	2024-09-23 00:00:00	48600.00	pagada	956
4177	FAC-2025-08-1160	448	\N	2025-08-25 00:00:00	69900.00	pagada	773
4366	FAC-2025-07-1349	387	\N	2025-07-29 00:00:00	75450.00	pagada	264
4244	FAC-2025-11-1227	64	\N	2025-11-10 00:00:00	43500.00	cancelada	217
4115	FAC-2025-04-1098	344	\N	2025-04-04 00:00:00	59250.00	pagada	141
4336	FAC-2024-10-1319	256	\N	2024-10-02 00:00:00	48600.00	pagada	194
4093	FAC-2024-02-1076	223	\N	2024-02-05 00:00:00	79150.00	pagada	181
4491	FAC-2023-05-1474	252	\N	2023-05-04 00:00:00	34250.00	pagada	795
4183	FAC-2025-04-1166	238	\N	2025-04-30 00:00:00	44900.00	pagada	1024
4328	FAC-2024-10-1311	431	\N	2024-10-22 00:00:00	46750.00	pagada	18
4444	FAC-2025-07-1427	123	\N	2025-07-27 00:00:00	50450.00	pagada	123
4330	FAC-2023-04-1313	55	\N	2023-04-30 00:00:00	75450.00	cancelada	554
4262	FAC-2023-05-1245	152	\N	2023-05-24 00:00:00	37950.00	pagada	482
4061	FAC-2025-08-1044	502	\N	2025-08-21 00:00:00	25450.00	pendiente	357
4375	FAC-2023-09-1358	130	\N	2023-09-19 00:00:00	23600.00	pagada	880
4043	FAC-2025-07-1026	503	\N	2025-07-06 00:00:00	75450.00	pagada	804
4039	FAC-2024-10-1022	136	\N	2024-10-21 00:00:00	79150.00	pendiente	528
4191	FAC-2023-06-1174	239	\N	2023-06-04 00:00:00	48600.00	pagada	652
4421	FAC-2025-02-1404	415	\N	2025-02-24 00:00:00	57400.00	pagada	1017
4345	FAC-2025-09-1328	127	\N	2025-09-13 00:00:00	27300.00	pagada	372
4213	FAC-2023-04-1196	86	\N	2023-04-14 00:00:00	25450.00	pendiente	935
4367	FAC-2024-02-1350	210	\N	2024-02-13 00:00:00	59250.00	pendiente	537
4514	FAC-2024-05-1497	171	\N	2024-05-19 00:00:00	62950.00	pendiente	702
4159	FAC-2024-07-1142	267	\N	2024-07-13 00:00:00	43050.00	pagada	1040
4272	FAC-2025-08-1255	423	\N	2025-08-27 00:00:00	39800.00	pagada	815
4297	FAC-2024-01-1280	245	\N	2024-01-01 00:00:00	75450.00	pagada	247
4145	FAC-2024-03-1128	402	\N	2024-03-13 00:00:00	62950.00	pagada	585
4353	FAC-2024-09-1336	410	\N	2024-09-27 00:00:00	39800.00	pagada	294
4132	FAC-2024-03-1115	45	\N	2024-03-09 00:00:00	37950.00	pagada	298
4184	FAC-2024-02-1167	137	\N	2024-02-29 00:00:00	75450.00	pagada	158
4158	FAC-2025-08-1141	416	\N	2025-08-30 00:00:00	48600.00	pendiente	930
4037	FAC-2023-02-1020	392	\N	2023-02-27 00:00:00	55550.00	pagada	821
4035	FAC-2024-03-1018	369	\N	2024-03-28 00:00:00	61100.00	pendiente	558
4518	F1763679447	364	\N	2025-11-20 16:57:27.753692	12.00	pagada	1
\.


--
-- TOC entry 5042 (class 0 OID 16656)
-- Dependencies: 230
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventario (id, codigo_producto, nombre, categoria_id, cantidad, precio_unitario, fecha_creacion, fecha_actualizacion) FROM stdin;
1	ACEITE-001	Aceite sintético 10W-40	1	50	25.00	2025-09-15 19:55:14.753539	2025-09-15 19:55:14.753539
2	FILTRO-001	Filtro de aceite universal	2	30	15.00	2025-09-15 19:55:14.753539	2025-09-15 19:55:14.753539
3	LLANTA-001	Llanta trasera 140/70-17	2	10	120.00	2025-09-15 19:55:14.753539	2025-09-15 19:55:14.753539
4	CADENA-001	Kit de cadena y sprockets	2	8	180.00	2025-09-15 19:55:14.753539	2025-09-15 19:55:14.753539
504	EQUIPO-2601	Equipo de Medición 3D Modelo 802-X	492	10	597.55	2025-10-23 21:11:30.259275	2025-10-23 21:11:30.259275
6	MOT-OIL-10W40-1L	Aceite Motul 5100 10W40 1L	5	24	180.00	2024-01-15 08:00:00	2024-06-15 14:30:00
7	MOT-OIL-20W50-1L	Aceite Repsol Moto Racing 20W50 1L	5	18	160.00	2024-01-16 09:15:00	2024-06-14 16:45:00
8	FIL-AIR-HIFLO-001	Filtro Aire HiFloSport HF112	7	12	85.00	2024-01-17 10:30:00	2024-06-13 11:20:00
9	FIL-OIL-KN-204	Filtro Aceite K&N KN-204	8	15	120.00	2024-01-18 11:45:00	2024-06-12 15:10:00
10	BUI-NGK-CR7E	Bujía NGK CR7E Standard	10	30	45.00	2024-01-19 13:20:00	2024-06-11 10:55:00
11	PAST-FREN-DEL-EBCC	Pastillas Freno Delantero EBC FA123	11	8	220.00	2024-01-20 14:35:00	2024-06-10 09:40:00
12	PAST-FREN-TRA-EPFA	Pastillas Freno Trasero Ferodo FDB419	12	10	190.00	2024-01-21 15:50:00	2024-06-09 13:25:00
13	CAD-DID-520VX	Cadena D.I.D 520VX2 O-Ring	16	6	850.00	2024-01-22 16:15:00	2024-06-08 17:30:00
14	SPROC-JT-40T	Sprocket Trasero JT 40 Dientes	17	9	180.00	2024-01-23 08:30:00	2024-06-07 12:15:00
15	NEUM-MIC-PIL-100-80	Neumático Michelin Pilot Street 100/80-17	18	4	650.00	2024-01-24 09:45:00	2024-06-06 14:50:00
16	NEUM-PIR-SC-140-70	Neumático Pirelli Sport Demon 140/70-17	19	3	890.00	2024-01-25 10:20:00	2024-06-05 16:35:00
17	BAT-YUASA-YTZ7S	Batería Yuasa YTZ7S Gel	21	7	680.00	2024-01-26 11:35:00	2024-06-04 10:20:00
18	AMORT-YSS-G310	Amortiguador Trasero YSS G310	23	5	1250.00	2024-01-27 12:40:00	2024-06-03 15:45:00
19	RET-HORQ-35MM	Retenes Horquilla 35mm NOK	25	20	35.00	2024-01-28 13:55:00	2024-06-02 11:30:00
20	JUNT-MOT-CB250	Kit Juntas Motor Honda CB250	27	3	450.00	2024-01-29 14:10:00	2024-06-01 14:15:00
21	PIST-YAM-66MM	Pistón Yamaha YBR 66mm Original	30	4	320.00	2024-01-30 15:25:00	2024-05-31 16:40:00
22	CARB-KEIHIN-28MM	Carburador Keihin 28mm PD28	42	6	580.00	2024-01-31 16:50:00	2024-05-30 09:55:00
23	INY-DENSO-150CC	Inyector Denso 150cc/min	44	8	420.00	2024-02-01 08:05:00	2024-05-29 13:10:00
24	BOM-GAS-BOSCH-044	Bomba Gasolina Bosch 044	45	5	780.00	2024-02-02 09:20:00	2024-05-28 15:25:00
25	FAR-H4-LED	Foco H4 LED 6000K	47	15	150.00	2024-02-03 10:35:00	2024-05-27 17:40:00
26	ESP-MAN-UNIV	Espejo Retrovisor Universal	51	12	85.00	2024-02-04 11:50:00	2024-05-26 08:55:00
27	MAN-ACEL-ASB	Manija Acelerador ASB	52	10	120.00	2024-02-05 12:15:00	2024-05-25 11:10:00
28	ESCAP-LEO-VINCE-SB	Escape LeoVince SBK	59	2	1850.00	2024-02-06 13:30:00	2024-05-24 14:25:00
29	SENS-O2-NTK	Sensor Oxígeno NTK OZA667	62	6	380.00	2024-02-07 14:45:00	2024-05-23 16:40:00
30	ALT-MIT-35A	Alternador Mitsubishi 35A	66	4	920.00	2024-02-08 15:00:00	2024-05-22 09:55:00
31	ARRA-DENSO-2800	Motor Arranque Denso 2800	67	3	680.00	2024-02-09 16:15:00	2024-05-21 12:10:00
32	BOB-ENC-DYN	Bobina Encendido Dyna	68	7	290.00	2024-02-10 08:30:00	2024-05-20 14:25:00
33	PORT-EQUI-GIVI	Portaequipajes Givi monolock	74	4	420.00	2024-02-11 09:45:00	2024-05-19 16:40:00
34	TOP-CASE-42L	Top Case 42 Litros Negro	76	3	650.00	2024-02-12 10:20:00	2024-05-18 08:55:00
35	GPS-RAM-MOUNT	Soporte GPS Ram Mount	77	8	180.00	2024-02-13 11:35:00	2024-05-17 11:10:00
36	ALAR-GORILLA-8017	Alarma Gorilla 8017	79	6	320.00	2024-02-14 12:50:00	2024-05-16 14:25:00
37	CAND-U-LOCK	Candado U-Lock Kryptonite	80	9	240.00	2024-02-15 13:15:00	2024-05-15 16:40:00
38	LUB-CAD-MAXIMA	Lubricante Cadena Maxima Chain Wax	82	25	95.00	2024-02-16 14:30:00	2024-05-14 09:55:00
39	ANTI-MOTUL-INU	Anticongelante Motul Inugel	83	20	75.00	2024-02-17 15:45:00	2024-05-13 12:10:00
40	LIM-INY-WYNN	Limpiador Inyectores Wynns	84	18	65.00	2024-02-18 16:00:00	2024-05-12 14:25:00
41	DEG-MOTUL-MC	Degrasante Motul Moto Clean	85	22	85.00	2024-02-19 08:15:00	2024-05-11 16:40:00
42	LLV-COM-1-2	Llave Combinada 1/2 10mm	87	15	25.00	2024-02-20 09:30:00	2024-05-10 08:55:00
43	TORQ-TEKTON-1-2	Torquímetro Tekton 1/2 40-200Nm	88	4	450.00	2024-02-21 10:45:00	2024-05-09 11:10:00
44	DEST-PHI-2	Destornillador Phillips #2	89	20	35.00	2024-02-22 11:20:00	2024-05-08 14:25:00
45	ALIC-CORT-6	Alicate Cortante 6"	90	12	45.00	2024-02-23 12:35:00	2024-05-07 16:40:00
46	KIT-HER-150PZ	Kit Herramientas 150 Piezas	91	3	1200.00	2024-02-24 13:50:00	2024-05-06 09:55:00
47	COMP-MOT-CP	Compresómetro CP-7820	95	2	380.00	2024-02-25 14:05:00	2024-05-05 12:10:00
48	MULT-FLUKE-101	Multímetro Digital Fluke 101	96	5	520.00	2024-02-26 15:20:00	2024-05-04 14:25:00
49	SCAN-AUTEL-MD802	Scanner Autel MD802	97	2	2850.00	2024-02-27 16:35:00	2024-05-03 16:40:00
50	CASO-SHOEI-RF1400	Casco Shoei RF-1400 Talla M	107	4	4850.00	2024-02-28 08:50:00	2024-05-02 09:55:00
51	GUANT-ALPINESTARS-SMX	Guantes Alpinestars SMX-2	111	8	650.00	2024-02-29 09:15:00	2024-05-01 12:10:00
52	CHAM-DAINESE-CARRO	Chamarra Dainese Carro Armor	112	5	1850.00	2024-03-01 10:30:00	2024-04-30 14:25:00
53	BOTAS-TCX-STREET	Botas TCX Street Ace	114	6	980.00	2024-03-02 11:45:00	2024-04-29 16:40:00
54	INTERCOM-SENA-20S	Intercomunicador Sena 20S	117	4	1250.00	2024-03-03 12:00:00	2024-04-28 08:55:00
55	ACEITE-FREN-DOT4	Aceite Frenos DOT4 Motul	119	16	110.00	2024-03-04 13:15:00	2024-04-27 11:10:00
56	GRAS-LITIO-MOLY	Grasa Litio Molykote	120	14	45.00	2024-03-05 14:30:00	2024-04-26 14:25:00
57	SELL-ROSC-LOCTITE	Sellador Roscas Loctite 577	123	25	85.00	2024-03-06 15:45:00	2024-04-25 16:40:00
58	TORN-6MM-1-25	Tornillos 6mm x 1.25	126	100	2.50	2024-03-07 16:10:00	2024-04-24 09:55:00
59	ABRA-MANGO-32-40	Abrazadera Manguera 32-40mm	127	50	8.00	2024-03-08 08:25:00	2024-04-23 12:10:00
60	ROD-RUEDA-6004	Rodamiento Rueda 6004-2RS	131	12	35.00	2024-03-09 09:40:00	2024-04-22 14:25:00
61	RES-SUSP-PROG	Resorte Suspensión Progressivo	135	4	320.00	2024-03-10 10:55:00	2024-04-21 16:40:00
62	MANG-FREN-STD	Manguito Freno Standard	138	8	45.00	2024-03-11 11:20:00	2024-04-20 08:55:00
63	CIL-MAES-NISSIN	Cilindro Maestro Nissin 14mm	140	6	280.00	2024-03-12 12:35:00	2024-04-19 11:10:00
64	SENS-ABS-FRNT	Sensor ABS Delantero	142	5	190.00	2024-03-13 13:50:00	2024-04-18 14:25:00
65	BUI-IRID-CR8EIX	Bujía Iridio NGK CR8EIX	144	15	95.00	2024-03-14 14:05:00	2024-04-17 16:40:00
66	CAB-BUJ-MAG-COR	Cable Bujía Magnacor	146	10	120.00	2024-03-15 15:20:00	2024-04-16 09:55:00
67	REG-VOL-SHINDENGEN	Regulador Voltaje Shindengen	148	7	180.00	2024-03-16 16:35:00	2024-04-15 12:10:00
68	BAT-LIT-SHK-12B	Batería Litio Shorai 12B	156	4	1250.00	2024-03-17 08:50:00	2024-04-14 14:25:00
69	CARG-BAT-CTEK	Cargador Batería CTEK	157	6	480.00	2024-03-18 09:15:00	2024-04-13 16:40:00
70	PORT-CEL-RAM-X	Porta Celular Ram X-Grip	161	10	220.00	2024-03-19 10:30:00	2024-04-12 08:55:00
71	SOP-GOPRO-CURV	Soporte GoPro Curvo	162	8	85.00	2024-03-20 11:45:00	2024-04-11 11:10:00
72	BOC-BOSCH-H3	Bocina Bosch H3	164	12	65.00	2024-03-21 12:00:00	2024-04-10 14:25:00
73	LUC-LED-AUX-4	Luces LED Auxiliares 4"	170	6	320.00	2024-03-22 13:15:00	2024-04-09 16:40:00
74	MOD-ABS-BOSCH	Módulo Control ABS Bosch	174	3	1850.00	2024-03-23 14:30:00	2024-04-08 09:55:00
75	SIST-INMOV-TRX	Sistema Inmovilizador TRX	178	4	420.00	2024-03-24 15:45:00	2024-04-07 12:10:00
76	PROT-MOT-SLIDER	Protector Motor Sliders	185	8	180.00	2024-03-25 16:10:00	2024-04-06 14:25:00
77	PROT-MAN-BAR-END	Protector Manubrio Bar End	186	15	45.00	2024-03-26 08:25:00	2024-04-05 16:40:00
78	REJ-RADI-ALU	Rejilla Radiador Aluminio	187	5	280.00	2024-03-27 09:40:00	2024-04-04 08:55:00
79	PROT-TANK-MAG	Protector Tanque Magnético	188	7	150.00	2024-03-28 10:55:00	2024-04-03 11:10:00
80	FUND-ASIENTO-GEL	Funda Asiento Gel Comfort	189	4	320.00	2024-03-29 11:20:00	2024-04-02 14:25:00
81	REP-AGUA-NANO	Repelente Agua Nanotecnología	190	10	95.00	2024-03-30 12:35:00	2024-04-01 16:40:00
82	CERAM-PINT-2STEP	Cerámico Pintura 2 Step	191	8	450.00	2024-03-31 13:50:00	2024-03-31 09:55:00
83	PUL-3M-ULTRA	Pulidor 3M Ultra Fine	192	12	85.00	2024-04-01 14:05:00	2024-03-30 12:10:00
84	CERA-MOTHERS	Cera Mothers Brazilian	193	15	120.00	2024-04-02 15:20:00	2024-03-29 14:25:00
85	LIM-LLAN-MEGUIARS	Limpiador Llantas Meguiars	194	18	75.00	2024-04-03 16:35:00	2024-03-28 16:40:00
86	LIM-CAD-KERO	Limpiador Cadena Kerosene	195	20	45.00	2024-04-04 08:50:00	2024-03-27 08:55:00
87	PROT-PLAST-BACK	Protector Plástico Back to Black	196	14	65.00	2024-04-05 09:15:00	2024-03-26 11:10:00
88	LIM-FREN-NONCHL	Limpiador Frenos Non-Chlor	197	16	55.00	2024-04-06 10:30:00	2024-03-25 14:25:00
89	DESENG-MOTUL-5L	Desengrasante Motul 5L	198	8	180.00	2024-04-07 11:45:00	2024-03-24 16:40:00
90	LUB-CAD-DRY	Lubricante Cadena Dry	199	22	110.00	2024-04-08 12:00:00	2024-03-23 09:55:00
91	SILIC-SPRAY-WD40	Spray Silicona WD40	200	25	45.00	2024-04-09 13:15:00	2024-03-22 12:10:00
92	ACE-PENET-KROIL	Aceite Penetrante Kroil	201	18	85.00	2024-04-10 14:30:00	2024-03-21 14:25:00
93	GRAS-COBRE-PERMAT	Grasa Cobre Permatex	202	12	65.00	2024-04-11 15:45:00	2024-03-20 16:40:00
94	GRAS-LIT-MOBIL	Grasa Litio Mobil	203	15	35.00	2024-04-12 16:10:00	2024-03-19 08:55:00
95	COMP-ASIENT-VALV	Compuesto Asientos Válvula	205	8	95.00	2024-04-13 08:25:00	2024-03-18 11:10:00
96	PASTE-FREN-CRC	Paste Antisqueal CRC	206	10	45.00	2024-04-14 09:40:00	2024-03-17 14:25:00
97	COMP-MONT-NEUM	Compuesto Montaje Neumáticos	207	14	55.00	2024-04-15 10:55:00	2024-03-16 16:40:00
98	SELL-NEUM-SLIME	Sellante Neumáticos Slime	208	12	120.00	2024-04-16 11:20:00	2024-03-15 09:55:00
99	ADIT-RADI-WATER	Aditivo Radiador Water Wetter	209	16	75.00	2024-04-17 12:35:00	2024-03-14 12:10:00
100	COND-GOMAS-GUMMY	Condicionador Gomas Gummi Pflege	210	20	65.00	2024-04-18 13:50:00	2024-03-13 14:25:00
101	DESM-NEUM-MAN	Desmontadora Neumáticos Manual	212	3	280.00	2024-04-19 14:05:00	2024-03-12 16:40:00
102	EQUI-RUEDA-BAL	Equilibradora Ruedas Manual	213	2	420.00	2024-04-20 15:20:00	2024-03-11 08:55:00
103	MED-PRES-DIG	Medidor Presión Digital	214	8	150.00	2024-04-21 16:35:00	2024-03-10 11:10:00
104	INFL-ELEC-12V	Inflador Eléctrico 12V	215	5	320.00	2024-04-22 08:50:00	2024-03-09 14:25:00
105	KIT-PAR-PINCH	Kit Parches Pinchazos	216	15	85.00	2024-04-23 09:15:00	2024-03-08 16:40:00
106	PARCH-NEUM-TIPO1	Parches Neumáticos Tipo 1	217	30	12.00	2024-04-24 10:30:00	2024-03-07 09:55:00
107	VALV-NEUM-ALUM	Válvulas Neumáticos Aluminio	218	25	15.00	2024-04-25 11:45:00	2024-03-06 12:10:00
108	TAPA-VALV-CHROME	Tapas Válvulas Cromadas	219	40	8.00	2024-04-26 12:00:00	2024-03-05 14:25:00
109	EXT-VALV-45DEG	Extensor Válvulas 45°	220	12	25.00	2024-04-27 13:15:00	2024-03-04 16:40:00
110	TRONCH-CAD-DID	Tronchadora Cadena D.I.D	222	2	180.00	2024-04-28 14:30:00	2024-03-03 08:55:00
111	REMACH-CAD-RK	Remachadora Cadena RK	223	2	220.00	2024-04-29 15:45:00	2024-03-02 11:10:00
112	MED-DESG-CAD	Medidor Desgaste Cadena	224	4	45.00	2024-04-30 16:10:00	2024-03-01 14:25:00
113	LAV-CAD-GRUNGE	Lavadora Cadena Grunge Brush	225	6	95.00	2024-05-01 08:25:00	2024-02-29 16:40:00
114	KIT-ENGR-CAD-MAX	Kit Engrase Cadena Maxima	226	8	120.00	2024-05-02 09:40:00	2024-02-28 09:55:00
115	COMP-SUSP-TYPE1	Compresor Suspensión Tipo 1	228	2	280.00	2024-05-03 10:55:00	2024-02-27 12:10:00
116	CALIB-VALV-MOT	Calibrador Válvulas Motor	230	3	65.00	2024-05-04 11:20:00	2024-02-26 14:25:00
117	GATO-SUSP-HYD	Gato Suspensión Hidráulico	231	2	420.00	2024-05-05 12:35:00	2024-02-25 16:40:00
118	EXT-PIST-TYPE2	Extractor Pistones Tipo 2	233	2	150.00	2024-05-06 13:50:00	2024-02-24 08:55:00
119	INS-PIST-PLAST	Insertador Pistones Plástico	234	3	85.00	2024-05-07 14:05:00	2024-02-23 11:10:00
120	TORQ-DIG-PREC	Torquímetro Digital Precisión	235	2	680.00	2024-05-08 15:20:00	2024-02-22 14:25:00
121	MIC-0-25MM	Micrómetro 0-25mm	237	3	220.00	2024-05-09 16:35:00	2024-02-21 16:40:00
122	CALIB-VERN-150	Calibrador Vernier 150mm	238	4	180.00	2024-05-10 08:50:00	2024-02-20 09:55:00
123	GALGA-ESP-001	Galga Espesores 0.01-1.0mm	239	5	45.00	2024-05-11 09:15:00	2024-02-19 12:10:00
124	IND-GOTA-MAG	Indicador Gota Magnético	240	3	120.00	2024-05-12 10:30:00	2024-02-18 14:25:00
125	COMP-ADV-ANALOG	Compresómetro Avanzado	241	2	520.00	2024-05-13 11:45:00	2024-02-17 16:40:00
126	VACU-CARB-TYPE1	Vacuómetro Carburadores	242	3	180.00	2024-05-14 12:00:00	2024-02-16 08:55:00
127	FLOW-INY-BOSCH	Flow Meter Inyectores Bosch	243	2	850.00	2024-05-15 13:15:00	2024-02-15 11:10:00
128	OSC-DIG-20MHZ	Osciloscopio Digital 20MHz	244	1	1850.00	2024-05-16 14:30:00	2024-02-14 14:25:00
129	GEN-SEÑ-TYPE2	Generador Señal Tipo 2	245	2	420.00	2024-05-17 15:45:00	2024-02-13 16:40:00
130	SIM-SENS-MAP	Simulador Sensor MAP	246	3	280.00	2024-05-18 16:10:00	2024-02-12 09:55:00
131	PROG-ECU-BAJAJ	Programador ECU Bajaj	247	2	1250.00	2024-05-19 08:25:00	2024-02-11 12:10:00
132	INTER-DIAG-OBD	Interface Diagnóstico OBD	248	3	380.00	2024-05-20 09:40:00	2024-02-10 14:25:00
133	SOFT-DIAG-TECH	Software Diagnóstico Tech	249	2	680.00	2024-05-21 10:55:00	2024-02-09 16:40:00
134	KIT-PRUEBA-GAS	Kit Prueba Combustible	250	4	150.00	2024-05-22 11:20:00	2024-02-08 08:55:00
135	MAN-GAS-DIG	Manómetro Combustible Digital	251	3	220.00	2024-05-23 12:35:00	2024-02-07 11:10:00
136	BOM-VAC-ELEC	Bomba Vacío Eléctrica	252	2	480.00	2024-05-24 13:50:00	2024-02-06 14:25:00
137	DET-FUGA-VAC	Detector Fugas Vacío	253	3	180.00	2024-05-25 14:05:00	2024-02-05 16:40:00
138	ESTET-MEC-SOUND	Estetoscopio Mecánico Sound	254	4	95.00	2024-05-26 15:20:00	2024-02-04 09:55:00
139	TERM-INFR-TEMP	Termómetro Infrarrojo Temp	255	3	320.00	2024-05-27 16:35:00	2024-02-03 12:10:00
140	ANEM-VEL-AIRE	Anemómetro Velocidad Aire	256	2	280.00	2024-05-28 08:50:00	2024-02-02 14:25:00
141	MAN-ACE-ANALOG	Manómetro Aceite Analógico	257	4	150.00	2024-05-29 09:15:00	2024-02-01 16:40:00
142	BAN-PRUE-MOT	Banco Prueba Motor	258	1	2850.00	2024-05-30 10:30:00	2024-01-31 08:55:00
143	PROB-BUI-ENC	Probador Bujías Encendido	259	3	180.00	2024-05-31 11:45:00	2024-01-30 11:10:00
144	PROB-ALT-VOLT	Probador Alternador Voltaje	260	2	220.00	2024-06-01 12:00:00	2024-01-29 14:25:00
145	PROB-ARRA-AMP	Probador Arranque Amperaje	261	2	280.00	2024-06-02 13:15:00	2024-01-28 16:40:00
146	PROB-BAT-CAP	Probador Batería Capacidad	262	3	320.00	2024-06-03 14:30:00	2024-01-27 09:55:00
147	ANAL-GAS-5GAS	Analizador Gases 5 Gases	263	1	4850.00	2024-06-04 15:45:00	2024-01-26 12:10:00
148	OPAC-DIES-OPM	Opacímetro Diesel OPM	264	1	1850.00	2024-06-05 16:10:00	2024-01-25 14:25:00
149	SIST-LIM-INY-ULT	Sistema Limpieza Inyectores Ultrasónico	265	1	1250.00	2024-06-06 08:25:00	2024-01-24 16:40:00
150	MAQ-ULT-2L	Máquina Ultrasonido 2L	266	2	850.00	2024-06-07 09:40:00	2024-01-23 08:55:00
151	LAV-PIEZ-20L	Lavadora Piezas 20L	267	1	1200.00	2024-06-08 10:55:00	2024-01-22 11:10:00
152	CEP-IND-ACERO	Cepillo Industrial Acero	268	10	25.00	2024-06-09 11:20:00	2024-01-21 14:25:00
153	PIST-VAP-1500W	Pistola Vapor 1500W	269	2	680.00	2024-06-10 12:35:00	2024-01-20 16:40:00
154	ASPI-IND-30L	Aspiradora Industrial 30L	270	2	850.00	2024-06-11 13:50:00	2024-01-19 09:55:00
155	ESTANT-MET-5NIV	Estantería Metálica 5 Niveles	272	3	980.00	2024-06-12 14:05:00	2024-01-18 12:10:00
156	CARRO-HER-3CAJ	Carro Herramientas 3 Cajones	273	2	1250.00	2024-06-13 15:20:00	2024-01-17 14:25:00
157	GAB-HER-8CAJ	Gabinetes Herramientas 8 Cajones	274	2	1850.00	2024-06-14 16:35:00	2024-01-16 16:40:00
158	ORG-TORN-64DIV	Organizador Tornillos 64 Divisiones	275	6	45.00	2024-06-15 08:50:00	2024-01-15 09:55:00
159	SIST-ETIQ-PRINT	Sistema Etiquetado Print	276	2	320.00	2024-06-16 09:15:00	2024-01-14 12:10:00
160	CONT-5L-PLAST	Contenedor 5L Plástico	277	12	35.00	2024-06-17 10:30:00	2024-01-13 14:25:00
161	BID-ACE-20L	Bidón Aceite 20L	278	8	85.00	2024-06-18 11:45:00	2024-01-12 16:40:00
162	EMB-FUN-500ML	Embudo 500ml Flexible	279	15	25.00	2024-06-19 12:00:00	2024-01-11 08:55:00
163	JERI-100ML-PLAST	Jeringa 100ml Plástico	280	20	15.00	2024-06-20 13:15:00	2024-01-10 11:10:00
164	BASC-DIG-50KG	Báscula Digital 50kg	281	2	280.00	2024-06-21 14:30:00	2024-01-09 14:25:00
165	DINO-MOT-EDDY	Dinamómetro Motor Eddy	282	1	48500.00	2024-06-22 15:45:00	2024-01-08 16:40:00
166	SIST-MED-POT-CHAS	Sistema Medición Potencia Chasis	283	1	12500.00	2024-06-23 16:10:00	2024-01-07 09:55:00
167	ANAL-COMB-EFIC	Analizador Combustión Eficiencia	284	1	2850.00	2024-06-24 08:25:00	2024-01-06 12:10:00
168	SIST-ADQ-DAT-16CH	Sistema Adquisición Datos 16 Canales	285	1	4850.00	2024-06-25 09:40:00	2024-01-05 14:25:00
169	CAM-INSP-8MM	Cámara Inspección 8mm	286	2	850.00	2024-06-26 10:55:00	2024-01-04 16:40:00
170	ENDOS-5M-6MM	Endoscopio 5m 6mm	287	1	1250.00	2024-06-27 11:20:00	2024-01-03 08:55:00
171	LUPA-INSP-10X	Lupa Inspección 10X	288	4	65.00	2024-06-28 12:35:00	2024-01-02 11:10:00
172	LAMP-TRAB-LED	Lámpara Trabajo LED	289	6	120.00	2024-06-29 13:50:00	2024-01-01 14:25:00
173	ESPE-INSP-EXT	Espejo Inspección Extensible	290	5	45.00	2024-06-30 14:05:00	2023-12-31 16:40:00
174	IMAN-RECUP-FLEX	Imán Recuperación Flexible	291	8	35.00	2024-07-01 15:20:00	2023-12-30 09:55:00
175	SOP-LIQ-10L	Soporte Líquidos 10L	292	10	25.00	2024-07-02 16:35:00	2023-12-29 12:10:00
176	BOM-TRANS-12V	Bomba Transferencia 12V	293	3	180.00	2024-07-03 08:50:00	2023-12-28 14:25:00
177	FIL-ACE-10MIC	Filtro Aceite 10 Micras	294	8	45.00	2024-07-04 09:15:00	2023-12-27 16:40:00
178	SEP-AGUA-AIRE	Separador Agua Aire	295	4	120.00	2024-07-05 10:30:00	2023-12-26 08:55:00
179	SEC-AIRE-REFRIG	Secador Aire Refrigerado	296	2	850.00	2024-07-06 11:45:00	2023-12-25 11:10:00
180	LUB-AIRE-AUTO	Lubricador Aire Automático	297	3	220.00	2024-07-07 12:00:00	2023-12-24 14:25:00
181	REG-AIRE-PREC	Regulador Aire Precisión	298	5	150.00	2024-07-08 13:15:00	2023-12-23 16:40:00
182	MANG-AIRE-10M	Manguera Aire 10m	299	8	85.00	2024-07-09 14:30:00	2023-12-22 09:55:00
183	ACOP-RAP-1-4	Acople Rápido 1/4"	300	15	25.00	2024-07-10 15:45:00	2023-12-21 12:10:00
184	PIST-AIRE-SOP	Pistola Aire Soplado	301	6	65.00	2024-07-11 16:10:00	2023-12-20 14:25:00
185	LLAV-NEUM-1-2	Llave Neumática 1/2"	302	3	680.00	2024-07-12 08:25:00	2023-12-19 16:40:00
186	LIJ-NEUM-ORB	Lijadora Neumática Orbital	303	2	420.00	2024-07-13 09:40:00	2023-12-18 08:55:00
187	TAL-NEUM-3-8	Taladro Neumático 3/8"	304	3	320.00	2024-07-14 10:55:00	2023-12-17 11:10:00
188	COMP-AIRE-50L	Compresor Aire 50L	307	2	1850.00	2024-07-15 11:20:00	2023-12-16 14:25:00
189	TAN-AIRE-100L	Tanque Aire 100L	308	1	850.00	2024-07-16 12:35:00	2023-12-15 16:40:00
190	PIST-PINT-HVLP	Pistola Pintura HVLP	306	3	480.00	2024-07-17 13:50:00	2023-12-14 09:55:00
191	SIST-FILT-PINT	Sistema Filtrado Pintura	309	2	320.00	2024-07-18 14:05:00	2023-12-13 12:10:00
192	CAB-PINT-PORT	Cabina Pintura Portátil	310	1	2850.00	2024-07-19 15:20:00	2023-12-12 14:25:00
193	SEC-PINT-IR	Secador Pintura Infrarrojo	311	1	1250.00	2024-07-20 16:35:00	2023-12-11 16:40:00
194	PUL-ELEC-7	Pulidora Eléctrica 7"	312	3	680.00	2024-07-21 08:50:00	2023-12-10 09:55:00
195	BUFF-ROTO-10	Buffer Rotatorio 10"	313	2	850.00	2024-07-22 09:15:00	2023-12-09 12:10:00
196	COMP-PUL-3ETAP	Compuesto Pulido 3 Etapas	314	8	95.00	2024-07-23 10:30:00	2023-12-08 14:25:00
197	LIJA-AGUA-2000	Lija Agua 2000 Grit	315	20	8.00	2024-07-24 11:45:00	2023-12-07 16:40:00
198	MASI-POLI-1KG	Masilla Poliéster 1kg	316	6	120.00	2024-07-25 12:00:00	2023-12-06 08:55:00
199	PRIM-EPOXI-1L	Primer Epóxi 1L	317	4	180.00	2024-07-26 13:15:00	2023-12-05 11:10:00
200	PINT-MOT-ALTA-TEMP	Pintura Moto Alta Temperatura	318	8	150.00	2024-07-27 14:30:00	2023-12-04 14:25:00
201	CLEAR-2K-1L	Clear Coat 2K 1L	319	5	220.00	2024-07-28 15:45:00	2023-12-03 16:40:00
202	DECAL-HONDA-OEM	Decal Honda OEM	320	12	45.00	2024-07-29 16:10:00	2023-12-02 09:55:00
203	KIT-PERS-GRAF	Kit Personalización Gráficos	321	4	320.00	2024-07-30 08:25:00	2023-12-01 12:10:00
204	ASIENT-CUSTOM-GEL	Asiento Custom Gel	322	3	680.00	2024-07-31 09:40:00	2023-11-30 14:25:00
205	MANUB-DEP-CLIP	Manubrio Deportivo Clip-On	323	6	180.00	2024-08-01 10:55:00	2023-11-29 16:40:00
206	PEGS-DEP-REUB	Pegs Deportivos Reubicables	324	8	120.00	2024-08-02 11:20:00	2023-11-28 08:55:00
207	LEVAS-CAMB-AJUS	Levas Cambio Ajustables	325	5	220.00	2024-08-03 12:35:00	2023-11-27 11:10:00
208	PEDAL-DEP-CNC	Pedales Deportivos CNC	326	4	280.00	2024-08-04 13:50:00	2023-11-26 14:25:00
209	ESCAP-DEP-FULL	Escape Deportivo Full System	327	2	2850.00	2024-08-05 14:05:00	2023-11-25 16:40:00
210	FIL-AIRE-HIFLO-SPORT	Filtro Aire HiFlo Sport	328	8	95.00	2024-08-06 15:20:00	2023-11-24 09:55:00
211	KIT-REL-CORTA	Kit Relación Corta	329	3	420.00	2024-08-07 16:35:00	2023-11-23 12:10:00
212	RADI-ALU-HI-PERF	Radiador Aluminio Alto Rendimiento	332	2	850.00	2024-08-08 08:50:00	2023-11-22 14:25:00
213	VENT-RADI-HI-FLOW	Ventilador Radiador Alto Flujo	333	4	180.00	2024-08-09 09:15:00	2023-11-21 16:40:00
214	TERM-RAP-OPEN	Termostato Apertura Rápida	334	6	120.00	2024-08-10 10:30:00	2023-11-20 08:55:00
215	BOM-GAS-HI-FLOW	Bomba Gasolina Alto Flujo	336	3	480.00	2024-08-11 11:45:00	2023-11-19 11:10:00
216	REG-PRES-AJUS	Regulador Presión Ajustable	337	5	220.00	2024-08-12 12:00:00	2023-11-18 14:25:00
217	RAIL-GAS-ALU	Rail Gasolina Aluminio	338	4	180.00	2024-08-13 13:15:00	2023-11-17 16:40:00
218	INY-HI-FLOW-240CC	Inyector Alto Flujo 240cc	339	6	320.00	2024-08-14 14:30:00	2023-11-16 09:55:00
219	SENS-WIDE-RANGE	Sensor Wide Range	340	4	280.00	2024-08-15 15:45:00	2023-11-15 12:10:00
220	ECU-PROG-STAND	ECU Programable Standalone	341	2	4850.00	2024-08-16 16:10:00	2023-11-14 14:25:00
221	KIT-TURBO-T25	Kit Turbo T25	342	1	8500.00	2024-08-17 08:25:00	2023-11-13 16:40:00
222	INTER-TURBO-ALUM	Intercooler Turbo Aluminio	344	2	1250.00	2024-08-18 09:40:00	2023-11-12 08:55:00
223	VALV-BLOW-OFF-TUR	Válvula Blow-Off Turbo	345	4	320.00	2024-08-19 10:55:00	2023-11-11 11:10:00
224	WASTEGATE-EXT	Wastegate Externa	346	3	680.00	2024-08-20 11:20:00	2023-11-10 14:25:00
225	BOOST-CONT-ELEC	Boost Controller Electrónico	347	2	850.00	2024-08-21 12:35:00	2023-11-09 16:40:00
226	SIST-INY-AGUA-MET	Sistema Inyección Agua/Metanol	348	1	1850.00	2024-08-22 13:50:00	2023-11-08 09:55:00
227	KIT-NOS-DRY-50HP	Kit NOS Dry 50HP	349	1	2850.00	2024-08-23 14:05:00	2023-11-07 12:10:00
228	SIST-ENC-MSL-IGN	Sistema Encendido MSD Ignition	350	2	1250.00	2024-08-24 15:20:00	2023-11-06 14:25:00
229	DIST-DEP-PERF	Distribuidor Deportivo Performance	351	3	480.00	2024-08-25 16:35:00	2023-11-05 16:40:00
230	AVAN-ENC-AJUS	Avanzador Encendido Ajustable	352	4	180.00	2024-08-26 08:50:00	2023-11-04 09:55:00
231	SIST-ADM-AIRE-FRIO	Sistema Admisión Aire Frío	353	3	680.00	2024-08-27 09:15:00	2023-11-03 12:10:00
232	COLEC-ADM-HI-FLOW	Colector Admisión Alto Flujo	354	4	320.00	2024-08-28 10:30:00	2023-11-02 14:25:00
233	BODY-MARI-42MM	Body Mariposa 42mm	355	3	420.00	2024-08-29 11:45:00	2023-11-01 16:40:00
234	HEADER-HI-FLOW-4-1	Header Alto Flujo 4-1	357	2	1250.00	2024-08-30 12:00:00	2023-10-31 08:55:00
235	SILEN-DEP-CARB	Silenciador Deportivo Carbono	359	4	680.00	2024-08-31 13:15:00	2023-10-30 11:10:00
236	SENS-O2-WIDE	Sensor O2 Wideband	361	3	480.00	2024-09-01 14:30:00	2023-10-29 14:25:00
237	VALV-EGR-DEL	Válvula EGR Delete	362	5	120.00	2024-09-02 15:45:00	2023-10-28 16:40:00
238	SIST-PCV-CATCH	Sistema PCV Catch Can	363	4	180.00	2024-09-03 16:10:00	2023-10-27 09:55:00
239	CANISTER-DEL	Canister Delete Kit	364	3	95.00	2024-09-04 08:25:00	2023-10-26 12:10:00
240	SENS-EVAP-PRES	Sensor EVAP Presión	365	4	150.00	2024-09-05 09:40:00	2023-10-25 14:25:00
241	EQUI-ALIN-LASER	Equipo Alineación Láser	367	1	4850.00	2024-09-06 10:55:00	2023-10-24 16:40:00
242	SIST-BAL-DINAM	Sistema Balanceo Dinámico	368	1	2850.00	2024-09-07 11:20:00	2023-10-23 08:55:00
243	MED-ANG-GIRO	Medidor Ángulo Giro	369	2	680.00	2024-09-08 12:35:00	2023-10-22 11:10:00
244	SIST-MED-CHAS-3D	Sistema Medición Chasis 3D	370	1	12500.00	2024-09-09 13:50:00	2023-10-21 14:25:00
245	HERR-CUAD-ESP	Herramientas Cuadro Especiales	371	3	320.00	2024-09-10 14:05:00	2023-10-20 16:40:00
246	SIST-ENDREZ-HID	Sistema Enderezado Hidráulico	372	1	8500.00	2024-09-11 15:20:00	2023-10-19 09:55:00
247	PUNT-ANCL-FIJ	Puntos Anclaje Fijos	373	8	45.00	2024-09-12 16:35:00	2023-10-18 12:10:00
248	SOP-MOT-AJUS	Soporte Motor Ajustable	374	3	280.00	2024-09-13 08:50:00	2023-10-17 14:25:00
249	POLIP-500KG	Polipasto 500kg	375	2	850.00	2024-09-14 09:15:00	2023-10-16 16:40:00
250	MESA-ELEV-HID	Mesa Elevadora Hidráulica	376	1	4850.00	2024-09-15 10:30:00	2023-10-15 08:55:00
251	SIST-SUJ-CAD	Sistema Sujeción Cadena	377	2	320.00	2024-09-16 11:45:00	2023-10-14 11:10:00
252	ROD-TRAB-ACER	Rodillos Trabajo Acero	378	6	85.00	2024-09-17 12:00:00	2023-10-13 14:25:00
253	PROT-PISO-EPOXI	Protección Piso Epóxi	379	4	180.00	2024-09-18 13:15:00	2023-10-12 16:40:00
254	SEÑ-SEG-PISO	Señalización Seguridad Piso	380	10	25.00	2024-09-19 14:30:00	2023-10-11 09:55:00
255	EXT-ABC-5KG	Extintor ABC 5kg	381	6	220.00	2024-09-20 15:45:00	2023-10-10 12:10:00
256	KIT-PRIM-AUX-50P	Kit Primeros Auxilios 50 Personas	382	2	480.00	2024-09-21 16:10:00	2023-10-09 14:25:00
257	EQUI-LIMP-PRES	Equipo Limpieza Presión	383	1	1250.00	2024-09-22 08:25:00	2023-10-08 16:40:00
258	SIST-VENT-EXT	Sistema Ventilación Extracción	384	1	2850.00	2024-09-23 09:40:00	2023-10-07 08:55:00
259	ILUM-LED-100W	Iluminación LED 100W	385	8	120.00	2024-09-24 10:55:00	2023-10-06 11:10:00
260	SIST-ENER-UPS	Sistema Energía UPS	386	2	1850.00	2024-09-25 11:20:00	2023-10-05 14:25:00
261	REGL-CONEX-8P	Regleta Conexión 8 Puertos	387	4	65.00	2024-09-26 12:35:00	2023-10-04 16:40:00
262	TRANS-220-110V	Transformador 220V a 110V	388	2	320.00	2024-09-27 13:50:00	2023-10-03 09:55:00
263	ESTAB-VOL-3000W	Estabilizador Voltaje 3000W	389	2	480.00	2024-09-28 14:05:00	2023-10-02 12:10:00
264	SIST-TIERRA-PROF	Sistema Tierra Profesional	390	1	850.00	2024-09-29 15:20:00	2023-10-01 14:25:00
265	EQUI-COM-RADIO	Equipo Comunicación Radio	391	4	220.00	2024-09-30 16:35:00	2023-09-30 16:40:00
266	SIST-GEST-TALL	Sistema Gestión Taller	392	1	4850.00	2024-10-01 08:50:00	2023-09-29 08:55:00
267	SOFT-TALL-PRO	Software Taller Profesional	393	1	2850.00	2024-10-02 09:15:00	2023-09-28 11:10:00
268	SIST-INV-AUTO	Sistema Inventario Automático	394	1	1850.00	2024-10-03 10:30:00	2023-09-27 14:25:00
269	EQUI-OFI-COMP	Equipo Oficina Computadora	395	3	6800.00	2024-10-04 11:45:00	2023-09-26 16:40:00
270	MOB-TALL-MET	Mobiliario Taller Metálico	396	5	850.00	2024-10-05 12:00:00	2023-09-25 09:55:00
271	EQUI-DESC-SILL	Equipo Descanso Sillas	397	8	320.00	2024-10-06 13:15:00	2023-09-24 12:10:00
272	SIST-CLIM-SPLIT	Sistema Climatización Split	398	2	4850.00	2024-10-07 14:30:00	2023-09-23 14:25:00
273	EQUI-LAV-PRES	Equipo Lavado Presión	399	1	2850.00	2024-10-08 15:45:00	2023-09-22 16:40:00
274	SIST-SEC-AIRE	Sistema Secado Aire	400	1	1250.00	2024-10-09 16:10:00	2023-09-21 08:55:00
275	PROD-DET-PRO	Productos Detailing Profesional	401	12	95.00	2024-10-10 08:25:00	2023-09-20 11:10:00
276	PUL-PRO-DUAL	Pulidora Profesional Dual Action	402	2	1250.00	2024-10-11 09:40:00	2023-09-19 14:25:00
277	SELL-PRO-CERAM	Sellador Profesional Cerámico	403	8	220.00	2024-10-12 10:55:00	2023-09-18 16:40:00
278	TRAT-PINT-NANO	Tratamiento Pintura Nanotecnología	404	6	180.00	2024-10-13 11:20:00	2023-09-17 09:55:00
279	REST-PLAST-PRO	Restaurador Plástico Profesional	405	10	65.00	2024-10-14 12:35:00	2023-09-16 12:10:00
280	TRAT-CUERO-COND	Tratamiento Cuero Condicionador	406	8	85.00	2024-10-15 13:50:00	2023-09-15 14:25:00
281	PROT-MET-ANTICOR	Protector Metal Anticorrosivo	407	12	45.00	2024-10-16 14:05:00	2023-09-14 16:40:00
282	RENOV-GOMA-BLACK	Renovador Goma Black	408	15	35.00	2024-10-17 15:20:00	2023-09-13 08:55:00
283	LIM-ALFOM-ESPUMA	Limpiador Alfombras Espuma	409	10	55.00	2024-10-18 16:35:00	2023-09-12 11:10:00
284	DESINF-SUP-BACT	Desinfectante Superficies Bactericida	410	8	65.00	2024-10-19 08:50:00	2023-09-11 14:25:00
285	AMBIENT-NEU-TALL	Ambientador Neutro Taller	411	12	25.00	2024-10-20 09:15:00	2023-09-10 16:40:00
286	PROD-MANT-INT	Productos Mantenimiento Interior	412	10	45.00	2024-10-21 10:30:00	2023-09-09 08:55:00
287	KIT-LIM-COMP	Kit Limpieza Completo	413	6	320.00	2024-10-22 11:45:00	2023-09-08 11:10:00
288	SIST-ALM-PROD-EST	Sistema Almacenamiento Productos Estantería	414	3	850.00	2024-10-23 12:00:00	2023-09-07 14:25:00
289	EXHIB-GON-ROT	Exhibidor Góndola Rotatorio	415	2	1250.00	2024-10-24 13:15:00	2023-09-06 16:40:00
290	MAT-POP-BANNER	Material POP Banner	416	8	85.00	2024-10-25 14:30:00	2023-09-05 09:55:00
291	SIST-ETIQ-PROD-DIG	Sistema Etiquetado Productos Digital	417	1	680.00	2024-10-26 15:45:00	2023-09-04 12:10:00
292	EMB-CAJ-CART	Embalaje Caja Cartón	418	50	12.00	2024-10-27 16:10:00	2023-09-03 14:25:00
293	MAT-SEG-MAN-PROD	Material Seguridad Manejo Productos	419	10	35.00	2024-10-28 08:25:00	2023-09-02 16:40:00
294	EQUI-TRANS-DOLY	Equipo Transporte Dolly	420	3	280.00	2024-10-29 09:40:00	2023-09-01 08:55:00
295	SIST-LOG-RAST	Sistema Logística Rastreo	421	1	1850.00	2024-10-30 10:55:00	2023-08-31 11:10:00
296	SOFT-VENT-POS	Software Ventas POS	422	1	2850.00	2024-10-31 11:20:00	2023-08-30 14:25:00
297	TERM-POS-TOUCH	Terminal POS Touch	423	2	1250.00	2024-11-01 12:35:00	2023-08-29 16:40:00
298	SIST-PAG-TPV	Sistema Pago TPV	424	1	850.00	2024-11-02 13:50:00	2023-08-28 09:55:00
299	EQUI-COB-EFECT	Equipo Cobro Efectivo	425	2	320.00	2024-11-03 14:05:00	2023-08-27 12:10:00
300	SIST-FID-CLIENT	Sistema Fidelización Clientes	426	1	1250.00	2024-11-04 15:20:00	2023-08-26 14:25:00
301	MAT-MER-FLYER	Material Mercadotecnia Flyer	427	100	5.00	2024-11-05 16:35:00	2023-08-25 16:40:00
302	SIST-ATEN-CLI-CALL	Sistema Atención Clientes Call Center	428	1	2850.00	2024-11-06 08:50:00	2023-08-24 08:55:00
303	EQUI-COM-CLI-TEL	Equipo Comunicación Clientes Teléfono	429	4	180.00	2024-11-07 09:15:00	2023-08-23 11:10:00
304	SIST-CITA-AUTO	Sistema Cita Automática	430	1	850.00	2024-11-08 10:30:00	2023-08-22 14:25:00
305	SOFT-AGEN-PROG	Software Agenda Programación	431	1	680.00	2024-11-09 11:45:00	2023-08-21 16:40:00
306	SIST-RECORD-SMS	Sistema Recordatorio SMS	432	1	480.00	2024-11-10 12:00:00	2023-08-20 08:55:00
307	EQUI-ENCU-TAB	Equipo Encuestas Tablet	433	2	1250.00	2024-11-11 13:15:00	2023-08-19 11:10:00
308	SIST-GARAN-DIG	Sistema Garantía Digital	434	1	850.00	2024-11-12 14:30:00	2023-08-18 14:25:00
309	SOFT-SERV-TEC	Software Servicio Técnico	435	1	1850.00	2024-11-13 15:45:00	2023-08-17 16:40:00
310	SIST-HIST-VEH	Sistema Historial Vehículos	436	1	1250.00	2024-11-14 16:10:00	2023-08-16 09:55:00
311	EQUI-DIAG-REM	Equipo Diagnóstico Remoto	437	1	2850.00	2024-11-15 08:25:00	2023-08-15 12:10:00
312	SIST-CONS-TEC-WEB	Sistema Consulta Técnica Web	438	1	850.00	2024-11-16 09:40:00	2023-08-14 14:25:00
313	BASE-DAT-TEC-PRO	Base Datos Técnica Profesional	439	1	1850.00	2024-11-17 10:55:00	2023-08-13 16:40:00
314	MAN-SERV-OEM	Manual Servicio OEM	440	5	320.00	2024-11-18 11:20:00	2023-08-12 08:55:00
315	DIAG-ELEC-WIR	Diagrama Eléctrico Wiring	441	8	85.00	2024-11-19 12:35:00	2023-08-11 11:10:00
316	ESQ-PART-EXP	Esquema Partes Explosionado	442	6	120.00	2024-11-20 13:50:00	2023-08-10 14:25:00
317	SOFT-DIAG-VIS	Software Diagramas Visual	443	1	680.00	2024-11-21 14:05:00	2023-08-09 16:40:00
318	SIST-ACT-AUTO	Sistema Actualización Automática	444	1	480.00	2024-11-22 15:20:00	2023-08-08 09:55:00
319	EQUI-CAP-PROY	Equipo Capacitación Proyector	445	1	2850.00	2024-11-23 16:35:00	2023-08-07 12:10:00
320	MAT-ENTR-MAN	Material Entrenamiento Manual	446	10	45.00	2024-11-24 08:50:00	2023-08-06 14:25:00
321	SIM-MOT-VIRT	Simulador Motor Virtual	447	1	4850.00	2024-11-25 09:15:00	2023-08-05 16:40:00
322	KIT-PRAC-DESM	Kit Práctica Desmontaje	448	3	850.00	2024-11-26 10:30:00	2023-08-04 08:55:00
323	SIST-EVAL-HAB	Sistema Evaluación Habilidades	449	1	1250.00	2024-11-27 11:45:00	2023-08-03 11:10:00
324	CERT-TEC-OFIC	Certificación Técnica Oficial	450	5	180.00	2024-11-28 12:00:00	2023-08-02 14:25:00
325	EQUI-DEM-TEC-MOT	Equipo Demostración Técnica Motor	451	1	2850.00	2024-11-29 13:15:00	2023-08-01 16:40:00
326	SIST-PRES-PANT	Sistema Presentación Pantalla	452	1	1850.00	2024-11-30 14:30:00	2023-07-31 08:55:00
327	MAT-REF-TEC-LIB	Material Referencia Técnica Libro	453	8	120.00	2024-12-01 15:45:00	2023-07-30 11:10:00
328	BIBL-TEC-DIG	Biblioteca Técnica Digital	454	1	850.00	2024-12-02 16:10:00	2023-07-29 14:25:00
329	SIST-CONS-RAP-APP	Sistema Consulta Rápida App	455	1	480.00	2024-12-03 08:25:00	2023-07-28 16:40:00
330	EQUI-MED-AVAN-CMM	Equipo Medición Avanzada CMM	456	1	48500.00	2024-12-04 09:40:00	2023-07-27 09:55:00
331	SIST-CALIB-PAT	Sistema Calibración Patrones	457	1	12500.00	2024-12-05 10:55:00	2023-07-26 12:10:00
332	PAT-REF-CER	Patrones Referencia Certificados	458	5	850.00	2024-12-06 11:20:00	2023-07-25 14:25:00
333	EQUI-METRO-PREC	Equipo Metrología Precisión	459	1	28500.00	2024-12-07 12:35:00	2023-07-24 16:40:00
334	SIST-TRAZ-MED	Sistema Trazabilidad Mediciones	460	1	8500.00	2024-12-08 13:50:00	2023-07-23 08:55:00
335	EQUI-CAL-INS	Equipo Calidad Inspección	461	1	1250.00	2024-12-09 14:05:00	2023-07-22 11:10:00
336	SIST-INS-VIS	Sistema Inspección Visual	462	1	2850.00	2024-12-10 15:20:00	2023-07-21 14:25:00
337	EQUI-PRUE-NDT-UT	Equipo Pruebas NDT Ultrasonido	463	1	4850.00	2024-12-11 16:35:00	2023-07-20 16:40:00
338	SIST-DOC-CAL-DIG	Sistema Documentación Calidad Digital	464	1	1850.00	2024-12-12 08:50:00	2023-07-19 08:55:00
339	SOFT-CAL-GEST	Software Calidad Gestión	465	1	2850.00	2024-12-13 09:15:00	2023-07-18 11:10:00
340	SIST-AUD-CAL-AUTO	Sistema Auditoría Calidad Automática	466	1	1250.00	2024-12-14 10:30:00	2023-07-17 14:25:00
341	EQUI-MED-AMB-TEMP	Equipo Medición Ambiental Temperatura	467	2	680.00	2024-12-15 11:45:00	2023-07-16 16:40:00
342	SIST-MON-COND-AMB	Sistema Monitoreo Condiciones Ambientales	468	1	1850.00	2024-12-16 12:00:00	2023-07-15 08:55:00
343	EQUI-SEG-IND-CAS	Equipo Seguridad Industrial Cascos	469	12	85.00	2024-12-17 13:15:00	2023-07-14 11:10:00
344	SIST-PRO-PER-EPP	Sistema Protección Personal EPP	470	10	120.00	2024-12-18 14:30:00	2023-07-13 14:25:00
345	EQUI-EMER-BOT	Equipo Emergencia Botiquín	471	4	320.00	2024-12-19 15:45:00	2023-07-12 16:40:00
346	SIST-ALAR-TALL-SEN	Sistema Alarma Taller Sensores	472	1	1250.00	2024-12-20 16:10:00	2023-07-11 09:55:00
347	EQUI-MON-SEG-CAM	Equipo Monitoreo Seguridad Cámaras	473	4	680.00	2024-12-21 08:25:00	2023-07-10 12:10:00
348	SIST-CONT-ACC-TAR	Sistema Control Acceso Tarjeta	474	1	1850.00	2024-12-22 09:40:00	2023-07-09 14:25:00
349	EQUI-COM-INT-RAD	Equipo Comunicación Interna Radio	475	6	220.00	2024-12-23 10:55:00	2023-07-08 16:40:00
350	SIST-GEST-TALL-INT	Sistema Gestión Taller Integral	476	1	4850.00	2024-12-24 11:20:00	2023-07-07 08:55:00
351	SOFT-PROD-KANBAN	Software Productividad Kanban	477	1	850.00	2024-12-25 12:35:00	2023-07-06 11:10:00
352	SIST-AUTO-PROCES	Sistema Automatización Procesos	478	1	12500.00	2024-12-26 13:50:00	2023-07-05 14:25:00
353	EQUI-DIG-ESC	Equipo Digitalización Escáner	479	1	2850.00	2024-12-27 14:05:00	2023-07-04 16:40:00
354	SIST-IOT-SENS	Sistema IoT Sensores	480	1	1850.00	2024-12-28 15:20:00	2023-07-03 08:55:00
355	EQUI-RA-GAFAS	Equipo Realidad Aumentada Gafas	481	2	4850.00	2024-12-29 16:35:00	2023-07-02 11:10:00
356	SIST-VIS-ART-CAM	Sistema Visión Artificial Cámara	482	1	8500.00	2024-12-30 08:50:00	2023-07-01 14:25:00
357	ROB-TALL-BRAZO	Robot Taller Brazo	483	1	48500.00	2024-12-31 09:15:00	2023-06-30 16:40:00
358	SIST-TRANS-AUTO-CIN	Sistema Transporte Automatizado Cinta	484	1	12500.00	2025-01-01 10:30:00	2023-06-29 08:55:00
359	EQUI-IMP-3D-RES	Equipo Impresión 3D Resina	485	1	28500.00	2025-01-02 11:45:00	2023-06-28 11:10:00
360	SIST-CAD-CAM-PRO	Sistema CAD/CAM Profesional	486	1	4850.00	2025-01-03 12:00:00	2023-06-27 14:25:00
361	SOFT-DIS-3D-CAD	Software Diseño 3D CAD	487	1	2850.00	2025-01-04 13:15:00	2023-06-26 16:40:00
362	EQUI-PROT-3D-PEN	Equipo Prototipado 3D Pen	488	2	850.00	2025-01-05 14:30:00	2023-06-25 09:55:00
363	SIST-PRUE-VIRT-SIM	Sistema Pruebas Virtual Simulación	489	1	12500.00	2025-01-06 15:45:00	2023-06-24 12:10:00
364	EQUI-ANAL-EST-FEM	Equipo Análisis Estructural FEM	490	1	28500.00	2025-01-07 16:10:00	2023-06-23 14:25:00
365	SIST-ING-REV-3D	Sistema Ingeniería Reversa 3D	491	1	18500.00	2025-01-08 08:25:00	2023-06-22 16:40:00
366	EQUI-MED-3D-ESC	Equipo Medición 3D Escáner	492	1	48500.00	2025-01-09 09:40:00	2023-06-21 08:55:00
367	SIST-DOC-3D-MOD	Sistema Documentación 3D Modelado	493	1	8500.00	2025-01-10 10:55:00	2023-06-20 11:10:00
368	SOFT-GEST-PROY-PRO	Software Gestión Proyectos Profesional	494	1	1850.00	2025-01-11 11:20:00	2023-06-19 14:25:00
369	SIST-COLAB-TEAM	Sistema Colaboración Team	495	1	850.00	2025-01-12 12:35:00	2023-06-18 16:40:00
370	EQUI-VID-CONF-PRO	Equipo Videoconferencia Profesional	496	1	2850.00	2025-01-13 13:50:00	2023-06-17 09:55:00
371	SIST-COMP-DAT-SEG	Sistema Compartición Datos Segura	497	1	1250.00	2025-01-14 14:05:00	2023-06-16 12:10:00
372	PLAT-CLOUD-TALL	Plataforma Cloud Taller	498	1	850.00	2025-01-15 15:20:00	2023-06-15 14:25:00
373	SIST-BACK-AUTO	Sistema Backup Automático	499	1	1250.00	2025-01-16 16:35:00	2023-06-14 16:40:00
374	EQUI-CIBER-SEG-FIRE	Equipo Ciberseguridad Firewall	500	1	2850.00	2025-01-17 08:50:00	2023-06-13 08:55:00
375	SIST-RED-PRO-SWITCH	Sistema Red Profesional Switch	501	1	1250.00	2025-01-18 09:15:00	2023-06-12 11:10:00
376	EQUI-TELECOM-PBX	Equipo Telecomunicaciones PBX	502	1	1850.00	2025-01-19 10:30:00	2023-06-11 14:25:00
377	SIST-ENER-UPS-PRO	Sistema Energía UPS Profesional	503	1	2850.00	2025-01-20 11:45:00	2023-06-10 16:40:00
378	EQUI-MANT-PREV-PRO	Equipo Mantenimiento Preventivo Profesional	504	1	1250.00	2025-01-21 12:00:00	2023-06-09 08:55:00
379	KIT-HER-ESP-MOT	Kit Herramientas Especiales Motor	92	3	850.00	2024-01-15 13:15:00	2024-06-15 15:30:00
380	EXTR-TORN-DAN- SET	Extractor Tornillos Dañados Set	93	2	320.00	2024-01-16 14:30:00	2024-06-14 16:45:00
381	PREN-ROD-10T	Prensa Rodamientos 10 Toneladas	94	1	1850.00	2024-01-17 15:45:00	2024-06-13 09:00:00
382	MED-HOLG-MOT-SET	Medidor Holguras Motor Set	236	2	180.00	2024-01-18 16:00:00	2024-06-12 10:15:00
383	IND-CARR-DIG	Indicador Carrera Digital	240	3	280.00	2024-01-19 08:15:00	2024-06-11 11:30:00
384	BAN-PRUE-COMP-ADV	Banco Prueba Compresión Avanzado	241	1	1250.00	2024-01-20 09:30:00	2024-06-10 12:45:00
385	VACU-CARB-PREC	Vacuómetro Carburadores Precisión	242	2	220.00	2024-01-21 10:45:00	2024-06-09 14:00:00
386	FLOW-INY-PRO	Flow Meter Inyectores Profesional	243	1	1250.00	2024-01-22 11:20:00	2024-06-08 15:15:00
387	OSC-DIG-100MHZ	Osciloscopio Digital 100MHz	244	1	4850.00	2024-01-23 12:35:00	2024-06-07 16:30:00
388	GEN-SEÑ-AUDIO	Generador Señal Audio	245	2	480.00	2024-01-24 13:50:00	2024-06-06 08:45:00
389	SIM-SENS-TPS	Simulador Sensor TPS	246	3	180.00	2024-01-25 14:05:00	2024-06-05 10:00:00
390	PROG-ECU-YAMAHA	Programador ECU Yamaha	247	1	2850.00	2024-01-26 15:20:00	2024-06-04 11:15:00
391	INTER-DIAG-MULT	Interface Diagnóstico Multimarca	248	2	850.00	2024-01-27 16:35:00	2024-06-03 12:30:00
392	SOFT-DIAG-ADV	Software Diagnóstico Avanzado	249	1	1250.00	2024-01-28 08:50:00	2024-06-02 13:45:00
393	KIT-PRUE-GAS-PRO	Kit Prueba Gasolina Profesional	250	2	320.00	2024-01-29 09:15:00	2024-06-01 15:00:00
394	MAN-GAS-ANALOG	Manómetro Gasolina Analógico	251	3	150.00	2024-01-30 10:30:00	2024-05-31 16:15:00
395	BOM-VAC-MAN	Bomba Vacío Manual	252	4	120.00	2024-01-31 11:45:00	2024-05-30 08:30:00
396	DET-FUGA-VAC-ULT	Detector Fugas Vacío Ultrasónico	253	2	480.00	2024-02-01 12:00:00	2024-05-29 09:45:00
397	ESTET-MEC-PRO	Estetoscopio Mecánico Profesional	254	3	180.00	2024-02-02 13:15:00	2024-05-28 11:00:00
398	TERM-INFR-PRO	Termómetro Infrarrojo Profesional	255	2	480.00	2024-02-03 14:30:00	2024-05-27 12:15:00
399	ANEM-VEL-PRO	Anemómetro Velocidad Profesional	256	1	680.00	2024-02-04 15:45:00	2024-05-26 13:30:00
400	MAN-ACE-DIG-PRO	Manómetro Aceite Digital Profesional	257	2	320.00	2024-02-05 16:10:00	2024-05-25 14:45:00
401	BAN-PRUE-ELEC	Banco Prueba Eléctrico	258	1	1850.00	2024-02-06 08:25:00	2024-05-24 16:00:00
402	PROB-BUI-ENC-PRO	Probador Bujías Encendido Profesional	259	2	280.00	2024-02-07 09:40:00	2024-05-23 08:15:00
403	PROB-ALT-CARGA	Probador Alternador Carga	260	1	420.00	2024-02-08 10:55:00	2024-05-22 09:30:00
404	PROB-ARRA-PAR	Probador Arranque Par	261	1	380.00	2024-02-09 11:20:00	2024-05-21 10:45:00
405	PROB-BAT-ADV	Probador Batería Avanzado	262	2	480.00	2024-02-10 12:35:00	2024-05-20 12:00:00
406	ANAL-GAS-4GAS	Analizador Gases 4 Gases	263	1	2850.00	2024-02-11 13:50:00	2024-05-19 13:15:00
407	OPAC-DIES-PORT	Opacímetro Diesel Portátil	264	1	1250.00	2024-02-12 14:05:00	2024-05-18 14:30:00
408	SIST-LIM-INY-BAN	Sistema Limpieza Inyectores Banco	265	1	1850.00	2024-02-13 15:20:00	2024-05-17 15:45:00
409	MAQ-ULT-6L-PRO	Máquina Ultrasonido 6L Profesional	266	1	1250.00	2024-02-14 16:35:00	2024-05-16 16:00:00
410	LAV-PIEZ-50L-PRO	Lavadora Piezas 50L Profesional	267	1	1850.00	2024-02-15 08:50:00	2024-05-15 08:15:00
411	CEP-IND-LATON	Cepillo Industrial Latón	268	8	35.00	2024-02-16 09:15:00	2024-05-14 09:30:00
412	PIST-VAP-2000W-PRO	Pistola Vapor 2000W Profesional	269	1	850.00	2024-02-17 10:30:00	2024-05-13 10:45:00
413	ASPI-IND-60L-PRO	Aspiradora Industrial 60L Profesional	270	1	1250.00	2024-02-18 11:45:00	2024-05-12 12:00:00
414	ESTANT-MET-6NIV-PRO	Estantería Metálica 6 Niveles Profesional	272	2	1250.00	2024-02-19 12:00:00	2024-05-11 13:15:00
415	CARRO-HER-5CAJ-PRO	Carro Herramientas 5 Cajones Profesional	273	1	1850.00	2024-02-20 13:15:00	2024-05-10 14:30:00
416	GAB-HER-12CAJ-PRO	Gabinetes Herramientas 12 Cajones Profesional	274	1	2850.00	2024-02-21 14:30:00	2024-05-09 15:45:00
417	ORG-TORN-128DIV-PRO	Organizador Tornillos 128 Divisiones Profesional	275	4	85.00	2024-02-22 15:45:00	2024-05-08 16:00:00
418	SIST-ETIQ-LASER	Sistema Etiquetado Láser	276	1	850.00	2024-02-23 16:10:00	2024-05-07 08:15:00
419	CONT-10L-PLAST-PRO	Contenedor 10L Plástico Profesional	277	8	45.00	2024-02-24 08:25:00	2024-05-06 09:30:00
420	BID-ACE-50L-PRO	Bidón Aceite 50L Profesional	278	4	120.00	2024-02-25 09:40:00	2024-05-05 10:45:00
421	EMB-FUN-1L-PRO	Embudo 1L Flexible Profesional	279	10	35.00	2024-02-26 10:55:00	2024-05-04 12:00:00
422	JERI-500ML-PRO	Jeringa 500ml Profesional	280	6	25.00	2024-02-27 11:20:00	2024-05-03 13:15:00
423	BASC-DIG-100KG-PRO	Báscula Digital 100kg Profesional	281	1	480.00	2024-02-28 12:35:00	2024-05-02 14:30:00
424	DINO-CHAS-EDDY-PRO	Dinamómetro Chasis Eddy Profesional	283	1	28500.00	2024-02-29 13:50:00	2024-05-01 15:45:00
425	ANAL-COMB-PORT-PRO	Analizador Combustión Portátil Profesional	284	1	1850.00	2024-03-01 14:05:00	2024-04-30 16:00:00
426	SIST-ADQ-DAT-32CH-PRO	Sistema Adquisición Datos 32 Canales Profesional	285	1	8500.00	2024-03-02 15:20:00	2024-04-29 08:15:00
427	CAM-INSP-5MM-PRO	Cámara Inspección 5mm Profesional	286	1	1250.00	2024-03-03 16:35:00	2024-04-28 09:30:00
428	ENDOS-10M-4MM-PRO	Endoscopio 10m 4mm Profesional	287	1	1850.00	2024-03-04 08:50:00	2024-04-27 10:45:00
429	LUPA-INSP-20X-PRO	Lupa Inspección 20X Profesional	288	2	120.00	2024-03-05 09:15:00	2024-04-26 12:00:00
430	LAMP-TRAB-LED-PRO	Lámpara Trabajo LED Profesional	289	4	180.00	2024-03-06 10:30:00	2024-04-25 13:15:00
431	ESPE-INSP-MAG-PRO	Espejo Inspección Magnético Profesional	290	3	65.00	2024-03-07 11:45:00	2024-04-24 14:30:00
432	IMAN-RECUP-POT-PRO	Imán Recuperación Potente Profesional	291	4	55.00	2024-03-08 12:00:00	2024-04-23 15:45:00
433	SOP-LIQ-20L-PRO	Soporte Líquidos 20L Profesional	292	6	35.00	2024-03-09 13:15:00	2024-04-22 16:00:00
434	BOM-TRANS-24V-PRO	Bomba Transferencia 24V Profesional	293	2	280.00	2024-03-10 14:30:00	2024-04-21 08:15:00
435	FIL-ACE-5MIC-PRO	Filtro Aceite 5 Micras Profesional	294	6	65.00	2024-03-11 15:45:00	2024-04-20 09:30:00
436	SEP-AGUA-AUTO-PRO	Separador Agua Automático Profesional	295	2	220.00	2024-03-12 16:10:00	2024-04-19 10:45:00
437	SEC-AIRE-DESEC-PRO	Secador Aire Desecante Profesional	296	1	1250.00	2024-03-13 08:25:00	2024-04-18 12:00:00
438	LUB-AIRE-REG-PRO	Lubricador Aire Regulable Profesional	297	2	320.00	2024-03-14 09:40:00	2024-04-17 13:15:00
439	REG-AIRE-DIG-PRO	Regulador Aire Digital Profesional	298	3	480.00	2024-03-15 10:55:00	2024-04-16 14:30:00
728	HEADER-STAINLESS	Header Stainless	357	1	1800.00	2024-12-29 11:20:00	2023-11-06 10:50:00
440	MANG-AIRE-15M-PRO	Manguera Aire 15m Profesional	299	6	120.00	2024-03-16 11:20:00	2024-04-15 15:45:00
441	ACOP-RAP-1-2-PRO	Acople Rápido 1/2" Profesional	300	10	35.00	2024-03-17 12:35:00	2024-04-14 16:00:00
442	PIST-AIRE-SOP-PRO	Pistola Aire Soplado Profesional	301	4	85.00	2024-03-18 13:50:00	2024-04-13 08:15:00
443	LLAV-NEUM-3-4-PRO	Llave Neumática 3/4" Profesional	302	1	1250.00	2024-03-19 14:05:00	2024-04-12 09:30:00
444	LIJ-NEUM-DA-PRO	Lijadora Neumática DA Profesional	303	1	680.00	2024-03-20 15:20:00	2024-04-11 10:45:00
445	TAL-NEUM-1-2-PRO	Taladro Neumático 1/2" Profesional	304	2	480.00	2024-03-21 16:35:00	2024-04-10 12:00:00
446	COMP-AIRE-100L-PRO	Compresor Aire 100L Profesional	307	1	2850.00	2024-03-22 08:50:00	2024-04-09 13:15:00
447	TAN-AIRE-200L-PRO	Tanque Aire 200L Profesional	308	1	1250.00	2024-03-23 09:15:00	2024-04-08 14:30:00
448	PIST-PINT-RP-PRO	Pistola Pintura RP Profesional	306	2	680.00	2024-03-24 10:30:00	2024-04-07 15:45:00
449	SIST-FILT-PINT-PRO	Sistema Filtrado Pintura Profesional	309	1	480.00	2024-03-25 11:45:00	2024-04-06 16:00:00
450	CAB-PINT-FIJA-PRO	Cabina Pintura Fija Profesional	310	1	4850.00	2024-03-26 12:00:00	2024-04-05 08:15:00
451	SEC-PINT-CONV-PRO	Secador Pintura Convección Profesional	311	1	1850.00	2024-03-27 13:15:00	2024-04-04 09:30:00
452	PUL-ELEC-9-PRO	Pulidora Eléctrica 9" Profesional	312	2	850.00	2024-03-28 14:30:00	2024-04-03 10:45:00
453	BUFF-DA-7-PRO	Buffer DA 7" Profesional	313	1	1250.00	2024-03-29 15:45:00	2024-04-02 12:00:00
454	COMP-PUL-5ETAP-PRO	Compuesto Pulido 5 Etapas Profesional	314	6	120.00	2024-03-30 16:10:00	2024-04-01 13:15:00
455	LIJA-AGUA-3000-PRO	Lija Agua 3000 Grit Profesional	315	15	12.00	2024-03-31 08:25:00	2024-03-31 14:30:00
456	MASI-POLI-5KG-PRO	Masilla Poliéster 5kg Profesional	316	3	480.00	2024-04-01 09:40:00	2024-03-30 15:45:00
457	PRIM-URET-1L-PRO	Primer Uretano 1L Profesional	317	3	220.00	2024-04-02 10:55:00	2024-03-29 16:00:00
458	PINT-PERL-EFEC-PRO	Pintura Perlada Efecto Profesional	318	4	180.00	2024-04-03 11:20:00	2024-03-28 08:15:00
459	CLEAR-1K-1L-PRO	Clear Coat 1K 1L Profesional	319	4	150.00	2024-04-04 12:35:00	2024-03-27 09:30:00
460	DECAL-YAMAHA-OEM-PRO	Decal Yamaha OEM Profesional	320	8	55.00	2024-04-05 13:50:00	2024-03-26 10:45:00
461	KIT-PERS-AERO-PRO	Kit Personalización Aerografía Profesional	321	2	850.00	2024-04-06 14:05:00	2024-03-25 12:00:00
462	ASIENT-RACE-CARB-PRO	Asiento Race Carbono Profesional	322	1	1250.00	2024-04-07 15:20:00	2024-03-24 13:15:00
463	MANUB-ALT-ADJ-PRO	Manubrio Alto Ajustable Profesional	323	3	280.00	2024-04-08 16:35:00	2024-03-23 14:30:00
464	PEGS-ANOD-COL-PRO	Pegs Anodizados Color Profesional	324	6	150.00	2024-04-09 08:50:00	2024-03-22 15:45:00
465	LEVAS-CAMB-RACE-PRO	Levas Cambio Race Profesional	325	3	320.00	2024-04-10 09:15:00	2024-03-21 16:00:00
466	PEDAL-RACE-TIT-PRO	Pedales Race Titanio Profesional	326	2	680.00	2024-04-11 10:30:00	2024-03-20 08:15:00
467	ESCAP-RACE-TIT-PRO	Escape Race Titanio Profesional	327	1	4850.00	2024-04-12 11:45:00	2024-03-19 09:30:00
468	FIL-AIRE-RACE-PRO	Filtro Aire Race Profesional	328	4	180.00	2024-04-13 12:00:00	2024-03-18 10:45:00
469	KIT-REL-RACE-PRO	Kit Relación Race Profesional	329	2	480.00	2024-04-14 13:15:00	2024-03-17 12:00:00
470	RADI-RACE-ALU-PRO	Radiador Race Aluminio Profesional	332	1	1250.00	2024-04-15 14:30:00	2024-03-16 13:15:00
471	VENT-RACE-HI-PERF-PRO	Ventilador Race Alto Performance Profesional	333	2	220.00	2024-04-16 15:45:00	2024-03-15 14:30:00
472	TERM-RACE-OPEN-PRO	Termostato Race Apertura Profesional	334	3	150.00	2024-04-17 16:10:00	2024-03-14 15:45:00
473	BOM-GAS-RACE-PRO	Bomba Gasolina Race Profesional	336	2	680.00	2024-04-18 08:25:00	2024-03-13 16:00:00
474	REG-PRES-RACE-PRO	Regulador Presión Race Profesional	337	3	280.00	2024-04-19 09:40:00	2024-03-12 08:15:00
475	RAIL-GAS-RACE-PRO	Rail Gasolina Race Profesional	338	2	220.00	2024-04-20 10:55:00	2024-03-11 09:30:00
476	INY-RACE-320CC-PRO	Inyector Race 320cc Profesional	339	4	480.00	2024-04-21 11:20:00	2024-03-10 10:45:00
477	SENS-RACE-PREC-PRO	Sensor Race Precisión Profesional	340	3	320.00	2024-04-22 12:35:00	2024-03-09 12:00:00
478	ECU-RACE-STAND-PRO	ECU Race Standalone Profesional	341	1	6800.00	2024-04-23 13:50:00	2024-03-08 13:15:00
479	KIT-TURBO-GT35-PRO	Kit Turbo GT35 Profesional	342	1	12500.00	2024-04-24 14:05:00	2024-03-07 14:30:00
480	INTER-TURBO-RACE-PRO	Intercooler Turbo Race Profesional	344	1	1850.00	2024-04-25 15:20:00	2024-03-06 15:45:00
481	VALV-BLOW-RACE-PRO	Válvula Blow-Off Race Profesional	345	2	480.00	2024-04-26 16:35:00	2024-03-05 16:00:00
482	WASTEGATE-RACE-PRO	Wastegate Race Profesional	346	2	850.00	2024-04-27 08:50:00	2024-03-04 08:15:00
483	BOOST-CONT-RACE-PRO	Boost Controller Race Profesional	347	1	1250.00	2024-04-28 09:15:00	2024-03-03 09:30:00
484	SIST-INY-MET-RACE-PRO	Sistema Inyección Metanol Race Profesional	348	1	2850.00	2024-04-29 10:30:00	2024-03-02 10:45:00
485	KIT-NOS-WET-100HP-PRO	Kit NOS Wet 100HP Profesional	349	1	4850.00	2024-04-30 11:45:00	2024-03-01 12:00:00
486	SIST-ENC-DIG-RACE-PRO	Sistema Encendido Digital Race Profesional	350	1	1850.00	2024-05-01 12:00:00	2024-02-29 13:15:00
487	DIST-RACE-CNC-PRO	Distribuidor Race CNC Profesional	351	2	680.00	2024-05-02 13:15:00	2024-02-28 14:30:00
488	AVAN-ENC-RACE-PRO	Avanzador Encendido Race Profesional	352	3	220.00	2024-05-03 14:30:00	2024-02-27 15:45:00
489	SIST-ADM-RACE-PRO	Sistema Admisión Race Profesional	353	2	850.00	2024-05-04 15:45:00	2024-02-26 16:00:00
490	COLEC-ADM-RACE-PRO	Colector Admisión Race Profesional	354	2	480.00	2024-05-05 16:10:00	2024-02-25 08:15:00
491	BODY-MARI-50MM-PRO	Body Mariposa 50mm Profesional	355	1	680.00	2024-05-06 08:25:00	2024-02-24 09:30:00
492	HEADER-RACE-TIT-PRO	Header Race Titanio Profesional	357	1	2850.00	2024-05-07 09:40:00	2024-02-23 10:45:00
493	SILEN-RACE-TIT-PRO	Silenciador Race Titanio Profesional	359	2	1250.00	2024-05-08 10:55:00	2024-02-22 12:00:00
494	SENS-O2-RACE-PRO	Sensor O2 Race Profesional	361	2	680.00	2024-05-09 11:20:00	2024-02-21 13:15:00
495	VALV-EGR-RACE-PRO	Válvula EGR Race Profesional	362	3	180.00	2024-05-10 12:35:00	2024-02-20 14:30:00
496	SIST-PCV-RACE-PRO	Sistema PCV Race Profesional	363	2	280.00	2024-05-11 13:50:00	2024-02-19 15:45:00
497	CANISTER-RACE-PRO	Canister Race Profesional	364	2	120.00	2024-05-12 14:05:00	2024-02-18 16:00:00
498	SENS-EVAP-RACE-PRO	Sensor EVAP Race Profesional	365	3	180.00	2024-05-13 15:20:00	2024-02-17 08:15:00
499	EQUI-ALIN-3D-PRO	Equipo Alineación 3D Profesional	367	1	12500.00	2024-05-14 16:35:00	2024-02-16 09:30:00
500	SIST-BAL-PREC-PRO	Sistema Balanceo Precisión Profesional	368	1	4850.00	2024-05-15 08:50:00	2024-02-15 10:45:00
501	MED-ANG-RACE-PRO	Medidor Ángulo Race Profesional	369	1	1250.00	2024-05-16 09:15:00	2024-02-14 12:00:00
502	SIST-MED-CHAS-RACE-PRO	Sistema Medición Chasis Race Profesional	370	1	18500.00	2024-05-17 10:30:00	2024-02-13 13:15:00
503	HERR-CUAD-RACE-PRO	Herramientas Cuadro Race Profesional	371	2	480.00	2024-05-18 11:45:00	2024-02-12 14:30:00
505	SIST-ENDREZ-RACE-PRO	Sistema Enderezado Race Profesional	372	1	12500.00	2024-05-19 12:00:00	2024-02-11 15:45:00
506	PUNT-ANCL-RACE-PRO	Puntos Anclaje Race Profesional	373	6	65.00	2024-05-20 13:15:00	2024-02-10 16:00:00
1006	ACE-MOT-15W50-1L	Aceite Motul 300V 15W50 1L	5	16	220.00	2024-05-21 14:30:00	2024-06-15 10:20:00
507	FIL-AIR-KN-RC-1822	Filtro Aire K&N RC-1822	7	8	350.00	2024-05-22 15:45:00	2024-06-14 11:35:00
508	BUI-NGK-DPR8EA-9	Bujía NGK DPR8EA-9	10	25	55.00	2024-05-23 16:20:00	2024-06-13 12:50:00
509	PAST-FREN-DEL-SBS-619	Pastillas Freno SBS 619HS	11	6	280.00	2024-05-24 08:35:00	2024-06-12 14:05:00
510	CAD-RK-520MXU	Cadena RK 520MXU X-Ring	16	4	1200.00	2024-05-25 09:50:00	2024-06-11 15:20:00
511	NEUM-BRID-BT46-120-70	Neumático Bridgestone BT46 120/70-17	18	3	750.00	2024-05-26 10:15:00	2024-06-10 16:35:00
512	BAT-YUASA-YTX9-BS	Batería Yuasa YTX9-BS	21	5	720.00	2024-05-27 11:30:00	2024-06-09 08:50:00
513	AMORT-OHLINS-STX	Amortiguador Ohlins STX46	23	2	4500.00	2024-05-28 12:45:00	2024-06-08 10:05:00
514	JUNT-MOT-CBR600	Kit Juntas Honda CBR600RR	27	2	680.00	2024-05-29 13:20:00	2024-06-07 11:20:00
515	PIST-SUZ-GSXR-81MM	Pistón Suzuki GSXR 81mm	30	3	450.00	2024-05-30 14:35:00	2024-06-06 12:35:00
516	CARB-MIK-BSR42	Carburador Mikuni BSR42	42	4	850.00	2024-05-31 15:50:00	2024-06-05 13:50:00
517	INY-BOSCH-028015	Inyector Bosch 028015	44	7	380.00	2024-06-01 16:05:00	2024-06-04 15:05:00
518	BOM-GAS-WALBRO-255	Bomba Gasolina Walbro 255LPH	45	4	650.00	2024-06-02 08:20:00	2024-06-03 16:20:00
519	FAR-LED-H7-5000K	Foco H7 LED 5000K	47	12	180.00	2024-06-03 09:35:00	2024-06-02 08:35:00
520	ESP-CONVEX-UNIV	Espejo Convexo Universal	51	10	95.00	2024-06-04 10:50:00	2024-06-01 09:50:00
521	MAN-EMB-HYD	Manija Embrague Hidráulico	52	6	280.00	2024-06-05 11:25:00	2024-05-31 11:05:00
522	ESCAP-ARROW-RACE	Escape Arrow Race	59	1	2200.00	2024-06-06 12:40:00	2024-05-30 12:20:00
523	SENS-O2-DENSO-1	Sensor Oxígeno Denso 1	62	5	320.00	2024-06-07 13:55:00	2024-05-29 13:35:00
524	ALT-HIT-40A	Alternador Hitachi 40A	66	3	850.00	2024-06-08 14:10:00	2024-05-28 14:50:00
525	ARRA-MIT-SM81	Motor Arranque Mitsubishi	67	2	750.00	2024-06-09 15:25:00	2024-05-27 16:05:00
526	BOB-ENC-MS-DBL	Bobina Encendido MSD Blaster	68	5	350.00	2024-06-10 16:40:00	2024-05-26 08:20:00
527	PORT-EQUI-SW-MOTECH	Portaequipajes SW-Motech	74	3	580.00	2024-06-11 08:55:00	2024-05-25 09:35:00
528	TOP-CASE-52L-SHAD	Top Case Shad 52L	76	2	850.00	2024-06-12 09:10:00	2024-05-24 10:50:00
529	GPS-TOMTOM-RIDER	Soporte GPS TomTom Rider	77	6	220.00	2024-06-13 10:25:00	2024-05-23 12:05:00
530	ALAR-SCORPIO-SR-i900	Alarma Scorpio SR-i900	79	4	450.00	2024-06-14 11:40:00	2024-05-22 13:20:00
531	CAND-CAD-16MM	Candado Cadena 16mm	80	7	320.00	2024-06-15 12:55:00	2024-05-21 14:35:00
532	LUB-CAD-PJ-BLACK	Lubricante Cadena PJ1 Black	82	20	110.00	2024-06-16 13:20:00	2024-05-20 15:50:00
533	ANTI-PEAK-LONG	Anticongelante Peak Long Life	83	15	85.00	2024-06-17 14:35:00	2024-05-19 16:05:00
534	LIM-INY-STP-SUPER	Limpiador Inyectores STP Super	84	16	75.00	2024-06-18 15:50:00	2024-05-18 08:20:00
535	DEG-SIMPLE-GREEN	Degrasante Simple Green	85	18	95.00	2024-06-19 16:15:00	2024-05-17 09:35:00
536	LLV-VAS-3-8-14MM	Llave de Vaso 3/8 14mm	87	12	28.00	2024-06-20 08:30:00	2024-05-16 10:50:00
537	TORQ-PREC-1-4	Torquímetro Precisión 1/4"	88	3	380.00	2024-06-21 09:45:00	2024-05-15 12:05:00
538	DEST-PUNTA-3-16	Destornillador Punta 3/16"	89	18	32.00	2024-06-22 10:20:00	2024-05-14 13:20:00
539	ALIC-PUNTA-REDONDA	Alicate Punta Redonda	90	10	52.00	2024-06-23 11:35:00	2024-05-13 14:35:00
540	KIT-HER-250PZ-PRO	Kit Herramientas 250 Piezas Profesional	91	2	1800.00	2024-06-24 12:50:00	2024-05-12 15:50:00
541	COMP-MOT-DIG-PRO	Compresómetro Digital Profesional	95	1	580.00	2024-06-25 13:05:00	2024-05-11 16:05:00
542	MULT-FLUKE-87V	Multímetro Fluke 87V	96	3	850.00	2024-06-26 14:20:00	2024-05-10 08:20:00
543	SCAN-LAUNCH-X431	Scanner Launch X431	97	1	3500.00	2024-06-27 15:35:00	2024-05-09 09:35:00
544	CASO-AGV-K6-TALLA-L	Casco AGV K6 Talla L	107	3	4200.00	2024-06-28 16:50:00	2024-05-08 10:50:00
545	GUANT-DAINESE-CARB	Guantes Dainese Carbon	111	6	850.00	2024-06-29 08:15:00	2024-05-07 12:05:00
546	CHAM-REVIT-SAND	Chamarra Revit Sand	112	4	2200.00	2024-06-30 09:30:00	2024-05-06 13:20:00
547	BOTAS-FORM-A-TALL-42	Botas Forma Tall 42	114	5	1200.00	2024-07-01 10:45:00	2024-05-05 14:35:00
548	INTERCOM-CARDO-PACKTALK	Intercomunicador Cardo Packtalk	117	3	1800.00	2024-07-02 11:20:00	2024-05-04 15:50:00
549	ACEITE-FREN-DOT5-1	Aceite Frenos DOT 5.1	119	12	130.00	2024-07-03 12:35:00	2024-05-03 16:05:00
550	GRAS-SILIC-DIELECT	Grasa Silicona Dieléctrica	120	10	55.00	2024-07-04 13:50:00	2024-05-02 08:20:00
551	SELL-JUNTA-COBRE	Sellador Juntas Cobre	123	20	95.00	2024-07-05 14:05:00	2024-05-01 09:35:00
552	TORN-8MM-1-25	Tornillos 8mm x 1.25	126	80	3.50	2024-07-06 15:20:00	2024-04-30 10:50:00
554	ROD-RUEDA-6205	Rodamiento Rueda 6205-2RS	131	8	42.00	2024-07-08 08:50:00	2024-04-28 13:20:00
555	RES-SUSP-LINEAL	Resorte Suspensión Lineal	135	3	280.00	2024-07-09 09:15:00	2024-04-27 14:35:00
556	MANG-FREN-BRAID	Manguito Freno Trenzado	138	6	65.00	2024-07-10 10:30:00	2024-04-26 15:50:00
557	CIL-MAES-BREMBO-16	Cilindro Maestro Brembo 16mm	140	4	350.00	2024-07-11 11:45:00	2024-04-25 16:05:00
558	SENS-ABS-TRAS	Sensor ABS Trasero	142	4	210.00	2024-07-12 12:00:00	2024-04-24 08:20:00
559	BUI-PLAT-CR9EIX	Bujía Platino NGK CR9EIX	144	12	120.00	2024-07-13 13:15:00	2024-04-23 09:35:00
560	CAB-BUJ-MSD-SUPER	Cable Bujía MSD Super Conductor	146	8	180.00	2024-07-14 14:30:00	2024-04-22 10:50:00
561	REG-VOL-RR-23	Regulador Voltaje RR-23	148	5	220.00	2024-07-15 15:45:00	2024-04-21 12:05:00
562	BAT-LIT-ANT-ATX12	Batería Litio Antigravity ATX12	156	3	1500.00	2024-07-16 16:10:00	2024-04-20 13:20:00
563	CARG-BAT-NOCO-GENIUS	Cargador Batería NOCO Genius	157	4	550.00	2024-07-17 08:25:00	2024-04-19 14:35:00
564	PORT-CEL-QUAD-LOCK	Porta Celular Quad Lock	161	8	280.00	2024-07-18 09:40:00	2024-04-18 15:50:00
565	SOP-INSTA-360	Soporte Insta360	162	6	120.00	2024-07-19 10:55:00	2024-04-17 16:05:00
566	BOC-HELLA-SHARP	Bocina Hella Sharp Tone	164	10	85.00	2024-07-20 11:20:00	2024-04-16 08:20:00
567	LUC-LED-AUX-6	Luces LED Auxiliares 6"	170	4	450.00	2024-07-21 12:35:00	2024-04-15 09:35:00
568	MOD-ABS-BOSCH-9	Módulo Control ABS Bosch 9	174	2	2200.00	2024-07-22 13:50:00	2024-04-14 10:50:00
569	SIST-INMOV-PANDORA	Sistema Inmovilizador Pandora	178	3	550.00	2024-07-23 14:05:00	2024-04-13 12:05:00
570	PROT-MOT-CAGE	Protector Motor Cage	185	6	320.00	2024-07-24 15:20:00	2024-04-12 13:20:00
571	PROT-MAN-BAR-CNC	Protector Manubrio Bar End CNC	186	12	65.00	2024-07-25 16:35:00	2024-04-11 14:35:00
572	REJ-RADI-CARB	Rejilla Radiador Carbono	187	3	450.00	2024-07-26 08:50:00	2024-04-10 15:50:00
573	PROT-TANK-CLEAR	Protector Tanque Clear	188	5	180.00	2024-07-27 09:15:00	2024-04-09 16:05:00
574	FUND-ASIENT-COMFORT	Funda Asiento Comfort Plus	189	3	380.00	2024-07-28 10:30:00	2024-04-08 08:20:00
575	REP-AGUA-CERAM	Repelente Agua Cerámico	190	8	120.00	2024-07-29 11:45:00	2024-04-07 09:35:00
576	CERAM-PINT-9H	Cerámico Pintura 9H	191	6	580.00	2024-07-30 12:00:00	2024-04-06 10:50:00
577	PUL-MENZ-400	Pulidor Menzerna 400	192	10	110.00	2024-07-31 13:15:00	2024-04-05 12:05:00
578	CERA-COLL-845	Cera Collinite 845	193	12	150.00	2024-08-01 14:30:00	2024-04-04 13:20:00
579	LIM-LLAN-SONAX	Limpiador Llantas Sonax	194	15	95.00	2024-08-02 15:45:00	2024-04-03 14:35:00
580	LIM-CAD-MUC-OFF	Limpiador Cadena Muc-Off	195	18	65.00	2024-08-03 16:10:00	2024-04-02 15:50:00
803	SOFT-SERV-AI	Software Servicio AI	435	1	2800.00	2025-03-14 14:05:00	2023-08-23 14:35:00
581	PROT-PLAST-303	Protector Plástico 303	196	12	85.00	2024-08-04 08:25:00	2024-04-01 16:05:00
582	LIM-FREN-CRC-BRAKE	Limpiador Frenos CRC Brakleen	197	14	65.00	2024-08-05 09:40:00	2024-03-31 08:20:00
583	DESENG-GUNK-5L	Desengrasante Gunk 5L	198	6	220.00	2024-08-06 10:55:00	2024-03-30 09:35:00
584	LUB-CAD-WET	Lubricante Cadena Wet	199	20	130.00	2024-08-07 11:20:00	2024-03-29 10:50:00
585	SILIC-SPRAY-CRC	Spray Silicona CRC	200	22	55.00	2024-08-08 12:35:00	2024-03-28 12:05:00
586	ACE-PENET-LIQUID	Aceite Penetrante Liquid Wrench	201	16	95.00	2024-08-09 13:50:00	2024-03-27 13:20:00
587	GRAS-ANTI-SEIZE	Grasa Anti-Seize	202	10	75.00	2024-08-10 14:05:00	2024-03-26 14:35:00
588	GRAS-MOLY-EP	Grasa Moly EP	203	12	45.00	2024-08-11 15:20:00	2024-03-25 15:50:00
589	COMP-VALV-PERMATEX	Compuesto Válvulas Permatex	205	6	110.00	2024-08-12 16:35:00	2024-03-24 16:05:00
590	PASTE-CALIPER	Paste Caliper	206	8	55.00	2024-08-13 08:50:00	2024-03-23 08:20:00
591	COMP-MONT-RUEDA	Compuesto Montaje Rueda	207	12	65.00	2024-08-14 09:15:00	2024-03-22 09:35:00
592	SELL-NEUM-ORANGE	Sellante Neumáticos Orange	208	10	150.00	2024-08-15 10:30:00	2024-03-21 10:50:00
593	ADIT-RADI-WATER-WETTER	Aditivo Radiador Water Wetter	209	14	85.00	2024-08-16 11:45:00	2024-03-20 12:05:00
594	COND-GOMAS-GUMMI	Condicionador Gomas Gummi	210	18	75.00	2024-08-17 12:00:00	2024-03-19 13:20:00
595	DESM-NEUM-ELECT	Desmontadora Neumáticos Eléctrica	212	1	850.00	2024-08-18 13:15:00	2024-03-18 14:35:00
596	EQUI-RUEDA-HUNTER	Equilibradora Ruedas Hunter	213	1	2800.00	2024-08-19 14:30:00	2024-03-17 15:50:00
597	MED-PRES-TIRE	Medidor Presión Tire	214	6	180.00	2024-08-20 15:45:00	2024-03-16 16:05:00
598	INFL-12V-DIGITAL	Inflador 12V Digital	215	4	380.00	2024-08-21 16:10:00	2024-03-15 08:20:00
599	KIT-PAR-PROF	Kit Parches Profesional	216	12	110.00	2024-08-22 08:25:00	2024-03-14 09:35:00
600	PARCH-NEUM-TIPO2	Parches Neumáticos Tipo 2	217	25	15.00	2024-08-23 09:40:00	2024-03-13 10:50:00
601	VALV-NEUM-METAL	Válvulas Neumáticos Metal	218	20	18.00	2024-08-24 10:55:00	2024-03-12 12:05:00
602	TAPA-VALV-ALUM	Tapas Válvulas Aluminio	219	35	10.00	2024-08-25 11:20:00	2024-03-11 13:20:00
603	EXT-VALV-90DEG	Extensor Válvulas 90°	220	8	32.00	2024-08-26 12:35:00	2024-03-10 14:35:00
604	TRONCH-CAD-RK-PRO	Tronchadora Cadena RK Profesional	222	1	280.00	2024-08-27 13:50:00	2024-03-09 15:50:00
605	REMACH-CAD-DID-PRO	Remachadora Cadena DID Profesional	223	1	320.00	2024-08-28 14:05:00	2024-03-08 16:05:00
606	MED-DESG-SPROCK	Medidor Desgaste Sprocket	224	3	55.00	2024-08-29 15:20:00	2024-03-07 08:20:00
607	LAV-CAD-GRUNGE-PRO	Lavadora Cadena Grunge Pro	225	4	120.00	2024-08-30 16:35:00	2024-03-06 09:35:00
608	KIT-ENGR-MOTUL	Kit Engrase Motul	226	6	150.00	2024-08-31 08:50:00	2024-03-05 10:50:00
609	COMP-SUSP-TYPE2	Compresor Suspensión Tipo 2	228	1	350.00	2024-09-01 09:15:00	2024-03-04 12:05:00
610	CALIB-VALV-FEELER	Calibrador Válvulas Feeler	230	2	85.00	2024-09-02 10:30:00	2024-03-03 13:20:00
611	GATO-SUSP-NEUM	Gato Suspensión Neumático	231	1	580.00	2024-09-03 11:45:00	2024-03-02 14:35:00
612	EXT-PIST-TYPE3	Extractor Pistones Tipo 3	233	1	180.00	2024-09-04 12:00:00	2024-03-01 15:50:00
613	INS-PIST-METAL	Insertador Pistones Metal	234	2	110.00	2024-09-05 13:15:00	2024-02-29 16:05:00
614	TORQ-DIG-PRO-1-2	Torquímetro Digital Pro 1/2"	235	1	850.00	2024-09-06 14:30:00	2024-02-28 08:20:00
615	MIC-25-50MM	Micrómetro 25-50mm	237	2	280.00	2024-09-07 15:45:00	2024-02-27 09:35:00
616	CALIB-VERN-200	Calibrador Vernier 200mm	238	3	220.00	2024-09-08 16:10:00	2024-02-26 10:50:00
617	GALGA-ESP-002	Galga Espesores 0.02-1.0mm	239	4	52.00	2024-09-09 08:25:00	2024-02-25 12:05:00
618	IND-GOTA-DIAL	Indicador Gota Dial	240	2	150.00	2024-09-10 09:40:00	2024-02-24 13:20:00
619	COMP-DIG-PRO	Compresómetro Digital Pro	241	1	680.00	2024-09-11 10:55:00	2024-02-23 14:35:00
620	VACU-CARB-DIG	Vacuómetro Carburadores Digital	242	2	220.00	2024-09-12 11:20:00	2024-02-22 15:50:00
621	FLOW-INY-DENSO	Flow Meter Inyectores Denso	243	1	950.00	2024-09-13 12:35:00	2024-02-21 16:05:00
622	OSC-DIG-50MHZ-PRO	Osciloscopio Digital 50MHz Pro	244	1	2200.00	2024-09-14 13:50:00	2024-02-20 08:20:00
623	GEN-SEÑ-FUNC	Generador Señal Funcional	245	1	550.00	2024-09-15 14:05:00	2024-02-19 09:35:00
624	SIM-SENS-CKP	Simulador Sensor CKP	246	2	320.00	2024-09-16 15:20:00	2024-02-18 10:50:00
625	PROG-ECU-KAWASAKI	Programador ECU Kawasaki	247	1	3200.00	2024-09-17 16:35:00	2024-02-17 12:05:00
626	INTER-DIAG-OBD2	Interface Diagnóstico OBD2	248	2	450.00	2024-09-18 08:50:00	2024-02-16 13:20:00
627	SOFT-DIAG-DELPHI	Software Diagnóstico Delphi	249	1	850.00	2024-09-19 09:15:00	2024-02-15 14:35:00
628	KIT-PRUE-GAS-DELPHI	Kit Prueba Gasolina Delphi	250	1	380.00	2024-09-20 10:30:00	2024-02-14 15:50:00
629	MAN-GAS-DELPHI	Manómetro Gasolina Delphi	251	2	280.00	2024-09-21 11:45:00	2024-02-13 16:05:00
630	BOM-VAC-DELPHI	Bomba Vacío Delphi	252	1	550.00	2024-09-22 12:00:00	2024-02-12 08:20:00
631	DET-FUGA-SMOKE	Detector Fugas Smoke	253	1	850.00	2024-09-23 13:15:00	2024-02-11 09:35:00
632	ESTET-ELECTRONIC	Estetoscopio Electrónico	254	2	180.00	2024-09-24 14:30:00	2024-02-10 10:50:00
633	TERM-INFR-FLUKE	Termómetro Infrarrojo Fluke	255	1	650.00	2024-09-25 15:45:00	2024-02-09 12:05:00
634	ANEM-VEL-DIG	Anemómetro Velocidad Digital	256	1	380.00	2024-09-26 16:10:00	2024-02-08 13:20:00
635	MAN-ACE-DIG-FLUKE	Manómetro Aceite Digital Fluke	257	1	450.00	2024-09-27 08:25:00	2024-02-07 14:35:00
636	BAN-PRUE-BOMBA	Banco Prueba Bomba	258	1	3200.00	2024-09-28 09:40:00	2024-02-06 15:50:00
637	PROB-BUI-ENC-DIG	Probador Bujías Encendido Digital	259	1	350.00	2024-09-29 10:55:00	2024-02-05 16:05:00
638	PROB-ALT-DIG	Probador Alternador Digital	260	1	480.00	2024-09-30 11:20:00	2024-02-04 08:20:00
639	PROB-ARRA-DIG	Probador Arranque Digital	261	1	420.00	2024-10-01 12:35:00	2024-02-03 09:35:00
640	PROB-BAT-DIG-PRO	Probador Batería Digital Pro	262	1	580.00	2024-10-02 13:50:00	2024-02-02 10:50:00
641	ANAL-GAS-5GAS-PRO	Analizador Gases 5 Gases Pro	263	1	5800.00	2024-10-03 14:05:00	2024-02-01 12:05:00
642	OPAC-DIES-PRO	Opacímetro Diesel Pro	264	1	2200.00	2024-10-04 15:20:00	2024-01-31 13:20:00
643	SIST-LIM-INY-PRO	Sistema Limpieza Inyectores Pro	265	1	2200.00	2024-10-05 16:35:00	2024-01-30 14:35:00
644	MAQ-ULT-10L-PRO	Máquina Ultrasonido 10L Pro	266	1	1800.00	2024-10-06 08:50:00	2024-01-29 15:50:00
645	LAV-PIEZ-100L-PRO	Lavadora Piezas 100L Pro	267	1	2800.00	2024-10-07 09:15:00	2024-01-28 16:05:00
646	CEP-IND-STAINLESS	Cepillo Industrial Stainless	268	6	42.00	2024-10-08 10:30:00	2024-01-27 08:20:00
647	PIST-VAP-3000W-PRO	Pistola Vapor 3000W Pro	269	1	1200.00	2024-10-09 11:45:00	2024-01-26 09:35:00
648	ASPI-IND-100L-PRO	Aspiradora Industrial 100L Pro	270	1	1800.00	2024-10-10 12:00:00	2024-01-25 10:50:00
649	ESTANT-MET-8NIV-PRO	Estantería Metálica 8 Niveles Pro	272	1	1500.00	2024-10-11 13:15:00	2024-01-24 12:05:00
650	CARRO-HER-8CAJ-PRO	Carro Herramientas 8 Cajones Pro	273	1	2200.00	2024-10-12 14:30:00	2024-01-23 13:20:00
651	GAB-HER-16CAJ-PRO	Gabinetes Herramientas 16 Cajones Pro	274	1	3500.00	2024-10-13 15:45:00	2024-01-22 14:35:00
652	ORG-TORN-256DIV-PRO	Organizador Tornillos 256 Divisiones Pro	275	2	120.00	2024-10-14 16:10:00	2024-01-21 15:50:00
653	SIST-ETIQ-COD-BAR	Sistema Etiquetado Código Barras	276	1	1200.00	2024-10-15 08:25:00	2024-01-20 16:05:00
654	CONT-20L-PLAST-PRO	Contenedor 20L Plástico Pro	277	4	65.00	2024-10-16 09:40:00	2024-01-19 08:20:00
655	BID-ACE-100L-PRO	Bidón Aceite 100L Pro	278	2	180.00	2024-10-17 10:55:00	2024-01-18 09:35:00
656	EMB-FUN-2L-PRO	Embudo 2L Flexible Pro	279	6	45.00	2024-10-18 11:20:00	2024-01-17 10:50:00
657	JERI-1000ML-PRO	Jeringa 1000ml Pro	280	4	35.00	2024-10-19 12:35:00	2024-01-16 12:05:00
658	BASC-DIG-200KG-PRO	Báscula Digital 200kg Pro	281	1	650.00	2024-10-20 13:50:00	2024-01-15 13:20:00
659	DINO-ENGINE-PRO	Dinamómetro Engine Pro	282	1	65000.00	2024-10-21 14:05:00	2024-01-14 14:35:00
660	SIST-MED-POT-ENG	Sistema Medición Potencia Engine	283	1	15000.00	2024-10-22 15:20:00	2024-01-13 15:50:00
661	ANAL-COMB-PRO	Analizador Combustión Pro	284	1	3200.00	2024-10-23 16:35:00	2024-01-12 16:05:00
662	SIST-ADQ-DAT-64CH-PRO	Sistema Adquisición Datos 64 Canales Pro	285	1	12000.00	2024-10-24 08:50:00	2024-01-11 08:20:00
663	CAM-INSP-3MM-PRO	Cámara Inspección 3mm Pro	286	1	1500.00	2024-10-25 09:15:00	2024-01-10 09:35:00
664	ENDOS-15M-3MM-PRO	Endoscopio 15m 3mm Pro	287	1	2500.00	2024-10-26 10:30:00	2024-01-09 10:50:00
665	LUPA-INSP-30X-PRO	Lupa Inspección 30X Pro	288	1	180.00	2024-10-27 11:45:00	2024-01-08 12:05:00
666	LAMP-TRAB-LED-200W	Lámpara Trabajo LED 200W	289	2	250.00	2024-10-28 12:00:00	2024-01-07 13:20:00
667	ESPE-INSP-LED-PRO	Espejo Inspección LED Pro	290	2	85.00	2024-10-29 13:15:00	2024-01-06 14:35:00
668	IMAN-RECUP-SUPER	Imán Recuperación Super	291	3	75.00	2024-10-30 14:30:00	2024-01-05 15:50:00
669	SOP-LIQ-50L-PRO	Soporte Líquidos 50L Pro	292	3	55.00	2024-10-31 15:45:00	2024-01-04 16:05:00
670	BOM-TRANS-110V-PRO	Bomba Transferencia 110V Pro	293	1	450.00	2024-11-01 16:10:00	2024-01-03 08:20:00
671	FIL-ACE-1MIC-PRO	Filtro Aceite 1 Micra Pro	294	4	95.00	2024-11-02 08:25:00	2024-01-02 09:35:00
672	SEP-AGUA-AUTO-ULTRA	Separador Agua Auto Ultra	295	1	350.00	2024-11-03 09:40:00	2024-01-01 10:50:00
673	SEC-AIRE-REFRIG-PRO	Secador Aire Refrigerado Pro	296	1	1200.00	2024-11-04 10:55:00	2023-12-31 12:05:00
674	LUB-AIRE-PRO	Lubricador Aire Pro	297	1	450.00	2024-11-05 11:20:00	2023-12-30 13:20:00
675	REG-AIRE-PRO	Regulador Aire Pro	298	2	220.00	2024-11-06 12:35:00	2023-12-29 14:35:00
676	MANG-AIRE-25M-PRO	Manguera Aire 25m Pro	299	4	150.00	2024-11-07 13:50:00	2023-12-28 15:50:00
677	ACOP-RAP-3-8-PRO	Acople Rápido 3/8" Pro	300	8	42.00	2024-11-08 14:05:00	2023-12-27 16:05:00
678	PIST-AIRE-BLOW-PRO	Pistola Aire Blow Pro	301	3	110.00	2024-11-09 15:20:00	2023-12-26 08:20:00
679	LLAV-NEUM-1-PRO	Llave Neumática 1" Pro	302	1	1800.00	2024-11-10 16:35:00	2023-12-25 09:35:00
680	LIJ-NEUM-ANGLE-PRO	Lijadora Neumática Angle Pro	303	1	850.00	2024-11-11 08:50:00	2023-12-24 10:50:00
681	TAL-NEUM-3-4-PRO	Taladro Neumático 3/4" Pro	304	1	650.00	2024-11-12 09:15:00	2023-12-23 12:05:00
682	COMP-AIRE-200L-PRO	Compresor Aire 200L Pro	307	1	3500.00	2024-11-13 10:30:00	2023-12-22 13:20:00
683	TAN-AIRE-500L-PRO	Tanque Aire 500L Pro	308	1	1800.00	2024-11-14 11:45:00	2023-12-21 14:35:00
684	PIST-PINT-HVLP-PRO	Pistola Pintura HVLP Pro	306	1	850.00	2024-11-15 12:00:00	2023-12-20 15:50:00
685	SIST-FILT-PINT-ULTRA	Sistema Filtrado Pintura Ultra	309	1	650.00	2024-11-16 13:15:00	2023-12-19 16:05:00
686	CAB-PINT-INDUSTRIAL	Cabina Pintura Industrial	310	1	8500.00	2024-11-17 14:30:00	2023-12-18 08:20:00
687	SEC-PINT-INFRARED	Secador Pintura Infrared	311	1	2800.00	2024-11-18 15:45:00	2023-12-17 09:35:00
688	PUL-ELEC-6-PRO	Pulidora Eléctrica 6" Pro	312	1	750.00	2024-11-19 16:10:00	2023-12-16 10:50:00
689	BUFF-ROTO-12-PRO	Buffer Rotatorio 12" Pro	313	1	1200.00	2024-11-20 08:25:00	2023-12-15 12:05:00
690	COMP-PUL-7ETAP-PRO	Compuesto Pulido 7 Etapas Pro	314	4	150.00	2024-11-21 09:40:00	2023-12-14 13:20:00
691	LIJA-AGUA-5000-PRO	Lija Agua 5000 Grit Pro	315	10	18.00	2024-11-22 10:55:00	2023-12-13 14:35:00
692	MASI-POLI-10KG-PRO	Masilla Poliéster 10kg Pro	316	2	850.00	2024-11-23 11:20:00	2023-12-12 15:50:00
693	PRIM-EPOXI-4L-PRO	Primer Epóxi 4L Pro	317	2	350.00	2024-11-24 12:35:00	2023-12-11 16:05:00
694	PINT-METAL-FLAKE	Pintura Metal Flake	318	3	220.00	2024-11-25 13:50:00	2023-12-10 08:20:00
695	CLEAR-2K-4L-PRO	Clear Coat 2K 4L Pro	319	2	450.00	2024-11-26 14:05:00	2023-12-09 09:35:00
696	DECAL-SUZUKI-OEM-PRO	Decal Suzuki OEM Pro	320	6	65.00	2024-11-27 15:20:00	2023-12-08 10:50:00
697	KIT-PERS-AIRBRUSH	Kit Personalización Airbrush	321	1	1200.00	2024-11-28 16:35:00	2023-12-07 12:05:00
698	ASIENT-TOUR-GEL	Asiento Touring Gel	322	2	850.00	2024-11-29 08:50:00	2023-12-06 13:20:00
699	MANUB-APE-ADJ	Manubrio Ape Hanger Ajustable	323	2	350.00	2024-11-30 09:15:00	2023-12-05 14:35:00
700	PEGS-HEEL-GUARD	Pegs Heel Guard	324	4	180.00	2024-12-01 10:30:00	2023-12-04 15:50:00
701	LEVAS-CAMB-QUICK	Levas Cambio Quick Shifter	325	2	450.00	2024-12-02 11:45:00	2023-12-03 16:05:00
702	PEDAL-REAR-SET	Pedal Rear Set	326	2	550.00	2024-12-03 12:00:00	2023-12-02 08:20:00
703	ESCAP-SUPER-TRAPP	Escape Super Trapp	327	1	1200.00	2024-12-04 13:15:00	2023-12-01 09:35:00
704	FIL-AIRE-KN-RC-0980	Filtro Aire K&N RC-0980	328	3	280.00	2024-12-05 14:30:00	2023-11-30 10:50:00
705	KIT-REL-ALU	Kit Relación Aluminio	329	1	650.00	2024-12-06 15:45:00	2023-11-29 12:05:00
706	RADI-OVERSIZE	Radiador Oversize	332	1	1200.00	2024-12-07 16:10:00	2023-11-28 13:20:00
707	VENT-RADI-DUAL	Ventilador Radiador Dual	333	2	280.00	2024-12-08 08:25:00	2023-11-27 14:35:00
708	TERM-LOW-TEMP	Termostato Low Temp	334	3	95.00	2024-12-09 09:40:00	2023-11-26 15:50:00
709	BOM-GAS-AEROMOTIVE	Bomba Gasolina Aeromotive	336	1	850.00	2024-12-10 10:55:00	2023-11-25 16:05:00
710	REG-PRES-AEROMOTIVE	Regulador Presión Aeromotive	337	2	350.00	2024-12-11 11:20:00	2023-11-24 08:20:00
711	RAIL-GAS-FUELAB	Rail Gasolina Fuelab	338	1	280.00	2024-12-12 12:35:00	2023-11-23 09:35:00
712	INY-BOSCH-1000CC	Inyector Bosch 1000cc	339	2	650.00	2024-12-13 13:50:00	2023-11-22 10:50:00
713	SENS-IAT-RACE	Sensor IAT Race	340	2	180.00	2024-12-14 14:05:00	2023-11-21 12:05:00
714	ECU-AEM-SERIES-2	ECU AEM Series 2	341	1	8500.00	2024-12-15 15:20:00	2023-11-20 13:20:00
715	KIT-TURBO-GT40	Kit Turbo GT40	342	1	15000.00	2024-12-16 16:35:00	2023-11-19 14:35:00
716	INTER-TURBO-AIR-WATER	Intercooler Turbo Air-Water	344	1	2800.00	2024-12-17 08:50:00	2023-11-18 15:50:00
717	VALV-BLOW-TIAL	Válvula Blow-Off Tial	345	1	650.00	2024-12-18 09:15:00	2023-11-17 16:05:00
718	WASTEGATE-TIAL-44MM	Wastegate Tial 44mm	346	1	1200.00	2024-12-19 10:30:00	2023-11-16 08:20:00
719	BOOST-CONT-GREDDY	Boost Controller Greddy	347	1	1800.00	2024-12-20 11:45:00	2023-11-15 09:35:00
720	SIST-INY-SNOW	Sistema Inyección Snow	348	1	3500.00	2024-12-21 12:00:00	2023-11-14 10:50:00
721	KIT-NOS-PRO-SHOT	Kit NOS Pro Shot	349	1	5800.00	2024-12-22 13:15:00	2023-11-13 12:05:00
722	SIST-ENC-MOTEC	Sistema Encendido Motec	350	1	2800.00	2024-12-23 14:30:00	2023-11-12 13:20:00
723	DIST-MSD-PRO-BILLET	Distribuidor MSD Pro Billet	351	1	850.00	2024-12-24 15:45:00	2023-11-11 14:35:00
724	AVAN-ENC-MS-DIGITAL	Avanzador Encendido MSD Digital	352	1	450.00	2024-12-25 16:10:00	2023-11-10 15:50:00
725	SIST-ADM-COLD-AIR	Sistema Admisión Cold Air	353	1	1200.00	2024-12-26 08:25:00	2023-11-09 16:05:00
726	COLEC-ADM-SHEET-METAL	Colector Admisión Sheet Metal	354	1	650.00	2024-12-27 09:40:00	2023-11-08 08:20:00
727	BODY-MARI-58MM	Body Mariposa 58mm	355	1	850.00	2024-12-28 10:55:00	2023-11-07 09:35:00
729	SILEN-ARROW-MEGAPHONE	Silenciador Arrow Megaphone	359	1	950.00	2024-12-30 12:35:00	2023-11-05 12:05:00
730	SENS-O2-AEM-WIDEBAND	Sensor O2 AEM Wideband	361	1	850.00	2024-12-31 13:50:00	2023-11-04 13:20:00
731	VALV-EGR-DELETE-KIT	Válvula EGR Delete Kit	362	2	180.00	2025-01-01 14:05:00	2023-11-03 14:35:00
732	SIST-PCV-OIL-CATCH	Sistema PCV Oil Catch	363	2	350.00	2025-01-02 15:20:00	2023-11-02 15:50:00
733	CANISTER-DELETE-KIT	Canister Delete Kit	364	2	120.00	2025-01-03 16:35:00	2023-11-01 16:05:00
734	SENS-EVAP-DELETE	Sensor EVAP Delete	365	2	150.00	2025-01-04 08:50:00	2023-10-31 08:20:00
735	EQUI-ALIN-HUNTER	Equipo Alineación Hunter	367	1	8500.00	2025-01-05 09:15:00	2023-10-30 09:35:00
736	SIST-BAL-HUNTER	Sistema Balanceo Hunter	368	1	6500.00	2025-01-06 10:30:00	2023-10-29 10:50:00
737	MED-ANG-CASTER	Medidor Ángulo Caster	369	1	950.00	2025-01-07 11:45:00	2023-10-28 12:05:00
738	SIST-MED-CHAS-LASER	Sistema Medición Chasis Láser	370	1	15000.00	2025-01-08 12:00:00	2023-10-27 13:20:00
739	HERR-CUAD-PRO	Herramientas Cuadro Pro	371	1	650.00	2025-01-09 13:15:00	2023-10-26 14:35:00
740	SIST-ENDREZ-PRO	Sistema Enderezado Pro	372	1	15000.00	2025-01-10 14:30:00	2023-10-25 15:50:00
741	PUNT-ANCL-PRO	Puntos Anclaje Pro	373	4	85.00	2025-01-11 15:45:00	2023-10-24 16:05:00
742	SOP-MOT-PRO	Soporte Motor Pro	374	1	450.00	2025-01-12 16:10:00	2023-10-23 08:20:00
743	POLIP-1TON-PRO	Polipasto 1 Ton Pro	375	1	1200.00	2025-01-13 08:25:00	2023-10-22 09:35:00
744	MESA-ELEV-1500KG	Mesa Elevadora 1500kg	376	1	6500.00	2025-01-14 09:40:00	2023-10-21 10:50:00
745	SIST-SUJ-PRO	Sistema Sujeción Pro	377	1	450.00	2025-01-15 10:55:00	2023-10-20 12:05:00
746	ROD-TRAB-PRO	Rodillos Trabajo Pro	378	4	120.00	2025-01-16 11:20:00	2023-10-19 13:20:00
747	PROT-PISO-EPOXI-PRO	Protección Piso Epóxi Pro	379	2	280.00	2025-01-17 12:35:00	2023-10-18 14:35:00
748	SEÑ-SEG-PRO	Señalización Seguridad Pro	380	8	35.00	2025-01-18 13:50:00	2023-10-17 15:50:00
749	EXT-CO2-10KG	Extintor CO2 10kg	381	2	350.00	2025-01-19 14:05:00	2023-10-16 16:05:00
750	KIT-PRIM-AUX-100P	Kit Primeros Auxilios 100 Personas	382	1	850.00	2025-01-20 15:20:00	2023-10-15 08:20:00
751	EQUI-LIMP-HP	Equipo Limpieza High Pressure	383	1	2800.00	2025-01-21 16:35:00	2023-10-14 09:35:00
752	SIST-VENT-INDUSTRIAL	Sistema Ventilación Industrial	384	1	4500.00	2025-01-22 08:50:00	2023-10-13 10:50:00
753	ILUM-LED-200W-PRO	Iluminación LED 200W Pro	385	4	180.00	2025-01-23 09:15:00	2023-10-12 12:05:00
754	SIST-ENER-GEN-10KW	Sistema Energía Generador 10KW	386	1	15000.00	2025-01-24 10:30:00	2023-10-11 13:20:00
755	REGL-CONEX-16P-PRO	Regleta Conexión 16 Puertos Pro	387	2	120.00	2025-01-25 11:45:00	2023-10-10 14:35:00
756	TRANS-ISOLATION	Transformador Isolation	388	1	650.00	2025-01-26 12:00:00	2023-10-09 15:50:00
757	ESTAB-VOL-5000W	Estabilizador Voltaje 5000W	389	1	850.00	2025-01-27 13:15:00	2023-10-08 16:05:00
758	SIST-TIERRA-PRO	Sistema Tierra Pro	390	1	1200.00	2025-01-28 14:30:00	2023-10-07 08:20:00
759	EQUI-COM-RADIO-PRO	Equipo Comunicación Radio Pro	391	2	350.00	2025-01-29 15:45:00	2023-10-06 09:35:00
760	SIST-GEST-TALL-ERP	Sistema Gestión Taller ERP	392	1	8500.00	2025-01-30 16:10:00	2023-10-05 10:50:00
761	SOFT-TALL-ERP-PRO	Software Taller ERP Pro	393	1	4500.00	2025-01-31 08:25:00	2023-10-04 12:05:00
762	SIST-INV-RFID	Sistema Inventario RFID	394	1	2800.00	2025-02-01 09:40:00	2023-10-03 13:20:00
763	EQUI-OFI-SERVER	Equipo Oficina Servidor	395	1	12000.00	2025-02-02 10:55:00	2023-10-02 14:35:00
764	MOB-TALL-ERGONOMIC	Mobiliario Taller Ergonómico	396	3	1200.00	2025-02-03 11:20:00	2023-10-01 15:50:00
765	EQUI-DESC-SOFAS	Equipo Descanso Sofás	397	2	2500.00	2025-02-04 12:35:00	2023-09-30 16:05:00
766	SIST-CLIM-CENTRAL	Sistema Climatización Central	398	1	25000.00	2025-02-05 13:50:00	2023-09-29 08:20:00
767	EQUI-LAV-STEAM	Equipo Lavado Steam	399	1	4500.00	2025-02-06 14:05:00	2023-09-28 09:35:00
768	SIST-SEC-AIRE-CAL	Sistema Secado Aire Caliente	400	1	2800.00	2025-02-07 15:20:00	2023-09-27 10:50:00
769	PROD-DET-CERAMIC-PRO	Productos Detailing Ceramic Pro	401	8	180.00	2025-02-08 16:35:00	2023-09-26 12:05:00
770	PUL-PRO-LONG-THROW	Pulidora Pro Long Throw	402	1	1800.00	2025-02-09 08:50:00	2023-09-25 13:20:00
771	SELL-PRO-GLASS	Sellador Pro Glass	403	6	280.00	2025-02-10 09:15:00	2023-09-24 14:35:00
772	TRAT-PINT-GRAPHENE	Tratamiento Pintura Graphene	404	4	350.00	2025-02-11 10:30:00	2023-09-23 15:50:00
773	REST-PLAST-PRO-PLUS	Restaurador Plástico Pro Plus	405	8	95.00	2025-02-12 11:45:00	2023-09-22 16:05:00
774	TRAT-CUERO-PRO	Tratamiento Cuero Pro	406	6	120.00	2025-02-13 12:00:00	2023-09-21 08:20:00
775	PROT-MET-CERAMIC	Protector Metal Ceramic	407	10	65.00	2025-02-14 13:15:00	2023-09-20 09:35:00
776	RENOV-GOMA-PRO	Renovador Goma Pro	408	12	45.00	2025-02-15 14:30:00	2023-09-19 10:50:00
777	LIM-ALFOM-PRO	Limpiador Alfombras Pro	409	8	75.00	2025-02-16 15:45:00	2023-09-18 12:05:00
778	DESINF-HOSPITAL	Desinfectante Hospital	410	6	85.00	2025-02-17 16:10:00	2023-09-17 13:20:00
779	AMBIENT-PRO-FRESH	Ambientador Pro Fresh	411	10	35.00	2025-02-18 08:25:00	2023-09-16 14:35:00
780	PROD-MANT-INT-PRO	Productos Mantenimiento Interior Pro	412	8	65.00	2025-02-19 09:40:00	2023-09-15 15:50:00
781	KIT-LIM-PRO-DELUXE	Kit Limpieza Pro Deluxe	413	2	650.00	2025-02-20 10:55:00	2023-09-14 16:05:00
782	SIST-ALM-PROD-AUTO	Sistema Almacenamiento Productos Automático	414	1	15000.00	2025-02-21 11:20:00	2023-09-13 08:20:00
783	EXHIB-GON-SMART	Exhibidor Góndola Smart	415	1	2800.00	2025-02-22 12:35:00	2023-09-12 09:35:00
784	MAT-POP-DIGITAL	Material POP Digital	416	4	350.00	2025-02-23 13:50:00	2023-09-11 10:50:00
785	SIST-ETIQ-RFID	Sistema Etiquetado RFID	417	1	1200.00	2025-02-24 14:05:00	2023-09-10 12:05:00
786	EMB-CAJ-PLAST	Embalaje Caja Plástico	418	20	25.00	2025-02-25 15:20:00	2023-09-09 13:20:00
787	MAT-SEG-PRO	Material Seguridad Pro	419	6	55.00	2025-02-26 16:35:00	2023-09-08 14:35:00
788	EQUI-TRANS-PALLET	Equipo Transporte Pallet	420	2	450.00	2025-02-27 08:50:00	2023-09-07 15:50:00
789	SIST-LOG-GPS	Sistema Logística GPS	421	1	2800.00	2025-02-28 09:15:00	2023-09-06 16:05:00
790	SOFT-VENT-CLOUD	Software Ventas Cloud	422	1	4500.00	2025-03-01 10:30:00	2023-09-05 08:20:00
791	TERM-POS-MOBILE	Terminal POS Mobile	423	2	1800.00	2025-03-02 11:45:00	2023-09-04 09:35:00
792	SIST-PAG-MOBILE	Sistema Pago Mobile	424	1	1200.00	2025-03-03 12:00:00	2023-09-03 10:50:00
793	EQUI-COB-POS	Equipo Cobro POS	425	1	650.00	2025-03-04 13:15:00	2023-09-02 12:05:00
794	SIST-FID-DIGITAL	Sistema Fidelización Digital	426	1	1800.00	2025-03-05 14:30:00	2023-09-01 13:20:00
795	MAT-MER-DIGITAL	Material Mercadotecnia Digital	427	5	150.00	2025-03-06 15:45:00	2023-08-31 14:35:00
796	SIST-ATEN-CHAT-BOT	Sistema Atención Chat Bot	428	1	3500.00	2025-03-07 16:10:00	2023-08-30 15:50:00
797	EQUI-COM-VOIP	Equipo Comunicación VoIP	429	2	450.00	2025-03-08 08:25:00	2023-08-29 16:05:00
798	SIST-CITA-AI	Sistema Cita AI	430	1	1200.00	2025-03-09 09:40:00	2023-08-28 08:20:00
799	SOFT-AGEN-AI	Software Agenda AI	431	1	950.00	2025-03-10 10:55:00	2023-08-27 09:35:00
800	SIST-RECORD-AUTO	Sistema Recordatorio Automático	432	1	650.00	2025-03-11 11:20:00	2023-08-26 10:50:00
801	EQUI-ENCU-DIGITAL	Equipo Encuestas Digital	433	1	1800.00	2025-03-12 12:35:00	2023-08-25 12:05:00
802	SIST-GARAN-AUTO	Sistema Garantía Automática	434	1	1200.00	2025-03-13 13:50:00	2023-08-24 13:20:00
804	SIST-HIST-BLOCKCHAIN	Sistema Historial Blockchain	436	1	4500.00	2025-03-15 15:20:00	2023-08-22 15:50:00
805	EQUI-DIAG-AI	Equipo Diagnóstico AI	437	1	8500.00	2025-03-16 16:35:00	2023-08-21 16:05:00
806	SIST-CONS-AI	Sistema Consulta AI	438	1	3500.00	2025-03-17 08:50:00	2023-08-20 08:20:00
807	BASE-DAT-AI	Base Datos AI	439	1	2800.00	2025-03-18 09:15:00	2023-08-19 09:35:00
808	MAN-SERV-AI	Manual Servicio AI	440	3	450.00	2025-03-19 10:30:00	2023-08-18 10:50:00
809	DIAG-AI-AUTO	Diagrama AI Automático	441	5	120.00	2025-03-20 11:45:00	2023-08-17 12:05:00
810	ESQ-PART-AI	Esquema Partes AI	442	4	180.00	2025-03-21 12:00:00	2023-08-16 13:20:00
811	SOFT-DIAG-AI	Software Diagramas AI	443	1	1200.00	2025-03-22 13:15:00	2023-08-15 14:35:00
812	SIST-ACT-AI	Sistema Actualización AI	444	1	650.00	2025-03-23 14:30:00	2023-08-14 15:50:00
813	EQUI-CAP-VR	Equipo Capacitación VR	445	1	8500.00	2025-03-24 15:45:00	2023-08-13 16:05:00
814	MAT-ENTR-VR	Material Entrenamiento VR	446	2	650.00	2025-03-25 16:10:00	2023-08-12 08:20:00
815	SIM-VR-PRO	Simulador VR Pro	447	1	15000.00	2025-03-26 08:25:00	2023-08-11 09:35:00
816	KIT-PRAC-VR	Kit Práctica VR	448	1	2800.00	2025-03-27 09:40:00	2023-08-10 10:50:00
817	SIST-EVAL-AI	Sistema Evaluación AI	449	1	1800.00	2025-03-28 10:55:00	2023-08-09 12:05:00
818	CERT-AI-PRO	Certificación AI Pro	450	2	280.00	2025-03-29 11:20:00	2023-08-08 13:20:00
819	EQUI-DEM-VR	Equipo Demostración VR	451	1	4500.00	2025-03-30 12:35:00	2023-08-07 14:35:00
820	SIST-PRES-HOLO	Sistema Presentación Holograma	452	1	12000.00	2025-03-31 13:50:00	2023-08-06 15:50:00
821	MAT-REF-AI	Material Referencia AI	453	4	180.00	2025-04-01 14:05:00	2023-08-05 16:05:00
822	BIBL-AI-DIG	Biblioteca AI Digital	454	1	1200.00	2025-04-02 15:20:00	2023-08-04 08:20:00
823	SIST-CONS-AI-PRO	Sistema Consulta AI Pro	455	1	650.00	2025-04-03 16:35:00	2023-08-03 09:35:00
824	EQUI-MED-AI	Equipo Medición AI	456	1	25000.00	2025-04-04 08:50:00	2023-08-02 10:50:00
825	SIST-CALIB-AI	Sistema Calibración AI	457	1	18000.00	2025-04-05 09:15:00	2023-08-01 12:05:00
826	PAT-AI-CERT	Patrones AI Certificados	458	3	1200.00	2025-04-06 10:30:00	2023-07-31 13:20:00
827	EQUI-METRO-AI	Equipo Metrología AI	459	1	35000.00	2025-04-07 11:45:00	2023-07-30 14:35:00
828	SIST-TRAZ-AI	Sistema Trazabilidad AI	460	1	12000.00	2025-04-08 12:00:00	2023-07-29 15:50:00
829	EQUI-CAL-AI	Equipo Calidad AI	461	1	1800.00	2025-04-09 13:15:00	2023-07-28 16:05:00
830	SIST-INS-AI	Sistema Inspección AI	462	1	4500.00	2025-04-10 14:30:00	2023-07-27 08:20:00
831	EQUI-PRUE-AI	Equipo Pruebas AI	463	1	6500.00	2025-04-11 15:45:00	2023-07-26 09:35:00
832	SIST-DOC-AI	Sistema Documentación AI	464	1	2800.00	2025-04-12 16:10:00	2023-07-25 10:50:00
833	SOFT-CAL-AI	Software Calidad AI	465	1	4500.00	2025-04-13 08:25:00	2023-07-24 12:05:00
834	SIST-AUD-AI	Sistema Auditoría AI	466	1	1800.00	2025-04-14 09:40:00	2023-07-23 13:20:00
835	EQUI-MED-AI-ENV	Equipo Medición AI Ambiental	467	1	950.00	2025-04-15 10:55:00	2023-07-22 14:35:00
836	SIST-MON-AI	Sistema Monitoreo AI	468	1	2800.00	2025-04-16 11:20:00	2023-07-21 15:50:00
837	EQUI-SEG-AI	Equipo Seguridad AI	469	8	120.00	2025-04-17 12:35:00	2023-07-20 16:05:00
838	SIST-PRO-AI	Sistema Protección AI	470	6	180.00	2025-04-18 13:50:00	2023-07-19 08:20:00
839	EQUI-EMER-AI	Equipo Emergencia AI	471	2	450.00	2025-04-19 14:05:00	2023-07-18 09:35:00
840	SIST-ALAR-AI	Sistema Alarma AI	472	1	1800.00	2025-04-20 15:20:00	2023-07-17 10:50:00
841	EQUI-MON-AI	Equipo Monitoreo AI	473	2	950.00	2025-04-21 16:35:00	2023-07-16 12:05:00
842	SIST-CONT-AI	Sistema Control AI	474	1	2800.00	2025-04-22 08:50:00	2023-07-15 13:20:00
843	EQUI-COM-AI	Equipo Comunicación AI	475	3	350.00	2025-04-23 09:15:00	2023-07-14 14:35:00
844	SIST-GEST-AI	Sistema Gestión AI	476	1	6500.00	2025-04-24 10:30:00	2023-07-13 15:50:00
845	SOFT-PROD-AI	Software Productividad AI	477	1	1200.00	2025-04-25 11:45:00	2023-07-12 16:05:00
846	SIST-AUTO-AI	Sistema Automatización AI	478	1	18000.00	2025-04-26 12:00:00	2023-07-11 08:20:00
847	EQUI-DIG-AI	Equipo Digitalización AI	479	1	4500.00	2025-04-27 13:15:00	2023-07-10 09:35:00
848	SIST-IOT-AI	Sistema IoT AI	480	1	2800.00	2025-04-28 14:30:00	2023-07-09 10:50:00
849	EQUI-RA-AI	Equipo Realidad Aumentada AI	481	1	6500.00	2025-04-29 15:45:00	2023-07-08 12:05:00
850	SIST-VIS-AI	Sistema Visión AI	482	1	12000.00	2025-04-30 16:10:00	2023-07-07 13:20:00
851	ROB-AI-PRO	Robot AI Pro	483	1	65000.00	2025-05-01 08:25:00	2023-07-06 14:35:00
852	SIST-TRANS-AI	Sistema Transporte AI	484	1	18000.00	2025-05-02 09:40:00	2023-07-05 15:50:00
853	EQUI-IMP-3D-AI	Equipo Impresión 3D AI	485	1	35000.00	2025-05-03 10:55:00	2023-07-04 16:05:00
854	SIST-CAD-AI	Sistema CAD AI	486	1	6500.00	2025-05-04 11:20:00	2023-07-03 08:20:00
855	SOFT-DIS-AI	Software Diseño AI	487	1	4500.00	2025-05-05 12:35:00	2023-07-02 09:35:00
856	EQUI-PROT-AI	Equipo Prototipado AI	488	1	1200.00	2025-05-06 13:50:00	2023-07-01 10:50:00
857	SIST-PRUE-AI	Sistema Pruebas AI	489	1	18000.00	2025-05-07 14:05:00	2023-06-30 12:05:00
858	EQUI-ANAL-AI	Equipo Análisis AI	490	1	35000.00	2025-05-08 15:20:00	2023-06-29 13:20:00
859	SIST-ING-AI	Sistema Ingeniería AI	491	1	25000.00	2025-05-09 16:35:00	2023-06-28 14:35:00
860	EQUI-MED-3D-AI	Equipo Medición 3D AI	492	1	65000.00	2025-05-10 08:50:00	2023-06-27 15:50:00
861	SIST-DOC-3D-AI	Sistema Documentación 3D AI	493	1	12000.00	2025-05-11 09:15:00	2023-06-26 16:05:00
862	SOFT-GEST-AI-PRO	Software Gestión AI Pro	494	1	2800.00	2025-05-12 10:30:00	2023-06-25 08:20:00
863	SIST-COLAB-AI	Sistema Colaboración AI	495	1	1200.00	2025-05-13 11:45:00	2023-06-24 09:35:00
864	EQUI-VID-AI	Equipo Videoconferencia AI	496	1	4500.00	2025-05-14 12:00:00	2023-06-23 10:50:00
865	SIST-COMP-AI	Sistema Compartición AI	497	1	1800.00	2025-05-15 13:15:00	2023-06-22 12:05:00
866	PLAT-CLOUD-AI	Plataforma Cloud AI	498	1	1200.00	2025-05-16 14:30:00	2023-06-21 13:20:00
867	SIST-BACK-AI	Sistema Backup AI	499	1	1800.00	2025-05-17 15:45:00	2023-06-20 14:35:00
868	EQUI-CIBER-AI	Equipo Ciberseguridad AI	500	1	4500.00	2025-05-18 16:10:00	2023-06-19 15:50:00
869	SIST-RED-AI	Sistema Red AI	501	1	1800.00	2025-05-19 08:25:00	2023-06-18 16:05:00
870	EQUI-TELECOM-AI	Equipo Telecomunicaciones AI	502	1	2800.00	2025-05-20 09:40:00	2023-06-17 08:20:00
871	SIST-ENER-AI	Sistema Energía AI	503	1	4500.00	2025-05-21 10:55:00	2023-06-16 09:35:00
872	EQUI-MANT-AI	Equipo Mantenimiento AI	504	1	1800.00	2025-05-22 11:20:00	2023-06-15 10:50:00
873	ACE-MOT-5W30-FULL	Aceite Motul 8100 5W30 Full Synthetic	5	14	250.00	2025-05-23 12:35:00	2024-06-15 11:30:00
874	FIL-AIR-BMC-RACE	Filtro Aire BMC Race	7	5	420.00	2025-05-24 13:50:00	2024-06-14 12:45:00
875	BUI-DENSO-IW27	Bujía Denso IW27 Iridium	10	18	150.00	2025-05-25 14:05:00	2024-06-13 14:00:00
876	PAST-FREN-GALFER-DF	Pastillas Freno Galfer DF	11	4	320.00	2025-05-26 15:20:00	2024-06-12 15:15:00
877	CAD-TSUBAKI-SIGMA	Cadena Tsubaki Sigma	16	3	950.00	2025-05-27 16:35:00	2024-06-11 16:30:00
878	NEUM-CONT-ROAD-ATTACK	Neumático Continental Road Attack	18	2	820.00	2025-05-28 08:50:00	2024-06-10 08:45:00
879	BAT-SHORAI-LFX14	Batería Shorai LFX14	21	3	1400.00	2025-05-29 09:15:00	2024-06-09 10:00:00
880	AMORT-WP-PRO	Amortiguador WP Pro	23	1	3800.00	2025-05-30 10:30:00	2024-06-08 11:15:00
881	JUNT-MOT-KAW-Z1000	Kit Juntas Kawasaki Z1000	27	1	750.00	2025-05-31 11:45:00	2024-06-07 12:30:00
882	PIST-WISECO-836	Pistón Wiseco 836 Kit	30	2	580.00	2025-06-01 12:00:00	2024-06-06 13:45:00
883	CARB-FCR-MX-39	Carburador FCR MX 39mm	42	2	1200.00	2025-06-02 13:15:00	2024-06-05 15:00:00
884	INY-SIEMENS-DEKA	Inyector Siemens Deka	44	4	280.00	2025-06-03 14:30:00	2024-06-04 16:15:00
885	BOM-GAS-DW-300	Bomba Gasolina DW300	45	2	850.00	2025-06-04 15:45:00	2024-06-03 08:30:00
886	FAR-AUX-LED-SPOT	Foco Auxiliar LED Spot	47	8	220.00	2025-06-05 16:10:00	2024-06-02 09:45:00
887	ESP-POWER-MIRROR	Espejo Power Mirror	51	6	180.00	2025-06-06 08:25:00	2024-06-01 11:00:00
888	MAN-QUICK-TWIST	Manija Quick Twist	52	4	350.00	2025-06-07 09:40:00	2024-05-31 12:15:00
889	ESCAP-YOSH-R77	Escape Yoshimura R77	59	1	1800.00	2025-06-08 10:55:00	2024-05-30 13:30:00
890	SENS-O2-BOSCH-LSU	Sensor O2 Bosch LSU	62	3	450.00	2025-06-09 11:20:00	2024-05-29 14:45:00
891	ALT-DENSO-50A	Alternador Denso 50A	66	2	950.00	2025-06-10 12:35:00	2024-05-28 16:00:00
892	ARRA-HITACHI-S13	Motor Arranque Hitachi S13	67	1	850.00	2025-06-11 13:50:00	2024-05-27 08:15:00
893	BOB-ACCEL-COIL	Bobina Acell Coil	68	3	420.00	2025-06-12 14:05:00	2024-05-26 09:30:00
894	PORT-EQUI-HEPCO-BECKER	Portaequipajes Hepco Becker	74	2	750.00	2025-06-13 15:20:00	2024-05-25 10:45:00
895	TOP-CASE-GIVI-V47	Top Case Givi V47	76	1	950.00	2025-06-14 16:35:00	2024-05-24 12:00:00
896	GPS-GARMIN-ZUMO	Soporte GPS Garmin Zumo	77	4	280.00	2025-06-15 08:50:00	2024-05-23 13:15:00
897	ALAR-SPY-BALLISTIC	Alarma Spy Ballistic	79	2	550.00	2025-06-16 09:15:00	2024-05-22 14:30:00
898	CAND-DISC-BRAKE	Candado Disc Brake	80	5	280.00	2025-06-17 10:30:00	2024-05-21 15:45:00
899	LUB-CAD-BEL-RAY	Lubricante Cadena Bel Ray	82	15	120.00	2025-06-18 11:45:00	2024-05-20 16:00:00
900	ANTI-PRESTONE-ASIAN	Anticongelante Prestone Asian	83	12	95.00	2025-06-19 12:00:00	2024-05-19 08:15:00
901	LIM-INY-CHEVRON-TECHRON	Limpiador Inyectores Chevron Techron	84	14	85.00	2025-06-20 13:15:00	2024-05-18 09:30:00
902	DEG-PURPLE-POWER	Degrasante Purple Power	85	16	110.00	2025-06-21 14:30:00	2024-05-17 10:45:00
903	LLV-TUBO-3-8-17MM	Llave Tubo 3/8 17mm	87	10	32.00	2025-06-22 15:45:00	2024-05-16 12:00:00
904	TORQ-PREC-3-8	Torquímetro Precisión 3/8"	88	2	450.00	2025-06-23 16:10:00	2024-05-15 13:15:00
905	DEST-TORX-T25	Destornillador Torx T25	89	15	38.00	2025-06-24 08:25:00	2024-05-14 14:30:00
906	ALIC-CORT-BOLT	Alicate Corta Perno	90	8	65.00	2025-06-25 09:40:00	2024-05-13 15:45:00
907	KIT-HER-300PZ-MASTER	Kit Herramientas 300 Piezas Master	91	1	2200.00	2025-06-26 10:55:00	2024-05-12 16:00:00
908	COMP-MOT-PRO-DIG	Compresómetro Pro Digital	95	1	750.00	2025-06-27 11:20:00	2024-05-11 08:15:00
909	MULT-KLEIN-TOOLS	Multímetro Klein Tools	96	2	650.00	2025-06-28 12:35:00	2024-05-10 09:30:00
910	SCAN-SNAP-ON-SOLUS	Scanner Snap-on Solus	97	1	4500.00	2025-06-29 13:50:00	2024-05-09 10:45:00
911	CASO-ARAI-RX-7V	Casco Arai RX-7V	107	2	5500.00	2025-06-30 14:05:00	2024-05-08 12:00:00
912	GUANT-HELD-STEVE	Guantes Held Steve	111	4	750.00	2025-07-01 15:20:00	2024-05-07 13:15:00
913	CHAM-RUKKA-R-K4	Chamarra Rukka R-K4	112	2	2800.00	2025-07-02 16:35:00	2024-05-06 14:30:00
914	BOTAS-SIDI-VERTIGO	Botas Sidi Vertigo	114	3	1500.00	2025-07-03 08:50:00	2024-05-05 15:45:00
915	INTERCOM-SENA-50S	Intercomunicador Sena 50S	117	2	2200.00	2025-07-04 09:15:00	2024-05-04 16:00:00
916	ACEITE-FREN-MOTUL-RBF	Aceite Frenos Motul RBF	119	10	180.00	2025-07-05 10:30:00	2024-05-03 08:15:00
917	GRAS-CERAMIC-BRAKE	Grasa Ceramic Brake	120	8	75.00	2025-07-06 11:45:00	2024-05-02 09:30:00
918	SELL-HYLOMAR	Sellador Hylomar	123	15	120.00	2025-07-07 12:00:00	2024-05-01 10:45:00
919	TORN-10MM-1-25	Tornillos 10mm x 1.25	126	60	4.50	2025-07-08 13:15:00	2024-04-30 12:00:00
920	ABRA-MANGO-50-60	Abrazadera Manguera 50-60mm	127	20	12.00	2025-07-09 14:30:00	2024-04-29 13:15:00
921	ROD-RUEDA-6305	Rodamiento Rueda 6305-2RS	131	6	55.00	2025-07-10 15:45:00	2024-04-28 14:30:00
922	RES-SUSP-OVAL	Resorte Suspensión Oval	135	2	350.00	2025-07-11 16:10:00	2024-04-27 15:45:00
923	MANG-FREN-STAINLESS	Manguito Freno Stainless	138	4	85.00	2025-07-12 08:25:00	2024-04-26 16:00:00
924	CIL-MAES-BREMBO-19	Cilindro Maestro Brembo 19mm	140	2	420.00	2025-07-13 09:40:00	2024-04-25 08:15:00
925	SENS-ABS-DUAL	Sensor ABS Dual	142	2	280.00	2025-07-14 10:55:00	2024-04-24 09:30:00
926	BUI-PULSE-PLUG	Bujía Pulse Plug	144	8	180.00	2025-07-15 11:20:00	2024-04-23 10:45:00
927	CAB-BUJ-TAYLOR	Cable Bujía Taylor	146	6	220.00	2025-07-16 12:35:00	2024-04-22 12:00:00
928	REG-VOL-MOSFET	Regulador Voltaje MOSFET	148	3	280.00	2025-07-17 13:50:00	2024-04-21 13:15:00
929	BAT-LIT-ENERGY-PRO	Batería Litio Energy Pro	156	2	1800.00	2025-07-18 14:05:00	2024-04-20 14:30:00
930	CARG-BAT-CTEK-PRO	Cargador Batería CTEK Pro	157	2	750.00	2025-07-19 15:20:00	2024-04-19 15:45:00
931	PORT-CEL-SP-GEOMETRY	Porta Celular SP Connect	161	6	320.00	2025-07-20 16:35:00	2024-04-18 16:00:00
932	SOP-DJI-ACTION	Soporte DJI Action	162	4	150.00	2025-07-21 08:50:00	2024-04-17 08:15:00
933	BOC-STEBEL-NAUTILUS	Bocina Stebel Nautilus	164	8	120.00	2025-07-22 09:15:00	2024-04-16 09:30:00
934	LUC-LED-AUX-8	Luces LED Auxiliares 8"	170	2	580.00	2025-07-23 10:30:00	2024-04-15 10:45:00
935	MOD-ABS-NISSIN	Módulo Control ABS Nissin	174	1	2500.00	2025-07-24 11:45:00	2024-04-14 12:00:00
936	SIST-INMOV-DATATOOL	Sistema Inmovilizador Datatool	178	2	650.00	2025-07-25 12:00:00	2024-04-13 13:15:00
937	PROT-MOT-CNC-BILLET	Protector Motor CNC Billet	185	4	450.00	2025-07-26 13:15:00	2024-04-12 14:30:00
938	PROT-MAN-BAR-END-CARB	Protector Manubrio Bar End Carbono	186	8	95.00	2025-07-27 14:30:00	2024-04-11 15:45:00
939	REJ-RADI-STAINLESS	Rejilla Radiador Stainless	187	2	550.00	2025-07-28 15:45:00	2024-04-10 16:00:00
940	PROT-TANK-CARBON	Protector Tanque Carbon	188	3	280.00	2025-07-29 16:10:00	2024-04-09 08:15:00
941	FUND-ASIENT-HEATED	Funda Asiento Calefaccionada	189	1	650.00	2025-07-30 08:25:00	2024-04-08 09:30:00
942	REP-AGUA-GLASS-COAT	Repelente Agua Glass Coat	190	6	180.00	2025-07-31 09:40:00	2024-04-07 10:45:00
943	CERAM-PINT-10H	Cerámico Pintura 10H	191	4	750.00	2025-08-01 10:55:00	2024-04-06 12:00:00
944	PUL-3M-PERFECT-IT	Pulidor 3M Perfect-It	192	8	150.00	2025-08-02 11:20:00	2024-04-05 13:15:00
945	CERA-CHEMICAL-GUYS	Cera Chemical Guys	193	10	180.00	2025-08-03 12:35:00	2024-04-04 14:30:00
946	LIM-LLAN-ADAMS-POLISH	Limpiador Llantas Adams Polish	194	12	120.00	2025-08-04 13:50:00	2024-04-03 15:45:00
947	LIM-CAD-DU-PONT	Limpiador Cadena Du Pont	195	16	85.00	2025-08-05 14:05:00	2024-04-02 16:00:00
948	PROT-PLAST-CAR-PRO	Protector Plástico Car Pro	196	10	110.00	2025-08-06 15:20:00	2024-04-01 08:15:00
949	LIM-FREN-PERMATEX	Limpiador Frenos Permatex	197	12	75.00	2025-08-07 16:35:00	2024-03-31 09:30:00
950	DESENG-SIMPLE-GREEN-PRO	Desengrasante Simple Green Pro	198	4	280.00	2025-08-08 08:50:00	2024-03-30 10:45:00
951	LUB-CAD-MAXIMA-CHAIN	Lubricante Cadena Maxima Chain	199	18	150.00	2025-08-09 09:15:00	2024-03-29 12:00:00
952	SILIC-SPRAY-CRC-HIGH	Spray Silicona CRC High Temp	200	20	65.00	2025-08-10 10:30:00	2024-03-28 13:15:00
953	ACE-PENET-PB-BLASTER	Aceite Penetrante PB Blaster	201	14	110.00	2025-08-11 11:45:00	2024-03-27 14:30:00
954	GRAS-NEVER-SEEZ	Grasa Never-Seez	202	8	95.00	2025-08-12 12:00:00	2024-03-26 15:45:00
955	GRAS-WHEEL-BEARING	Grasa Wheel Bearing	203	10	55.00	2025-08-13 13:15:00	2024-03-25 16:00:00
956	COMP-VALV-PERMATEX-ULTRA	Compuesto Válvulas Permatex Ultra	205	4	150.00	2025-08-14 14:30:00	2024-03-24 08:15:00
957	PASTE-CALIPER-CERAMIC	Paste Caliper Ceramic	206	6	75.00	2025-08-15 15:45:00	2024-03-23 09:30:00
958	COMP-MONT-TIRE-PRO	Compuesto Montaje Tire Pro	207	10	85.00	2025-08-16 16:10:00	2024-03-22 10:45:00
959	SELL-NEUM-RIDE-ON	Sellante Neumáticos Ride-On	208	8	180.00	2025-08-17 08:25:00	2024-03-21 12:00:00
960	ADIT-RADI-PEAK-FINAL	Aditivo Radiador Peak Final Charge	209	12	110.00	2025-08-18 09:40:00	2024-03-20 13:15:00
961	COND-GOMAS-303-PROTECTANT	Condicionador Gomas 303 Protectant	210	15	95.00	2025-08-19 10:55:00	2024-03-19 14:30:00
962	DESM-NEUM-HUNTER	Desmontadora Neumáticos Hunter	212	1	1200.00	2025-08-20 11:20:00	2024-03-18 15:45:00
963	EQUI-RUEDA-COATS	Equilibradora Ruedas Coats	213	1	3500.00	2025-08-21 12:35:00	2024-03-17 16:00:00
964	MED-PRES-TIRE-TEK	Medidor Presión Tire Tek	214	5	220.00	2025-08-22 13:50:00	2024-03-16 08:15:00
965	INFL-12V-VIAIR	Inflador 12V Viair	215	3	450.00	2025-08-23 14:05:00	2024-03-15 09:30:00
966	KIT-PAR-ULTRA	Kit Parches Ultra	216	10	150.00	2025-08-24 15:20:00	2024-03-14 10:45:00
967	PARCH-NEUM-RADIAL	Parches Neumáticos Radial	217	20	18.00	2025-08-25 16:35:00	2024-03-13 12:00:00
968	VALV-NEUM-TPMS	Válvulas Neumáticos TPMS	218	15	25.00	2025-08-26 08:50:00	2024-03-12 13:15:00
969	TAPA-VALV-TPMS	Tapas Válvulas TPMS	219	25	12.00	2025-08-27 09:15:00	2024-03-11 14:30:00
970	EXT-VALV-360DEG	Extensor Válvulas 360°	220	6	42.00	2025-08-28 10:30:00	2024-03-10 15:45:00
971	TRONCH-CAD-RK-ULTRA	Tronchadora Cadena RK Ultra	222	1	350.00	2025-08-29 11:45:00	2024-03-09 16:00:00
972	REMACH-CAD-DID-ULTRA	Remachadora Cadena DID Ultra	223	1	450.00	2025-08-30 12:00:00	2024-03-08 08:15:00
973	MED-DESG-CHAIN	Medidor Desgaste Chain	224	2	75.00	2025-08-31 13:15:00	2024-03-07 09:30:00
974	LAV-CAD-MOTUL-CHAIN	Lavadora Cadena Motul Chain	225	3	150.00	2025-09-01 14:30:00	2024-03-06 10:45:00
975	KIT-ENGR-PJ1-BLUE	Kit Engrase PJ1 Blue	226	5	180.00	2025-09-02 15:45:00	2024-03-05 12:00:00
976	COMP-SUSP-RACE	Compresor Suspensión Race	228	1	480.00	2025-09-03 16:10:00	2024-03-04 13:15:00
977	CALIB-VALV-PRECISION	Calibrador Válvulas Precision	230	1	120.00	2025-09-04 08:25:00	2024-03-03 14:30:00
978	GATO-SUSP-PNEUMATIC-PRO	Gato Suspensión Pneumatic Pro	231	1	850.00	2025-09-05 09:40:00	2024-03-02 15:45:00
979	EXT-PIST-RACE	Extractor Pistones Race	233	1	220.00	2025-09-06 10:55:00	2024-03-01 16:00:00
980	INS-PIST-RACE	Insertador Pistones Race	234	1	150.00	2025-09-07 11:20:00	2024-02-29 08:15:00
981	TORQ-DIG-RACE	Torquímetro Digital Race	235	1	1200.00	2025-09-08 12:35:00	2024-02-28 09:30:00
982	MIC-50-75MM	Micrómetro 50-75mm	237	1	350.00	2025-09-09 13:50:00	2024-02-27 10:45:00
983	CALIB-VERN-300	Calibrador Vernier 300mm	238	2	280.00	2025-09-10 14:05:00	2024-02-26 12:00:00
984	GALGA-ESP-PRECISION	Galga Espesores Precision	239	3	75.00	2025-09-11 15:20:00	2024-02-25 13:15:00
985	IND-GOTA-DIGITAL	Indicador Gota Digital	240	1	220.00	2025-09-12 16:35:00	2024-02-24 14:30:00
986	COMP-ADV-RACE	Compresómetro Avanzado Race	241	1	850.00	2025-09-13 08:50:00	2024-02-23 15:45:00
987	VACU-CARB-RACE	Vacuómetro Carburadores Race	242	1	280.00	2025-09-14 09:15:00	2024-02-22 16:00:00
988	FLOW-INY-RACE	Flow Meter Inyectores Race	243	1	1200.00	2025-09-15 10:30:00	2024-02-21 08:15:00
989	OSC-DIG-100MHZ-RACE	Osciloscopio Digital 100MHz Race	244	1	3500.00	2025-09-16 11:45:00	2024-02-20 09:30:00
990	GEN-SEÑ-RACE	Generador Señal Race	245	1	750.00	2025-09-17 12:00:00	2024-02-19 10:45:00
991	SIM-SENS-RACE	Simulador Sensor Race	246	1	450.00	2025-09-18 13:15:00	2024-02-18 12:00:00
992	PROG-ECU-RACE	Programador ECU Race	247	1	4500.00	2025-09-19 14:30:00	2024-02-17 13:15:00
993	INTER-DIAG-RACE	Interface Diagnóstico Race	248	1	650.00	2025-09-20 15:45:00	2024-02-16 14:30:00
994	SOFT-DIAG-RACE	Software Diagnóstico Race	249	1	1500.00	2025-09-21 16:10:00	2024-02-15 15:45:00
995	KIT-PRUE-RACE	Kit Prueba Race	250	1	450.00	2025-09-22 08:25:00	2024-02-14 16:00:00
996	MAN-GAS-RACE	Manómetro Gasolina Race	251	1	350.00	2025-09-23 09:40:00	2024-02-13 08:15:00
997	BOM-VAC-RACE	Bomba Vacío Race	252	1	750.00	2025-09-24 10:55:00	2024-02-12 09:30:00
998	DET-FUGA-RACE	Detector Fugas Race	253	1	1200.00	2025-09-25 11:20:00	2024-02-11 10:45:00
999	ESTET-RACE	Estetoscopio Race	254	1	250.00	2025-09-26 12:35:00	2024-02-10 12:00:00
1000	TERM-INFR-RACE	Termómetro Infrarrojo Race	255	1	850.00	2025-09-27 13:50:00	2024-02-09 13:15:00
1001	ANEM-RACE	Anemómetro Race	256	1	550.00	2025-09-28 14:05:00	2024-02-08 14:30:00
1002	MAN-ACE-RACE	Manómetro Aceite Race	257	1	550.00	2025-09-29 15:20:00	2024-02-07 15:45:00
1003	BAN-PRUE-RACE	Banco Prueba Race	258	1	4500.00	2025-09-30 16:35:00	2024-02-06 16:00:00
1004	PROB-BUI-RACE	Probador Bujías Race	259	1	450.00	2025-10-01 08:50:00	2024-02-05 08:15:00
1005	PROB-ALT-RACE	Probador Alternador Race	260	1	650.00	2025-10-02 09:15:00	2024-02-04 09:30:00
1007	ACE-20W50	Aceite Motul 20W50 5100	5	100	150.00	2025-11-24 17:09:37.255565	2025-11-24 17:16:51.157071
\.


--
-- TOC entry 5038 (class 0 OID 16630)
-- Dependencies: 226
-- Data for Name: motos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motos (id, cliente_id, modelo, placa, ano, fecha_creacion) FROM stdin;
16	1	Honda CBR 600RR	MTR001	2020	2023-01-15 09:30:00
17	2	Yamaha R6	MTR002	2019	2023-01-16 10:15:00
18	3	Kawasaki Ninja 650	MTR003	2021	2023-01-17 11:20:00
19	4	Suzuki GSX-R750	MTR004	2018	2023-01-18 12:45:00
20	5	Ducati Panigale V4	MTR005	2022	2023-01-19 14:30:00
21	6	BMW S1000RR	MTR006	2020	2023-01-20 16:15:00
22	7	Harley Davidson Sportster	MTR007	2019	2023-01-21 08:45:00
23	8	KTM Duke 390	MTR008	2021	2023-01-22 09:30:00
8	501	Pulsar Ns 200	544fesd	2016	2025-10-24 19:21:46.645538
9	502	Ninja 500	24sd58	2025	2025-10-30 15:07:06.649276
10	503	Ninja 500	jhsd845	2025	2025-10-30 18:55:29.951248
11	504	Pulsar Ns200	254sd8	2025	2025-11-05 14:32:46.547016
12	505	N250	54sd5fd	2025	2025-11-05 14:37:14.421247
24	9	Triumph Street Triple	MTR009	2018	2023-01-23 10:15:00
25	10	Aprilia RSV4	MTR010	2022	2023-01-24 11:00:00
15	507	ns	458hju	2020	2025-11-12 14:40:20.330019
26	11	Honda Rebel 500	MTR011	2020	2023-01-25 12:20:00
27	12	Yamaha MT-07	MTR012	2019	2023-01-26 13:45:00
28	13	Kawasaki Z900	MTR013	2021	2023-01-27 14:30:00
29	14	Suzuki Hayabusa	MTR014	2018	2023-01-28 15:15:00
30	15	Ducati Monster 821	MTR015	2022	2023-01-29 16:00:00
31	16	BMW R1250GS	MTR016	2020	2023-01-30 08:20:00
32	17	Harley Davidson Softail	MTR017	2019	2023-01-31 09:10:00
33	18	KTM RC 390	MTR018	2021	2023-02-01 10:05:00
34	19	Triumph Tiger 800	MTR019	2018	2023-02-02 11:30:00
35	20	Aprilia Tuono 660	MTR020	2022	2023-02-03 12:45:00
36	21	Honda CB500F	MTR021	2020	2023-02-04 13:20:00
37	22	Yamaha XMAX 300	MTR022	2019	2023-02-05 14:15:00
38	23	Kawasaki Vulcan S	MTR023	2021	2023-02-06 15:40:00
39	24	Suzuki V-Strom 650	MTR024	2018	2023-02-07 16:25:00
40	25	Ducati Scrambler	MTR025	2022	2023-02-08 08:50:00
41	26	BMW F750GS	MTR026	2020	2023-02-09 09:35:00
42	27	Harley Davidson Road King	MTR027	2019	2023-02-10 10:40:00
43	28	KTM 790 Adventure	MTR028	2021	2023-02-11 11:55:00
44	29	Triumph Bonneville T120	MTR029	2018	2023-02-12 12:30:00
45	30	Aprilia Shiver 900	MTR030	2022	2023-02-13 13:45:00
46	31	Honda Africa Twin	MTR031	2020	2023-02-14 14:20:00
47	32	Yamaha Tracer 900	MTR032	2019	2023-02-15 15:10:00
48	33	Kawasaki H2 SX	MTR033	2021	2023-02-16 16:05:00
49	34	Suzuki Katana	MTR034	2018	2023-02-17 08:15:00
50	35	Ducati Multistrada V4	MTR035	2022	2023-02-18 09:25:00
51	36	BMW K1600GTL	MTR036	2020	2023-02-19 10:35:00
52	37	Harley Davidson Breakout	MTR037	2019	2023-02-20 11:45:00
53	38	KTM 1290 Super Duke R	MTR038	2021	2023-02-21 12:55:00
54	39	Triumph Rocket 3	MTR039	2018	2023-02-22 13:40:00
55	40	Aprilia RS 660	MTR040	2022	2023-02-23 14:50:00
56	41	Honda Gold Wing	MTR041	2020	2023-02-24 15:30:00
57	42	Yamaha Niken GT	MTR042	2019	2023-02-25 16:20:00
58	43	Kawasaki Z1000	MTR043	2021	2023-02-26 08:40:00
59	44	Suzuki Burgman 400	MTR044	2018	2023-02-27 09:50:00
60	45	Ducati Diavel 1260	MTR045	2022	2023-02-28 10:25:00
61	46	BMW C400X	MTR046	2020	2023-03-01 11:35:00
62	47	Harley Davidson Street Glide	MTR047	2019	2023-03-02 12:45:00
63	48	KTM 450 EXC	MTR048	2021	2023-03-03 13:20:00
64	49	Triumph Speed Triple	MTR049	2018	2023-03-04 14:30:00
65	50	Aprilia Caponord 1200	MTR050	2022	2023-03-05 15:40:00
66	51	Honda NC750X	MTR051	2020	2023-03-06 16:15:00
67	52	Yamaha WR250R	MTR052	2019	2023-03-07 08:25:00
68	53	Kawasaki Versys 650	MTR053	2021	2023-03-08 09:35:00
69	54	Suzuki DR-Z400S	MTR054	2018	2023-03-09 10:45:00
70	55	Ducati Hypermotard 950	MTR055	2022	2023-03-10 11:55:00
71	56	BMW R18	MTR056	2020	2023-03-11 12:30:00
72	57	Harley Davidson Low Rider S	MTR057	2019	2023-03-12 13:40:00
73	58	KTM 500 EXC-F	MTR058	2021	2023-03-13 14:50:00
74	59	Triumph Trident 660	MTR059	2018	2023-03-14 15:25:00
75	60	Aprilia Dorsoduro 900	MTR060	2022	2023-03-15 16:35:00
76	61	Honda CBR1000RR	MTR061	2020	2023-03-16 08:45:00
77	62	Yamaha YZF-R1	MTR062	2019	2023-03-17 09:20:00
78	63	Kawasaki Ninja 400	MTR063	2021	2023-03-18 10:30:00
79	64	Suzuki GSX-S1000	MTR064	2018	2023-03-19 11:40:00
80	65	Ducati Streetfighter V4	MTR065	2022	2023-03-20 12:50:00
81	66	BMW M1000RR	MTR066	2020	2023-03-21 13:25:00
82	67	Harley Davidson Fat Boy	MTR067	2019	2023-03-22 14:35:00
83	68	KTM 890 Duke	MTR068	2021	2023-03-23 15:45:00
84	69	Triumph Scrambler 1200	MTR069	2018	2023-03-24 16:20:00
85	70	Aprilia RS 125	MTR070	2022	2023-03-25 08:30:00
86	71	Honda CB650R	MTR071	2020	2023-03-26 09:40:00
87	72	Yamaha MT-09	MTR072	2019	2023-03-27 10:50:00
88	73	Kawasaki Z650	MTR073	2021	2023-03-28 11:25:00
89	74	Suzuki SV650	MTR074	2018	2023-03-29 12:35:00
90	75	Ducati SuperSport 950	MTR075	2022	2023-03-30 13:45:00
91	76	BMW F850GS	MTR076	2020	2023-03-31 14:55:00
92	77	Harley Davidson Electra Glide	MTR077	2019	2023-04-01 15:30:00
93	78	KTM 390 Adventure	MTR078	2021	2023-04-02 16:40:00
94	79	Triumph Thruxton RS	MTR079	2018	2023-04-03 08:50:00
95	80	Aprilia Tuono V4	MTR080	2022	2023-04-04 09:35:00
96	81	Honda Shadow 750	MTR081	2020	2023-04-05 10:45:00
97	82	Yamaha Bolt R-Spec	MTR082	2019	2023-04-06 11:55:00
98	83	Kawasaki W800	MTR083	2021	2023-04-07 12:40:00
99	84	Suzuki Intruder 800	MTR084	2018	2023-04-08 13:50:00
100	85	Ducati XDiavel	MTR085	2022	2023-04-09 14:25:00
101	86	BMW R nineT	MTR086	2020	2023-04-10 15:35:00
102	87	Harley Davidson Iron 883	MTR087	2019	2023-04-11 16:45:00
103	88	KTM 250 SX-F	MTR088	2021	2023-04-12 08:55:00
104	89	Triumph Tiger 1200	MTR089	2018	2023-04-13 09:40:00
105	90	Aprilia Pegaso 650	MTR090	2022	2023-04-14 10:50:00
106	91	Honda CRF250L	MTR091	2020	2023-04-15 11:30:00
107	92	Yamaha TW200	MTR092	2019	2023-04-16 12:40:00
108	93	Kawasaki KLX230	MTR093	2021	2023-04-17 13:50:00
109	94	Suzuki RM-Z250	MTR094	2018	2023-04-18 14:25:00
110	95	Ducati DesertX	MTR095	2022	2023-04-19 15:35:00
111	96	BMW G310GS	MTR096	2020	2023-04-20 16:45:00
112	97	Harley Davidson Pan America	MTR097	2019	2023-04-21 08:35:00
113	98	KTM 350 EXC-F	MTR098	2021	2023-04-22 09:45:00
114	99	Triumph Street Scrambler	MTR099	2018	2023-04-23 10:55:00
115	100	Aprilia RSV4 Factory	MTR100	2022	2023-04-24 11:40:00
116	101	Honda CBR250R	MTR101	2020	2023-04-25 12:50:00
117	102	Yamaha MT-03	MTR102	2019	2023-04-26 13:35:00
118	103	Kawasaki Ninja 300	MTR103	2021	2023-04-27 14:45:00
119	104	Suzuki GSX250R	MTR104	2018	2023-04-28 15:55:00
120	105	Ducati Monster 797	MTR105	2022	2023-04-29 16:30:00
121	106	BMW C650GT	MTR106	2020	2023-04-30 08:40:00
122	107	Harley Davidson LiveWire	MTR107	2019	2023-05-01 09:50:00
123	108	KTM 690 Enduro R	MTR108	2021	2023-05-02 10:25:00
124	109	Triumph Tiger Sport 660	MTR109	2018	2023-05-03 11:35:00
125	110	Aprilia Tuareg 660	MTR110	2022	2023-05-04 12:45:00
126	111	Honda PCX150	MTR111	2020	2023-05-05 13:20:00
127	112	Yamaha NMAX 155	MTR112	2019	2023-05-06 14:30:00
128	113	Kawasaki J300	MTR113	2021	2023-05-07 15:40:00
129	114	Suzuki Address 110	MTR114	2018	2023-05-08 16:15:00
130	115	Ducati 899 Panigale	MTR115	2022	2023-05-09 08:25:00
131	116	BMW R1250R	MTR116	2020	2023-05-10 09:35:00
132	117	Harley Davidson Roadster	MTR117	2019	2023-05-11 10:45:00
133	118	KTM 1090 Adventure R	MTR118	2021	2023-05-12 11:55:00
134	119	Triumph Bobber	MTR119	2018	2023-05-13 12:30:00
135	120	Aprilia Mana 850	MTR120	2022	2023-05-14 13:40:00
136	121	Honda CB1100	MTR121	2020	2023-05-15 14:50:00
137	122	Yamaha XSR700	MTR122	2019	2023-05-16 15:25:00
138	123	Kawasaki Z400	MTR123	2021	2023-05-17 16:35:00
139	124	Suzuki GS500	MTR124	2018	2023-05-18 08:45:00
140	125	Ducati 1199 Panigale	MTR125	2022	2023-05-19 09:20:00
141	126	BMW K1300S	MTR126	2020	2023-05-20 10:30:00
142	127	Harley Davidson V-Rod	MTR127	2019	2023-05-21 11:40:00
143	128	KTM 450 SMR	MTR128	2021	2023-05-22 12:50:00
144	129	Triumph Daytona 675	MTR129	2018	2023-05-23 13:25:00
145	130	Aprilia RS 50	MTR130	2022	2023-05-24 14:35:00
146	131	Honda CBR500R	MTR131	2020	2023-05-25 15:45:00
147	132	Yamaha FZ6R	MTR132	2019	2023-05-26 16:20:00
148	133	Kawasaki ER-6n	MTR133	2021	2023-05-27 08:30:00
149	134	Suzuki Bandit 650	MTR134	2018	2023-05-28 09:40:00
150	135	Ducati 848 Evo	MTR135	2022	2023-05-29 10:50:00
151	136	BMW HP4 Race	MTR136	2020	2023-05-30 11:25:00
152	137	Harley Davidson Street 750	MTR137	2019	2023-05-31 12:35:00
153	138	KTM 640 Adventure	MTR138	2021	2023-06-01 13:45:00
154	139	Triumph Speed 400	MTR139	2018	2023-06-02 14:55:00
155	140	Aprilia RSV Mille	MTR140	2022	2023-06-03 15:30:00
156	141	Honda VFR800F	MTR141	2020	2023-06-04 16:40:00
157	142	Yamaha FJR1300	MTR142	2019	2023-06-05 08:50:00
158	143	Kawasaki Concours 14	MTR143	2021	2023-06-06 09:35:00
159	144	Suzuki DL1000	MTR144	2018	2023-06-07 10:45:00
160	145	Ducati ST4	MTR145	2022	2023-06-08 11:55:00
161	146	BMW R1200RT	MTR146	2020	2023-06-09 12:40:00
162	147	Harley Davidson Ultra Limited	MTR147	2019	2023-06-10 13:50:00
163	148	KTM 625 SMC	MTR148	2021	2023-06-11 14:25:00
164	149	Triumph Sprint ST	MTR149	2018	2023-06-12 15:35:00
165	150	Aprilia Falco	MTR150	2022	2023-06-13 16:45:00
166	151	Honda ST1300	MTR151	2020	2023-06-14 08:55:00
167	152	Yamaha XVS950	MTR152	2019	2023-06-15 09:40:00
168	153	Kawasaki VN900	MTR153	2021	2023-06-16 10:50:00
169	154	Suzuki C50	MTR154	2018	2023-06-17 11:30:00
170	155	Ducati PaulSmart 1000	MTR155	2022	2023-06-18 12:40:00
171	156	BMW R1150GS	MTR156	2020	2023-06-19 13:50:00
172	157	Harley Davidson SuperLow	MTR157	2019	2023-06-20 14:25:00
173	158	KTM 525 EXC	MTR158	2021	2023-06-21 15:35:00
174	159	Triumph Thunderbird	MTR159	2018	2023-06-22 16:45:00
175	160	Aprilia RS 250	MTR160	2022	2023-06-23 08:35:00
176	161	Honda VT750C	MTR161	2020	2023-06-24 09:45:00
177	162	Yamaha MT-10	MTR162	2019	2023-06-25 10:55:00
178	163	Kawasaki Z1000SX	MTR163	2021	2023-06-26 11:40:00
179	164	Suzuki GSX1400	MTR164	2018	2023-06-27 12:50:00
180	165	Ducati 1098	MTR165	2022	2023-06-28 13:35:00
181	166	BMW K1200LT	MTR166	2020	2023-06-29 14:45:00
182	167	Harley Davidson Dyna	MTR167	2019	2023-06-30 15:55:00
183	168	KTM 950 Supermoto	MTR168	2021	2023-07-01 16:30:00
184	169	Triumph America	MTR169	2018	2023-07-02 08:40:00
185	170	Aprilia RSV1000R	MTR170	2022	2023-07-03 09:50:00
186	171	Honda CB1000R	MTR171	2020	2023-07-04 10:25:00
187	172	Yamaha XT660R	MTR172	2019	2023-07-05 11:35:00
188	173	Kawasaki KLR650	MTR173	2021	2023-07-06 12:45:00
189	174	Suzuki DR650	MTR174	2018	2023-07-07 13:20:00
190	175	Ducati Monster S4R	MTR175	2022	2023-07-08 14:30:00
191	176	BMW F800R	MTR176	2020	2023-07-09 15:40:00
192	177	Harley Davidson CVO	MTR177	2019	2023-07-10 16:15:00
193	178	KTM 990 Adventure	MTR178	2021	2023-07-11 08:25:00
194	179	Triumph Speed Twin	MTR179	2018	2023-07-12 09:35:00
195	180	Aprilia SL 750 Shiver	MTR180	2022	2023-07-13 10:45:00
196	181	Honda CBF1000	MTR181	2020	2023-07-14 11:55:00
197	182	Yamaha FZ1	MTR182	2019	2023-07-15 12:30:00
198	183	Kawasaki Z750	MTR183	2021	2023-07-16 13:40:00
199	184	Suzuki GSX1300R Hayabusa	MTR184	2018	2023-07-17 14:50:00
200	185	Ducati 999	MTR185	2022	2023-07-18 15:25:00
201	186	BMW R1200C	MTR186	2020	2023-07-19 16:35:00
202	187	Harley Davidson Night Rod	MTR187	2019	2023-07-20 08:45:00
203	188	KTM 690 SMC R	MTR188	2021	2023-07-21 09:20:00
204	189	Triumph Tiger 1050	MTR189	2018	2023-07-22 10:30:00
205	190	Aprilia RS 125 Replica	MTR190	2022	2023-07-23 11:40:00
206	191	Honda CB1300	MTR191	2020	2023-07-24 12:50:00
207	192	Yamaha XJR1300	MTR192	2019	2023-07-25 13:25:00
208	193	Kawasaki ZRX1200	MTR193	2021	2023-07-26 14:35:00
209	194	Suzuki GSX1100	MTR194	2018	2023-07-27 15:45:00
210	195	Ducati MH900e	MTR195	2022	2023-07-28 16:20:00
211	196	BMW R1100S	MTR196	2020	2023-07-29 08:30:00
212	197	Harley Davidson Softail Deluxe	MTR197	2019	2023-07-30 09:40:00
213	198	KTM 450 SX-F	MTR198	2021	2023-07-31 10:50:00
214	199	Triumph Legend TT	MTR199	2018	2023-08-01 11:25:00
215	200	Aprilia RSV4 RF	MTR200	2022	2023-08-02 12:35:00
216	201	Honda CBR1100XX	MTR201	2020	2023-08-03 13:45:00
217	202	Yamaha YZF-R7	MTR202	2019	2023-08-04 14:55:00
218	203	Kawasaki ZZR1400	MTR203	2021	2023-08-05 15:30:00
219	204	Suzuki TL1000R	MTR204	2018	2023-08-06 16:40:00
220	205	Ducati 749	MTR205	2022	2023-08-07 08:50:00
221	206	BMW R1200RS	MTR206	2020	2023-08-08 09:35:00
222	207	Harley Davidson Road Glide	MTR207	2019	2023-08-09 10:45:00
223	208	KTM 350 SX-F	MTR208	2021	2023-08-10 11:55:00
224	209	Triumph Adventurer	MTR209	2018	2023-08-11 12:40:00
225	210	Aprilia Tuono 125	MTR210	2022	2023-08-12 13:50:00
226	211	Honda CB400	MTR211	2020	2023-08-13 14:25:00
227	212	Yamaha SR400	MTR212	2019	2023-08-14 15:35:00
228	213	Kawasaki Z300	MTR213	2021	2023-08-15 16:45:00
229	214	Suzuki GS150R	MTR214	2018	2023-08-16 08:55:00
230	215	Ducati Monster 600	MTR215	2022	2023-08-17 09:40:00
231	216	BMW G450X	MTR216	2020	2023-08-18 10:50:00
232	217	Harley Davidson XG750	MTR217	2019	2023-08-19 11:30:00
233	218	KTM 125 Duke	MTR218	2021	2023-08-20 12:40:00
234	219	Triumph T100	MTR219	2018	2023-08-21 13:50:00
235	220	Aprilia RS4 125	MTR220	2022	2023-08-22 14:25:00
236	221	Honda CBR150R	MTR221	2020	2023-08-23 15:35:00
237	222	Yamaha YZF-R15	MTR222	2019	2023-08-24 16:45:00
238	223	Kawasaki Ninja 125	MTR223	2021	2023-08-25 08:35:00
239	224	Suzuki Gixxer SF 250	MTR224	2018	2023-08-26 09:45:00
240	225	Ducati 848	MTR225	2022	2023-08-27 10:55:00
241	226	BMW F650GS	MTR226	2020	2023-08-28 11:40:00
242	227	Harley Davidson Street 500	MTR227	2019	2023-08-29 12:50:00
243	228	KTM 200 Duke	MTR228	2021	2023-08-30 13:35:00
244	229	Triumph Scrambler 900	MTR229	2018	2023-08-31 14:45:00
245	230	Aprilia SX 125	MTR230	2022	2023-09-01 15:55:00
246	231	Honda CB125F	MTR231	2020	2023-09-02 16:30:00
247	232	Yamaha MT-125	MTR232	2019	2023-09-03 08:40:00
248	233	Kawasaki Z125	MTR233	2021	2023-09-04 09:50:00
249	234	Suzuki GSX-R125	MTR234	2018	2023-09-05 10:25:00
250	235	Ducati 1198	MTR235	2022	2023-09-06 11:35:00
251	236	BMW C600 Sport	MTR236	2020	2023-09-07 12:45:00
252	237	Harley Davidson Softail Standard	MTR237	2019	2023-09-08 13:20:00
253	238	KTM 85 SX	MTR238	2021	2023-09-09 14:30:00
254	239	Triumph Street Cup	MTR239	2018	2023-09-10 15:40:00
255	240	Aprilia RS 50 Replica	MTR240	2022	2023-09-11 16:15:00
256	241	Honda MSX125	MTR241	2020	2023-09-12 08:25:00
257	242	Yamaha Tricity 125	MTR242	2019	2023-09-13 09:35:00
258	243	Kawasaki Z250SL	MTR243	2021	2023-09-14 10:45:00
259	244	Suzuki VanVan 125	MTR244	2018	2023-09-15 11:55:00
260	245	Ducati 1098S	MTR245	2022	2023-09-16 12:30:00
261	246	BMW R65	MTR246	2020	2023-09-17 13:40:00
262	247	Harley Davidson Softail Slim	MTR247	2019	2023-09-18 14:50:00
263	248	KTM 65 SX	MTR248	2021	2023-09-19 15:25:00
264	249	Triumph Thunderbird Storm	MTR249	2018	2023-09-20 16:35:00
265	250	Aprilia RSV4 X	MTR250	2022	2023-09-21 08:45:00
266	251	Honda CB300R	MTR251	2020	2023-09-22 09:20:00
267	252	Yamaha XT250	MTR252	2019	2023-09-23 10:30:00
268	253	Kawasaki KLX140	MTR253	2021	2023-09-24 11:40:00
269	254	Suzuki DR200	MTR254	2018	2023-09-25 12:50:00
270	255	Ducati Monster 1200	MTR255	2022	2023-09-26 13:25:00
271	256	BMW R1150R	MTR256	2020	2023-09-27 14:35:00
272	257	Harley Davidson Softail Heritage	MTR257	2019	2023-09-28 15:45:00
273	258	KTM 50 SX	MTR258	2021	2023-09-29 16:20:00
274	259	Triumph Speed Triple RS	MTR259	2018	2023-09-30 08:30:00
275	260	Aprilia Tuono 1100	MTR260	2022	2023-10-01 09:40:00
276	261	Honda CMX500	MTR261	2020	2023-10-02 10:50:00
278	263	Kawasaki Vulcan 900	MTR263	2021	2023-10-04 12:35:00
279	264	Suzuki Boulevard M50	MTR264	2018	2023-10-05 13:45:00
280	265	Ducati Multistrada 1260	MTR265	2022	2023-10-06 14:55:00
281	266	BMW R1200R	MTR266	2020	2023-10-07 15:30:00
282	267	Harley Davidson Softail Fat Boy	MTR267	2019	2023-10-08 16:40:00
283	268	KTM 1290 Super Adventure	MTR268	2021	2023-10-09 08:50:00
284	269	Triumph Tiger 800 XC	MTR269	2018	2023-10-10 09:35:00
285	270	Aprilia RS 660 Extrema	MTR270	2022	2023-10-11 10:45:00
286	271	Honda CB500X	MTR271	2020	2023-10-12 11:55:00
287	272	Yamaha Ténéré 700	MTR272	2019	2023-10-13 12:40:00
288	273	Kawasaki Versys 1000	MTR273	2021	2023-10-14 13:50:00
289	274	Suzuki V-Strom 1050	MTR274	2018	2023-10-15 14:25:00
290	275	Ducati Hypermotard 939	MTR275	2022	2023-10-16 15:35:00
291	276	BMW R1250GS Adventure	MTR276	2020	2023-10-17 16:45:00
292	277	Harley Davidson Softail Low Rider	MTR277	2019	2023-10-18 08:55:00
293	278	KTM 790 Duke	MTR278	2021	2023-10-19 09:40:00
294	279	Triumph Street Twin	MTR279	2018	2023-10-20 10:50:00
295	280	Aprilia Tuono 660 Factory	MTR280	2022	2023-10-21 11:30:00
296	281	Honda CRF1100L Africa Twin	MTR281	2020	2023-10-22 12:40:00
297	282	Yamaha Super Ténéré	MTR282	2019	2023-10-23 13:50:00
298	283	Kawasaki Z H2	MTR283	2021	2023-10-24 14:25:00
299	284	Suzuki GSX-S750	MTR284	2018	2023-10-25 15:35:00
300	285	Ducati Streetfighter 848	MTR285	2022	2023-10-26 16:45:00
301	286	BMW S1000XR	MTR286	2020	2023-10-27 08:35:00
302	287	Harley Davidson Softail Deuce	MTR287	2019	2023-10-28 09:45:00
303	288	KTM 450 XC-F	MTR288	2021	2023-10-29 10:55:00
304	289	Triumph Bonneville T100	MTR289	2018	2023-10-30 11:40:00
305	290	Aprilia RSV4 1100 Factory	MTR290	2022	2023-10-31 12:50:00
306	291	Honda GL1800 Gold Wing Tour	MTR291	2020	2023-11-01 13:35:00
307	292	Yamaha FJR1300AE	MTR292	2019	2023-11-02 14:45:00
308	293	Kawasaki Ninja H2	MTR293	2021	2023-11-03 15:55:00
309	294	Suzuki GSX-R1000R	MTR294	2018	2023-11-04 16:30:00
310	295	Ducati Panigale V2	MTR295	2022	2023-11-05 08:40:00
311	296	BMW R18 Classic	MTR296	2020	2023-11-06 09:50:00
312	297	Harley Davidson Softail Springer	MTR297	2019	2023-11-07 10:25:00
313	298	KTM 350 XC-F	MTR298	2021	2023-11-08 11:35:00
314	299	Triumph Thruxton 900	MTR299	2018	2023-11-09 12:45:00
315	300	Aprilia Tuono V4 1100 Factory	MTR300	2022	2023-11-10 13:20:00
316	301	Honda CBR650F	MTR301	2020	2023-11-11 14:30:00
317	302	Yamaha MT-15	MTR302	2019	2023-11-12 15:40:00
318	303	Kawasaki Z650RS	MTR303	2021	2023-11-13 16:15:00
319	304	Suzuki GSX-R750	MTR304	2018	2023-11-14 08:25:00
320	305	Ducati Monster 821 Stealth	MTR305	2022	2023-11-15 09:35:00
321	306	BMW G310R	MTR306	2020	2023-11-16 10:45:00
322	307	Harley Davidson Softail Fat Bob	MTR307	2019	2023-11-17 11:55:00
323	308	KTM 250 XC-F	MTR308	2021	2023-11-18 12:30:00
324	309	Triumph Tiger 900	MTR309	2018	2023-11-19 13:40:00
325	310	Aprilia RS 457	MTR310	2022	2023-11-20 14:50:00
326	311	Honda CB1100RS	MTR311	2020	2023-11-21 15:25:00
327	312	Yamaha XSR900	MTR312	2019	2023-11-22 16:35:00
328	313	Kawasaki Z900RS	MTR313	2021	2023-11-23 08:45:00
329	314	Suzuki Katana GSX-S1000S	MTR314	2018	2023-11-24 09:20:00
330	315	Ducati Scrambler Desert Sled	MTR315	2022	2023-11-25 10:30:00
331	316	BMW R nineT Scrambler	MTR316	2020	2023-11-26 11:40:00
332	317	Harley Davidson Softail Standard	MTR317	2019	2023-11-27 12:50:00
333	318	KTM 300 XC-W	MTR318	2021	2023-11-28 13:25:00
334	319	Triumph Bonneville Bobber	MTR319	2018	2023-11-29 14:35:00
335	320	Aprilia Tuareg 660	MTR320	2022	2023-11-30 15:45:00
336	321	Honda CB1000R Neo Sports Café	MTR321	2020	2023-12-01 16:20:00
337	322	Yamaha MT-07	MTR322	2019	2023-12-02 08:30:00
338	323	Kawasaki Z400	MTR323	2021	2023-12-03 09:40:00
339	324	Suzuki SV650X	MTR324	2018	2023-12-04 10:50:00
340	325	Ducati Monster 1200S	MTR325	2022	2023-12-05 11:25:00
341	326	BMW R1250RT	MTR326	2020	2023-12-06 12:35:00
342	327	Harley Davidson Softail Breakout 114	MTR327	2019	2023-12-07 13:45:00
343	328	KTM 690 Enduro R	MTR328	2021	2023-12-08 14:55:00
344	329	Triumph Street Scrambler	MTR329	2018	2023-12-09 15:30:00
345	330	Aprilia RS 660	MTR330	2022	2023-12-10 16:40:00
346	331	Honda CB300F	MTR331	2020	2023-12-11 08:50:00
347	332	Yamaha XMAX 250	MTR332	2019	2023-12-12 09:35:00
348	333	Kawasaki Ninja 650	MTR333	2021	2023-12-13 10:45:00
349	334	Suzuki Burgman 200	MTR334	2018	2023-12-14 11:55:00
350	335	Ducati Multistrada V2	MTR335	2022	2023-12-15 12:40:00
351	336	BMW C400GT	MTR336	2020	2023-12-16 13:50:00
352	337	Harley Davidson Softail Slim	MTR337	2019	2023-12-17 14:25:00
353	338	KTM 390 Duke	MTR338	2021	2023-12-18 15:35:00
354	339	Triumph Tiger 1200 XCa	MTR339	2018	2023-12-19 16:45:00
355	340	Aprilia RSV4 Factory	MTR340	2022	2023-12-20 08:55:00
356	341	Honda CBR1000RR-R	MTR341	2020	2023-12-21 09:40:00
357	342	Yamaha YZF-R1M	MTR342	2019	2023-12-22 10:50:00
358	343	Kawasaki Z H2 SE	MTR343	2021	2023-12-23 11:30:00
359	344	Suzuki GSX-R1000	MTR344	2018	2023-12-24 12:40:00
360	345	Ducati Panigale V4 S	MTR345	2022	2023-12-25 13:50:00
361	346	BMW M1000R	MTR346	2020	2023-12-26 14:25:00
362	347	Harley Davidson Softail Standard	MTR347	2019	2023-12-27 15:35:00
363	348	KTM 1290 Super Duke GT	MTR348	2021	2023-12-28 16:45:00
364	349	Triumph Speed Triple 1200 RS	MTR349	2018	2023-12-29 08:35:00
365	350	Aprilia Tuono V4 Factory	MTR350	2022	2023-12-30 09:45:00
366	351	Honda CB500F	MTR351	2020	2023-12-31 10:55:00
367	352	Yamaha MT-03	MTR352	2019	2024-01-01 11:40:00
368	353	Kawasaki Z650	MTR353	2021	2024-01-02 12:50:00
369	354	Suzuki GSX-S1000F	MTR354	2018	2024-01-03 13:35:00
370	355	Ducati Hypermotard 950 RVE	MTR355	2022	2024-01-04 14:45:00
371	356	BMW R18 Transcontinental	MTR356	2020	2024-01-05 15:55:00
372	357	Harley Davidson Softail Standard	MTR357	2019	2024-01-06 16:30:00
373	358	KTM 890 Adventure R	MTR358	2021	2024-01-07 08:40:00
374	359	Triumph Tiger 900 Rally Pro	MTR359	2018	2024-01-08 09:50:00
375	360	Aprilia RS 660 Trofeo	MTR360	2022	2024-01-09 10:25:00
376	361	Honda CB650R	MTR361	2020	2024-01-10 11:35:00
377	362	Yamaha XSR700	MTR362	2019	2024-01-11 12:45:00
378	363	Kawasaki Z900	MTR363	2021	2024-01-12 13:20:00
379	364	Suzuki V-Strom 650XT	MTR364	2018	2024-01-13 14:30:00
380	365	Ducati Monster Plus	MTR365	2022	2024-01-14 15:40:00
381	366	BMW F900XR	MTR366	2020	2024-01-15 16:15:00
382	367	Harley Davidson Softail Standard	MTR367	2019	2024-01-16 08:25:00
383	368	KTM 790 Adventure R	MTR368	2021	2024-01-17 09:35:00
384	369	Triumph Street Triple RS	MTR369	2018	2024-01-18 10:45:00
385	370	Aprilia Tuono 660	MTR370	2022	2024-01-19 11:55:00
386	371	Honda CB1000R	MTR371	2020	2024-01-20 12:30:00
387	372	Yamaha MT-09	MTR372	2019	2024-01-21 13:40:00
388	373	Kawasaki Z1000	MTR373	2021	2024-01-22 14:50:00
389	374	Suzuki GSX-S750Z	MTR374	2018	2024-01-23 15:25:00
390	375	Ducati Streetfighter V4 S	MTR375	2022	2024-01-24 16:35:00
391	376	BMW S1000R	MTR376	2020	2024-01-25 08:45:00
392	377	Harley Davidson Softail Standard	MTR377	2019	2024-01-26 09:20:00
393	378	KTM 450 Rally	MTR378	2021	2024-01-27 10:30:00
394	379	Triumph Bonneville T120 Black	MTR379	2018	2024-01-28 11:40:00
395	380	Aprilia RSV4 X	MTR380	2022	2024-01-29 12:50:00
396	381	Honda CBR600RR	MTR381	2020	2024-01-30 13:25:00
397	382	Yamaha R6	MTR382	2019	2024-01-31 14:35:00
398	383	Kawasaki Ninja 650	MTR383	2021	2024-02-01 15:45:00
399	384	Suzuki GSX-R750	MTR384	2018	2024-02-02 16:20:00
400	385	Ducati Panigale V4	MTR385	2022	2024-02-03 08:30:00
401	386	BMW S1000RR	MTR386	2020	2024-02-04 09:40:00
402	387	Harley Davidson Sportster	MTR387	2019	2024-02-05 10:50:00
403	388	KTM Duke 390	MTR388	2021	2024-02-06 11:25:00
404	389	Triumph Street Triple	MTR389	2018	2024-02-07 12:35:00
405	390	Aprilia RSV4	MTR390	2022	2024-02-08 13:45:00
406	391	Honda Rebel 500	MTR391	2020	2024-02-09 14:55:00
407	392	Yamaha MT-07	MTR392	2019	2024-02-10 15:30:00
408	393	Kawasaki Z900	MTR393	2021	2024-02-11 16:40:00
409	394	Suzuki Hayabusa	MTR394	2018	2024-02-12 08:50:00
410	395	Ducati Monster 821	MTR395	2022	2024-02-13 09:35:00
411	396	BMW R1250GS	MTR396	2020	2024-02-14 10:45:00
412	397	Harley Davidson Softail	MTR397	2019	2024-02-15 11:55:00
413	398	KTM RC 390	MTR398	2021	2024-02-16 12:40:00
414	399	Triumph Tiger 800	MTR399	2018	2024-02-17 13:50:00
415	400	Aprilia Tuono 660	MTR400	2022	2024-02-18 14:25:00
416	401	Honda CB500F	MTR401	2020	2024-02-19 15:35:00
417	402	Yamaha XMAX 300	MTR402	2019	2024-02-20 16:45:00
418	403	Kawasaki Vulcan S	MTR403	2021	2024-02-21 08:55:00
419	404	Suzuki V-Strom 650	MTR404	2018	2024-02-22 09:40:00
420	405	Ducati Scrambler	MTR405	2022	2024-02-23 10:50:00
421	406	BMW F750GS	MTR406	2020	2024-02-24 11:30:00
422	407	Harley Davidson Road King	MTR407	2019	2024-02-25 12:40:00
423	408	KTM 790 Adventure	MTR408	2021	2024-02-26 13:50:00
424	409	Triumph Bonneville T120	MTR409	2018	2024-02-27 14:25:00
425	410	Aprilia Shiver 900	MTR410	2022	2024-02-28 15:35:00
426	411	Honda Africa Twin	MTR411	2020	2024-02-29 16:45:00
427	412	Yamaha Tracer 900	MTR412	2019	2024-03-01 08:35:00
428	413	Kawasaki H2 SX	MTR413	2021	2024-03-02 09:45:00
429	414	Suzuki Katana	MTR414	2018	2024-03-03 10:55:00
430	415	Ducati Multistrada V4	MTR415	2022	2024-03-04 11:40:00
431	416	BMW K1600GTL	MTR416	2020	2024-03-05 12:50:00
432	417	Harley Davidson Breakout	MTR417	2019	2024-03-06 13:35:00
433	418	KTM 1290 Super Duke R	MTR418	2021	2024-03-07 14:45:00
434	419	Triumph Rocket 3	MTR419	2018	2024-03-08 15:55:00
435	420	Aprilia RS 660	MTR420	2022	2024-03-09 16:30:00
436	421	Honda Gold Wing	MTR421	2020	2024-03-10 08:40:00
437	422	Yamaha Niken GT	MTR422	2019	2024-03-11 09:50:00
438	423	Kawasaki Z1000	MTR423	2021	2024-03-12 10:25:00
439	424	Suzuki Burgman 400	MTR424	2018	2024-03-13 11:35:00
440	425	Ducati Diavel 1260	MTR425	2022	2024-03-14 12:45:00
441	426	BMW C400X	MTR426	2020	2024-03-15 13:20:00
442	427	Harley Davidson Street Glide	MTR427	2019	2024-03-16 14:30:00
443	428	KTM 450 EXC	MTR428	2021	2024-03-17 15:40:00
444	429	Triumph Speed Triple	MTR429	2018	2024-03-18 16:15:00
445	430	Aprilia Caponord 1200	MTR430	2022	2024-03-19 08:25:00
446	431	Honda NC750X	MTR431	2020	2024-03-20 09:35:00
447	432	Yamaha WR250R	MTR432	2019	2024-03-21 10:45:00
448	433	Kawasaki Versys 650	MTR433	2021	2024-03-22 11:55:00
449	434	Suzuki DR-Z400S	MTR434	2018	2024-03-23 12:30:00
450	435	Ducati Hypermotard 950	MTR435	2022	2024-03-24 13:40:00
451	436	BMW R18	MTR436	2020	2024-03-25 14:50:00
452	437	Harley Davidson Low Rider S	MTR437	2019	2024-03-26 15:25:00
453	438	KTM 500 EXC-F	MTR438	2021	2024-03-27 16:35:00
454	439	Triumph Trident 660	MTR439	2018	2024-03-28 08:45:00
455	440	Aprilia Dorsoduro 900	MTR440	2022	2024-03-29 09:20:00
456	441	Honda CBR1000RR	MTR441	2020	2024-03-30 10:30:00
457	442	Yamaha YZF-R1	MTR442	2019	2024-03-31 11:40:00
458	443	Kawasaki Ninja 400	MTR443	2021	2024-04-01 12:50:00
459	444	Suzuki GSX-S1000	MTR444	2018	2024-04-02 13:25:00
460	445	Ducati Streetfighter V4	MTR445	2022	2024-04-03 14:35:00
461	446	BMW M1000RR	MTR446	2020	2024-04-04 15:45:00
462	447	Harley Davidson Fat Boy	MTR447	2019	2024-04-05 16:20:00
463	448	KTM 890 Duke	MTR448	2021	2024-04-06 08:30:00
464	449	Triumph Scrambler 1200	MTR449	2018	2024-04-07 09:40:00
465	450	Aprilia RS 125	MTR450	2022	2024-04-08 10:50:00
466	451	Honda CB650R	MTR451	2020	2024-04-09 11:25:00
467	452	Yamaha MT-09	MTR452	2019	2024-04-10 12:35:00
468	453	Kawasaki Z650	MTR453	2021	2024-04-11 13:45:00
469	454	Suzuki SV650	MTR454	2018	2024-04-12 14:55:00
470	455	Ducati SuperSport 950	MTR455	2022	2024-04-13 15:30:00
471	456	BMW F850GS	MTR456	2020	2024-04-14 16:40:00
472	457	Harley Davidson Electra Glide	MTR457	2019	2024-04-15 08:50:00
473	458	KTM 390 Adventure	MTR458	2021	2024-04-16 09:35:00
474	459	Triumph Thruxton RS	MTR459	2018	2024-04-17 10:45:00
475	460	Aprilia Tuono V4	MTR460	2022	2024-04-18 11:55:00
476	461	Honda Shadow 750	MTR461	2020	2024-04-19 12:40:00
477	462	Yamaha Bolt R-Spec	MTR462	2019	2024-04-20 13:50:00
478	463	Kawasaki W800	MTR463	2021	2024-04-21 14:25:00
479	464	Suzuki Intruder 800	MTR464	2018	2024-04-22 15:35:00
480	465	Ducati XDiavel	MTR465	2022	2024-04-23 16:45:00
481	466	BMW R nineT	MTR466	2020	2024-04-24 08:55:00
482	467	Harley Davidson Iron 883	MTR467	2019	2024-04-25 09:40:00
483	468	KTM 250 SX-F	MTR468	2021	2024-04-26 10:50:00
484	469	Triumph Tiger 1200	MTR469	2018	2024-04-27 11:30:00
485	470	Aprilia Pegaso 650	MTR470	2022	2024-04-28 12:40:00
486	471	Honda CRF250L	MTR471	2020	2024-04-29 13:50:00
487	472	Yamaha TW200	MTR472	2019	2024-04-30 14:25:00
488	473	Kawasaki KLX230	MTR473	2021	2024-05-01 15:35:00
489	474	Suzuki RM-Z250	MTR474	2018	2024-05-02 16:45:00
490	475	Ducati DesertX	MTR475	2022	2024-05-03 08:35:00
491	476	BMW G310GS	MTR476	2020	2024-05-04 09:45:00
492	477	Harley Davidson Pan America	MTR477	2019	2024-05-05 10:55:00
493	478	KTM 350 EXC-F	MTR478	2021	2024-05-06 11:40:00
494	479	Triumph Street Scrambler	MTR479	2018	2024-05-07 12:50:00
495	480	Aprilia RSV4 Factory	MTR480	2022	2024-05-08 13:35:00
496	481	Honda CBR250R	MTR481	2020	2024-05-09 14:45:00
497	482	Yamaha MT-03	MTR482	2019	2024-05-10 15:55:00
498	483	Kawasaki Ninja 300	MTR483	2021	2024-05-11 16:30:00
499	484	Suzuki GSX250R	MTR484	2018	2024-05-12 08:40:00
500	485	Ducati Monster 797	MTR485	2022	2024-05-13 09:50:00
501	486	BMW C650GT	MTR486	2020	2024-05-14 10:25:00
502	487	Harley Davidson LiveWire	MTR487	2019	2024-05-15 11:35:00
503	488	KTM 690 Enduro R	MTR488	2021	2024-05-16 12:45:00
504	489	Triumph Tiger Sport 660	MTR489	2018	2024-05-17 13:20:00
505	490	Aprilia Tuareg 660	MTR490	2022	2024-05-18 14:30:00
506	491	Honda PCX150	MTR491	2020	2024-05-19 15:40:00
507	492	Yamaha NMAX 155	MTR492	2019	2024-05-20 16:15:00
508	493	Kawasaki J300	MTR493	2021	2024-05-21 08:25:00
509	494	Suzuki Address 110	MTR494	2018	2024-05-22 09:35:00
510	495	Ducati 899 Panigale	MTR495	2022	2024-05-23 10:45:00
511	496	BMW R1250R	MTR496	2020	2024-05-24 11:55:00
512	497	Harley Davidson Roadster	MTR497	2019	2024-05-25 12:30:00
513	498	KTM 1090 Adventure R	MTR498	2021	2024-05-26 13:40:00
514	499	Triumph Bobber	MTR499	2018	2024-05-27 14:50:00
515	500	Aprilia Mana 850	MTR500	2022	2024-05-28 15:25:00
517	509	Honda Xr190	35as65	2025	2025-11-20 16:50:49.968783
520	262	Yamaha XV250	MTR262	2019	2025-11-21 23:21:07.511163
521	510	Suzuki AX100	54asj5	2025	2025-11-24 17:42:17.549672
\.


--
-- TOC entry 5032 (class 0 OID 16595)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, nombre) FROM stdin;
1	Admin
2	Empleado
3	Cliente
\.


--
-- TOC entry 5044 (class 0 OID 16673)
-- Dependencies: 232
-- Data for Name: servicios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servicios (id, nombre, costo_general, descripcion, duracion_estimada) FROM stdin;
1	Cambio de aceite	50.00	Cambio de aceite y filtro	30
2	Afinación mayor	200.00	Afinación completa del motor	120
3	Cambio de llantas	150.00	Cambio de llantas y balanceo	60
4	Revisión general	80.00	Revisión completa de la moto	45
5	Lavado básico de moto	80.00	Lavado exterior completo de la motocicleta	30
6	Lavado premium de moto	150.00	Lavado exterior e interior con detailing	60
7	Cambio de filtro de aire	120.00	Reemplazo del filtro de aire del motor	20
8	Ajuste de cadena	60.00	Ajuste y lubricación de cadena	15
9	Cambio de bujías	180.00	Reemplazo de juego completo de bujías	45
10	Lubricación de cables	40.00	Lubricación de cables de acelerador y embrague	15
11	Ajuste de frenos	100.00	Ajuste y calibración de frenos delanteros y traseros	30
12	Cambio de pastillas de freno	220.00	Reemplazo de pastillas de freno delanteras	40
13	Cambio pastillas freno trasero	180.00	Reemplazo de pastillas de freno traseras	35
14	Sangrado de frenos	150.00	Purga y sangrado completo del sistema de frenos	50
15	Alineación de manubrio	80.00	Alineación y centrado del manubrio	25
16	Balanceo de llantas	120.00	Balanceo dinámico de ambas llantas	40
17	Cambio de aceite de frenos	50.00	Reemplazo completo del líquido de frenos	30
18	Ajuste de suspensión	110.00	Ajuste de precarga de suspensión trasera y delantera	25
19	Cambio de líquido refrigerante	160.00	Reemplazo del líquido refrigerante del motor	40
20	Limpieza de carburador	200.00	Desmontaje y limpieza completa del carburador	75
21	Calibración de carburador	120.00	Calibración y sincronización de carburador	30
22	Cambio de batería	140.00	Reemplazo de batería incluyendo instalación	20
23	Prueba de compresión	100.00	Medición de compresión en cilindros del motor	25
24	Diagnóstico computarizado	180.00	Escaneo computarizado de sistemas electrónicos	35
25	Cambio de kit de arrastre	350.00	Reemplazo completo de cadena y sprockets	90
26	Ajuste de válvulas	280.00	Ajuste de juego de válvulas del motor	120
27	Limpieza de inyectores	220.00	Limpieza ultrasónica de inyectores de combustible	50
29	Reparación de pinchazo	60.00	Reparación de llanta ponchada con parche interno	20
28	Cambio de sensor de oxígeno	190.00	Reemplazo del sensor de oxígeno	30
30	Instalación de accesorios	120.00	Instalación de top case, alarma o otros accesorios	45
31	Cambio de bobina de encendido	170.00	Reemplazo de bobina de encendido	25
33	Limpieza de sistema eléctrico	130.00	Limpieza de conexiones y terminales eléctricos	35
34	Cambio de interruptores	90.00	Reemplazo de interruptores de manubrio	20
35	Reparación de faros	110.00	Reparación o reemplazo de focos de faros	25
36	Ajuste de clutch	70.00	Ajuste de juego de clutch	15
37	Cambio de aceite de transmisión	140.00	Reemplazo de aceite de caja de cambios	30
38	Limpieza de filtro de combustible	80.00	Limpieza del filtro de combustible	20
39	Calibración de velocímetro	100.00	Calibración y verificación de velocímetro	25
40	Instalación de protecciones	180.00	Instalación de sliders o protectores de motor	50
41	Montaje de neumáticos	160.00	Montaje y desmontaje de neumáticos en llantas	40
42	Alineación de suspensión delantera	200.00	Alineación y balanceo de horquilla delantera	60
43	Cambio de retenes de suspensión	240.00	Reemplazo de retenes de horquilla delantera	75
44	Limpieza de sistema de escape	90.00	Limpieza interna y externa del escape	30
45	Reparación de guardafangos	70.00	Reparación o ajuste de guardafangos	20
46	Ajuste de asiento	50.00	Ajuste y fijación de asiento	15
47	Cambio de espejos	80.00	Reemplazo de espejos retrovisores	20
350	Reparación de amplifier	170.00	Reparación de amplificador	50
48	Instalación de luces LED	150.00	Instalación de kit de luces LED adicionales	45
49	Calibración de tacómetro	110.00	Calibración de indicador de revoluciones	25
50	Limpieza de radiador	130.00	Limpieza externa de radiador de refrigeración	30
51	Reparación de tanque de gasolina	280.00	Reparación de fugas en tanque de combustible	120
52	Cambio de junta de culata	450.00	Reemplazo de junta de culata del motor	180
53	Rectificación de discos de freno	320.00	Rectificación de discos de freno delanteros	90
54	Ajuste de sensores ABS	160.00	Calibración de sensores del sistema ABS	40
55	Limpieza de cuerpo de aceleración	190.00	Limpieza del cuerpo de aceleración en motos con inyección	50
56	Cambio de módulo de control	380.00	Reemplazo de ECU o módulo de control electrónico	60
57	Instalación de calentadores	120.00	Instalación de manijas calefaccionadas	35
58	Reparación de centralita	220.00	Reparación de centralita eléctrica	75
59	Ajuste de palancas de freno	60.00	Ajuste y lubricación de palancas de freno	15
60	Cambio de rodamientos de rueda	210.00	Reemplazo de rodamientos de rueda delantera y trasera	80
61	Limpieza de sistema de arranque	140.00	Limpieza y mantenimiento de motor de arranque	40
62	Ajuste de tensores	90.00	Ajuste de tensores de cadena de distribución	25
63	Cambio de termostato	130.00	Reemplazo del termostato del sistema de refrigeración	30
64	Reparación de indicadores	70.00	Reparación de luces indicadoras del tablero	25
65	Instalación de portamatrículas	50.00	Instalación o reemplazo de portamatrículas	15
66	Ajuste de pedales	40.00	Ajuste y lubricación de pedales	15
67	Cambio de silentblocks	110.00	Reemplazo de silentblocks de motor y basculante	45
68	Limpieza de mariposa	160.00	Limpieza de mariposa de aceleración	35
69	Calibración de presiones	80.00	Calibración de sensores de presión de neumáticos	20
70	Reparación de carenados	190.00	Reparación y fijación de carenados de moto	50
71	Cambio de retenes de biela	270.00	Reemplazo de retenes de biela del motor	100
72	Ajuste de carbones	120.00	Ajuste y reemplazo de carbones de motor de arranque	30
73	Limpieza de válvula IAC	140.00	Limpieza de válvula de control de aire en ralentí	35
74	Instalación de antirrobos	90.00	Instalación de sistema antirrobo adicional	25
75	Reparación de caja de cambios	520.00	Reparación interna de caja de cambios	240
76	Cambio de eje de rueda	180.00	Reemplazo de eje de rueda delantera o trasera	60
77	Ajuste de tensor de correa	100.00	Ajuste de tensor en motos con transmisión por correa	25
78	Limpieza de filtro de aceite	70.00	Limpieza del filtro de aceite reutilizable	20
79	Calibración de inyectores	230.00	Calibración y prueba de inyectores de combustible	60
80	Reparación de bomba de agua	290.00	Reparación o reemplazo de bomba de agua	90
81	Cambio de mangueras	120.00	Reemplazo de mangueras de refrigeración	40
82	Ajuste de basculante	130.00	Ajuste y alineación de basculante trasero	35
83	Limpieza de tanque	150.00	Limpieza interna de tanque de combustible	45
84	Instalación de defensas	110.00	Instalación de defensas para motor	30
85	Reparación de cuadro	380.00	Reparación y soldadura de cuadro de moto	120
86	Cambio de rodamientos dirección	160.00	Reemplazo de rodamientos de dirección	50
87	Ajuste de luz larga	60.00	Ajuste de alineación de luz larga	15
88	Limpieza de bujías	50.00	Limpieza y calibración de bujías	20
89	Calibración de MAP	170.00	Calibración de sensor MAP (presión absoluta múltiple)	35
90	Reparación de alternador	310.00	Reparación o reemplazo de alternador	90
91	Cambio de relés	80.00	Reemplazo de relés eléctricos	20
92	Ajuste de cúpulas	140.00	Ajuste de cúpulas de suspensión delantera	40
93	Limpieza de TPS	110.00	Limpieza de sensor de posición de mariposa	25
94	Instalación de GPS	200.00	Instalación de sistema de localización GPS	45
95	Reparación de bomba combustible	240.00	Reparación de bomba de combustible eléctrica	60
96	Cambio de resortes suspensión	190.00	Reemplazo de resortes de suspensión	50
97	Ajuste de válvula PCV	90.00	Ajuste de válvula de ventilación positiva del cárter	20
98	Limpieza de EGR	160.00	Limpieza de válvula EGR (recirculación de gases)	40
99	Calibración de TPS	130.00	Calibración de sensor de posición del acelerador	30
100	Reparación de central locking	170.00	Reparación de sistema de cierre centralizado	45
101	Cambio de fusibles	40.00	Reemplazo de juego completo de fusibles	10
102	Ajuste de cabezal	180.00	Ajuste y torque de tornillos de cabezal	35
103	Limpieza de admisión	140.00	Limpieza de tuberías de admisión de aire	30
104	Instalación de baúl	120.00	Instalación de baúl trasero para moto	35
105	Reparación de chasis	420.00	Reparación estructural del chasis	150
106	Cambio de juntas motor	280.00	Reemplazo de juego completo de juntas del motor	120
107	Ajuste de pedal cambio	70.00	Ajuste y lubricación de pedal de cambios	15
108	Limpieza de VVT	190.00	Limpieza de sistema de distribución variable	45
109	Calibración de ángulo	110.00	Calibración de sensor de ángulo de inclinación	25
110	Reparación de display	230.00	Reparación de pantalla digital del tablero	60
111	Cambio de soportes motor	150.00	Reemplazo de soportes de motor	40
112	Ajuste de horquilla	160.00	Ajuste de precarga de horquilla delantera	35
113	Limpieza de IAT	90.00	Limpieza de sensor de temperatura de aire de admisión	20
114	Instalación de alarmas	180.00	Instalación de sistema de alarma con sirena	50
115	Reparación de turbo	580.00	Reparación de turbocompresor en motos equipadas	180
116	Cambio de intercooler	320.00	Reemplazo de intercooler	75
117	Ajuste de wastegate	140.00	Ajuste de válvula wastegate en motos turbo	30
118	Limpieza de DPF	270.00	Limpieza de filtro de partículas diésel	90
119	Calibración de NOx	210.00	Calibración de sensores de óxidos de nitrógeno	45
120	Reparación de AdBlue	290.00	Reparación de sistema AdBlue en motos diésel	80
121	Cambio de SCR	380.00	Reemplazo de sistema de reducción catalítica selectiva	100
122	Ajuste de DPF	160.00	Ajuste y regeneración de filtro de partículas	40
123	Limpieza de EGT	130.00	Limpieza de sensor de temperatura de gases de escape	25
124	Instalación de intermitentes	80.00	Instalación de intermitentes adicionales	25
125	Reparación de common rail	340.00	Reparación de sistema common rail en motos diésel	120
126	Cambio de inyector diésel	310.00	Reemplazo de inyector en motos diésel	60
127	Ajuste de presión rail	170.00	Ajuste de presión del rail de combustible	35
128	Limpieza de FAP	220.00	Limpieza de filtro de partículas antipolución	60
129	Calibración de lambda	150.00	Calibración de sensor lambda	30
130	Reparación de DDE	360.00	Reparación de unidad de control diésel	90
131	Cambio de calentadores	190.00	Reemplazo de bujías de precalentamiento	40
132	Ajuste de bomba inyección	240.00	Ajuste de bomba de inyección diésel	50
133	Limpieza de turbo	180.00	Limpieza básica de turbocompresor	45
134	Instalación de precalentador	120.00	Instalación de sistema de precalentamiento	30
135	Reparación de HPFP	420.00	Reparación de bomba de alta presión de combustible	100
136	Cambio de sensores AdBlue	230.00	Reemplazo de sensores del sistema AdBlue	50
137	Ajuste de dosificación	160.00	Ajuste de dosificación de AdBlue	35
138	Limpieza de tanque AdBlue	140.00	Limpieza de tanque de AdBlue	40
139	Calibración de SCR	200.00	Calibración de sistema de reducción catalítica	45
140	Reparación de DEF	280.00	Reparación de sistema de fluido de escape diésel	75
141	Cambio de módulo AdBlue	350.00	Reemplazo de módulo de control AdBlue	60
142	Ajuste de presión turbo	130.00	Ajuste de presión de sobrealimentación	25
143	Limpieza de intercooler	110.00	Limpieza externa e interna de intercooler	30
144	Instalación de boost gauge	150.00	Instalación de indicador de presión de turbo	35
145	Reparación de wastegate	190.00	Reparación de válvula wastegate	50
146	Cambio de actuador turbo	210.00	Reemplazo de actuador de turbocompresor	45
147	Ajuste de VGT	170.00	Ajuste de álabes variables en turbo	40
148	Limpieza de compresor	120.00	Limpieza de compresor de turbo	30
149	Calibración de MAP turbo	140.00	Calibración de sensor MAP para turbo	25
150	Reparación de twin-scroll	480.00	Reparación de turbo twin-scroll	120
151	Cambio de junta turbo	160.00	Reemplazo de juntas del turbocompresor	40
152	Ajuste de by-pass	110.00	Ajuste de válvula by-pass del turbo	25
153	Limpieza de wastegate	90.00	Limpieza de válvula wastegate	20
154	Instalación de blow-off	200.00	Instalación de válvula blow-off	45
155	Reparación de sequential	520.00	Reparación de turbo secuencial	150
156	Cambio de cartucho turbo	380.00	Reemplazo de cartucho de turbocompresor	80
157	Ajuste de presión wastegate	130.00	Ajuste de presión de apertura de wastegate	30
158	Limpieza de VNT	150.00	Limpieza de turbo de geometría variable	35
159	Calibración de VGT	180.00	Calibración de turbo de geometría variable	40
160	Reparación de compound	620.00	Reparación de sistema turbo compound	180
161	Cambio de twin-turbo	780.00	Reemplazo de sistema twin-turbo	240
162	Ajuste de bi-turbo	220.00	Ajuste de sistema bi-turbo	50
163	Limpieza de compuesto	170.00	Limpieza de sistema turbo compound	45
164	Instalación de temp gauge	140.00	Instalación de indicador de temperatura	30
165	Reparación de e-turbo	680.00	Reparación de turbocompresor eléctrico	160
166	Cambio de motor eléctrico	420.00	Reemplazo de motor eléctrico de turbo	90
167	Ajuste de e-boost	190.00	Ajuste de sistema de sobrealimentación eléctrica	40
168	Limpieza de e-turbo	160.00	Limpieza de turbocompresor eléctrico	35
169	Calibración de e-wastegate	150.00	Calibración de wastegate eléctrica	30
170	Reparación de supercharger	580.00	Reparación de supercargador mecánico	140
171	Cambio de correa SC	180.00	Reemplazo de correa de supercargador	45
172	Ajuste de clutch SC	210.00	Ajuste de embrague de supercargador	50
173	Limpieza de rotor SC	170.00	Limpieza de rotores de supercargador	40
174	Instalación de SC kit	1200.00	Instalación de kit de supercargador	300
175	Reparación de twin-charger	820.00	Reparación de sistema twin-charger	200
176	Cambio de módulo SC	340.00	Reemplazo de módulo de control de supercargador	70
177	Ajuste de bypass SC	160.00	Ajuste de válvula bypass de supercargador	35
178	Limpieza de intercooler SC	140.00	Limpieza de intercooler de supercargador	30
179	Calibración de presión SC	190.00	Calibración de presión de supercargador	40
180	Reparación de roots	480.00	Reparación de supercargador tipo roots	120
181	Cambio de engranajes SC	290.00	Reemplazo de engranajes de supercargador	60
182	Ajuste de tornillo SC	230.00	Ajuste de supercargador de tornillo	50
183	Limpieza de lobes	180.00	Limpieza de lóbulos de supercargador	40
184	Instalación de boost controller	220.00	Instalación de controlador de boost electrónico	45
185	Reparación de centrífugo	380.00	Reparación de supercargador centrífugo	100
186	Cambio de impulsores	260.00	Reemplazo de impulsores de supercargador	55
187	Ajuste de ratio SC	170.00	Ajuste de relación de transmisión de SC	35
188	Limpieza de housing SC	130.00	Limpieza de carcasa de supercargador	30
189	Calibración de SC map	200.00	Calibración de mapa de supercargador	45
190	Reparación de eléctrico	320.00	Reparación de sistema de sobrealimentación eléctrica	80
191	Cambio de compresor eléctrico	280.00	Reemplazo de compresor eléctrico	60
192	Ajuste de voltaje SC	150.00	Ajuste de voltaje de supercargador eléctrico	30
193	Limpieza de motor SC	140.00	Limpieza de motor eléctrico de SC	25
194	Instalación de e-charger	950.00	Instalación de supercargador eléctrico	180
195	Reparación de híbrido	720.00	Reparación de sistema de sobrealimentación híbrida	160
196	Cambio de batería SC	380.00	Reemplazo de batería para SC eléctrico	50
197	Ajuste de híbrido	240.00	Ajuste de sistema turbo y SC combinados	55
198	Limpieza de sistema híbrido	190.00	Limpieza de sistema de sobrealimentación híbrida	45
199	Calibración de híbrido	270.00	Calibración de sistema turbo/SC híbrido	60
200	Reparación de nitrógeno	180.00	Reparación de sistema de inyección de óxido nitroso	50
201	Cambio de botella NOS	320.00	Reemplazo de botella de óxido nitroso	40
202	Ajuste de inyectores NOS	210.00	Ajuste de inyectores de óxido nitroso	45
203	Limpieza de líneas NOS	130.00	Limpieza de líneas de óxido nitroso	30
204	Instalación de kit NOS	850.00	Instalación de kit de inyección de óxido nitroso	150
205	Reparación de solenoide NOS	170.00	Reparación de solenoide de sistema NOS	35
206	Cambio de válvula NOS	190.00	Reemplazo de válvula principal de NOS	40
207	Ajuste de presión NOS	160.00	Ajuste de presión de inyección de NOS	30
208	Limpieza de botella NOS	110.00	Limpieza y mantenimiento de botella NOS	25
209	Calibración de NOS	230.00	Calibración de sistema de inyección de NOS	50
210	Reparación de wet kit	290.00	Reparación de kit NOS húmedo	70
211	Cambio de dry kit	270.00	Reemplazo de kit NOS seco	65
212	Ajuste de fogger	180.00	Ajuste de inyector fogger de NOS	40
213	Limpieza de plenum	150.00	Limpieza de plenum de admisión con NOS	35
214	Instalación de progressive	320.00	Instalación de controlador progresivo de NOS	60
215	Reparación de purge	140.00	Reparación de sistema de purga de NOS	30
216	Cambio de switches NOS	90.00	Reemplazo de interruptores de activación NOS	20
217	Ajuste de WOT	130.00	Ajuste de activación por WOT (wide open throttle)	25
218	Limpieza de arming	100.00	Limpieza de sistema de armado de NOS	20
219	Calibración de progresivo	190.00	Calibración de controlador progresivo	45
220	Reparación de direct port	480.00	Reparación de sistema NOS direct port	120
221	Cambio de rails NOS	340.00	Reemplazo de rails de inyección NOS	80
222	Ajuste de distribución	210.00	Ajuste de distribución de NOS por cilindro	50
223	Limpieza de nozzles	170.00	Limpieza de nozzles de inyección directa	40
224	Instalación de plate	280.00	Instalación de plate system para NOS	70
225	Reparación de crossfire	320.00	Reparación de sistema crossfire NOS	85
226	Cambio de solenoides múltiples	380.00	Reemplazo de solenoides múltiples de NOS	90
227	Ajuste de timing	160.00	Ajuste de retardo de encendido con NOS	35
228	Limpieza de controlador	140.00	Limpieza de controlador electrónico de NOS	30
229	Calibración de seguridad	120.00	Calibración de sistemas de seguridad NOS	25
230	Reparación de bottle heater	110.00	Reparación de calentador de botella NOS	30
231	Cambio de thermostat NOS	100.00	Reemplazo de termostato de calentador NOS	20
232	Ajuste de temperatura NOS	90.00	Ajuste de temperatura de botella NOS	15
233	Limpieza de heater	80.00	Limpieza de elemento calefactor NOS	20
234	Instalación de pressure safety	150.00	Instalación de válvula de seguridad de presión	35
235	Reparación de blowdown	130.00	Reparación de tubo blowdown de NOS	25
236	Cambio de fitting NOS	70.00	Reemplazo de fittings de conexión NOS	15
237	Ajuste de braided lines	120.00	Ajuste de líneas de acero trenzado NOS	30
238	Limpieza de anodizado	60.00	Limpieza de partes anodizadas del sistema NOS	15
239	Calibración de bottle pressure	110.00	Calibración de sensor de presión de botella	20
240	Reparación de nitrous express	290.00	Reparación de sistemas Nitrous Express	70
241	Cambio de componentes NX	210.00	Reemplazo de componentes Nitrous Express	50
242	Ajuste de kit NX	180.00	Ajuste de kit Nitrous Express	40
243	Limpieza de sistema NX	140.00	Limpieza de sistema Nitrous Express	35
244	Instalación de maximizer	340.00	Instalación de maximizer electrónico NX	75
245	Reparación de NOS cheater	260.00	Reparación de sistema NOS cheater	65
246	Cambio de solenoide NOS	150.00	Reemplazo de solenoide NOS específico	35
247	Ajuste de plate system	190.00	Ajuste de plate system de NOS	45
248	Limpieza de fogger nozzle	110.00	Limpieza de fogger nozzle de NOS	25
249	Calibración de minimax	170.00	Calibración de sistema MiniMax NOS	40
250	Reparación de powershot	220.00	Reparación de sistema PowerShot NOS	55
251	Cambio de jets NOS	80.00	Reemplazo de jets de dosificación NOS	20
252	Ajuste de horsepower	130.00	Ajuste de caballaje con cambio de jets NOS	30
253	Limpieza de jet block	90.00	Limpieza de bloque de jets NOS	20
254	Instalación de window switch	160.00	Instalación de window switch para NOS	35
255	Reparación de RPM activator	140.00	Reparación de activador por RPM de NOS	30
256	Cambio de module NOS	200.00	Reemplazo de módulo de control NOS	45
257	Ajuste de TPS switch	110.00	Ajuste de interruptor TPS para NOS	25
258	Limpieza de MAP switch	100.00	Limpieza de interruptor MAP para NOS	20
259	Calibración de full throttle	120.00	Calibración de switch de acelerador total	25
260	Reparación de bottle opener	85.00	Reparación de aperturador de botella NOS	20
261	Cambio de valve NOS	170.00	Reemplazo de válvula de botella NOS	40
262	Ajuste de pressure gauge	95.00	Ajuste de manómetro de presión NOS	20
263	Limpieza de gauge cluster	75.00	Limpieza de grupo de manómetros NOS	15
264	Instalación de remote opener	130.00	Instalación de aperturador remoto NOS	30
265	Reparación de solenoid pack	180.00	Reparación de paquete de solenoides NOS	45
266	Cambio de wiring NOS	120.00	Reemplazo de cableado del sistema NOS	35
267	Ajuste de relay NOS	70.00	Ajuste de relé del sistema NOS	15
268	Limpieza de connectors	60.00	Limpieza de conectores eléctricos NOS	15
269	Calibración de microswitch	80.00	Calibración de microswitch de NOS	20
270	Reparación de bottle bracket	90.00	Reparación de soporte de botella NOS	25
271	Cambio de mounting hardware	50.00	Reemplazo de hardware de montaje NOS	15
272	Ajuste de angle bracket	40.00	Ajuste de soporte angular de botella	10
273	Limpieza de bracket	35.00	Limpieza de soporte de botella	10
274	Instalación de safety cable	45.00	Instalación de cable de seguridad NOS	15
275	Reparación de blowdown tube	55.00	Reparación de tubo de descarga NOS	20
276	Cambio de tube fitting	30.00	Reemplazo de fitting de tubo NOS	10
277	Ajuste de tube routing	40.00	Ajuste de ruteo de tubos NOS	15
278	Limpieza de tubes	35.00	Limpieza de tubos del sistema NOS	10
279	Calibración de flow	95.00	Calibración de flujo de NOS	25
280	Reparación de nitrous analyzer	210.00	Reparación de analizador de sistema NOS	50
281	Cambio de sensor flow	140.00	Reemplazo de sensor de flujo NOS	30
282	Ajuste de analyzer	110.00	Ajuste de analizador de NOS	25
283	Limpieza de analyzer	90.00	Limpieza de unidad analizadora	20
284	Instalación de datalogger	180.00	Instalación de datalogger para NOS	40
285	Reparación de wideband	160.00	Reparación de sensor wideband con NOS	35
286	Cambio de sensor O2	120.00	Reemplazo de sensor O2 para NOS	25
287	Ajuste de AFR	130.00	Ajuste de relación aire-combustible con NOS	30
288	Limpieza de wideband	85.00	Limpieza de sensor wideband	20
289	Calibración de wideband	100.00	Calibración de sensor wideband	25
290	Reparación de gauge wideband	150.00	Reparación de indicador wideband	35
291	Cambio de display wideband	170.00	Reemplazo de display wideband	40
292	Ajuste de alarm wideband	80.00	Ajuste de alarmas wideband	20
293	Limpieza de controller	70.00	Limpieza de controlador wideband	15
294	Instalación de sensor bung	60.00	Instalación de bung para sensor wideband	20
295	Reparación de interface	110.00	Reparación de interfaz wideband	30
296	Cambio de cable wideband	90.00	Reemplazo de cableado wideband	25
297	Ajuste de calibration	75.00	Ajuste de calibración wideband	20
298	Limpieza de probe	65.00	Limpieza de sonda wideband	15
299	Calibración de free air	55.00	Calibración en aire libre de wideband	15
300	Reparación de controller box	130.00	Reparación de caja de control wideband	35
301	Cambio de power supply	85.00	Reemplazo de fuente de poder wideband	20
302	Ajuste de voltage	60.00	Ajuste de voltaje wideband	15
303	Limpieza de terminals	45.00	Limpieza de terminales wideband	10
304	Instalación de gauge pod	95.00	Instalación de soporte para indicadores	25
305	Reparación de pillar pod	110.00	Reparación de soporte de pilar A	30
306	Cambio de dash pod	120.00	Reemplazo de soporte de tablero	35
307	Ajuste de mounting	50.00	Ajuste de montaje de soportes	15
308	Limpieza de pods	40.00	Limpieza de soportes de indicadores	10
309	Calibración de angle	35.00	Calibración de ángulo de visibilidad	10
310	Reparación de triple pod	140.00	Reparación de soporte triple	40
311	Cambio de single pod	70.00	Reemplazo de soporte simple	20
312	Ajuste de fitment	45.00	Ajuste de ajuste de soportes	15
313	Limpieza de surface	30.00	Limpieza de superficie de montaje	10
314	Instalación de universal pod	85.00	Instalación de soporte universal	25
315	Reparación de custom pod	160.00	Reparación de soporte personalizado	45
316	Cambio de material pod	95.00	Reemplazo de material de soporte	30
317	Ajuste de color	55.00	Ajuste de color de soportes	20
318	Limpieza de texture	35.00	Limpieza de textura de soportes	10
319	Calibración de position	40.00	Calibración de posición de indicadores	15
320	Reparación de gauge lights	75.00	Reparación de luces de indicadores	25
321	Cambio de bulbs	50.00	Reemplazo de focos de indicadores	15
322	Ajuste de brightness	45.00	Ajuste de brillo de indicadores	10
323	Limpieza de lenses	30.00	Limpieza de lentes de indicadores	10
324	Instalación de LED conversion	110.00	Instalación de conversión a LED	35
325	Reparación de stepper motor	130.00	Reparación de motor de pasos de indicador	40
326	Cambio de needle	85.00	Reemplazo de aguja de indicador	25
327	Ajuste de calibration gauge	70.00	Ajuste de calibración de indicador	20
328	Limpieza de movement	55.00	Limpieza de mecanismo de indicador	15
329	Calibración de zero	45.00	Calibración de cero de indicador	15
330	Reparación de electric gauge	95.00	Reparación de indicador eléctrico	30
331	Cambio de mechanical gauge	120.00	Reemplazo de indicador mecánico	35
332	Ajuste de capillary	80.00	Ajuste de tubo capilar de indicador	25
333	Limpieza de bourdon tube	65.00	Limpieza de tubo bourdon	20
334	Instalación de digital gauge	140.00	Instalación de indicador digital	40
335	Reparación de LCD display	160.00	Reparación de display LCD	45
336	Cambio de backlight	90.00	Reemplazo de luz de fondo	25
337	Ajuste de contrast	50.00	Ajuste de contraste de display	15
338	Limpieza de screen	35.00	Limpieza de pantalla digital	10
339	Calibración de digital readout	60.00	Calibración de lectura digital	20
340	Reparación de touch screen	180.00	Reparación de pantalla táctil	50
341	Cambio de digitizer	150.00	Reemplazo de digitalizador	40
342	Ajuste de sensitivity	70.00	Ajuste de sensibilidad táctil	20
343	Limpieza de surface touch	45.00	Limpieza de superficie táctil	15
344	Instalación de head unit	220.00	Instalación de unidad principal	60
345	Reparación de stereo	130.00	Reparación de sistema de audio	35
346	Cambio de speakers	160.00	Reemplazo de altavoces	45
347	Ajuste de sound	85.00	Ajuste de calidad de sonido	25
348	Limpieza de cones	55.00	Limpieza de conos de altavoz	15
349	Calibración de crossover	95.00	Calibración de crossover	30
351	Cambio de capacitors	110.00	Reemplazo de capacitores de amplificador	35
352	Ajuste de gain	75.00	Ajuste de ganancia de amplificador	20
353	Limpieza de board	65.00	Limpieza de placa de amplificador	25
354	Instalación de subwoofer	190.00	Instalación de subwoofer	55
355	Reparación de woofer	140.00	Reparación de woofer	40
356	Cambio de voice coil	120.00	Reemplazo de bobina móvil	45
357	Ajuste de suspension	80.00	Ajuste de suspensión de altavoz	25
358	Limpieza de magnet	60.00	Limpieza de imán de altavoz	20
359	Calibración de T/S parameters	100.00	Calibración de parámetros Thiele/Small	35
360	Reparación de enclosure	130.00	Reparación de caja acústica	45
361	Cambio de port	85.00	Reemplazo de puerto de caja	30
362	Ajuste de tuning	70.00	Ajuste de sintonización de caja	25
363	Limpieza de interior	50.00	Limpieza interior de caja	20
364	Instalación de sound deadening	180.00	Instalación de material antisonido	60
365	Reparación de damping	110.00	Reparación de material de amortiguación	40
366	Cambio de foam	75.00	Reemplazo de espuma acústica	25
367	Ajuste de coverage	65.00	Ajuste de cobertura antisonido	20
368	Limpieza de adhesive	45.00	Limpieza de adhesivo antisonido	15
369	Calibración de absorption	85.00	Calibración de absorción acústica	30
370	Reparación de wiring audio	95.00	Reparación de cableado de audio	35
371	Cambio de cables speaker	120.00	Reemplazo de cables de altavoz	40
372	Ajuste de gauge wire	70.00	Ajuste de calibre de cable	25
373	Limpieza de terminals audio	40.00	Limpieza de terminales de audio	15
374	Instalación de distribution block	90.00	Instalación de bloque de distribución	30
375	Reparación de fuse holder	55.00	Reparación de portafusibles	20
376	Cambio de fuses audio	35.00	Reemplazo de fusibles de audio	10
377	Ajuste de rating	30.00	Ajuste de rating de fusibles	10
378	Limpieza de contacts	25.00	Limpieza de contactos eléctricos	10
379	Calibración de voltage drop	60.00	Calibración de caída de voltaje	20
380	Reparación de ground	50.00	Reparación de conexión a tierra	15
381	Cambio de ground wire	45.00	Reemplazo de cable a tierra	15
382	Ajuste de ground point	35.00	Ajuste de punto de tierra	10
383	Limpieza de chassis ground	30.00	Limpieza de tierra al chasis	10
384	Instalación de battery terminal	40.00	Instalación de terminal de batería	15
385	Reparación de terminal	35.00	Reparación de terminal de batería	10
386	Cambio de post adapter	25.00	Reemplazo de adaptador de poste	10
387	Ajuste de connection	20.00	Ajuste de conexión de terminal	5
388	Limpieza de corrosion	15.00	Limpieza de corrosión en terminales	5
389	Calibración de torque	30.00	Calibración de torque de terminales	10
390	Reparación de battery box	55.00	Reparación de caja de batería	20
391	Cambio de hold down	35.00	Reemplazo de sujeción de batería	15
392	Ajuste de bracket	25.00	Ajuste de soporte de batería	10
393	Limpieza de tray	20.00	Limpieza de bandeja de batería	10
394	Instalación de battery relocate	180.00	Instalación de reubicación de batería	60
395	Reparación de cables largos	110.00	Reparación de cables largos de batería	40
396	Cambio de main cable	95.00	Reemplazo de cable principal	30
397	Ajuste de length	45.00	Ajuste de longitud de cables	20
398	Limpieza de insulation	35.00	Limpieza de aislamiento de cables	15
399	Calibración de resistance	50.00	Calibración de resistencia de cables	20
400	Reparación de starter cable	85.00	Reparación de cable de arranque	30
401	Cambio de solenoid cable	70.00	Reemplazo de cable de solenoide	25
402	Ajuste de routing starter	40.00	Ajuste de ruteo de cables de arranque	15
403	Limpieza de terminals starter	30.00	Limpieza de terminales de arranque	10
404	Instalación de heat shield	65.00	Instalación de protector térmico	25
405	Reparación de shielding	55.00	Reparación de blindaje térmico	20
406	Cambio de heat wrap	45.00	Reemplazo de envoltura térmica	15
407	Ajuste de coverage heat	35.00	Ajuste de cobertura térmica	15
408	Limpieza de wrap	25.00	Limpieza de envoltura térmica	10
409	Calibración de temperature	40.00	Calibración de protección térmica	15
410	Reparación de cool can	120.00	Reparación de enfriador de combustible	35
411	Cambio de cooling coil	85.00	Reemplazo de serpentín de enfriamiento	25
412	Ajuste de flow cooler	60.00	Ajuste de flujo de enfriador	20
413	Limpieza de internals cooler	45.00	Limpieza interna de enfriador	15
414	Instalación de fuel cooler	150.00	Instalación de enfriador de combustible	45
415	Reparación de ice box	95.00	Reparación de caja de hielo para NOS	30
416	Cambio de cooling pack	110.00	Reemplazo de paquete de enfriamiento	35
417	Ajuste de temperature NOS	70.00	Ajuste de temperatura de NOS	25
418	Limpieza de ice system	50.00	Limpieza de sistema de hielo	20
419	Calibración de cooling	80.00	Calibración de sistema de enfriamiento	30
420	Reparación de intercooler spray	130.00	Reparación de spray de intercooler	40
421	Cambio de nozzle spray	65.00	Reemplazo de nozzle de spray	20
422	Ajuste de pattern spray	45.00	Ajuste de patrón de spray	15
423	Limpieza de tank spray	55.00	Limpieza de tanque de spray	20
424	Instalación de spray system	170.00	Instalación de sistema de spray	50
425	Reparación de pump spray	90.00	Reparación de bomba de spray	30
426	Cambio de motor spray	120.00	Reemplazo de motor de spray	35
427	Ajuste de pressure spray	60.00	Ajuste de presión de spray	20
428	Limpieza de filter spray	40.00	Limpieza de filtro de spray	15
429	Calibración de timer spray	75.00	Calibración de temporizador de spray	25
430	Reparación de controller spray	100.00	Reparación de controlador de spray	35
431	Cambio de switch spray	50.00	Reemplazo de interruptor de spray	15
432	Ajuste de sensitivity spray	45.00	Ajuste de sensibilidad de spray	15
433	Limpieza de sensor spray	35.00	Limpieza de sensor de spray	10
434	Instalación de meth injection	220.00	Instalación de inyección de metanol	65
435	Reparación de meth system	160.00	Reparación de sistema de metanol	50
436	Cambio de pump meth	140.00	Reemplazo de bomba de metanol	40
437	Ajuste de ratio meth	85.00	Ajuste de relación de metanol	25
438	Limpieza de tank meth	70.00	Limpieza de tanque de metanol	20
439	Calibración de meth controller	110.00	Calibración de controlador de metanol	35
440	Reparación de nozzle meth	95.00	Reparación de nozzle de metanol	30
441	Cambio de jet meth	60.00	Reemplazo de jet de metanol	20
442	Ajuste de spray meth	55.00	Ajuste de spray de metanol	15
443	Limpieza de line meth	45.00	Limpieza de línea de metanol	15
444	Instalación de water injection	200.00	Instalación de inyección de agua	60
445	Reparación de water system	150.00	Reparación de sistema de agua	45
446	Cambio de pump water	130.00	Reemplazo de bomba de agua	35
447	Ajuste de ratio water	80.00	Ajuste de relación de agua	25
448	Limpieza de tank water	65.00	Limpieza de tanque de agua	20
449	Calibración de water controller	105.00	Calibración de controlador de agua	30
450	Reparación de nozzle water	90.00	Reparación de nozzle de agua	25
451	Cambio de jet water	55.00	Reemplazo de jet de agua	15
452	Ajuste de spray water	50.00	Ajuste de spray de agua	15
453	Limpieza de line water	40.00	Limpieza de línea de agua	10
454	Instalación de dual nozzle	140.00	Instalación de sistema dual nozzle	40
455	Reparación de progressive controller	170.00	Reparación de controlador progresivo	50
456	Cambio de map sensor boost	120.00	Reemplazo de sensor MAP para boost	30
457	Ajuste de boost control	95.00	Ajuste de control de boost	25
458	Limpieza de solenoid boost	70.00	Limpieza de solenoide de boost	20
459	Calibración de wastegate boost	110.00	Calibración de wastegate electrónica	35
460	Reparación de boost gauge	85.00	Reparación de indicador de boost	25
461	Cambio de vacuum line	35.00	Reemplazo de línea de vacío	10
462	Ajuste de leak test	60.00	Ajuste de prueba de fugas	20
463	Limpieza de intercooler pipes	75.00	Limpieza de tuberías de intercooler	25
464	Instalación de blow-through MAF	190.00	Instalación de MAF blow-through	55
465	Reparación de MAF sensor	130.00	Reparación de sensor MAF	35
466	Cambio de IAT sensor	90.00	Reemplazo de sensor IAT	25
467	Ajuste de air temp	65.00	Ajuste de temperatura de aire	20
468	Limpieza de MAF element	55.00	Limpieza de elemento MAF	15
469	Calibración de MAF transfer	100.00	Calibración de transferencia MAF	30
470	Reparación de speed density	140.00	Reparación de sistema speed density	40
471	Cambio de MAP sensor	110.00	Reemplazo de sensor MAP	30
472	Ajuste de baro correction	75.00	Ajuste de corrección barométrica	25
473	Limpieza de MAP port	45.00	Limpieza de puerto MAP	15
474	Instalación de standalone ECU	580.00	Instalación de ECU independiente	180
475	Reparación de ECU	320.00	Reparación de unidad de control electrónico	90
476	Cambio de harness ECU	240.00	Reemplazo de arnés de ECU	75
477	Ajuste de base map	160.00	Ajuste de mapa base de ECU	45
478	Limpieza de connectors ECU	85.00	Limpieza de conectores de ECU	25
479	Calibración de fuel map	190.00	Calibración de mapa de combustible	60
480	Reparación de ignition map	180.00	Reparación de mapa de encendido	55
481	Cambio de knock sensor	120.00	Reemplazo de sensor de detonación	30
482	Ajuste de knock threshold	95.00	Ajuste de umbral de detonación	25
483	Limpieza de sensor knock	65.00	Limpieza de sensor de detonación	20
484	Instalación de wideband interface	150.00	Instalación de interfaz wideband para ECU	40
485	Reparación de data logging	130.00	Reparación de función datalogging	35
486	Cambio de SD card logger	90.00	Reemplazo de tarjeta SD para datalogger	25
487	Ajuste de sample rate	70.00	Ajuste de tasa de muestreo	20
488	Limpieza de logger unit	55.00	Limpieza de unidad datalogger	15
489	Calibración de triggers	85.00	Calibración de triggers de datalogger	30
490	Reparación de launch control	170.00	Reparación de control de salida	50
491	Cambio de switch launch	80.00	Reemplazo de interruptor de launch control	25
492	Ajuste de rpm launch	95.00	Ajuste de RPM de launch control	30
493	Limpieza de wiring launch	60.00	Limpieza de cableado de launch control	20
494	Instalación de flat shift	140.00	Instalación de flat shift system	45
495	Reparación de shift cut	110.00	Reparación de corte de cambios	35
496	Cambio de sensor shift	100.00	Reemplazo de sensor de cambios	30
497	Ajuste de duration shift	75.00	Ajuste de duración de corte	25
498	Limpieza de switch shift	50.00	Limpieza de interruptor de cambios	15
499	Calibración de blip throttle	120.00	Calibración de blip del acelerador	40
500	Reparación de auto blip	150.00	Reparación de auto blip system	50
501	Cambio de actuator blip	130.00	Reemplazo de actuador de auto blip	35
502	Ajuste de sensitivity blip	85.00	Ajuste de sensibilidad de auto blip	25
503	Limpieza de throttle body	95.00	Limpieza de cuerpo de aceleración para auto blip	30
504	Instalación de quick shifter	220.00	Instalación de quick shifter	65
505	Chequeo de presión de neumáticos	50.00	Se verifica que la presión de los neumáticos sea la adecuada	10
\.


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 227
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 506, true);


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 235
-- Name: cita_servicios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cita_servicios_id_seq', 9, true);


--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 233
-- Name: citas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.citas_id_seq', 1009, true);


--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 223
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 510, true);


--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 221
-- Name: empleados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleados_id_seq', 1054, true);


--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 239
-- Name: factura_detalles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_detalles_id_seq', 1515, true);


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 237
-- Name: facturas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facturas_id_seq', 4519, true);


--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 229
-- Name: inventario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventario_id_seq', 1007, true);


--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 225
-- Name: motos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motos_id_seq', 521, true);


--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 231
-- Name: servicios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicios_id_seq', 505, true);


--
-- TOC entry 4847 (class 2606 OID 16654)
-- Name: categorias categorias_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);


--
-- TOC entry 4849 (class 2606 OID 16652)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 16709)
-- Name: cita_servicios cita_servicios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita_servicios
    ADD CONSTRAINT cita_servicios_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 16692)
-- Name: citas citas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_pkey PRIMARY KEY (id);


--
-- TOC entry 4841 (class 2606 OID 16623)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4839 (class 2606 OID 16610)
-- Name: empleados empleados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_pkey PRIMARY KEY (id);


--
-- TOC entry 4867 (class 2606 OID 16754)
-- Name: factura_detalles factura_detalles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_detalles
    ADD CONSTRAINT factura_detalles_pkey PRIMARY KEY (id);


--
-- TOC entry 4863 (class 2606 OID 16732)
-- Name: facturas facturas_numero_factura_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_numero_factura_key UNIQUE (numero_factura);


--
-- TOC entry 4865 (class 2606 OID 16730)
-- Name: facturas facturas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (id);


--
-- TOC entry 4851 (class 2606 OID 16666)
-- Name: inventario inventario_codigo_producto_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_codigo_producto_key UNIQUE (codigo_producto);


--
-- TOC entry 4853 (class 2606 OID 16664)
-- Name: inventario inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id);


--
-- TOC entry 4843 (class 2606 OID 16636)
-- Name: motos motos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motos
    ADD CONSTRAINT motos_pkey PRIMARY KEY (id);


--
-- TOC entry 4845 (class 2606 OID 16638)
-- Name: motos motos_placa_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motos
    ADD CONSTRAINT motos_placa_key UNIQUE (placa);


--
-- TOC entry 4835 (class 2606 OID 16602)
-- Name: roles roles_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_nombre_key UNIQUE (nombre);


--
-- TOC entry 4837 (class 2606 OID 16600)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 16682)
-- Name: servicios servicios_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT servicios_nombre_key UNIQUE (nombre);


--
-- TOC entry 4857 (class 2606 OID 16680)
-- Name: servicios servicios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicios
    ADD CONSTRAINT servicios_pkey PRIMARY KEY (id);


--
-- TOC entry 4882 (class 2620 OID 16771)
-- Name: inventario trigger_update_fecha_actualizacion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_fecha_actualizacion BEFORE UPDATE ON public.inventario FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();


--
-- TOC entry 4874 (class 2606 OID 16710)
-- Name: cita_servicios cita_servicios_cita_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita_servicios
    ADD CONSTRAINT cita_servicios_cita_id_fkey FOREIGN KEY (cita_id) REFERENCES public.citas(id) ON DELETE CASCADE;


--
-- TOC entry 4875 (class 2606 OID 16715)
-- Name: cita_servicios cita_servicios_servicio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita_servicios
    ADD CONSTRAINT cita_servicios_servicio_id_fkey FOREIGN KEY (servicio_id) REFERENCES public.servicios(id);


--
-- TOC entry 4872 (class 2606 OID 16693)
-- Name: citas citas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- TOC entry 4873 (class 2606 OID 16773)
-- Name: citas citas_moto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_moto_id_fkey FOREIGN KEY (moto_id) REFERENCES public.motos(id) ON DELETE CASCADE;


--
-- TOC entry 4869 (class 2606 OID 16624)
-- Name: clientes clientes_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);


--
-- TOC entry 4868 (class 2606 OID 16611)
-- Name: empleados empleados_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleados_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);


--
-- TOC entry 4879 (class 2606 OID 16755)
-- Name: factura_detalles factura_detalles_factura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_detalles
    ADD CONSTRAINT factura_detalles_factura_id_fkey FOREIGN KEY (factura_id) REFERENCES public.facturas(id) ON DELETE CASCADE;


--
-- TOC entry 4880 (class 2606 OID 16765)
-- Name: factura_detalles factura_detalles_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_detalles
    ADD CONSTRAINT factura_detalles_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.inventario(id);


--
-- TOC entry 4881 (class 2606 OID 16760)
-- Name: factura_detalles factura_detalles_servicio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura_detalles
    ADD CONSTRAINT factura_detalles_servicio_id_fkey FOREIGN KEY (servicio_id) REFERENCES public.servicios(id);


--
-- TOC entry 4876 (class 2606 OID 16733)
-- Name: facturas facturas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- TOC entry 4877 (class 2606 OID 16738)
-- Name: facturas facturas_moto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_moto_id_fkey FOREIGN KEY (moto_id) REFERENCES public.motos(id);


--
-- TOC entry 4878 (class 2606 OID 16788)
-- Name: facturas fk_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT fk_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleados(id) ON DELETE SET NULL;


--
-- TOC entry 4871 (class 2606 OID 16667)
-- Name: inventario inventario_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias(id);


--
-- TOC entry 4870 (class 2606 OID 16639)
-- Name: motos motos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motos
    ADD CONSTRAINT motos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id) ON DELETE CASCADE;


-- Completed on 2025-11-24 21:19:22

--
-- PostgreSQL database dump complete
--

\unrestrict nXzX2lv78HNlimliz8rALVwMXcVRzeZQKRImBzdNuh5NvnyTPPnlhff7JD3rH21

