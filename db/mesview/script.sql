create sequence productividadplanificacionproductividadplanificacionrest_id_seq;

alter sequence productividadplanificacionproductividadplanificacionrest_id_seq owner to postgres;

create sequence equipment_property_id_seq;

alter sequence equipment_property_id_seq owner to postgres;

create sequence equipment_property_meter_id_seq;

alter sequence equipment_property_meter_id_seq owner to postgres;

create sequence parteeficiencia_id_seq;

alter sequence parteeficiencia_id_seq owner to postgres;

create sequence parteeficienciaatributo_id_seq;

alter sequence parteeficienciaatributo_id_seq owner to postgres;

create sequence partemermas_id_seq;

alter sequence partemermas_id_seq owner to postgres;

create sequence parteproductividad_id_seq;

alter sequence parteproductividad_id_seq owner to postgres;

create sequence parteproductividadoperario_id_seq;

alter sequence parteproductividadoperario_id_seq owner to postgres;

create sequence productotipo_id_seq;

alter sequence productotipo_id_seq owner to postgres;

create sequence suscripcion_id_seq;

alter sequence suscripcion_id_seq owner to postgres;

create sequence variableclase_id_seq;

alter sequence variableclase_id_seq owner to postgres;

create type enum_accion_estado as enum ('abierta', 'en curso', 'cerrada', 'desestimada');

alter type enum_accion_estado owner to postgres;

create type enum_atributo_tipocalculo as enum ('promedio', 'conjuncion', 'expresion');

alter type enum_atributo_tipocalculo owner to postgres;

create type enum_defecto_estado as enum ('abierto', 'en curso', 'cerrado', 'desestimado');

alter type enum_defecto_estado owner to postgres;

create type enum_defecto_prioridad as enum ('baja', 'media', 'alta');

alter type enum_defecto_prioridad owner to postgres;

create type enum_estadooperario_tipoestado as enum ('noactivo', 'pausa');

alter type enum_estadooperario_tipoestado owner to postgres;

create type enum_formacioncurso_estado as enum ('abierto', 'cerrado', 'en_curso');

alter type enum_formacioncurso_estado owner to postgres;

create type enum_grupocomunicacion_estado as enum ('abierto', 'cerrado');

alter type enum_grupocomunicacion_estado owner to postgres;

create type enum_incidencia_estado as enum ('abierta', 'cerrada', 'desestimada');

alter type enum_incidencia_estado owner to postgres;

create type enum_incidencia_old_estado as enum ('abierta', 'cerrada');

alter type enum_incidencia_old_estado owner to postgres;

create type enum_log_severidad as enum ('info', 'warning', 'error');

alter type enum_log_severidad owner to postgres;

create type enum_mejora_ahorro as enum ('economico', 'tiempo', 'reclamacion');

alter type enum_mejora_ahorro owner to postgres;

create type enum_mejora_colectivo as enum ('Operario', 'Jefe Equipo', 'Mando');

alter type enum_mejora_colectivo owner to postgres;

create type enum_mejora_estado as enum ('abierta', 'en curso', 'cerrada', 'desestimada');

alter type enum_mejora_estado owner to postgres;

create type enum_operario_cuadrante as enum ('L-V', 'CAMPAÑA');

alter type enum_operario_cuadrante owner to postgres;

create type tipo_incremento_enum as enum ('ABSOLUTO', 'PORCENTAJE (%)');

alter type tipo_incremento_enum owner to postgres;

create type tipo_valor_enum as enum ('STRING', 'LONG', 'FLOAT', 'BOOLEAN', 'DATE', 'JSON');

alter type tipo_valor_enum owner to postgres;

create type tipo_agregacion_enum as enum ('magnitud', 'incremental', 'discreto');

alter type tipo_agregacion_enum owner to postgres;

create table centroestadocrear
(
    estado            varchar(100) default NULL::character varying,
    padre             varchar(100) default NULL::character varying,
    tipo              varchar(100) default NULL::character varying,
    justificar        boolean,
    centro            varchar(100) default NULL::character varying,
    tipocapturaestado varchar(50)  default NULL::character varying
);

alter table centroestadocrear
    owner to postgres;

create table centroordenwipinmaterialinsertar
(
    codorden             varchar(100) default NULL::character varying,
    numsecuencia         integer,
    cantidad             double precision,
    centronombre         varchar(100) default NULL::character varying,
    productonombre       varchar(100) default NULL::character varying,
    codigoproducto       varchar(100) default NULL::character varying,
    unidadprinc          varchar(100) default NULL::character varying,
    fecha                date,
    ean13                varchar(200) default NULL::character varying,
    codreceta            varchar(100) default NULL::character varying,
    unidadreceta         varchar(100) default NULL::character varying,
    nombrematerial       varchar(150) default NULL::character varying,
    codigomaterial       varchar(200) default NULL::character varying,
    manual1              boolean,
    consumoteorico       double precision,
    consumoobjetivo      double precision,
    unidadmaterial       varchar(100) default NULL::character varying,
    ratioconteoprincipal varchar(50)  default NULL::character varying,
    tipo                 varchar(10)  default NULL::character varying,
    nombrewipin          varchar(100) default NULL::character varying,
    codigowipin          varchar(50)  default NULL::character varying,
    ratioconsumomaterial double precision,
    porcentaje           double precision,
    descuento            boolean
);

alter table centroordenwipinmaterialinsertar
    owner to postgres;

create table grupocomunicaciontipo
(
    id         bigserial
        primary key,
    nombre     varchar(45) default NULL::character varying,
    padre_fk   bigint
        constraint grupocomunicaciontipo_padre_fk
            references grupocomunicaciontipo,
    orden      bigint      default 0,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table grupocomunicaciontipo
    owner to postgres;

create table incidenciafichero
(
    id          bigserial
        primary key,
    nombre      varchar(45)  default NULL::character varying,
    rutafichero varchar(500) default NULL::character varying,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table incidenciafichero
    owner to postgres;

create table incidenciatipo
(
    id               bigserial
        primary key,
    tipopadre_fk     bigint
        constraint incidenciatipo_tipopadre_fk
            references incidenciatipo,
    nombre           varchar(255) default NULL::character varying,
    descripcion      varchar(200) default NULL::character varying,
    orden            bigint       default 0,
    operarioafectado boolean,
    activo           boolean      default true,
    plantilla        varchar(150) default NULL::character varying,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint,
    tipoespecial     integer      default 0
);

alter table incidenciatipo
    owner to postgres;

create table licencia
(
    clave      varchar(255) not null
        primary key,
    token      varchar(300) default NULL::character varying,
    created    date,
    updated    date,
    created_by bigint,
    updated_by bigint
);

alter table licencia
    owner to postgres;

create table log_transacciones
(
    id             bigint generated by default as identity
        primary key,
    tipo           integer    not null,
    solicitud      text       not null,
    respuesta      text,
    hora_solicitud timestamp,
    hora_respuesta timestamp,
    resultado      varchar(2) not null,
    documento      varchar(20),
    centro_fk      bigint,
    centroorden_fk bigint,
    producto_fk    bigint
);

alter table log_transacciones
    owner to postgres;

create table mejoratipo
(
    id                 bigserial
        primary key,
    nombre             varchar(45) default NULL::character varying,
    mejoratipopadre_fk bigint
        constraint mejoratipo_mejoratipopadre_fk
            references mejoratipo,
    descripcion        varchar(45) default NULL::character varying,
    orden              integer     default 0,
    activo             boolean,
    created            timestamp,
    updated            timestamp,
    created_by         bigint,
    updated_by         bigint
);

alter table mejoratipo
    owner to postgres;

create table menuitem
(
    id         bigserial
        primary key,
    item       varchar(50) not null,
    contexto   varchar(50) not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table menuitem
    owner to postgres;

create table menuitemaccion
(
    id          bigserial
        primary key,
    menuitem_fk bigint
        constraint menuitemaccion_menuitem_fk
            references menuitem,
    accion      varchar(100) default NULL::character varying,
    created     timestamp,
    updated     timestamp
);

alter table menuitemaccion
    owner to postgres;

create table modulo
(
    id         bigserial
        primary key,
    nombre     varchar(45)  not null,
    contexto   varchar(45)  not null,
    ruta       varchar(100) not null,
    rol        varchar(45) default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table modulo
    owner to postgres;

create table observaciontipo
(
    id                      bigserial
        primary key,
    observaciontipopadre_fk bigint
        constraint observaciontipo_observaciontipopadre_fk
            references observaciontipo,
    nombre                  varchar(45)  default NULL::character varying,
    descripcion             varchar(150) default NULL::character varying,
    activo                  boolean      default false,
    plantilla               varchar(150) default NULL::character varying,
    reglada                 boolean      default false,
    email                   boolean      default false,
    orden                   bigint       default 0,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint,
    updated_by              bigint
);

alter table observaciontipo
    owner to postgres;

create table oldcentroestado
(
    id                bigserial
        primary key,
    frecmuestreoseg   bigint                     not null,
    nodeidopc         varchar(255) default NULL::character varying,
    tipocapturaestado varchar(255) default NULL::character varying,
    umbralmax         bigint                     not null,
    umbralmin         bigint                     not null,
    centro_fk         bigint,
    estado_fk         bigint,
    nsecuencia        integer      default 50000 not null,
    created           timestamp,
    updated           timestamp,
    created_by        bigint,
    updated_by        bigint
);

alter table oldcentroestado
    owner to postgres;

create table opcnodo
(
    variable_id    bigserial
        primary key,
    uri            varchar(150)          not null,
    vector         boolean default false not null,
    posicionvector integer default 0     not null,
    valorreset     integer default 0     not null,
    created        timestamp,
    updated        timestamp,
    created_by     bigint,
    updated_by     bigint
);

alter table opcnodo
    owner to postgres;

create table opcserver
(
    servidor_id  bigint       not null
        primary key,
    uri          varchar(100) not null,
    tag_bit_vida varchar(45) default NULL::character varying,
    created      timestamp,
    updated      timestamp,
    created_by   bigint,
    updated_by   bigint
);

alter table opcserver
    owner to postgres;

create table ordenestado
(
    id                  bigserial
        primary key,
    nombre              varchar(50) default NULL::character varying,
    codigo              varchar(50) default NULL::character varying,
    activa              boolean     default false,
    modificable         boolean     default false,
    created             timestamp,
    updated             timestamp,
    created_by          bigint,
    updated_by          bigint,
    permite_consumos    boolean,
    permite_altas       boolean,
    permite_encurso     boolean,
    estadoerp           boolean,
    codigoerp           varchar(50) default NULL::character varying,
    estadotocambioorden boolean,
    estilo              varchar(50) default NULL::character varying,
    prioridad           integer,
    esestadofinal       boolean,
    validacion          boolean     default false
);

alter table ordenestado
    owner to postgres;

create table ordenestadotransicion
(
    id                    bigserial
        primary key,
    ordenestadoorigen_fk  bigint not null
        constraint ordenestadotransicion_ordenestadoorigen_fk
            references ordenestado,
    ordenestadodestino_fk bigint not null
        constraint ordenestadotransicion_ordenestadodestino_fk
            references ordenestado,
    created               timestamp,
    updated               timestamp,
    created_by            bigint,
    updated_by            bigint
);

alter table ordenestadotransicion
    owner to postgres;

create table perdidatipo
(
    id                  bigserial
        primary key,
    nombre              varchar(45) default NULL::character varying,
    perdidatipopadre_fk bigint
        constraint perdidatipo_perdidatipopadre_fk
            references perdidatipo,
    descripcion         varchar(45) default NULL::character varying,
    orden               bigint      default 0,
    activo              boolean,
    created             timestamp,
    updated             timestamp,
    created_by          bigint,
    updated_by          bigint
);

alter table perdidatipo
    owner to postgres;

create table perfilusuario
(
    id                   bigserial
        primary key,
    nombre               varchar(45) default NULL::character varying,
    acceso_configuracion boolean     default false not null,
    pordefecto           boolean     default false not null,
    mantenimiento        boolean     default false not null,
    created              timestamp,
    updated              timestamp,
    created_by           bigint,
    updated_by           bigint
);

alter table perfilusuario
    owner to postgres;

create table perfilusuariomenuitem
(
    id               bigserial
        primary key,
    perfilusuario_fk bigint not null,
    menuitem_fk      bigint not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table perfilusuariomenuitem
    owner to postgres;

create table perfilusuariomenuitemaccion
(
    id                bigserial
        primary key,
    menuitemaccion_fk bigint
        constraint perfilusuariomenuitemaccion_menuitemaccion_fk
            references menuitemaccion,
    perfilusuario_fk  bigint
        constraint perfilusuariomenuitemaccion_perfilusuario_fk
            references perfilusuario,
    read_p            boolean,
    write_p           boolean,
    operation_p       boolean,
    created           timestamp,
    updated           timestamp
);

alter table perfilusuariomenuitemaccion
    owner to postgres;

create table perfilusuariomodulo
(
    id         bigserial
        primary key,
    perfil_fk  bigint not null,
    modulo_fk  bigint not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table perfilusuariomodulo
    owner to postgres;

create table planificacionproduccion
(
    id            bigserial
        primary key,
    fechasubida   timestamp,
    nombrefichero varchar(100) default NULL::character varying,
    procesada     boolean      default false not null,
    fechaproceso  timestamp,
    created       timestamp,
    updated       timestamp,
    created_by    bigint,
    updated_by    bigint
);

alter table planificacionproduccion
    owner to postgres;

create table planta
(
    id         bigserial
        primary key,
    nombre     varchar(255) default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table planta
    owner to postgres;

create table productividadlistaoperario
(
    id         bigserial
        primary key,
    nombre     varchar(45) default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table productividadlistaoperario
    owner to postgres;

create table operarioclase
(
    id               bigserial
        primary key,
    nombre           varchar(255) default NULL::character varying,
    externo          boolean      default false,
    listaoperario_fk bigint
        constraint operarioclase_listaoperario_fk
            references productividadlistaoperario,
    abreviatura      varchar(10)  default NULL::character varying,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table operarioclase
    owner to postgres;

create table productividadplanificacionestado
(
    id              bigserial
        primary key,
    nombre          varchar(90)                not null,
    descripcion     varchar(250) default NULL::character varying,
    listaproduccion boolean      default false not null,
    created         timestamp,
    updated         timestamp,
    created_by      bigint,
    updated_by      bigint
);

alter table productividadplanificacionestado
    owner to postgres;

create table productividadplanificacionfichero
(
    id          bigserial
        primary key,
    nombre      varchar(45) default NULL::character varying,
    fechainicio timestamp,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table productividadplanificacionfichero
    owner to postgres;

create table productividadplanificacionrestriccion
(
    id          bigserial
        primary key,
    descripcion varchar(150) default NULL::character varying,
    horas       integer,
    general     boolean,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table productividadplanificacionrestriccion
    owner to postgres;

create table productoentrada
(
    id         bigserial
        primary key,
    cantidad   double precision default 0 not null,
    fecha      timestamp                  not null,
    lote       varchar(20)                not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table productoentrada
    owner to postgres;

create table productofamilia
(
    id                      bigserial
        primary key,
    nombre                  varchar(255) not null,
    codigo                  varchar(50) default NULL::character varying
        constraint uq_productofamilia
            unique,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint,
    updated_by              bigint,
    productofamiliapadre_fk bigint
        constraint productofamilia_productofamiliapadre_fk
            references productofamilia
);

alter table productofamilia
    owner to postgres;

create table productofamiliapropiedad
(
    id                               bigserial
        primary key,
    codigo                           varchar(50)  default NULL::character varying,
    descripcion                      varchar(250) default NULL::character varying,
    valor                            varchar(255),
    unidad                           varchar(100) default NULL::character varying,
    productofamilia_fk               bigint                                           not null
        constraint productofamiliapropiedad_productofamilia_fk
            references productofamilia,
    productofamiliapropiedadpadre_fk bigint
        constraint productofamiliapropiedad_productofamiliapropiedadpadre_fk
            references productofamiliapropiedad,
    created                          timestamp,
    updated                          timestamp,
    created_by                       bigint,
    updated_by                       bigint,
    tipo_valor                       varchar(20)  default 'STRING'::character varying not null
        constraint check_tipo_valor
            check ((tipo_valor)::text = ANY
                   (ARRAY [('STRING'::character varying)::text, ('LONG'::character varying)::text, ('FLOAT'::character varying)::text, ('BOOLEAN'::character varying)::text, ('DATE'::character varying)::text, ('JSON'::character varying)::text])),
    constraint unique_index
        unique (codigo, productofamilia_fk)
);

alter table productofamiliapropiedad
    owner to postgres;

create table productoinsertar
(
    codigoproducto varchar(255) default NULL::character varying,
    codigolargo    varchar(255) default NULL::character varying,
    nombreproducto varchar(255) default NULL::character varying,
    tipo           varchar(20)  default NULL::character varying
);

alter table productoinsertar
    owner to postgres;

create table productotipo
(
    id         bigint default nextval('productotipo_id_seq'::regclass) not null
        primary key,
    nombre     varchar(45)                                             not null,
    created    date,
    updated    date,
    created_by bigint,
    updated_by bigint
);

alter table productotipo
    owner to postgres;

create table recetaingredientewipininsertar
(
    recetacodigo         varchar(255) default NULL::character varying,
    productoprincipal    varchar(255) default NULL::character varying,
    unidadreceta         varchar(255) default NULL::character varying,
    cantidad             varchar(20)  default NULL::character varying,
    material             varchar(255) default NULL::character varying,
    unidadmaterial       varchar(255) default NULL::character varying,
    consumoteorico       double precision,
    consumoobjetivo      double precision,
    tipo                 varchar(10)  default NULL::character varying,
    consumomanual        boolean,
    wipin                varchar(255) default NULL::character varying,
    ratioconsumomaterial double precision,
    porcentaje           double precision
);

alter table recetaingredientewipininsertar
    owner to postgres;

create table recursotipo
(
    id         bigserial
        primary key,
    nombre     varchar(255) default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table recursotipo
    owner to postgres;

create table regla
(
    id          bigserial
        primary key,
    nombre      varchar(90) not null,
    descripcion varchar(250) default NULL::character varying,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table regla
    owner to postgres;

create table perfilusuarioregla
(
    id               bigserial
        primary key,
    perfilusuario_fk bigint not null
        constraint perfilusuarioregla_perfilusuario_fk
            references perfilusuario,
    regla_fk         bigint not null
        constraint perfilusuarioregla_regla_fk
            references regla,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table perfilusuarioregla
    owner to postgres;

create table servidor
(
    id               bigserial
        primary key,
    nombre           varchar(45)  default NULL::character varying,
    descripcion      varchar(150) default NULL::character varying,
    servidorclase_fk bigint                    not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint,
    activo           boolean      default true not null
);

alter table servidor
    owner to postgres;

create table servidorclase
(
    id          bigserial
        primary key,
    codigo      varchar(40) not null,
    descripcion varchar(150) default NULL::character varying,
    created     timestamp    default CURRENT_TIMESTAMP,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table servidorclase
    owner to postgres;

create table servidorclasepropiedad
(
    id                        bigserial
        primary key,
    nombre                    varchar(50)                                      not null,
    descripcion               varchar(150) default NULL::character varying,
    valor                     varchar(100) default NULL::character varying,
    tipovalor                 varchar(20)  default 'STRING'::character varying not null,
    servidorclasepropiedad_fk bigint
        constraint servidorclasepropiedad_servidorclasepropiedad_fk
            references servidorclasepropiedad,
    servidorclase_fk          bigint                                           not null
        constraint servidorclasepropiedad_servidorclase_fk
            references servidorclase,
    created                   timestamp    default CURRENT_TIMESTAMP,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table servidorclasepropiedad
    owner to postgres;

create table sugerenciatipo
(
    id                     bigserial
        primary key,
    sugerenciatipopadre_fk bigint
        constraint sugerenciatipo_sugerenciatipopadre_fk
            references sugerenciatipo,
    nombre                 varchar(45)  default NULL::character varying,
    descripcion            varchar(150) default NULL::character varying,
    orden                  bigint       default 0,
    activo                 boolean      default true not null,
    plantilla              varchar(150) default NULL::character varying,
    created                timestamp,
    updated                timestamp,
    created_by             bigint,
    updated_by             bigint
);

alter table sugerenciatipo
    owner to postgres;

create table suscripcion
(
    id         bigint       default nextval('suscripcion_id_seq'::regclass) not null
        primary key,
    nombre     varchar(100) default NULL::character varying,
    url        varchar(255)                                                 not null,
    tipo       varchar(45)  default NULL::character varying,
    clasedto   varchar(45)  default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table suscripcion
    owner to postgres;

create table tareasprogramadas
(
    id               bigserial
        primary key,
    clave            bigint                  not null,
    tipo             bigint                  not null,
    fechaprogramada  timestamp               not null,
    fechaproceso     timestamp,
    fechacancelacion timestamp,
    procesada        boolean   default false not null,
    created          timestamp default CURRENT_TIMESTAMP,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table tareasprogramadas
    owner to postgres;

create table tempmedida
(
    id                        bigserial
        primary key,
    finicio                   timestamp,
    ffin                      timestamp,
    valormedida               bigint       default 0,
    centroestado_fk           bigint,
    centroproducto_fk         bigint,
    grupo                     varchar(45)  default NULL::character varying,
    incidencia                varchar(255) default NULL::character varying,
    justificacion             varchar(255) default NULL::character varying,
    justificada               boolean not null,
    orden                     varchar(255) default NULL::character varying,
    tipomedida                varchar(255) default NULL::character varying,
    valoropc                  bigint  not null,
    valorideal                bigint  not null,
    valorobjetivo             bigint  not null,
    valornarmario             varchar(255) default NULL::character varying,
    valornpalet               varchar(255) default NULL::character varying,
    valorpesomedio            varchar(255) default NULL::character varying,
    valornplacas              varchar(255) default NULL::character varying,
    valorfaltapeso            varchar(255) default NULL::character varying,
    valorgruesas              varchar(255) default NULL::character varying,
    turno_fk                  bigint,
    duracion                  bigint,
    automatica                boolean,
    valormedidaxmin           double precision,
    umbralmaxxmin             double precision,
    umbralminxmin             double precision,
    ordensuperada             boolean,
    centroorden_fk            bigint,
    inconsistenciacentroorden boolean      default false,
    created                   timestamp,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table tempmedida
    owner to postgres;

create table tempmedidaatributo
(
    id             bigserial
        primary key,
    medida_fk      bigint,
    atributo_fk    bigint,
    valor          varchar(100) default NULL::character varying,
    nombreatributo varchar(100) default NULL::character varying,
    nsecuencia     integer,
    created        timestamp,
    updated        timestamp,
    created_by     bigint,
    updated_by     bigint
);

alter table tempmedidaatributo
    owner to postgres;

create table terminal
(
    id         bigserial
        primary key,
    nombre     varchar(45) not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table terminal
    owner to postgres;

create table tipooperario
(
    id                 bigserial
        primary key,
    codigo             varchar(40) default NULL::character varying,
    nombre             varchar(45) default NULL::character varying,
    abreviatura        varchar(10) default NULL::character varying,
    nsecuencia         integer,
    grado              integer     default 0,
    gestionincidencias boolean     default false,
    defecto            boolean     default false,
    listaspersonal     boolean     default true,
    created            timestamp,
    updated            timestamp,
    created_by         bigint,
    updated_by         bigint,
    manoobradirecta    boolean     default true
);

alter table tipooperario
    owner to postgres;

create index idx_tipooperario_lookup
    on tipooperario (id) include (nombre);

create table turno
(
    id               bigserial
        primary key,
    identificador    varchar(45)              not null,
    doblado          boolean     default false,
    turnorotacion_fk bigint
        constraint turno_turnorotacion_fk
            references turno,
    horainicio       varchar(45) default NULL::character varying,
    horafin          varchar(45) default NULL::character varying,
    lunes            boolean     default true not null,
    martes           boolean     default true not null,
    miercoles        boolean     default true not null,
    jueves           boolean     default true not null,
    viernes          boolean     default true not null,
    sabado           boolean     default true not null,
    domingo          boolean     default true not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint,
    iniciojornada    boolean,
    operativo        boolean,
    grupo_fk         integer,
    pararcentro      boolean     default false,
    turnoactual      boolean     default false
);

alter table turno
    owner to postgres;

create table unidadescentro
(
    id         bigserial
        primary key,
    idcentro   bigint,
    idunidad   bigint,
    principal  boolean not null,
    conteo     boolean not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table unidadescentro
    owner to postgres;

create table usuario
(
    id                          bigserial
        primary key,
    nombre                      varchar(255) default NULL::character varying,
    login                       varchar(10)                not null,
    password                    varchar(255)               not null,
    activo                      boolean      default true  not null,
    perfil_fk                   bigint                     not null
        constraint usuario_perfil_fk
            references perfilusuario,
    autorizadovalidacioncalidad boolean      default false not null,
    autorizadoeditarcontrol     boolean      default false not null,
    email                       varchar(100) default NULL::character varying,
    created                     timestamp,
    updated                     timestamp,
    created_by                  bigint,
    updated_by                  bigint
);

alter table usuario
    owner to postgres;

create table aplicacion
(
    id         bigserial
        primary key,
    nombre     varchar(45)  not null,
    icono      varchar(45) default NULL::character varying,
    ruta       varchar(100) not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint aplicacion_created_by_fk
            references usuario,
    updated_by bigint
        constraint aplicacion_updated_by_fk
            references usuario
);

alter table aplicacion
    owner to postgres;

create index aplicacion_created_by_idx
    on aplicacion (created_by);

create index aplicacion_updated_by_idx
    on aplicacion (updated_by);

create table app_config
(
    id                              serial
        primary key,
    show_tabs_efficiency            boolean      default true  not null,
    show_tabs_productivity          boolean      default true  not null,
    show_tabs_quality               boolean      default true  not null,
    show_tabs_material              boolean      default true  not null,
    show_tabs_incidence             boolean      default true  not null,
    show_tabs_standardization       boolean      default true  not null,
    show_ep_data                    boolean      default true  not null,
    show_tabs_scrap                 boolean      default true  not null,
    is_scrap_auto                   boolean      default false not null,
    scrap_objective                 double precision,
    scrap_auto                      double precision,
    event_cambioorden_parte         boolean      default false not null,
    event_cambioturno_parte         boolean      default false not null,
    minutosiniciotiemporeal         integer      default 0,
    desahbilitaroperariosincidencia boolean      default false not null,
    init_page                       varchar(300) default NULL::character varying,
    created                         timestamp,
    updated                         timestamp,
    created_by                      bigint
        constraint app_config_created_by_fk
            references usuario,
    updated_by                      bigint
        constraint app_config_updated_by_fk
            references usuario,
    lp_whatsapp_df_diffusiongroup   varchar(255) default NULL::character varying
);

alter table app_config
    owner to postgres;

create index app_config_created_by_idx
    on app_config (created_by);

create index app_config_updated_by_idx
    on app_config (updated_by);

create table area
(
    id         bigserial
        primary key,
    nombre     varchar(255) default NULL::character varying,
    planta_fk  bigint
        constraint area_planta_fk
            references planta,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint area_created_by_fk
            references usuario,
    updated_by bigint
        constraint area_updated_by_fk
            references usuario
);

alter table area
    owner to postgres;

create index area_created_by_idx
    on area (created_by);

create index area_planta_fk_idx
    on area (planta_fk);

create index area_updated_by_idx
    on area (updated_by);

create index idx_area_planta_covering
    on area (planta_fk) include (nombre);

create table atributogrupo
(
    id         bigserial
        primary key,
    nombre     varchar(45) not null,
    created    date,
    updated    date,
    created_by bigint
        constraint atributogrupo_created_by_fk
            references usuario,
    updated_by bigint
        constraint atributogrupo_updated_by_fk
            references usuario
);

alter table atributogrupo
    owner to postgres;

create table atributo
(
    id              bigserial
        primary key,
    grupo_fk        bigint
        constraint atributo_atributogrupo_fk
            references atributogrupo,
    nombre          varchar(45)  default NULL::character varying,
    orden           integer,
    estandarizacion boolean      default false,
    receta          boolean      default false,
    editablereceta  boolean      default false,
    articulo        boolean      default false,
    informearticulo boolean      default false,
    tablareceta     boolean      default false,
    tipovalor       varchar(45)  default NULL::character varying,
    valordefecto    varchar(45)  default NULL::character varying,
    calculado       boolean      default false,
    tipocalculo     enum_atributo_tipocalculo,
    expresion       varchar(200) default NULL::character varying,
    etiqueta        varchar(45)  default NULL::character varying,
    icono           varchar(45)  default NULL::character varying,
    created         timestamp,
    updated         timestamp,
    created_by      bigint
        constraint atributo_created_by_fk
            references usuario,
    updated_by      bigint
        constraint atributo_updated_by_fk
            references usuario
);

alter table atributo
    owner to postgres;

create index atributo_created_by_idx
    on atributo (created_by);

create index atributo_grupo_fk_idx
    on atributo (grupo_fk);

create index atributo_updated_by_idx
    on atributo (updated_by);

create index atributogrupo_created_by_idx
    on atributogrupo (created_by);

create index atributogrupo_updated_by_idx
    on atributogrupo (updated_by);

create table atributovalorseleccion
(
    id          bigserial
        primary key,
    atributo_fk bigint not null
        constraint atributovalorseleccion_atributo_fk
            references atributo,
    etiqueta    varchar(45)  default NULL::character varying,
    valor       varchar(200) default NULL::character varying,
    created     date,
    updated     date,
    created_by  bigint
        constraint atributovalorseleccion_created_by_fk
            references usuario,
    updated_by  bigint
        constraint atributovalorseleccion_updated_by_fk
            references usuario,
    constraint atributovalorseleccion_uq
        unique (atributo_fk, valor)
);

alter table atributovalorseleccion
    owner to postgres;

create index atributovalorseleccion_atributo_fk_idx
    on atributovalorseleccion (atributo_fk);

create index atributovalorseleccion_created_by_idx
    on atributovalorseleccion (created_by);

create index atributovalorseleccion_updated_by_idx
    on atributovalorseleccion (updated_by);

create index atributovalorseleccion_valor_idx
    on atributovalorseleccion (valor);

create table calendario
(
    id          bigserial
        primary key,
    descripcion varchar(40) not null,
    tipo_fk     bigint,
    fechainicio timestamp,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint calendario_created_by_fk
            references usuario,
    updated_by  bigint
        constraint calendario_updated_by_fk
            references usuario
);

alter table calendario
    owner to postgres;

create index calendario_created_by_idx
    on calendario (created_by);

create index calendario_updated_by_idx
    on calendario (updated_by);

create table calendarioevento
(
    id            bigserial
        primary key,
    descripcion   varchar(500) not null,
    ubicacion     varchar(250) default NULL::character varying,
    calendario_fk bigint       not null
        constraint calendarioevento_calendario_fk
            references calendario,
    fechainicio   timestamp,
    fechafin      timestamp,
    recurrencia   varchar(40)  default NULL::character varying,
    starts_on     date,
    ends_on       date,
    starts_at     timestamp,
    ends_at       timestamp,
    frequency     varchar(45)  default NULL::character varying,
    separation    integer      default 1,
    occurlimit    integer,
    until         date,
    created       timestamp,
    updated       timestamp,
    created_by    bigint
        constraint calendarioevento_created_by_fk
            references usuario,
    updated_by    bigint
        constraint calendarioevento_updated_by_fk
            references usuario,
    grupo_fk      integer
);

alter table calendarioevento
    owner to postgres;

create index calendarioevento_calendario_fk_idx
    on calendarioevento (calendario_fk);

create index calendarioevento_created_by_idx
    on calendarioevento (created_by);

create index calendarioevento_grupo_fk_idx
    on calendarioevento (grupo_fk);

create index calendarioevento_updated_by_idx
    on calendarioevento (updated_by);

create table calendarioeventoauxiliar
(
    id                  bigserial
        primary key,
    calendarioevento_fk bigint
        constraint calendarioeventoauxiliar_calendarioevento_fk
            references calendarioevento,
    fecha               timestamp,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint calendarioeventoauxiliar_created_by_fk
            references usuario,
    updated_by          bigint
        constraint calendarioeventoauxiliar_updated_by_fk
            references usuario,
    constraint calendarioeventoauxiliar_uq
        unique (calendarioevento_fk, fecha)
);

alter table calendarioeventoauxiliar
    owner to postgres;

create index calendarioeventoauxiliar_calendarioevento_fk_idx
    on calendarioeventoauxiliar (calendarioevento_fk);

create index calendarioeventoauxiliar_created_by_idx
    on calendarioeventoauxiliar (created_by);

create index calendarioeventoauxiliar_updated_by_idx
    on calendarioeventoauxiliar (updated_by);

create table calendarioeventocancelacion
(
    id                  bigserial
        primary key,
    calendarioevento_fk bigint
        constraint calendarioeventocancelacion_calendarioevento_fk
            references calendarioevento,
    canceldate          date,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint calendarioeventocancelacion_created_by_fk
            references usuario,
    updated_by          bigint
        constraint calendarioeventocancelacion_updated_by_fk
            references usuario
);

alter table calendarioeventocancelacion
    owner to postgres;

create index calendarioeventocancelacion_calendarioevento_fk_idx
    on calendarioeventocancelacion (calendarioevento_fk);

create index calendarioeventocancelacion_created_by_idx
    on calendarioeventocancelacion (created_by);

create index calendarioeventocancelacion_updated_by_idx
    on calendarioeventocancelacion (updated_by);

create table calendarioeventorecurrencia
(
    id                  bigserial
        primary key,
    calendarioevento_fk bigint
        constraint calendarioeventorecurrencia_calendarioevento_fk
            references calendarioevento,
    month               integer,
    day                 integer,
    week                integer,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint calendarioeventorecurrencia_created_by_fk
            references usuario,
    updated_by          bigint
        constraint calendarioeventorecurrencia_updated_by_fk
            references usuario
);

alter table calendarioeventorecurrencia
    owner to postgres;

create index calendarioeventorecurrencia_calendarioevento_fk_idx
    on calendarioeventorecurrencia (calendarioevento_fk);

create index calendarioeventorecurrencia_created_by_idx
    on calendarioeventorecurrencia (created_by);

create index calendarioeventorecurrencia_updated_by_idx
    on calendarioeventorecurrencia (updated_by);

create table calendariotipo
(
    id          bigserial
        primary key,
    nombre      varchar(45)  default NULL::character varying,
    descripcion varchar(255) default NULL::character varying,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint calendariotipo_created_by_fk
            references usuario,
    updated_by  bigint
        constraint calendariotipo_updated_by_fk
            references usuario
);

alter table calendariotipo
    owner to postgres;

create index calendariotipo_created_by_idx
    on calendariotipo (created_by);

create index calendariotipo_updated_by_idx
    on calendariotipo (updated_by);

create table calidadeventocontrol
(
    id              bigserial
        primary key,
    nombre          varchar(100) default NULL::character varying,
    tipo            integer      default 1 not null,
    tiempo          integer      default 0 not null,
    cantidad        double precision,
    horafija        timestamp,
    horavencimiento timestamp,
    created         timestamp,
    updated         timestamp,
    created_by      bigint
        constraint calidadeventocontrol_created_by_fk
            references usuario,
    updated_by      bigint
        constraint calidadeventocontrol_updated_by_fk
            references usuario
);

alter table calidadeventocontrol
    owner to postgres;

create index calidadeventocontrol_created_by_idx
    on calidadeventocontrol (created_by);

create index calidadeventocontrol_updated_by_idx
    on calidadeventocontrol (updated_by);

create table calidadfichaayuda
(
    id          bigserial
        primary key,
    nombre      varchar(45)  default NULL::character varying,
    rutafichero varchar(500) default NULL::character varying,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint calidadfichaayuda_created_by_fk
            references usuario,
    updated_by  bigint
        constraint calidadfichaayuda_updated_by_fk
            references usuario
);

alter table calidadfichaayuda
    owner to postgres;

create index calidadfichaayuda_created_by_idx
    on calidadfichaayuda (created_by);

create index calidadfichaayuda_updated_by_idx
    on calidadfichaayuda (updated_by);

create table calidadpuntocontrolfamilia
(
    id              bigserial
        primary key,
    nombre          varchar(100)          not null,
    principal       boolean default false not null,
    familiamadre_fk bigint
        constraint calidadpuntocontrolfamilia_familiamadre_fk
            references calidadpuntocontrolfamilia,
    numero          integer default 0     not null,
    created         timestamp,
    updated         timestamp,
    created_by      bigint
        constraint calidadpuntocontrolfamilia_created_by_fk
            references usuario,
    updated_by      bigint
        constraint calidadpuntocontrolfamilia_updated_by_fk
            references usuario
);

alter table calidadpuntocontrolfamilia
    owner to postgres;

create table calidadpuntocontrol
(
    id                 bigserial
        primary key,
    nombre             varchar(100) default NULL::character varying,
    descripcion        varchar(255) default NULL::character varying,
    tipo               integer      default 1     not null,
    tipovencimiento    integer      default 0     not null,
    subfamilia_fk      bigint
        constraint calidadpuntocontrol_subfamilia_fk
            references calidadpuntocontrolfamilia,
    numero             integer      default 0     not null,
    numeropuntocritico integer      default 0     not null,
    vencimiento        timestamp,
    fichaayuda_fk      bigint
        constraint calidadpuntocontrol_fichaayuda_fk
            references calidadfichaayuda,
    mostraraviso       boolean      default false,
    created            timestamp,
    updated            timestamp,
    created_by         bigint
        constraint calidadpuntocontrol_created_by_fk
            references usuario,
    updated_by         bigint
        constraint calidadpuntocontrol_updated_by_fk
            references usuario,
    permite_imagenes   boolean      default false not null
);

alter table calidadpuntocontrol
    owner to postgres;

create index calidadpuntocontrol_created_by_idx
    on calidadpuntocontrol (created_by);

create index calidadpuntocontrol_fichaayuda_fk_idx
    on calidadpuntocontrol (fichaayuda_fk);

create index calidadpuntocontrol_subfamilia_fk_idx
    on calidadpuntocontrol (subfamilia_fk);

create index calidadpuntocontrol_updated_by_idx
    on calidadpuntocontrol (updated_by);

create table calidadpuntocontrolautocompletar
(
    calidadpuntocontrolid bigint      not null
        primary key
        constraint calidadpuntocontrolautocompletar_calidadpuntocontrol_fk
            references calidadpuntocontrol,
    campo                 varchar(45) not null,
    created               timestamp,
    updated               timestamp,
    created_by            bigint
        constraint calidadpuntocontrolautocompletar_created_by_fk
            references usuario,
    updated_by            bigint
        constraint calidadpuntocontrolautocompletar_updated_by_fk
            references usuario
);

alter table calidadpuntocontrolautocompletar
    owner to postgres;

create index calidadpuntocontrolautocompletar_calidadpuntocontrolid_idx
    on calidadpuntocontrolautocompletar (calidadpuntocontrolid);

create index calidadpuntocontrolautocompletar_created_by_idx
    on calidadpuntocontrolautocompletar (created_by);

create index calidadpuntocontrolautocompletar_updated_by_idx
    on calidadpuntocontrolautocompletar (updated_by);

create index calidadpuntocontrolfamilia_created_by_idx
    on calidadpuntocontrolfamilia (created_by);

create index calidadpuntocontrolfamilia_familiamadre_fk_idx
    on calidadpuntocontrolfamilia (familiamadre_fk);

create index calidadpuntocontrolfamilia_updated_by_idx
    on calidadpuntocontrolfamilia (updated_by);

create table centroclase
(
    id             bigserial
        primary key,
    centroclase_fk bigint
        constraint centroclase_centroclase_fk
            references centroclase,
    nombre         varchar(100) not null,
    descripcion    varchar(300) default NULL::character varying,
    created        timestamp,
    updated        timestamp,
    created_by     bigint
        constraint centroclase_created_by_fk
            references usuario,
    updated_by     bigint
        constraint centroclase_updated_by_fk
            references usuario
);

alter table centroclase
    owner to postgres;

create index centroclase_centroclase_fk_idx
    on centroclase (centroclase_fk);

create index centroclase_created_by_idx
    on centroclase (created_by);

create index centroclase_updated_by_idx
    on centroclase (updated_by);

create table centroordenpropiedad
(
    id          bigserial
        primary key,
    nombre      varchar(255) not null,
    codigo      varchar(50)  default NULL::character varying,
    descripcion varchar(255) default NULL::character varying,
    created     timestamp    default CURRENT_TIMESTAMP,
    updated     timestamp,
    created_by  bigint
        constraint centroordenpropiedad_created_by_fk
            references usuario,
    updated_by  bigint
        constraint centroordenpropiedad_updated_by_fk
            references usuario
);

alter table centroordenpropiedad
    owner to postgres;

create index centroordenpropiedad_created_by_idx
    on centroordenpropiedad (created_by);

create index centroordenpropiedad_updated_by_idx
    on centroordenpropiedad (updated_by);

create table centrotipo
(
    id         bigserial
        primary key,
    nombre     varchar(45) default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint centrotipo_created_by_fk
            references usuario,
    updated_by bigint
        constraint centrotipo_updated_by_fk
            references usuario
);

alter table centrotipo
    owner to postgres;

create index centrotipo_created_by_idx
    on centrotipo (created_by);

create index centrotipo_updated_by_idx
    on centrotipo (updated_by);

create table defectotipo
(
    id                  bigserial
        primary key,
    nombre              varchar(45) default NULL::character varying,
    defectotipopadre_fk bigint
        constraint defectotipo_defectotipopadre_fk
            references defectotipo,
    descripcion         varchar(45) default NULL::character varying,
    orden               integer     default 0,
    activo              boolean,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint defectotipo_created_by_fk
            references usuario,
    updated_by          bigint
        constraint defectotipo_updated_by_fk
            references usuario
);

alter table defectotipo
    owner to postgres;

create index defectotipo_created_by_idx
    on defectotipo (created_by);

create index defectotipo_defectotipopadre_fk_idx
    on defectotipo (defectotipopadre_fk);

create index defectotipo_updated_by_idx
    on defectotipo (updated_by);

create table dic_claseoperario
(
    id               bigserial
        primary key,
    claseoperario_fk bigint
        constraint dic_claseoperario_claseoperario_fk
            references operarioclase,
    extcodigo        varchar(45) default NULL::character varying,
    extnombre        varchar(45) default NULL::character varying,
    cretaed          timestamp,
    updated          timestamp,
    created_by       bigint
        constraint dic_claseoperario_created_by_fk
            references usuario,
    updated_by       bigint
        constraint dic_claseoperario_updated_by_fk
            references usuario
);

alter table dic_claseoperario
    owner to postgres;

create index dic_claseoperario_claseoperario_fk_idx
    on dic_claseoperario (claseoperario_fk);

create index dic_claseoperario_created_by_idx
    on dic_claseoperario (created_by);

create index dic_claseoperario_updated_by_idx
    on dic_claseoperario (updated_by);

create table dic_tipooperario
(
    id              bigserial
        primary key,
    tipooperario_fk bigint
        constraint dic_tipooperario_tipooperario_fk
            references tipooperario,
    extcodigo       varchar(40) default NULL::character varying,
    extnombre       varchar(45) default NULL::character varying,
    created         timestamp,
    updated         timestamp,
    created_by      bigint
        constraint dic_tipooperario_created_by_fk
            references usuario,
    updated_by      bigint
        constraint dic_tipooperario_updated_by_fk
            references usuario,
    constraint dic_tipooperario_uq
        unique (tipooperario_fk, extcodigo)
);

alter table dic_tipooperario
    owner to postgres;

create index dic_tipooperario_created_by_idx
    on dic_tipooperario (created_by);

create index dic_tipooperario_tipooperario_fk_idx
    on dic_tipooperario (tipooperario_fk);

create index dic_tipooperario_updated_by_idx
    on dic_tipooperario (updated_by);

create table energiacoeficiente
(
    id         bigserial
        primary key,
    nombre     varchar(45) not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint energiacoeficiente_created_by_fk
            references usuario,
    updated_by bigint
        constraint energiacoeficiente_updated_by_fk
            references usuario
);

alter table energiacoeficiente
    owner to postgres;

create index energiacoeficiente_created_by_idx
    on energiacoeficiente (created_by);

create index energiacoeficiente_updated_by_idx
    on energiacoeficiente (updated_by);

create table energiacoeficienteintervalo
(
    id             bigserial
        primary key,
    coeficiente_fk bigint                     not null
        constraint energiacoeficienteintervalo_coeficiente_fk
            references energiacoeficiente,
    mesinicio      integer          default 0 not null,
    mesfin         integer          default 0 not null,
    diainicio      integer          default 0 not null,
    diafin         integer          default 0 not null,
    turno_fk       bigint
        constraint energiacoeficienteintervalo_turno_fk
            references turno,
    valor          double precision default 0 not null,
    created        timestamp,
    updated        timestamp,
    created_by     bigint
        constraint energiacoeficienteintervalo_created_by_fk
            references usuario,
    updated_by     bigint
        constraint energiacoeficienteintervalo_updated_by_fk
            references usuario
);

alter table energiacoeficienteintervalo
    owner to postgres;

create index energiacoeficienteintervalo_coeficiente_fk_idx
    on energiacoeficienteintervalo (coeficiente_fk);

create index energiacoeficienteintervalo_created_by_idx
    on energiacoeficienteintervalo (created_by);

create index energiacoeficienteintervalo_turno_fk_idx
    on energiacoeficienteintervalo (turno_fk);

create index energiacoeficienteintervalo_updated_by_idx
    on energiacoeficienteintervalo (updated_by);

create table equipoclase
(
    id                  bigserial
        primary key,
    nombre              varchar(50)  default NULL::character varying,
    descripcion         varchar(200) default NULL::character varying,
    equipoclasepadre_fk bigint
        constraint equipoclase_equipoclasepadre_fk
            references equipoclase,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint equipoclase_created_by_fk
            references usuario,
    updated_by          bigint
        constraint equipoclase_updated_by_fk
            references usuario
);

alter table equipoclase
    owner to postgres;

create table equipo
(
    id             bigserial
        primary key,
    nombre         varchar(50)  default NULL::character varying,
    descripcion    varchar(200) default NULL::character varying,
    equipoclase_fk bigint not null
        constraint equipo_equipoclase_fk
            references equipoclase,
    equipopadre_fk bigint
        constraint equipo_equipopadre_fk
            references equipo,
    created        timestamp,
    updated        timestamp,
    created_by     bigint
        constraint equipo_created_by_fk
            references usuario,
    updated_by     bigint
        constraint equipo_updated_by_fk
            references usuario
);

alter table equipo
    owner to postgres;

create index equipo_created_by_idx
    on equipo (created_by);

create index equipo_equipoclase_fk_idx
    on equipo (equipoclase_fk);

create index equipo_updated_by_idx
    on equipo (updated_by);

create index equipoclase_created_by_idx
    on equipoclase (created_by);

create index equipoclase_updated_by_idx
    on equipoclase (updated_by);

create table estadooperario
(
    id               bigserial
        primary key,
    nombre           varchar(45) default NULL::character varying,
    tiempoproductivo boolean     default false,
    defecto          boolean     default false,
    created          timestamp,
    updated          timestamp,
    created_by       bigint
        constraint estadooperario_created_by_fk
            references usuario,
    updated_by       bigint
        constraint estadooperario_updated_by_fk
            references usuario,
    tipoestado       enum_estadooperario_tipoestado
);

alter table estadooperario
    owner to postgres;

create index estadooperario_created_by_idx
    on estadooperario (created_by);

create index estadooperario_updated_by_idx
    on estadooperario (updated_by);

create index idx_estadooperario_lookup
    on estadooperario (id) include (nombre);

create index idx_estadooperario_tiempoproductivo
    on estadooperario (tiempoproductivo)
    where (tiempoproductivo = true);

create table estadotipo
(
    id         bigserial
        primary key,
    nombre     varchar(255) default NULL::character varying,
    color      varchar(255) default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint estadotipo_created_by_fk
            references usuario,
    updated_by bigint
        constraint estadotipo_updated_by_fk
            references usuario
);

alter table estadotipo
    owner to postgres;

create table estado
(
    id                       bigserial
        primary key,
    esgeneral                boolean                    not null,
    nombre                   varchar(255) default NULL::character varying,
    estadopadre_fk           bigint
        constraint estado_estadopadre_fk
            references estado,
    tipo_fk                  bigint
        constraint estado_tipo_fk
            references estadotipo,
    estadooperario_fk        bigint
        constraint estado_estadooperario_fk
            references estadooperario,
    usarparajustificar       boolean      default false not null,
    estadocambio             boolean      default false not null,
    estadoeventonotificacion boolean      default false not null,
    comunicacionhabilitada   boolean,
    created                  timestamp,
    updated                  timestamp,
    created_by               bigint
        constraint estado_created_by_fk
            references usuario,
    updated_by               bigint
        constraint estado_updated_by_fk
            references usuario,
    activo                   boolean      default true
);

alter table estado
    owner to postgres;

create index estado_created_by_idx
    on estado (created_by);

create index estado_estadooperario_fk_idx
    on estado (estadooperario_fk);

create index estado_estadopadre_fk_idx
    on estado (estadopadre_fk);

create index estado_tipo_fk_idx
    on estado (tipo_fk);

create index estado_updated_by_idx
    on estado (updated_by);

create index estadotipo_created_by_idx
    on estadotipo (created_by);

create index estadotipo_updated_by_idx
    on estadotipo (updated_by);

create table fichero
(
    id          bigserial
        primary key,
    nombre      varchar(255) default NULL::character varying,
    rutafichero varchar(500) default NULL::character varying,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint fichero_created_by_fk
            references usuario,
    updated_by  bigint
        constraint fichero_updated_by_fk
            references usuario
);

alter table fichero
    owner to postgres;

create index fichero_created_by_idx
    on fichero (created_by);

create index fichero_updated_by_idx
    on fichero (updated_by);

create table formacioncurso
(
    id                    bigserial
        primary key,
    nombre                varchar(255) not null,
    descripcion           varchar(500) default ''::character varying,
    duracion              integer      default 0,
    usuarioresponsable_fk bigint
        constraint formacioncurso_usuarioresponsable_fk
            references usuario,
    created               timestamp,
    updated               timestamp,
    created_by            bigint
        constraint formacioncurso_created_by_fk
            references usuario,
    updated_by            bigint
        constraint formacioncurso_updated_by_fk
            references usuario,
    estado                varchar(50)  not null
        constraint check_formacioncurso_estado
            check ((estado)::text = ANY
                   (ARRAY [('abierto'::character varying)::text, ('cerrado'::character varying)::text, ('en_curso'::character varying)::text]))
);

alter table formacioncurso
    owner to postgres;

create index formacioncurso_created_by_idx
    on formacioncurso (created_by);

create index formacioncurso_updated_by_idx
    on formacioncurso (updated_by);

create index formacioncurso_usuarioresponsable_fk_idx
    on formacioncurso (usuarioresponsable_fk);

create table formacioncursocalendarioevento
(
    id                  bigserial
        primary key,
    curso_fk            bigint not null
        constraint formacioncursocalendarioevento_curso_fk
            references formacioncurso,
    calendarioevento_fk bigint not null
        constraint formacioncursocalendarioevento_calendarioevento_fk
            references calendarioevento,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint formacioncursocalendarioevento_created_by_fk
            references usuario,
    updated_by          bigint
        constraint formacioncursocalendarioevento_updated_by_fk
            references usuario
);

alter table formacioncursocalendarioevento
    owner to postgres;

create index formacioncursocalendarioevento_calendarioevento_fk_idx
    on formacioncursocalendarioevento (calendarioevento_fk);

create index formacioncursocalendarioevento_created_by_idx
    on formacioncursocalendarioevento (created_by);

create index formacioncursocalendarioevento_curso_fk_idx
    on formacioncursocalendarioevento (curso_fk);

create index formacioncursocalendarioevento_updated_by_idx
    on formacioncursocalendarioevento (updated_by);

create table formacioncursofichero
(
    id         bigserial
        primary key,
    curso_fk   bigint not null
        constraint formacioncursofichero_curso_fk
            references formacioncurso,
    fichero_fk bigint not null
        constraint formacioncursofichero_fichero_fk
            references fichero,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint formacioncursofichero_created_by_fk
            references usuario,
    updated_by bigint
        constraint formacioncursofichero_updated_by_fk
            references usuario,
    constraint formacioncursofichero_uq
        unique (curso_fk, fichero_fk)
);

alter table formacioncursofichero
    owner to postgres;

create index formacioncursofichero_created_by_idx
    on formacioncursofichero (created_by);

create index formacioncursofichero_fichero_fk_idx
    on formacioncursofichero (fichero_fk);

create index formacioncursofichero_updated_by_idx
    on formacioncursofichero (updated_by);

create table formacionidentificadorgrupo
(
    id         bigserial
        primary key,
    nombre     varchar(255) default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint formacionidentificadorgrupo_created_by_fk
            references usuario,
    updated_by bigint
        constraint formacionidentificadorgrupo_updated_by_fk
            references usuario
);

alter table formacionidentificadorgrupo
    owner to postgres;

create index formacionidentificadorgrupo_created_by_idx
    on formacionidentificadorgrupo (created_by);

create index formacionidentificadorgrupo_updated_by_idx
    on formacionidentificadorgrupo (updated_by);

create table formacionmodulotipo
(
    id         bigserial
        primary key,
    codigo     varchar(40)  not null,
    nombre     varchar(250) not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint formacionmodulotipo_created_by_fk
            references usuario,
    updated_by bigint
        constraint formacionmodulotipo_updated_by_fk
            references usuario
);

alter table formacionmodulotipo
    owner to postgres;

create table formacionmodulo
(
    id                    bigserial
        primary key,
    nombre                varchar(250) not null,
    codigo                varchar(50)
        constraint formacionmodulo_codigo_uq
            unique,
    usuarioresponsable_fk bigint
        constraint formacionmodulo_usuarioresponsable_fk
            references usuario,
    modulotipo_fk         bigint
        constraint formacionmodulo_modulotipo_fk
            references formacionmodulotipo,
    notas                 varchar(255) default NULL::character varying,
    orden                 bigint,
    created               timestamp,
    updated               timestamp,
    created_by            bigint
        constraint formacionmodulo_created_by_fk
            references usuario,
    updated_by            bigint
        constraint formacionmodulo_updated_by_fk
            references usuario
);

alter table formacionmodulo
    owner to postgres;

create index formacionmodulo_created_by_idx
    on formacionmodulo (created_by);

create index formacionmodulo_modulotipo_fk_idx
    on formacionmodulo (modulotipo_fk);

create index formacionmodulo_updated_by_idx
    on formacionmodulo (updated_by);

create index formacionmodulo_usuarioresponsable_fk_idx
    on formacionmodulo (usuarioresponsable_fk);

create index formacionmodulotipo_created_by_idx
    on formacionmodulotipo (created_by);

create index formacionmodulotipo_updated_by_idx
    on formacionmodulotipo (updated_by);

create table formacionpuestotrabajo
(
    id                bigserial
        primary key,
    nombre            varchar(40) default NULL::character varying,
    abreviatura       varchar(10) default NULL::character varying,
    tipooperario_fk   bigint
        constraint formacionpuestotrabajo_tipooperario_fk
            references tipooperario,
    tipoespecial      boolean     default false,
    pordefecto        boolean     default false not null,
    tipoidentificador boolean     default false not null,
    created           timestamp,
    updated           timestamp,
    created_by        bigint
        constraint formacionpuestotrabajo_created_by_fk
            references usuario,
    updated_by        bigint
        constraint formacionpuestotrabajo_updated_by_fk
            references usuario
);

alter table formacionpuestotrabajo
    owner to postgres;

create index formacionpuestotrabajo_created_by_idx
    on formacionpuestotrabajo (created_by);

create index formacionpuestotrabajo_tipooperario_fk_idx
    on formacionpuestotrabajo (tipooperario_fk);

create index formacionpuestotrabajo_updated_by_idx
    on formacionpuestotrabajo (updated_by);

create table formaciontareatipo
(
    id         bigserial
        primary key,
    codigo     varchar(40)  not null,
    nombre     varchar(255) not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint formaciontareatipo_created_by_fk
            references usuario,
    updated_by bigint
        constraint formaciontareatipo_updated_by_fk
            references usuario
);

alter table formaciontareatipo
    owner to postgres;

create index formaciontareatipo_created_by_idx
    on formaciontareatipo (created_by);

create index formaciontareatipo_updated_by_idx
    on formaciontareatipo (updated_by);

create table formador
(
    id         bigserial
        primary key,
    codigo     varchar(40) default NULL::character varying,
    nombre     varchar(255) not null,
    usuario_fk bigint       not null
        constraint formador_usuario_fk
            references usuario,
    activo     boolean     default true,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint formador_created_by_fk
            references usuario,
    updated_by bigint
        constraint formador_updated_by_fk
            references usuario
);

alter table formador
    owner to postgres;

create table formaciontarea
(
    id              bigserial
        primary key,
    formador_fk     bigint
        constraint formaciontarea_formador_fk
            references formador,
    modulo_fk       bigint                     not null
        constraint formaciontarea_modulo_fk
            references formacionmodulo,
    nombre          varchar(255)               not null,
    codigo          integer,
    orden           integer,
    activa          boolean      default true,
    descripcion     varchar(500) default NULL::character varying,
    tipotarea_fk    bigint
        constraint formaciontarea_tipotarea_fk
            references formaciontareatipo,
    opl             boolean      default true,
    obligatoria     boolean      default false not null,
    renovable       boolean      default false,
    duracion        integer                    not null,
    periodovigencia integer      default 0,
    created         timestamp,
    updated         timestamp,
    created_by      bigint
        constraint formaciontarea_created_by_fk
            references usuario,
    updated_by      bigint
        constraint formaciontarea_updated_by_fk
            references usuario
);

alter table formaciontarea
    owner to postgres;

create table formacionactividadplanificacion
(
    id          bigserial
        primary key,
    tarea_fk    bigint not null
        constraint formacionactividadplanificacion_tarea_fk
            references formaciontarea,
    curso_fk    bigint not null
        constraint formacionactividadplanificacion_curso_fk
            references formacioncurso,
    formador_fk bigint not null
        constraint formacionactividadplanificacion_formador_fk
            references formador,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint formacionactividadplanificacion_created_by_fk
            references usuario,
    updated_by  bigint
        constraint formacionactividadplanificacion_updated_by_fk
            references usuario
);

alter table formacionactividadplanificacion
    owner to postgres;

create index formacionactividadplanificacion_created_by_idx
    on formacionactividadplanificacion (created_by);

create index formacionactividadplanificacion_curso_fk_idx
    on formacionactividadplanificacion (curso_fk);

create index formacionactividadplanificacion_formador_fk_idx
    on formacionactividadplanificacion (formador_fk);

create index formacionactividadplanificacion_tarea_fk_idx
    on formacionactividadplanificacion (tarea_fk);

create index formacionactividadplanificacion_updated_by_idx
    on formacionactividadplanificacion (updated_by);

create table formacioncursotarea
(
    id          bigserial
        primary key,
    tarea_fk    bigint                     not null
        constraint formacioncursotarea_tarea_fk
            references formaciontarea,
    formador_fk bigint
        constraint formacioncursotarea_formador_fk
            references formador,
    curso_fk    bigint                     not null
        constraint formacioncursotarea_curso_fk
            references formacioncurso,
    duracion    double precision default 0 not null,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint formacioncursotarea_created_by_fk
            references usuario,
    updated_by  bigint
        constraint formacioncursotarea_updated_by_fk
            references usuario,
    constraint formacioncursotarea_uq
        unique (curso_fk, tarea_fk)
);

alter table formacioncursotarea
    owner to postgres;

create table formacioncursocalendariotarea
(
    id                  bigserial
        primary key,
    cursotarea_fk       bigint
        constraint formacioncursocalendariotarea_cursotarea_fk
            references formacioncursotarea,
    calendarioevento_fk bigint
        constraint formacioncursocalendariotarea_calendarioevento_fk
            references calendarioevento,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint formacioncursocalendariotarea_created_by_fk
            references usuario,
    updated_by          bigint
        constraint formacioncursocalendariotarea_updated_by_fk
            references usuario,
    constraint formacioncursocalendariotarea_uq
        unique (cursotarea_fk, calendarioevento_fk)
);

alter table formacioncursocalendariotarea
    owner to postgres;

create index formacioncursocalendariotarea_calendarioevento_fk_idx
    on formacioncursocalendariotarea (calendarioevento_fk);

create index formacioncursocalendariotarea_created_by_idx
    on formacioncursocalendariotarea (created_by);

create index formacioncursocalendariotarea_cursotarea_fk_idx
    on formacioncursocalendariotarea (cursotarea_fk);

create index formacioncursocalendariotarea_updated_by_idx
    on formacioncursocalendariotarea (updated_by);

create index formacioncursotarea_created_by_idx
    on formacioncursotarea (created_by);

create index formacioncursotarea_curso_fk_idx
    on formacioncursotarea (curso_fk);

create index formacioncursotarea_formador_fk_idx
    on formacioncursotarea (formador_fk);

create index formacioncursotarea_tarea_fk_idx
    on formacioncursotarea (tarea_fk);

create index formacioncursotarea_updated_by_idx
    on formacioncursotarea (updated_by);

create table formacionpuestotrabajotarea
(
    id               bigserial
        primary key,
    puestotrabajo_fk bigint not null
        constraint formacionpuestotrabajotarea_puestotrabajo_fk
            references formacionpuestotrabajo,
    tarea_fk         bigint not null
        constraint formacionpuestotrabajotarea_tarea_fk
            references formaciontarea,
    created          timestamp,
    updated          timestamp,
    created_by       bigint
        constraint formacionpuestotrabajotarea_created_by_fk
            references usuario,
    updated_by       bigint
        constraint formacionpuestotrabajotarea_updated_by_fk
            references usuario,
    constraint formacionpuestotrabajotarea_uq
        unique (puestotrabajo_fk, tarea_fk)
);

alter table formacionpuestotrabajotarea
    owner to postgres;

create index formacionpuestotrabajotarea_created_by_idx
    on formacionpuestotrabajotarea (created_by);

create index formacionpuestotrabajotarea_puestotrabajo_fk_idx
    on formacionpuestotrabajotarea (puestotrabajo_fk);

create index formacionpuestotrabajotarea_tarea_fk_idx
    on formacionpuestotrabajotarea (tarea_fk);

create index formacionpuestotrabajotarea_updated_by_idx
    on formacionpuestotrabajotarea (updated_by);

create index formaciontarea_created_by_idx
    on formaciontarea (created_by);

create index formaciontarea_formador_fk_idx
    on formaciontarea (formador_fk);

create index formaciontarea_modulo_fk_idx
    on formaciontarea (modulo_fk);

create index formaciontarea_tipotarea_fk_idx
    on formaciontarea (tipotarea_fk);

create index formaciontarea_updated_by_idx
    on formaciontarea (updated_by);

create table formaciontareafichero
(
    id         bigserial
        primary key,
    fichero_fk bigint
        constraint formaciontareafichero_fichero_fk
            references fichero,
    tarea_fk   bigint not null
        constraint formaciontareafichero_tarea_fk
            references formaciontarea,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint formaciontareafichero_created_by_fk
            references usuario,
    updated_by bigint
        constraint formaciontareafichero_updated_by_fk
            references usuario
);

alter table formaciontareafichero
    owner to postgres;

create index formaciontareafichero_created_by_idx
    on formaciontareafichero (created_by);

create index formaciontareafichero_fichero_fk_idx
    on formaciontareafichero (fichero_fk);

create index formaciontareafichero_tarea_fk_idx
    on formaciontareafichero (tarea_fk);

create index formaciontareafichero_updated_by_idx
    on formaciontareafichero (updated_by);

create index formador_created_by_idx
    on formador (created_by);

create index formador_updated_by_idx
    on formador (updated_by);

create index formador_usuario_fk_idx
    on formador (usuario_fk);

create table grupocomunicacion
(
    id          bigserial
        primary key,
    nombre      varchar(45)  default NULL::character varying,
    descripcion varchar(255) default NULL::character varying,
    tipo_fk     bigint
        constraint grupocomunicacion_tipo_fk
            references grupocomunicaciontipo,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint grupocomunicacion_created_by_fk
            references usuario,
    updated_by  bigint
        constraint grupocomunicacion_updated_by_fk
            references usuario,
    estado      varchar(50)  default 'abierto'::enum_grupocomunicacion_estado not null
);

alter table grupocomunicacion
    owner to postgres;

create index grupocomunicacion_created_by_idx
    on grupocomunicacion (created_by);

create index grupocomunicacion_estado_idx
    on grupocomunicacion (estado);

create index grupocomunicacion_tipo_fk_idx
    on grupocomunicacion (tipo_fk);

create index grupocomunicacion_updated_by_idx
    on grupocomunicacion (updated_by);

create table operario
(
    id                    bigserial
        primary key,
    nombre                varchar(255) default NULL::character varying,
    codigo                varchar(45)  default NULL::character varying
        constraint uq_operario
            unique,
    codigopresencia       varchar(45)  default NULL::character varying,
    created               timestamp,
    updated               timestamp,
    created_by            bigint,
    updated_by            bigint,
    tipooperario_fk       bigint
        constraint operario_tipooperario_fk
            references tipooperario,
    estadooperario_fk     bigint,
    nombrecorto           varchar(10)  default NULL::character varying,
    usuario_fk            bigint
        constraint operario_usuario_fk
            references usuario,
    clase_fk              bigint
        constraint operario_clase_fk
            references operarioclase,
    activo                boolean      default true not null,
    puestotrabajo_fk      bigint
        constraint operario_puestotrabajo_fk
            references formacionpuestotrabajo,
    cuadrante             enum_operario_cuadrante,
    limitacion            boolean,
    limitaciondescripcion varchar(200) default NULL::character varying,
    nsecuencia            integer
);

alter table operario
    owner to postgres;

create table calendarioeventooperario
(
    id                  bigserial
        primary key,
    calendarioevento_fk bigint not null
        constraint calendarioeventooperario_calendarioevento_fk
            references calendarioevento,
    operario_fk         bigint not null
        constraint calendarioeventooperario_operario_fk
            references operario,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint calendarioeventooperario_created_by_fk
            references usuario,
    updated_by          bigint
        constraint calendarioeventooperario_updated_by_fk
            references usuario,
    constraint calendarioeventooperario_uq
        unique (calendarioevento_fk, operario_fk)
);

alter table calendarioeventooperario
    owner to postgres;

create index calendarioeventooperario_calendarioevento_fk_idx
    on calendarioeventooperario (calendarioevento_fk);

create index calendarioeventooperario_created_by_idx
    on calendarioeventooperario (created_by);

create index calendarioeventooperario_operario_fk_idx
    on calendarioeventooperario (operario_fk);

create index calendarioeventooperario_updated_by_idx
    on calendarioeventooperario (updated_by);

create table formacioncompetenciaoperario
(
    id           bigserial
        primary key,
    tarea_fk     bigint                not null
        constraint formacioncompetenciaoperario_tarea_fk
            references formaciontarea,
    operario_fk  bigint                not null
        constraint formacioncompetenciaoperario_operario_fk
            references operario,
    fechainicio  timestamp,
    fechavalidez timestamp,
    noaplicable  boolean default false not null,
    created      timestamp,
    updated      timestamp,
    created_by   bigint
        constraint formacioncompetenciaoperario_created_by_fk
            references usuario,
    updated_by   bigint
        constraint formacioncompetenciaoperario_updated_by_fk
            references usuario,
    constraint formacioncompetenciaoperario_uq
        unique (tarea_fk, operario_fk, fechainicio)
);

alter table formacioncompetenciaoperario
    owner to postgres;

create index formacioncompetenciaoperario_created_by_idx
    on formacioncompetenciaoperario (created_by);

create index formacioncompetenciaoperario_operario_fk_idx
    on formacioncompetenciaoperario (operario_fk);

create index formacioncompetenciaoperario_tarea_fk_idx
    on formacioncompetenciaoperario (tarea_fk);

create index formacioncompetenciaoperario_updated_by_idx
    on formacioncompetenciaoperario (updated_by);

create table formacioncursooperario
(
    id          bigserial
        primary key,
    curso_fk    bigint not null
        constraint formacioncursooperario_curso_fk
            references formacioncurso,
    operario_fk bigint not null
        constraint formacioncursooperario_operario_fk
            references operario,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint formacioncursooperario_created_by_fk
            references usuario,
    updated_by  bigint
        constraint formacioncursooperario_updated_by_fk
            references usuario,
    constraint formacioncursooperario_uq
        unique (curso_fk, operario_fk)
);

alter table formacioncursooperario
    owner to postgres;

create table formacioncursocalendariooperario
(
    id                  bigserial
        primary key,
    cursooperario_fk    bigint
        constraint formacioncursocalendariooperario_cursooperario_fk
            references formacioncursooperario,
    calendarioevento_fk bigint
        constraint formacioncursocalendariooperario_calendarioevento_fk
            references calendarioevento,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint formacioncursocalendariooperario_created_by_fk
            references usuario,
    updated_by          bigint
        constraint formacioncursocalendariooperario_updated_by_fk
            references usuario
);

alter table formacioncursocalendariooperario
    owner to postgres;

create index formacioncursocalendariooperario_calendarioevento_fk_idx
    on formacioncursocalendariooperario (calendarioevento_fk);

create index formacioncursocalendariooperario_created_by_idx
    on formacioncursocalendariooperario (created_by);

create index formacioncursocalendariooperario_cursooperario_fk_idx
    on formacioncursocalendariooperario (cursooperario_fk);

create index formacioncursocalendariooperario_updated_by_idx
    on formacioncursocalendariooperario (updated_by);

create index formacioncursooperario_created_by_idx
    on formacioncursooperario (created_by);

create index formacioncursooperario_curso_fk_idx
    on formacioncursooperario (curso_fk);

create index formacioncursooperario_operario_fk_idx
    on formacioncursooperario (operario_fk);

create index formacioncursooperario_updated_by_idx
    on formacioncursooperario (updated_by);

create table formacionidentificadorgrupocompetencia
(
    id                    bigserial
        primary key,
    identificadorgrupo_fk bigint
        constraint formacionidentificadorgrupocompetencia_identificadorgrupo_fk
            references formacionidentificadorgrupo
            on delete cascade,
    puestotrabajo_fk      bigint
        constraint formacionidentificadorgrupocompetencia_puestotrabajo_fk
            references formacionpuestotrabajo
            on delete cascade,
    tarea_fk              bigint
        constraint formacionidentificadorgrupocompetencia_tarea_fk
            references formaciontarea
            on delete cascade,
    operario_fk           bigint
        constraint formacionidentificadorgrupocompetencia_operario_fk
            references operario
            on delete cascade,
    created               timestamp,
    updated               timestamp,
    created_by            bigint
        constraint formacionidentificadorgrupocompetencia_created_by_fk
            references usuario,
    updated_by            bigint
        constraint formacionidentificadorgrupocompetencia_updated_by_fk
            references usuario,
    constraint formacionidentificadorgrupocompetencia_uq
        unique (identificadorgrupo_fk, puestotrabajo_fk, tarea_fk, operario_fk)
);

alter table formacionidentificadorgrupocompetencia
    owner to postgres;

create index formacionidentificadorgrupocompetencia_created_by_idx
    on formacionidentificadorgrupocompetencia (created_by);

create index formacionidentificadorgrupocompetencia_operario_fk_idx
    on formacionidentificadorgrupocompetencia (operario_fk);

create index formacionidentificadorgrupocompetencia_puestotrabajo_fk_idx
    on formacionidentificadorgrupocompetencia (puestotrabajo_fk);

create index formacionidentificadorgrupocompetencia_tarea_fk_idx
    on formacionidentificadorgrupocompetencia (tarea_fk);

create index formacionidentificadorgrupocompetencia_updated_by_idx
    on formacionidentificadorgrupocompetencia (updated_by);

create index formacionidgrupocompetencia_identificadorgrupo_fk_idx
    on formacionidentificadorgrupocompetencia (identificadorgrupo_fk);

create table formacionpuestotrabajooperario
(
    id               bigserial
        primary key,
    puestotrabajo_fk bigint not null
        constraint formacionpuestotrabajooperario_puestotrabajo_fk
            references formacionpuestotrabajo,
    operario_fk      bigint not null
        constraint formacionpuestotrabajooperario_operario_fk
            references operario,
    nsecuencia       integer,
    created          timestamp,
    updated          timestamp,
    created_by       bigint
        constraint formacionpuestotrabajooperario_created_by_fk
            references usuario,
    updated_by       bigint
        constraint formacionpuestotrabajooperario_updated_by_fk
            references usuario,
    constraint formacionpuestotrabajooperario_uq
        unique (puestotrabajo_fk, operario_fk)
);

alter table formacionpuestotrabajooperario
    owner to postgres;

create index formacionpuestotrabajooperario_created_by_idx
    on formacionpuestotrabajooperario (created_by);

create index formacionpuestotrabajooperario_operario_fk_idx
    on formacionpuestotrabajooperario (operario_fk);

create index formacionpuestotrabajooperario_puestotrabajo_fk_idx
    on formacionpuestotrabajooperario (puestotrabajo_fk);

create index formacionpuestotrabajooperario_updated_by_idx
    on formacionpuestotrabajooperario (updated_by);

create index idx_operario_codigo
    on operario (codigo);

create index idx_operario_lookup
    on operario (id) include (nombre, codigo);

create index idx_operario_nombre
    on operario (nombre);

create table operariooperariotipoorden
(
    id              bigserial
        primary key,
    operario_fk     bigint
        constraint operariooperariotipoorden_operario_fk
            references operario,
    operariotipo_fk bigint
        constraint operariooperariotipoorden_operariotipo_fk
            references tipooperario,
    orden           bigint default 0,
    created         timestamp,
    updated         timestamp,
    created_by      bigint,
    updated_by      bigint
);

alter table operariooperariotipoorden
    owner to postgres;

create table perfilusuarioaplicacion
(
    id                bigserial
        primary key,
    perfil_fk         bigint not null
        constraint perfilusuarioaplicacion_perfil_fk
            references perfilusuario,
    aplicacion_fk     bigint not null
        constraint perfilusuarioaplicacion_aplicacion_fk
            references aplicacion,
    pantallaprincipal varchar(100) default NULL::character varying,
    created           timestamp,
    updated           timestamp,
    created_by        bigint,
    updated_by        bigint
);

alter table perfilusuarioaplicacion
    owner to postgres;

create table perfilusuarioelemento
(
    id               bigserial
        primary key,
    perfil_fk        bigint                 not null
        constraint perfilusuarioelemento_perfil_fk
            references perfilusuario,
    tipo             integer      default 0 not null,
    etiqueta         varchar(45)            not null,
    modulo_fk        bigint
        constraint perfilusuarioelemento_modulo_fk
            references modulo,
    url              varchar(255) default NULL::character varying,
    orden            integer      default 0 not null,
    elementopadre_fk bigint
        constraint perfilusuarioelemento_elementopadre_fk
            references perfilusuarioelemento,
    icono            varchar(45)  default NULL::character varying,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint,
    aplicacion_fk    bigint
        constraint perfilusuarioelemento_aplicacion_fk
            references aplicacion,
    contexto         varchar(45)  default NULL::character varying
);

alter table perfilusuarioelemento
    owner to postgres;

create table presenciareglafichaje
(
    id                 bigserial
        primary key,
    estadooperario_fk  bigint            not null
        constraint presenciareglafichaje_estadooperario_fk
            references estadooperario,
    hora               time              not null,
    offsetpreviomin    integer default 0 not null,
    offsetposteriormin integer default 0 not null,
    created            timestamp,
    updated            timestamp,
    created_by         bigint,
    updated_by         bigint
);

alter table presenciareglafichaje
    owner to postgres;

create table presenciareglaproduccion
(
    id                 bigserial
        primary key,
    estadooperario_fk  bigint            not null
        constraint presenciareglaproduccion_estadooperario_fk
            references estadooperario,
    hora               time              not null,
    offsetpreviomin    integer default 0 not null,
    offsetposteriormin integer default 0 not null,
    asignaranterior    boolean,
    asignarposterior   boolean,
    created            timestamp,
    updated            timestamp,
    created_by         bigint,
    updated_by         bigint
);

alter table presenciareglaproduccion
    owner to postgres;

create table productividadmedida
(
    id              bigserial
        primary key,
    operario_fk     bigint           not null
        constraint productividadmedida_operario_fk
            references operario,
    turno_fk        bigint           not null
        constraint productividadmedida_turno_fk
            references turno,
    fechajornada    timestamp        not null,
    estado_fk       bigint           not null
        constraint productividadmedida_estado_fk
            references estadooperario,
    fechainicio     timestamp        not null,
    fechafin        timestamp,
    fechainicioreal timestamp,
    fechafinreal    timestamp,
    duracion        double precision not null,
    cerrada         boolean default false,
    created         timestamp,
    updated         timestamp,
    created_by      bigint,
    updated_by      bigint
);

alter table productividadmedida
    owner to postgres;

create index idx_productividadmedida_covering
    on productividadmedida (id, operario_fk, estado_fk) include (fechainicio, fechafin);

create index idx_productividadmedida_estado
    on productividadmedida (estado_fk);

create index idx_productividadmedida_fechas
    on productividadmedida (fechainicio, fechafin);

create index idx_productividadmedida_operario
    on productividadmedida (operario_fk);

create index idx_productividadmedida_optimal
    on productividadmedida (fechainicio, fechafin) include (id, operario_fk, estado_fk);

create table productividadmedidahist
(
    id               bigserial
        primary key,
    operario_fk      bigint           not null
        constraint productividadmedidahist_operario_fk
            references operario,
    turno_fk         bigint           not null
        constraint productividadmedidahist_turno_fk
            references turno,
    fechajornada     timestamp        not null,
    estado_fk        bigint           not null
        constraint productividadmedidahist_estado_fk
            references estadooperario,
    tiempoproductivo boolean,
    fechainicio      timestamp        not null,
    fechafin         timestamp,
    fechainicioreal  timestamp,
    fechafinreal     timestamp,
    duracion         double precision not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table productividadmedidahist
    owner to postgres;

create index idx_prodmedidahist_composite
    on productividadmedidahist (operario_fk, estado_fk, fechainicio, fechafin);

create index idx_prodmedidahist_fechas
    on productividadmedidahist (fechainicio, fechafin);

create index idx_productividadmedidahist_covering
    on productividadmedidahist (id, operario_fk, estado_fk) include (fechainicio, fechafin);

create table productividadmedidainconsistentehist
(
    id               bigserial
        primary key,
    operario_fk      bigint           not null
        constraint productividadmedidainconsistentehist_operario_fk
            references operario,
    turno_fk         bigint           not null
        constraint productividadmedidainconsistentehist_turno_fk
            references turno,
    fechajornada     timestamp        not null,
    estado_fk        bigint           not null
        constraint productividadmedidainconsistentehist_estado_fk
            references estadooperario,
    tiempoproductivo boolean,
    fechainicio      timestamp        not null,
    fechafin         timestamp,
    fechainicioreal  timestamp,
    fechafinreal     timestamp,
    duracion         double precision not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table productividadmedidainconsistentehist
    owner to postgres;

create table productividadplanificacion
(
    id                         bigserial
        primary key,
    estado_fk                  bigint
        constraint productividadplanficacion_prodplanestado_fk
            references productividadplanificacionestado,
    planificacionreferencia_fk bigint
        constraint productividadplanificacion_planificacionreferencia_fk
            references productividadplanificacion,
    descripcion                varchar(45),
    turnodoblado               boolean,
    fechainicio                timestamp not null,
    fechafin                   timestamp,
    fechaactivacion            timestamp,
    created                    timestamp,
    updated                    timestamp,
    created_by                 bigint
        constraint productividadplanificacion_created_by
            references usuario,
    updated_by                 bigint
        constraint productividadplanificacion_updated_by
            references usuario
);

alter table productividadplanificacion
    owner to postgres;

create index productividadplanficacion_prodplanestado_fk_idx
    on productividadplanificacion (estado_fk);

create index productividadplanificacion_planificacionreferencia_fk_idx
    on productividadplanificacion (planificacionreferencia_fk);

create table productividadplanificacionoperariodeshabilitado
(
    id                            bigserial
        primary key,
    productividadplanificacion_fk bigint
        constraint prodplan_operariodeshabilitado_prodplan_fk
            references productividadplanificacion,
    operario_fk                   bigint
        constraint productividadplanificacionoperariodeshabilitado_operario_fk
            references operario,
    tipo                          varchar(45)  default NULL::character varying,
    descripcion                   varchar(200) default NULL::character varying,
    created                       timestamp,
    updated                       timestamp,
    created_by                    bigint,
    updated_by                    bigint
);

alter table productividadplanificacionoperariodeshabilitado
    owner to postgres;

create table productividadplanificacionproductividadplanificacionrestriccion
(
    id                                       bigint default nextval('productividadplanificacionproductividadplanificacionrest_id_seq'::regclass) not null
        constraint pppprestriccion_pkey
            primary key,
    productividadplanificacion_fk            bigint
        constraint prodplan_prodplanrestriccion_prodplan_fk
            references productividadplanificacion,
    productividadplanificacionrestriccion_fk bigint
        constraint prodplan_prodplanrestriccion_prodplanrestriccion_fk
            references productividadplanificacionrestriccion,
    created                                  timestamp,
    updated                                  timestamp,
    created_by                               bigint,
    updated_by                               bigint
);

alter table productividadplanificacionproductividadplanificacionrestriccion
    owner to postgres;

alter sequence productividadplanificacionproductividadplanificacionrest_id_seq owned by productividadplanificacionproductividadplanificacionrestriccion.id;

create table productividadplanificacionrotacionturno
(
    id                            bigserial
        primary key,
    productividadplanificacion_fk bigint
        constraint prodplan_rotacionturno_prodplan_fk
            references productividadplanificacion,
    turnoorigen_fk                bigint
        constraint productividadplanificacionrotacionturno_turnoorigen_fk
            references turno,
    turnorotado_fk                bigint
        constraint productividadplanificacionrotacionturno_turnorotado_fk
            references turno,
    created                       timestamp,
    updated                       timestamp,
    created_by                    bigint,
    updated_by                    bigint
);

alter table productividadplanificacionrotacionturno
    owner to postgres;

create table productotipoatributo
(
    productotipo_fk bigint not null
        constraint productotipoatributo_productotipo_fk
            references productotipo,
    atributo_fk     bigint not null
        constraint productotipoatributo_atributo_fk
            references atributo,
    created         date,
    updated         date,
    created_by      bigint,
    updated_by      bigint,
    primary key (productotipo_fk, atributo_fk)
);

alter table productotipoatributo
    owner to postgres;

create table puntoestandarizacion
(
    id                           bigserial
        primary key,
    codigo                       varchar(200) default NULL::character varying,
    nombre                       varchar(200) default NULL::character varying,
    descripcion                  varchar(200) default NULL::character varying,
    orden                        integer      default 0,
    puntoestandarizacionpadre_fk bigint
        constraint puntoestandarizacion_puntoestandarizacionpadre_fk
            references puntoestandarizacion,
    tipo                         varchar(50)  default NULL::character varying,
    atributo_fk                  bigint
        constraint puntoestandarizacion_atributo_fk
            references atributo,
    rutaadjunto                  varchar(100) default NULL::character varying,
    created                      timestamp,
    updated                      timestamp,
    created_by                   bigint,
    updated_by                   bigint
);

alter table puntoestandarizacion
    owner to postgres;

create table seccion
(
    id         bigserial
        primary key,
    nombre     varchar(255) default NULL::character varying,
    area_fk    bigint
        constraint seccion_area_fk
            references area,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table seccion
    owner to postgres;

create index idx_seccion_area
    on seccion (area_fk) include (nombre);

create table tiponotificacionusuario
(
    id         bigserial
        primary key,
    usuario_fk bigint not null
        constraint tiponotificacionusuario_usuario_fk
            references usuario,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table tiponotificacionusuario
    owner to postgres;

create table tipooperariooperario
(
    id              bigserial
        primary key,
    tipooperario_fk bigint not null
        constraint tipooperariooperario_tipooperario_fk
            references tipooperario,
    operario_fk     bigint not null
        constraint tipooperariooperario_operario_fk
            references operario,
    nsecuencia      integer,
    created         timestamp,
    updated         timestamp,
    created_by      bigint,
    updated_by      bigint
);

alter table tipooperariooperario
    owner to postgres;

create table unidad_familia
(
    id         bigserial
        primary key,
    nombre     varchar(45) not null,
    parent_id  bigint
        constraint unidad_familia_parent
            references unidad_familia,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint unidad_familia_created_by
            references usuario,
    updated_by bigint
        constraint unidad_familia_updated_by
            references usuario
);

alter table unidad_familia
    owner to postgres;

create table unidad
(
    id         bigserial
        primary key,
    tipo       varchar(45),
    nombre     varchar(45)                   not null
        constraint uq_unidad
            unique,
    simbolo    varchar(25)     default NULL::character varying,
    conteo     boolean         default false,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint,
    familia_id bigint
        constraint unidad_familia_fk
            references unidad_familia,
    factor     numeric(20, 10) default 1.0   not null,
    constante  numeric(20, 10) default 0.0   not null,
    es_base    boolean         default false not null
);

alter table unidad
    owner to postgres;

create table centroclasepropiedad
(
    id                           bigserial
        primary key,
    centroclase_fk               bigint       not null
        constraint centroclasepropiedad_centroclase_fk
            references centroclase,
    nombre                       varchar(100) not null,
    descripcion                  varchar(300) default NULL::character varying,
    valor                        varchar(255) default NULL::character varying,
    tipo_valor                   varchar(20)  not null,
    unidad_fk                    bigint
        constraint centroclasepropiedad_unidad_fk
            references unidad,
    created                      timestamp,
    updated                      timestamp,
    created_by                   bigint
        constraint centroclasepropiedad_created_by_fk
            references usuario,
    updated_by                   bigint
        constraint centroclasepropiedad_updated_by_fk
            references usuario,
    aplica_cuando_propiedad_fk   bigint
        constraint centroclasepropiedad_aplica_cuando_propiedad_fk
            references centroclasepropiedad
            on delete set null,
    aplica_cuando_valor          varchar(100) default NULL::character varying,
    centroclasepropiedadpadre_fk bigint
        constraint centroclasepropiedad_centroclasepropiedadpadre_fk
            references centroclasepropiedad
            on delete set null
);

alter table centroclasepropiedad
    owner to postgres;

create index centroclasepropiedad_aplica_cuando_propiedad_fk_idx
    on centroclasepropiedad (aplica_cuando_propiedad_fk);

create index centroclasepropiedad_centroclase_fk_idx
    on centroclasepropiedad (centroclase_fk);

create index centroclasepropiedad_centroclasepropiedadpadre_fk_idx
    on centroclasepropiedad (centroclasepropiedadpadre_fk);

create index centroclasepropiedad_created_by_idx
    on centroclasepropiedad (created_by);

create index centroclasepropiedad_unidad_fk_idx
    on centroclasepropiedad (unidad_fk);

create index centroclasepropiedad_updated_by_idx
    on centroclasepropiedad (updated_by);

create table energiacontadortipo
(
    id                           bigserial
        primary key,
    nombre                       varchar(45)                not null,
    periodomuestreo              integer          default 0 not null,
    velocidadminima              double precision default 0 not null,
    velocidadmaxima              double precision default 0 not null,
    unidad_fk                    bigint                     not null
        constraint energiacontadortipo_unidad_fk
            references unidad,
    unidadtiempotipo             integer          default 0 not null,
    unidadvelocidad_fk           bigint                     not null
        constraint energiacontadortipo_unidadvelocidad_fk
            references unidad,
    coeficientevelocidad         double precision default 0 not null,
    etiquetavelocidad            varchar(45)                not null,
    duraciontiemporealjornadas   integer          default 0 not null,
    duracionmaximahistoricohoras integer          default 0 not null,
    created                      timestamp,
    updated                      timestamp,
    created_by                   bigint
        constraint energiacontadortipo_created_by_fk
            references usuario,
    updated_by                   bigint
        constraint energiacontadortipo_updated_by_fk
            references usuario
);

alter table energiacontadortipo
    owner to postgres;

create table energiacontadorgrupo
(
    id            bigserial
        primary key,
    nombre        varchar(45) default NULL::character varying,
    tipo_fk       bigint                    not null
        constraint energiacontadorgrupo_tipo_fk
            references energiacontadortipo,
    grupopadre_fk bigint
        constraint energiacontadorgrupo_grupopadre_fk
            references energiacontadorgrupo,
    reparto       boolean     default false not null,
    valorreparto  integer     default 0     not null,
    orden         integer     default 0     not null,
    created       timestamp,
    updated       timestamp,
    created_by    bigint
        constraint energiacontadorgrupo_created_by_fk
            references usuario,
    updated_by    bigint
        constraint energiacontadorgrupo_updated_by_fk
            references usuario
);

alter table energiacontadorgrupo
    owner to postgres;

create index energiacontadorgrupo_created_by_idx
    on energiacontadorgrupo (created_by);

create index energiacontadorgrupo_grupopadre_fk_idx
    on energiacontadorgrupo (grupopadre_fk);

create index energiacontadorgrupo_tipo_fk_idx
    on energiacontadorgrupo (tipo_fk);

create index energiacontadorgrupo_updated_by_idx
    on energiacontadorgrupo (updated_by);

create index energiacontadortipo_created_by_idx
    on energiacontadortipo (created_by);

create index energiacontadortipo_unidad_fk_idx
    on energiacontadortipo (unidad_fk);

create index energiacontadortipo_unidadvelocidad_fk_idx
    on energiacontadortipo (unidadvelocidad_fk);

create index energiacontadortipo_updated_by_idx
    on energiacontadortipo (updated_by);

create table energiacontadortipoatributo
(
    id         bigserial
        primary key,
    tipo_fk    bigint not null
        constraint energiacontadortipoatributo_tipo_fk
            references energiacontadortipo,
    nombre     varchar(45) default NULL::character varying,
    unidad_fk  bigint not null
        constraint energiacontadortipoatributo_unidad_fk
            references unidad,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint energiacontadortipoatributo_created_by_fk
            references usuario,
    updated_by bigint
        constraint energiacontadortipoatributo_updated_by_fk
            references usuario
);

alter table energiacontadortipoatributo
    owner to postgres;

create index energiacontadortipoatributo_created_by_idx
    on energiacontadortipoatributo (created_by);

create index energiacontadortipoatributo_tipo_fk_idx
    on energiacontadortipoatributo (tipo_fk);

create index energiacontadortipoatributo_unidad_fk_idx
    on energiacontadortipoatributo (unidad_fk);

create index energiacontadortipoatributo_updated_by_idx
    on energiacontadortipoatributo (updated_by);

create table energiaexpresionconsumo
(
    id         bigserial
        primary key,
    tipo_fk    bigint       not null
        constraint energiaexpresionconsumo_tipo_fk
            references energiacontadortipo,
    nombre     varchar(45)  not null,
    expresion  varchar(200) not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint energiaexpresionconsumo_created_by_fk
            references usuario,
    updated_by bigint
        constraint energiaexpresionconsumo_updated_by_fk
            references usuario
);

alter table energiaexpresionconsumo
    owner to postgres;

create table energiaactividad
(
    id                     bigserial
        primary key,
    nombre                 varchar(45) default NULL::character varying,
    tipo                   integer     default 0     not null,
    actividadpadre_fk      bigint
        constraint energiaactividad_actividadpadre_fk
            references energiaactividad,
    expresionorigen_fk     bigint                    not null
        constraint energiaactividad_expresionorigen_fk
            references energiaexpresionconsumo,
    expresiondestino_fk    bigint
        constraint energiaactividad_expresiondestino_fk
            references energiaexpresionconsumo,
    unidadproduccion_fk    bigint
        constraint energiaactividad_unidadproduccion_fk
            references unidad,
    repartodetallado       boolean     default false not null,
    orden                  integer     default 0     not null,
    objetivocentroproducto boolean     default false not null,
    created                timestamp,
    updated                timestamp,
    created_by             bigint
        constraint energiaactividad_created_by_fk
            references usuario,
    updated_by             bigint
        constraint energiaactividad_updated_by_fk
            references usuario
);

alter table energiaactividad
    owner to postgres;

create index energiaactividad_actividadpadre_fk_idx
    on energiaactividad (actividadpadre_fk);

create index energiaactividad_created_by_idx
    on energiaactividad (created_by);

create index energiaactividad_expresiondestino_fk_idx
    on energiaactividad (expresiondestino_fk);

create index energiaactividad_expresionorigen_fk_idx
    on energiaactividad (expresionorigen_fk);

create index energiaactividad_tipo_idx
    on energiaactividad (tipo);

create index energiaactividad_unidadproduccion_fk_idx
    on energiaactividad (unidadproduccion_fk);

create index energiaactividad_updated_by_idx
    on energiaactividad (updated_by);

create table energiaactividadmedida
(
    id                    bigserial
        primary key,
    actividad_fk          bigint                     not null
        constraint energiaactividadmedida_actividad_fk
            references energiaactividad,
    fechainicio           timestamp                  not null,
    fechafin              timestamp                  not null,
    turno_fk              bigint                     not null
        constraint energiaactividadmedida_turno_fk
            references turno,
    fechajornada          timestamp                  not null,
    valorexpresionorigen  double precision default 0 not null,
    valorexpresiondestino double precision default 0 not null,
    unidadproduccion_fk   bigint
        constraint energiaactividadmedida_unidadproduccion_fk
            references unidad,
    valorobjetivo         double precision default 0 not null,
    created               timestamp,
    updated               timestamp,
    created_by            bigint
        constraint energiaactividadmedida_created_by_fk
            references usuario,
    updated_by            bigint
        constraint energiaactividadmedida_updated_by_fk
            references usuario
);

alter table energiaactividadmedida
    owner to postgres;

create index energiaactividadmedida_actividad_fk_idx
    on energiaactividadmedida (actividad_fk);

create index energiaactividadmedida_created_by_idx
    on energiaactividadmedida (created_by);

create index energiaactividadmedida_fechafin_idx
    on energiaactividadmedida (fechafin);

create index energiaactividadmedida_fechainicio_idx
    on energiaactividadmedida (fechainicio);

create index energiaactividadmedida_turno_fk_idx
    on energiaactividadmedida (turno_fk);

create index energiaactividadmedida_unidadproduccion_fk_idx
    on energiaactividadmedida (unidadproduccion_fk);

create index energiaactividadmedida_updated_by_idx
    on energiaactividadmedida (updated_by);

create table energiaactividadobjetivo
(
    id                              bigserial
        primary key,
    actividad_fk                    bigint                      not null
        constraint energiaactividadobjetivo_actividad_fk
            references energiaactividad,
    mesinicio                       integer          default 1  not null,
    mesfin                          integer          default 12 not null,
    diainicio                       integer          default 1  not null,
    diafin                          integer          default 7  not null,
    turno_fk                        bigint
        constraint energiaactividadobjetivo_turno_fk
            references turno,
    objetivoactividadproductiva     double precision default 0  not null,
    objetivoactividadnoproductiva   double precision default 0  not null,
    objetivoactividadtransformacion double precision default 0  not null,
    created                         timestamp,
    updated                         timestamp,
    created_by                      bigint
        constraint energiaactividadobjetivo_created_by_fk
            references usuario,
    updated_by                      bigint
        constraint energiaactividadobjetivo_updated_by_fk
            references usuario
);

alter table energiaactividadobjetivo
    owner to postgres;

create index energiaactividadobjetivo_actividad_fk_idx
    on energiaactividadobjetivo (actividad_fk);

create index energiaactividadobjetivo_created_by_idx
    on energiaactividadobjetivo (created_by);

create index energiaactividadobjetivo_turno_fk_idx
    on energiaactividadobjetivo (turno_fk);

create index energiaactividadobjetivo_updated_by_idx
    on energiaactividadobjetivo (updated_by);

create index energiaexpresionconsumo_created_by_idx
    on energiaexpresionconsumo (created_by);

create index energiaexpresionconsumo_tipo_fk_idx
    on energiaexpresionconsumo (tipo_fk);

create index energiaexpresionconsumo_updated_by_idx
    on energiaexpresionconsumo (updated_by);

create table producto
(
    id                  bigserial
        primary key,
    codigo              varchar(255) default NULL::character varying
        constraint uq_producto
            unique,
    codigolargo         varchar(255) default NULL::character varying,
    nombre              varchar(255) default NULL::character varying,
    proveedor           varchar(255) default NULL::character varying,
    ean13               varchar(13)  default NULL::character varying,
    familia_fk          bigint
        constraint producto_familia_fk
            references productofamilia,
    tipo_fk             bigint
        constraint producto_tipo_fk
            references productotipo,
    fechacreacion       timestamp,
    thumbnail           varchar(255) default NULL::character varying,
    created             timestamp,
    updated             timestamp,
    created_by          bigint,
    updated_by          bigint,
    parent_fk           bigint
        constraint producto_parent_fk
            references producto,
    unidadprincipal_fk  bigint
        constraint producto_unidadprincipal_fk
            references unidad,
    unidadsecundaria_fk bigint,
    relacionunidad      double precision
);

alter table producto
    owner to postgres;

create table consumible
(
    producto_id                 bigint                     not null
        primary key
        constraint consumible_producto_fk
            references producto,
    tiempomaximoenproceso       double precision default 0 not null,
    tiempopreparacion           double precision default 0 not null,
    unidadmovimientostock_fk    bigint                     not null
        constraint consumible_unidadmovimientostock_fk
            references unidad,
    ratioconsumomovimientostock double precision           not null,
    unidadrecepcion_fk          bigint                     not null
        constraint consumible_unidadrecepcion_fk
            references unidad,
    ratioconsumorecepcion       double precision           not null,
    unidadconsumo_fk            bigint                     not null
        constraint consumible_unidadconsumo_fk
            references unidad,
    created                     timestamp,
    updated                     timestamp,
    created_by                  bigint
        constraint consumible_created_by_fk
            references usuario,
    updated_by                  bigint
        constraint consumible_updated_by_fk
            references usuario
);

alter table consumible
    owner to postgres;

create index consumible_created_by_idx
    on consumible (created_by);

create index consumible_unidadconsumo_fk_idx
    on consumible (unidadconsumo_fk);

create index consumible_unidadmovimientostock_fk_idx
    on consumible (unidadmovimientostock_fk);

create index consumible_unidadrecepcion_fk_idx
    on consumible (unidadrecepcion_fk);

create index consumible_updated_by_idx
    on consumible (updated_by);

create table orden
(
    id          bigserial
        primary key,
    codigo      varchar(45) default NULL::character varying,
    producto_fk bigint not null
        constraint orden_producto_fk
            references producto,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table orden
    owner to postgres;

create index idx_orden_codigo
    on orden (codigo);

create index idx_producto_familia
    on producto (familia_fk) include (codigo, nombre);

create table productoatributo
(
    id          bigserial
        primary key,
    atributo_fk bigint not null
        constraint productoatributo_atributo_fk
            references atributo,
    producto_fk bigint not null
        constraint productoatributo_producto_fk
            references producto,
    valor       varchar(400) default NULL::character varying,
    created     date,
    updated     date,
    created_by  bigint,
    updated_by  bigint
);

alter table productoatributo
    owner to postgres;

create table productoatributovalorseleccion
(
    id                        bigserial
        primary key,
    producto_fk               bigint not null
        constraint productoatributovalorseleccion_producto_fk
            references producto,
    atributovalorseleccion_fk bigint not null
        constraint productoatributovalorseleccion_atributovalorseleccion_fk
            references atributovalorseleccion,
    created                   timestamp,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table productoatributovalorseleccion
    owner to postgres;

create table productocalidad
(
    id                    bigserial
        primary key,
    producto_principal_fk bigint
        constraint productocalidad_producto_principal_fk
            references producto,
    producto_calidad_fk   bigint
        constraint productocalidad_producto_calidad_fk
            references producto,
    created               timestamp,
    updated               timestamp,
    created_by            bigint,
    updated_by            bigint
);

alter table productocalidad
    owner to postgres;

create table productofichero
(
    id          bigserial
        primary key,
    producto_fk bigint not null
        constraint productofichero_producto_fk
            references producto,
    fichero_fk  bigint not null
        constraint productofichero_fichero_fk
            references fichero,
    created     timestamp,
    updated     timestamp
);

alter table productofichero
    owner to postgres;

create table productopropiedad
(
    id                          bigserial
        primary key,
    producto_fk                 bigint not null
        constraint productopropiedad_producto_fk
            references producto,
    productofamiliapropiedad_fk bigint not null
        constraint productopropiedad_productofamiliapropiedad_fk
            references productofamiliapropiedad,
    codigo                      varchar(50)  default NULL::character varying,
    descripcion                 varchar(250) default NULL::character varying,
    valor                       varchar(150) default NULL::character varying,
    unidad                      varchar(100) default NULL::character varying,
    productopropiedadpadre_fk   bigint,
    created                     timestamp,
    updated                     timestamp,
    created_by                  bigint,
    updated_by                  bigint,
    constraint uq_productopropiedad
        unique (producto_fk, productofamiliapropiedad_fk)
);

alter table productopropiedad
    owner to postgres;

create table productounidad
(
    id                    bigserial
        primary key,
    producto_fk           bigint           not null
        constraint productounidad_producto_fk
            references producto,
    unidad_fk             bigint           not null
        constraint productounidad_unidad_fk
            references unidad,
    relacion_to_principal double precision not null,
    created               timestamp,
    updated               timestamp,
    created_by            bigint,
    updated_by            bigint,
    constraint uq_productounidad
        unique (producto_fk, unidad_fk)
);

alter table productounidad
    owner to postgres;

create table propiedadfamilia
(
    id                       bigserial
        primary key,
    nombre                   varchar(100) not null,
    descripcion              varchar(300),
    propiedadfamiliapadre_fk bigint
        constraint propiedadfamilia_padre_fk
            references propiedadfamilia,
    unidad_fk                bigint
        constraint propiedadfamilia_unidad_fk
            references unidad,
    created                  timestamp,
    updated                  timestamp,
    created_by               bigint
        constraint propiedadfamilia_created_by
            references usuario,
    updated_by               bigint
        constraint propiedadfamilia_updated_by
            references usuario,
    tipo_agregacion          tipo_agregacion_enum default 'magnitud'::tipo_agregacion_enum,
    producto_fk              bigint
        references producto
);

alter table propiedadfamilia
    owner to postgres;

create table equipoclasepropiedad
(
    id                           bigserial
        primary key,
    nombre                       varchar(50)     default NULL::character varying,
    descripcion                  varchar(200)    default NULL::character varying,
    equipoclase_fk               bigint                                            not null
        constraint equipoclasepropiedad_equipoclase_fk
            references equipoclase,
    equipoclasepropiedadpadre_fk bigint
        constraint equipoclasepropiedad_padre_fk
            references equipoclasepropiedad
        constraint equipoclasepropiedad_equipoclasepropiedadpadre_fk
            references equipoclasepropiedad,
    valor                        varchar(150),
    unidad                       varchar(50)     default NULL::character varying,
    created                      timestamp,
    updated                      timestamp,
    created_by                   bigint
        constraint equipoclasepropiedad_created_by_fk
            references usuario,
    updated_by                   bigint
        constraint equipoclasepropiedad_updated_by_fk
            references usuario,
    unidad_fk                    bigint
        constraint equipoclasepropiedad_unidad_fk
            references unidad,
    tipo_valor                   tipo_valor_enum default 'STRING'::tipo_valor_enum not null,
    propiedadfamilia_fk          bigint
        constraint equipoclasepropiedad_propiedadfamilia_fk
            references propiedadfamilia
);

alter table equipoclasepropiedad
    owner to postgres;

create index equipoclasepropiedad_created_by_idx
    on equipoclasepropiedad (created_by);

create index equipoclasepropiedad_equipoclase_fk_idx
    on equipoclasepropiedad (equipoclase_fk);

create index equipoclasepropiedad_updated_by_idx
    on equipoclasepropiedad (updated_by);

create table receta
(
    id                bigserial
        primary key,
    producto_fk       bigint
        constraint receta_producto_fk
            references producto,
    recetabase_fk     bigint
        constraint receta_recetabase_fk
            references receta,
    unidad_fk         bigint
        constraint receta_unidad_fk
            references unidad,
    cantidad          double precision default 0     not null,
    racionpersona     double precision,
    nombre            varchar(255)     default NULL::character varying,
    codigo            varchar(100)     default NULL::character varying
        constraint uq_receta
            unique,
    numproyecto       varchar(45)      default NULL::character varying,
    marca             varchar(45)      default NULL::character varying,
    revision          integer,
    activo            boolean          default false not null,
    versionpordefecto boolean          default false,
    tipoof            boolean          default false,
    version           integer          default 1     not null,
    observaciones     varchar(90)      default NULL::character varying,
    fecha             timestamp,
    created           timestamp,
    updated           timestamp,
    created_by        bigint,
    updated_by        bigint
);

alter table receta
    owner to postgres;

create table recetaadjunto
(
    id         bigserial
        primary key,
    receta_fk  bigint not null
        constraint recetaadjunto_receta_fk
            references receta,
    nombre     varchar(75)  default NULL::character varying,
    ruta       varchar(200) default NULL::character varying,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table recetaadjunto
    owner to postgres;

create table recetaatributo
(
    id          bigserial
        primary key,
    atributo_fk bigint
        constraint recetaatributo_atributo_fk
            references atributo,
    receta_fk   bigint
        constraint recetaatributo_receta_fk
            references receta,
    valor       varchar(400) default NULL::character varying,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table recetaatributo
    owner to postgres;

create table recetaatributovalor
(
    id                bigserial
        primary key,
    receta_fk         bigint not null
        constraint recetaatributovalor_receta_fk
            references receta,
    recetaatributo_fk bigint not null
        constraint recetaatributovalor_recetaatributo_fk
            references recetaatributo,
    valor             varchar(400) default NULL::character varying,
    created           timestamp,
    updated           timestamp,
    created_by        bigint,
    updated_by        bigint
);

alter table recetaatributovalor
    owner to postgres;

create table recetaatributovalorseleccion
(
    id                        bigserial
        primary key,
    receta_fk                 bigint not null
        constraint recetaatributovalorseleccion_receta_fk
            references receta,
    atributovalorseleccion_fk bigint not null
        constraint recetaatributovalorseleccion_atributovalorseleccion_fk
            references atributovalorseleccion,
    valor                     varchar(200) default NULL::character varying,
    created                   timestamp,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table recetaatributovalorseleccion
    owner to postgres;

create table recetacomentario
(
    id          bigserial
        primary key,
    receta_fk   bigint not null
        constraint recetacomentario_receta_fk
            references receta,
    operario_fk bigint
        constraint recetacomentario_operario_fk
            references operario,
    comentario  varchar(512) default NULL::character varying,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table recetacomentario
    owner to postgres;

create table recetaingrediente
(
    id                   bigserial
        primary key,
    receta_fk            bigint                        not null
        constraint recetaingrediente_receta_fk
            references receta,
    producto_fk          bigint                        not null
        constraint recetaingrediente_producto_fk
            references producto,
    consumo_teorico      double precision              not null,
    consumo_objetivo     double precision default 0    not null,
    unidad_fk            bigint,
    ratioconteoprincipal double precision default 1    not null,
    consumos             boolean          default false,
    puntoestandarizacion boolean          default false,
    consumomanual        boolean          default true not null,
    orden                integer          default 0    not null,
    tipo                 varchar(10)      default NULL::character varying,
    created              timestamp        default CURRENT_TIMESTAMP,
    updated              timestamp,
    created_by           bigint,
    updated_by           bigint,
    consumodescuento     boolean          default false,
    posicion             varchar(50)      default NULL::character varying,
    numero_reserva       varchar(50)      default NULL::character varying,
    posicion_reserva     varchar(50)      default NULL::character varying,
    almacen              varchar(50)      default NULL::character varying,
    constraint uq_receta_producto_pos
        unique (receta_fk, producto_fk, posicion)
);

alter table recetaingrediente
    owner to postgres;

create table usuariooperarioinsertar
(
    codigo              varchar(100) default NULL::character varying,
    nombreoperario      varchar(100) default NULL::character varying,
    nombrecortooperario varchar(100) default NULL::character varying,
    categoria           varchar(100) default NULL::character varying,
    clase               varchar(100) default NULL::character varying,
    nombreusuario       varchar(100) default NULL::character varying,
    login               varchar(50)  default NULL::character varying,
    password            varchar(100) default NULL::character varying,
    perfilusuario       varchar(100) default NULL::character varying,
    validacalidad       boolean,
    editacalidad        boolean,
    seccion             varchar(100) default NULL::character varying
);

alter table usuariooperarioinsertar
    owner to postgres;

create table usuarioperfilusuario
(
    id               bigserial
        primary key,
    usuario_fk       bigint not null
        constraint usuarioperfilusuario_usuario_fk
            references usuario,
    perfilusuario_fk bigint not null
        constraint usuarioperfilusuario_perfilusuario_fk
            references perfilusuario,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table usuarioperfilusuario
    owner to postgres;

create table usuarioseccion
(
    id         bigserial
        primary key,
    usuario_fk bigint not null
        constraint usuarioseccion_usuario_fk
            references usuario,
    seccion_fk bigint not null
        constraint usuarioseccion_seccion_fk
            references seccion,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table usuarioseccion
    owner to postgres;

create table variableclase
(
    id               bigint       default nextval('variableclase_id_seq'::regclass) not null
        primary key,
    variableclase_fk bigint
        constraint variableclase_variableclase_fk
            references variableclase,
    codigo           varchar(40)                                                    not null,
    descripcion      varchar(255) default NULL::character varying,
    created          timestamp    default CURRENT_TIMESTAMP,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table variableclase
    owner to postgres;

create table variable_industrial
(
    id                      bigserial
        primary key,
    nombre                  varchar(150)              not null,
    servidor_fk             bigint                    not null
        constraint variable_industrial_servidor_fk
            references servidor,
    variableclase_fk        bigint
        constraint fk_variableindustrial_variable_clase
            references variableclase
            on update cascade on delete set null,
    nodoestados             boolean     default false not null,
    nodoproduccionevento    boolean     default false not null,
    nodoproduccionmuestreo  boolean     default false not null,
    nodoatributo            boolean     default false not null,
    nodoalarma              boolean     default false not null,
    nodocalidad             boolean     default false not null,
    nodoordenevento         boolean     default false,
    nodocontador            boolean     default false not null,
    nodocontadorreparto     boolean     default false not null,
    nodocontadoratributo    boolean     default false not null,
    nodocontadorconsumos    boolean     default false not null,
    nodoestandarizacion     boolean     default false not null,
    nodoeventodisparador    boolean     default false not null,
    nodoconfirmacion        boolean     default false not null,
    tipo                    varchar(20),
    fechaopc                timestamp,
    tipovalor               varchar(45) default NULL::character varying,
    ultimovalorint          integer,
    ultimovalorstring       varchar(45) default NULL::character varying,
    variableconfirmacion_fk bigint
        constraint variable_industrial_variableconfirmacion_fk
            references variable_industrial,
    confirmada              boolean     default false not null,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint,
    updated_by              bigint
);

alter table variable_industrial
    owner to postgres;

create table centro
(
    id                                   bigserial
        primary key,
    medible                              boolean          default false not null,
    nombre                               varchar(255)     default NULL::character varying,
    tipo_fk                              bigint
        constraint centro_centrotipo_fk
            references centrotipo,
    centroclase_fk                       bigint
        constraint centro_centroclase_fk
            references centroclase,
    tipo                                 varchar(45)      default NULL::character varying,
    ordenactual                          varchar(255)     default NULL::character varying,
    productivo                           boolean          default true  not null,
    activo                               boolean          default true  not null,
    centropersona                        boolean          default false not null,
    ordensenyalmaquina                   boolean          default false not null,
    modoasignacion                       varchar,
    centropadre_fk                       bigint
        constraint centro_centropadre_fk
            references centro,
    estadoactual_fk                      bigint
        constraint centro_estadoactual_fk
            references estado,
    seccion_fk                           bigint
        constraint centro_seccion_fk
            references seccion,
    opcserver_fk                         bigint
        constraint centro_opcserver_fk
            references opcserver,
    gestionmanualestados                 boolean          default false not null,
    vbleindustrialestados_fk             bigint
        constraint centro_vbleindustrialestados_fk
            references variable_industrial,
    vbleestadosesproductiva              boolean          default false not null,
    vbleindustrialproduccionmuestreo_fk  bigint
        constraint centro_vbleindustrialproduccionmuestreo_fk
            references variable_industrial,
    vbleindustrialproduccionevento_fk    bigint
        constraint centro_vbleindustrialproduccionevento_fk
            references variable_industrial,
    vbleindustrialcalidad_fk             bigint
        constraint centro_vbleindustrialcalidad_fk
            references variable_industrial,
    vbleindustrialordenevento_fk         bigint
        constraint centro_vbleindustrialordenevento_fk
            references variable_industrial,
    vbleindustrialconfirmacionllenado_fk bigint
        constraint centro_vbleindustrialconfirmacionllenado_fk
            references variable_industrial,
    frecestadoopcmin                     integer          default 0     not null,
    frecproduccionopcmin                 integer          default 0     not null,
    tipocapturaproduccion                varchar(45)      default NULL::character varying,
    tipocapturaestado                    varchar(45)      default NULL::character varying,
    centroordenactual_fk                 bigint,
    conectado                            boolean          default false not null,
    valorinicialproduccion               bigint           default 0,
    valorinicialestados                  bigint           default 0,
    valorinicialproduccionconforme       bigint           default 0,
    fechainicialopc                      timestamp,
    usarvalorinicialproduccion           boolean,
    usarvalorinicialestados              boolean,
    ultimotrunit                         varchar(45)      default NULL::character varying,
    carpetaintercambio                   varchar(255)     default NULL::character varying,
    carpetatrunitbackup                  varchar(255)     default NULL::character varying,
    unidadconteo_fk                      bigint
        constraint centro_unidadconteo_fk
            references unidad,
    unidadprincipal_fk                   bigint
        constraint centro_unidadprincipal_fk
            references unidad,
    unidadsecundaria_fk                  bigint
        constraint centro_unidadsecundaria_fk
            references unidad,
    unidadeficiencia_fk                  bigint
        constraint centro_unidadeficiencia_fk
            references unidad,
    unidadcantidaddesechada_fk           bigint
        constraint centro_unidadcantidaddesechada_fk
            references unidad,
    unidadmermas_fk                      bigint
        constraint centro_unidadmermas_fk
            references unidad,
    umbralfalloproduccion                double precision default 0,
    tipounidadproductividad              varchar(45)      default 'principal'::character varying,
    tipotiempoproductividad              varchar(45)      default 'horas'::character varying,
    nsecuencia                           integer          default 1,
    secuenciaordenauto                   varchar(45)      default NULL::character varying,
    eventocambioof                       varchar(45)      default NULL::character varying,
    created                              timestamp,
    updated                              timestamp,
    created_by                           bigint
        constraint centro_created_by_fk
            references usuario,
    updated_by                           bigint
        constraint centro_updated_by_fk
            references usuario,
    tipotiempoeficiencia                 varchar(45)      default 'horas'::character varying,
    cambioautomaticoof                   boolean          default true,
    codigo                               varchar(50)      default NULL::character varying,
    tiempojustificacionobligatorio       integer          default 0,
    unidadauxiliar_fk                    bigint
        constraint centro_unidadauxiliar_fk
            references unidad,
    tiempomicroparada                    double precision default 0,
    valorparcialproduccion               double precision default 0
);

alter table centro
    owner to postgres;

create table calendarioeventocentro
(
    id                  bigserial
        primary key,
    calendarioevento_fk bigint not null
        constraint calendarioeventocentro_calendarioevento_fk
            references calendarioevento,
    centro_fk           bigint not null
        constraint calendarioeventocentro_centro_fk
            references centro,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint calendarioeventocentro_created_by_fk
            references usuario,
    updated_by          bigint
        constraint calendarioeventocentro_updated_by_fk
            references usuario,
    constraint calendarioeventocentro_uq
        unique (calendarioevento_fk, centro_fk)
);

alter table calendarioeventocentro
    owner to postgres;

create index calendarioeventocentro_calendarioevento_fk_idx
    on calendarioeventocentro (calendarioevento_fk);

create index calendarioeventocentro_centro_fk_idx
    on calendarioeventocentro (centro_fk);

create index calendarioeventocentro_created_by_idx
    on calendarioeventocentro (created_by);

create index calendarioeventocentro_updated_by_idx
    on calendarioeventocentro (updated_by);

create index centro_centroclase_fk_idx
    on centro (centroclase_fk);

create index centro_centroordenactual_fk_idx
    on centro (centroordenactual_fk);

create index centro_centropadre_fk_idx
    on centro (centropadre_fk);

create index centro_centrotipo_fk_idx
    on centro (tipo_fk);

create index centro_created_by_idx
    on centro (created_by);

create index centro_estadoactual_fk_idx
    on centro (estadoactual_fk);

create index centro_nombre_idx
    on centro (nombre);

create index centro_opcserver_fk_idx
    on centro (opcserver_fk);

create index centro_seccion_fk_idx
    on centro (seccion_fk);

create index centro_unidadauxiliar_fk_idx
    on centro (unidadauxiliar_fk);

create index centro_unidadcantidaddesechada_fk_idx
    on centro (unidadcantidaddesechada_fk);

create index centro_unidadconteo_fk_idx
    on centro (unidadconteo_fk);

create index centro_unidadeficiencia_fk_idx
    on centro (unidadeficiencia_fk);

create index centro_unidadmermas_fk_idx
    on centro (unidadmermas_fk);

create index centro_unidadprincipal_fk_idx
    on centro (unidadprincipal_fk);

create index centro_unidadsecundaria_fk_idx
    on centro (unidadsecundaria_fk);

create index centro_updated_by_idx
    on centro (updated_by);

create index centro_vbleindustrialcalidad_fk_idx
    on centro (vbleindustrialcalidad_fk);

create index centro_vbleindustrialconfirmacionllenado_fk_idx
    on centro (vbleindustrialconfirmacionllenado_fk);

create index centro_vbleindustrialestados_fk_idx
    on centro (vbleindustrialestados_fk);

create index centro_vbleindustrialordenevento_fk_idx
    on centro (vbleindustrialordenevento_fk);

create index centro_vbleindustrialproduccionevento_fk_idx
    on centro (vbleindustrialproduccionevento_fk);

create index centro_vbleindustrialproduccionmuestreo_fk_idx
    on centro (vbleindustrialproduccionmuestreo_fk);

create table centroalarma
(
    id          bigserial
        primary key,
    centro_fk   bigint    not null
        constraint centroalarma_centro_fk
            references centro,
    estado_fk   bigint    not null
        constraint centroalarma_estado_fk
            references estado,
    fechainicio timestamp not null,
    fechafin    timestamp,
    activa      boolean,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint centroalarma_created_by_fk
            references usuario,
    updated_by  bigint
        constraint centroalarma_updated_by_fk
            references usuario
);

alter table centroalarma
    owner to postgres;

create index centroalarma_activa_idx
    on centroalarma (activa);

create index centroalarma_centro_fk_idx
    on centroalarma (centro_fk);

create index centroalarma_created_by_idx
    on centroalarma (created_by);

create index centroalarma_estado_fk_idx
    on centroalarma (estado_fk);

create index centroalarma_updated_by_idx
    on centroalarma (updated_by);

create index idx_centroalarma_centro_fechas_activa
    on centroalarma (centro_fk, fechainicio, fechafin)
    where (activa = true);

create table centroatributo
(
    id                         bigserial
        primary key,
    nombre                     varchar(45)                not null,
    tipovalor                  varchar(20)  default NULL::character varying,
    centro_fk                  bigint
        constraint centroatributo_centro_fk
            references centro,
    tipocaptura                varchar(20)  default 'manual'::character varying,
    tagopc                     varchar(255) default NULL::character varying,
    opcnodo_fk                 bigint
        constraint centroatributo_opcnodo_fk
            references opcnodo,
    opcnodoescritura_fk        bigint
        constraint centroatributo_opcnodoescritura_fk
            references opcnodo,
    opcnodoconfirmacion_fk     bigint
        constraint centroatributo_opcnodoconfirmacion_fk
            references opcnodo,
    nsecuencia                 integer,
    tipomerma                  boolean      default false,
    tipoverificacionreferencia boolean      default false,
    valorconfirmacion          boolean      default false not null,
    idpalet                    boolean      default false not null,
    created                    timestamp,
    updated                    timestamp,
    created_by                 bigint
        constraint centroatributo_created_by_fk
            references usuario,
    updated_by                 bigint
        constraint centroatributo_updated_by_fk
            references usuario,
    valorinicialopc            bigint,
    constraint centroatributo_centro_nombre_uq
        unique (nombre, centro_fk)
);

alter table centroatributo
    owner to postgres;

create index centroatributo_centro_fk_idx
    on centroatributo (centro_fk);

create index centroatributo_created_by_idx
    on centroatributo (created_by);

create index centroatributo_opcnodo_fk_idx
    on centroatributo (opcnodo_fk);

create index centroatributo_opcnodoconfirmacion_fk_idx
    on centroatributo (opcnodoconfirmacion_fk);

create index centroatributo_opcnodoescritura_fk_idx
    on centroatributo (opcnodoescritura_fk);

create index centroatributo_updated_by_idx
    on centroatributo (updated_by);

create table centrocalidad
(
    id                          bigserial
        primary key,
    centro_fk                   bigint                                                 not null
        constraint centrocalidad_centro_fk
            references centro,
    producto_fk                 bigint
        constraint centrocalidad_producto_fk
            references producto,
    estado_fk                   bigint
        constraint centrocalidad_estado_fk
            references estado,
    puntocontrol_fk             bigint                                                 not null
        constraint centrocalidad_puntocontrol_fk
            references calidadpuntocontrol,
    eventocontrol_fk            bigint                                                 not null
        constraint centrocalidad_eventocontrol_fk
            references calidadeventocontrol,
    valornumericomaximo         double precision default 0                             not null,
    valornumericominimo         double precision default 0                             not null,
    activo                      boolean          default true                          not null,
    created                     timestamp,
    updated                     timestamp,
    created_by                  bigint
        constraint centrocalidad_created_by_fk
            references usuario,
    updated_by                  bigint
        constraint centrocalidad_updated_by_fk
            references usuario,
    productofamiliapropiedad_fk bigint
        constraint fk_centrocalidad_productofamiliapropiedad
            references productofamiliapropiedad,
    tipo_incremento             varchar(50)      default 'ABSOLUTO'::character varying not null
        constraint check_tipo_incremento
            check ((tipo_incremento)::text = ANY
                   (ARRAY [('ABSOLUTO'::character varying)::text, ('PORCENTAJE (%)'::character varying)::text])),
    orden_anterior_cambio_turno boolean          default false                         not null,
    constraint centrocalidad_uq
        unique (centro_fk, producto_fk, estado_fk, puntocontrol_fk, eventocontrol_fk)
);

alter table centrocalidad
    owner to postgres;

create index centrocalidad_centro_fk_idx
    on centrocalidad (centro_fk);

create index centrocalidad_created_by_idx
    on centrocalidad (created_by);

create index centrocalidad_estado_fk_idx
    on centrocalidad (estado_fk);

create index centrocalidad_eventocontrol_fk_idx
    on centrocalidad (eventocontrol_fk);

create index centrocalidad_producto_fk_idx
    on centrocalidad (producto_fk);

create index centrocalidad_puntocontrol_fk_idx
    on centrocalidad (puntocontrol_fk);

create index centrocalidad_updated_by_idx
    on centrocalidad (updated_by);

create table centroequipo
(
    id         bigserial
        primary key,
    centro_fk  bigint not null
        constraint centroequipo_centro_fk
            references centro,
    equipo_fk  bigint not null
        constraint centroequipo_equipo_fk
            references equipo,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint centroequipo_created_by_fk
            references usuario,
    updated_by bigint
        constraint centroequipo_updated_by_fk
            references usuario,
    pordefecto boolean default false,
    constraint centroequipo_uq
        unique (centro_fk, equipo_fk)
);

alter table centroequipo
    owner to postgres;

create index centroequipo_centro_fk_idx
    on centroequipo (centro_fk);

create index centroequipo_created_by_idx
    on centroequipo (created_by);

create index centroequipo_equipo_fk_idx
    on centroequipo (equipo_fk);

create index centroequipo_updated_by_idx
    on centroequipo (updated_by);

create table centroestado
(
    id                bigserial
        primary key,
    frecmuestreoseg   bigint       default 0     not null,
    nodeidopc         varchar(255) default NULL::character varying,
    vbleindustrial_fk bigint
        constraint centroestado_vbleindustrial_fk
            references variable_industrial,
    tipocapturaestado varchar(255) default NULL::character varying,
    umbralmax         bigint       default 0     not null,
    umbralmin         bigint       default 0     not null,
    centro_fk         bigint
        constraint centroestado_centro_fk
            references centro,
    estado_fk         bigint
        constraint centroestado_estado_fk
            references estado,
    nsecuencia        integer      default 50000 not null,
    tmaximo           integer      default 0,
    tminimoalarma     integer      default 0,
    created           timestamp,
    updated           timestamp,
    created_by        bigint
        constraint centroestado_created_by_fk
            references usuario,
    updated_by        bigint
        constraint centroestado_updated_by_fk
            references usuario,
    valor_variable    integer,
    constraint centroestado_centro_estado_uq
        unique (centro_fk, estado_fk)
);

alter table centroestado
    owner to postgres;

create index centroestado_centro_fk_idx
    on centroestado (centro_fk);

create index centroestado_created_by_idx
    on centroestado (created_by);

create index centroestado_estado_fk_idx
    on centroestado (estado_fk);

create index centroestado_updated_by_idx
    on centroestado (updated_by);

create index centroestado_vbleindustrial_fk_idx
    on centroestado (vbleindustrial_fk);

create table centroparada
(
    id           bigserial
        primary key,
    centro_fk    bigint                not null
        constraint centroparada_centro_fk
            references centro,
    fechaparada  timestamp             not null,
    fechaproceso timestamp,
    procesada    boolean default false not null,
    created      timestamp,
    updated      timestamp,
    created_by   bigint
        constraint centroparada_created_by_fk
            references usuario,
    updated_by   bigint
        constraint centroparada_updated_by_fk
            references usuario
);

alter table centroparada
    owner to postgres;

create index centroparada_centro_fk_idx
    on centroparada (centro_fk);

create index centroparada_created_by_idx
    on centroparada (created_by);

create index centroparada_updated_by_idx
    on centroparada (updated_by);

create table centroproducto
(
    id                       bigserial
        primary key,
    version                  varchar(10)      default NULL::character varying,
    frecmuestreoatribprod    bigint           default 0 not null,
    idnodoopcatribprod       varchar(255)     default NULL::character varying,
    tipocapturaatribprod     varchar(255)     default NULL::character varying,
    vlimite                  double precision default 0 not null,
    vobjetivo                double precision default 0 not null,
    vteoria                  double precision default 0 not null,
    centro_fk                bigint
        constraint centroproducto_centro_fk
            references centro,
    producto_fk              bigint
        constraint centroproducto_producto_fk
            references producto,
    disponibilidad           double precision default 0,
    doobjetivo               double precision default 0,
    offsetparadamin          double precision,
    created                  timestamp,
    updated                  timestamp,
    created_by               bigint
        constraint centroproducto_created_by_fk
            references usuario,
    updated_by               bigint
        constraint centroproducto_updated_by_fk
            references usuario,
    prodobjetivo             bigint           default 0,
    calidadobjetivo          double precision default 0,
    ratioconteoprincipal     double precision default 1,
    ratioprincipalsecundaria double precision default 1,
    ratioprincipaleficiencia double precision default 1 not null,
    ratioprincipaldesechada  double precision default 1 not null,
    ratioeficienciaconteo    double precision default 1,
    ratioprincipalauxiliar   double precision,
    prodestandar             double precision default 0,
    receta_fk                bigint
        constraint centroproducto_receta_fk
            references receta,
    constraint centroproducto_centro_producto_uq
        unique (centro_fk, producto_fk)
);

alter table centroproducto
    owner to postgres;

create table centroorden
(
    id                        bigserial
        primary key,
    codigo                    varchar(45)      default NULL::character varying,
    nsecuencia                bigint,
    centroproducto_fk         bigint
        constraint centroorden_centroproducto_fk
            references centroproducto,
    ratioconteoprincipal      double precision default 1,
    cantidad                  bigint                         not null,
    cantidadproducida         double precision default 0,
    cantidadreportada         double precision,
    cantidadreportepordefecto double precision,
    fechareporte              timestamp,
    mostrarunidadprincipal    boolean          default false not null,
    estado                    varchar(45)      default 'planificada'::character varying,
    fecha                     timestamp,
    ordenmadre_fk             bigint
        constraint centroorden_ordenmadre_fk
            references centroorden,
    receta_fk                 bigint
        constraint centroorden_receta_fk
            references receta,
    cambioorden               boolean          default false,
    manual                    boolean          default false,
    ean13                     varchar(13)      default NULL::character varying,
    observaciones             varchar(512)     default NULL::character varying,
    created                   timestamp,
    updated                   timestamp,
    created_by                bigint
        constraint centroorden_created_by_fk
            references usuario,
    updated_by                bigint
        constraint centroorden_updated_by_fk
            references usuario,
    cod_estado_erp            varchar(50)      default NULL::character varying,
    fechainicioextrema        timestamp,
    fechafinextrema           timestamp,
    fechafinprogramado        timestamp,
    operacion                 varchar(50)      default NULL::character varying,
    ordenestadoactual_fk      bigint
        constraint centroorden_ordenestadoactual_fk
            references ordenestado,
    ordenestadoactualerp_fk   bigint
        constraint centroorden_ordenestadoactualerp_fk
            references ordenestado,
    producto_fk               bigint
        constraint centroorden_producto_fk
            references producto,
    orden_fk                  bigint
        constraint centroorden_orden_fk
            references orden,
    cantidaderp               double precision,
    ordenerp                  boolean          default true,
    inicioproduccionorden     boolean          default false,
    constraint centroorden_codigo_operacion_uq
        unique (codigo, operacion)
);

alter table centroorden
    owner to postgres;

create table calidadcontrol
(
    id                  bigserial
        primary key,
    centro_fk           bigint                         not null
        constraint calidadcontrol_centro_fk
            references centro,
    puntocontrol_fk     bigint                         not null
        constraint calidadcontrol_puntocontrol_fk
            references calidadpuntocontrol,
    eventocontrol_fk    bigint                         not null
        constraint calidadcontrol_eventocontrol_fk
            references calidadeventocontrol,
    fechalanzamiento    timestamp                      not null,
    turno_fk            bigint                         not null
        constraint calidadcontrol_turno_fk
            references turno,
    producto_fk         bigint                         not null
        constraint calidadcontrol_producto_fk
            references producto,
    orden_fk            bigint                         not null
        constraint calidadcontrol_orden_fk
            references centroorden,
    productoactual_fk   bigint
        constraint calidadcontrol_productoactual_fk
            references producto,
    ordenactual_fk      bigint
        constraint calidadcontrol_ordenactual_fk
            references centroorden,
    operario_fk         bigint
        constraint calidadcontrol_operario_fk
            references operario,
    valornumerico       double precision,
    valoralfanumerico   varchar(300)     default NULL::character varying,
    valorci             boolean          default false not null,
    valorrealizado      boolean          default false,
    valoranotacion      varchar(45)      default NULL::character varying,
    valornumericomaximo double precision default 0     not null,
    valornumericominimo double precision default 0     not null,
    observaciones       varchar(500)     default NULL::character varying,
    fecharealizacion    timestamp,
    fechavencimiento    timestamp,
    estado              integer          default 1     not null,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint calidadcontrol_created_by_fk
            references usuario,
    updated_by          bigint
        constraint calidadcontrol_updated_by_fk
            references usuario,
    nuevo               boolean          default true  not null,
    ruta_imagen         varchar(500),
    responsable_fk      bigint
        references operario
);

alter table calidadcontrol
    owner to postgres;

create index calidadcontrol_centro_fk_idx
    on calidadcontrol (centro_fk);

create index calidadcontrol_created_by_idx
    on calidadcontrol (created_by);

create index calidadcontrol_eventocontrol_fk_idx
    on calidadcontrol (eventocontrol_fk);

create index calidadcontrol_fechalanzamiento_idx
    on calidadcontrol (fechalanzamiento);

create index calidadcontrol_operario_fk_idx
    on calidadcontrol (operario_fk);

create index calidadcontrol_orden_fk_idx
    on calidadcontrol (orden_fk);

create index calidadcontrol_ordenactual_fk_idx
    on calidadcontrol (ordenactual_fk);

create index calidadcontrol_producto_fk_idx
    on calidadcontrol (producto_fk);

create index calidadcontrol_productoactual_fk_idx
    on calidadcontrol (productoactual_fk);

create index calidadcontrol_puntocontrol_fk_idx
    on calidadcontrol (puntocontrol_fk);

create index calidadcontrol_turno_fk_idx
    on calidadcontrol (turno_fk);

create index calidadcontrol_updated_by_idx
    on calidadcontrol (updated_by);

create table calidadcontrolhist
(
    id                       bigserial
        primary key,
    centro_fk                bigint                         not null
        constraint calidadcontrolhist_centro_fk
            references centro,
    puntocontrol_fk          bigint                         not null
        constraint calidadcontrolhist_puntocontrol_fk
            references calidadpuntocontrol,
    eventocontrol_fk         bigint                         not null
        constraint calidadcontrolhist_eventocontrol_fk
            references calidadeventocontrol,
    fechalanzamiento         timestamp                      not null,
    turno_fk                 bigint                         not null
        constraint calidadcontrolhist_turno_fk
            references turno,
    producto_fk              bigint                         not null
        constraint calidadcontrolhist_producto_fk
            references producto,
    orden_fk                 bigint                         not null
        constraint calidadcontrolhist_orden_fk
            references centroorden,
    operario_fk              bigint
        constraint calidadcontrolhist_operario_fk
            references operario,
    valornumerico            double precision,
    valoralfanumerico        varchar(300)     default NULL::character varying,
    valorci                  boolean          default false not null,
    valorrealizado           boolean          default false,
    valoranotacion           varchar(45)      default NULL::character varying,
    valornumericomaximo      double precision default 0     not null,
    valornumericominimo      double precision default 0     not null,
    observaciones            varchar(500)     default NULL::character varying,
    observacionessupervisor  varchar(200)     default NULL::character varying,
    observacionesresponsable varchar(200)     default NULL::character varying,
    fecharealizacion         timestamp,
    estado                   integer          default 1     not null,
    validado                 boolean          default false not null,
    usuariovalidacion_fk     bigint
        constraint calidadcontrolhist_usuariovalidacion_fk
            references usuario,
    fechavalidacion          timestamp,
    editado                  boolean          default false not null,
    fechaedicion             timestamp,
    usuarioedicion_fk        bigint
        constraint calidadcontrolhist_usuarioedicion_fk
            references usuario,
    created                  timestamp,
    updated                  timestamp,
    created_by               bigint
        constraint calidadcontrolhist_created_by_fk
            references usuario,
    updated_by               bigint
        constraint calidadcontrolhist_updated_by_fk
            references usuario,
    ruta_imagen              varchar(500),
    responsable_fk           bigint
        references operario
);

alter table calidadcontrolhist
    owner to postgres;

create index calidadcontrolhist_centro_fk_idx
    on calidadcontrolhist (centro_fk);

create index calidadcontrolhist_created_by_idx
    on calidadcontrolhist (created_by);

create index calidadcontrolhist_eventocontrol_fk_idx
    on calidadcontrolhist (eventocontrol_fk);

create index calidadcontrolhist_fechalanzamiento_idx
    on calidadcontrolhist (fechalanzamiento);

create index calidadcontrolhist_operario_fk_idx
    on calidadcontrolhist (operario_fk);

create index calidadcontrolhist_orden_fk_idx
    on calidadcontrolhist (orden_fk);

create index calidadcontrolhist_producto_fk_idx
    on calidadcontrolhist (producto_fk);

create index calidadcontrolhist_puntocontrol_fk_idx
    on calidadcontrolhist (puntocontrol_fk);

create index calidadcontrolhist_turno_fk_idx
    on calidadcontrolhist (turno_fk);

create index calidadcontrolhist_updated_by_idx
    on calidadcontrolhist (updated_by);

create index calidadcontrolhist_usuarioedicion_fk_idx
    on calidadcontrolhist (usuarioedicion_fk);

create index calidadcontrolhist_usuariovalidacion_fk_idx
    on calidadcontrolhist (usuariovalidacion_fk);

alter table centro
    add constraint centro_centroordenactual_fk
        foreign key (centroordenactual_fk) references centroorden;

create index centroorden_centroproducto_fk_idx
    on centroorden (centroproducto_fk);

create index centroorden_codigo_idx
    on centroorden (codigo);

create index centroorden_created_by_idx
    on centroorden (created_by);

create index centroorden_estado_idx
    on centroorden (estado);

create index centroorden_orden_fk_idx
    on centroorden (orden_fk);

create index centroorden_ordenestadoactual_fk_idx
    on centroorden (ordenestadoactual_fk);

create index centroorden_ordenestadoactualerp_fk_idx
    on centroorden (ordenestadoactualerp_fk);

create index centroorden_ordenmadre_fk_idx
    on centroorden (ordenmadre_fk);

create index centroorden_producto_fk_idx
    on centroorden (producto_fk);

create index centroorden_receta_fk_idx
    on centroorden (receta_fk);

create index centroorden_updated_by_idx
    on centroorden (updated_by);

create index idx_centroorden_centroproducto_covering
    on centroorden (centroproducto_fk, id, codigo);

create table centroordencambio
(
    id               bigserial
        primary key,
    centroorden_fk   bigint                  not null
        constraint centroordencambio_centroorden_fk
            references centroorden,
    fechaprogramada  timestamp               not null,
    fechaproceso     timestamp,
    fechacancelacion timestamp,
    procesada        boolean   default false not null,
    created          timestamp default CURRENT_TIMESTAMP,
    updated          timestamp,
    created_by       bigint
        constraint centroordencambio_created_by_fk
            references usuario,
    updated_by       bigint
        constraint centroordencambio_updated_by_fk
            references usuario
);

alter table centroordencambio
    owner to postgres;

create index centroordencambio_centroorden_fk_idx
    on centroordencambio (centroorden_fk);

create index centroordencambio_created_by_idx
    on centroordencambio (created_by);

create index centroordencambio_updated_by_idx
    on centroordencambio (updated_by);

create table centroordenoee
(
    id                    bigserial
        primary key,
    centroorden_fk        bigint not null
        constraint centroordenoee_centroorden_uq
            unique
        constraint centroordenoee_centroorden_fk
            references centroorden,
    objetivooee           double precision default 0,
    vteorica              double precision default 0,
    disponibilidad        double precision default 0,
    doobjetivo            double precision default 0,
    calidadobjetivo       double precision default 0,
    ratioeficienciaconteo double precision default 1,
    ratioconteoprincipal  double precision default 1,
    created               timestamp        default CURRENT_TIMESTAMP,
    updated               timestamp,
    created_by            bigint
        constraint centroordenoee_created_by_fk
            references usuario,
    updated_by            bigint
        constraint centroordenoee_updated_by_fk
            references usuario
);

alter table centroordenoee
    owner to postgres;

create index centroordenoee_centroorden_fk_idx
    on centroordenoee (centroorden_fk);

create index centroordenoee_created_by_idx
    on centroordenoee (created_by);

create index centroordenoee_updated_by_idx
    on centroordenoee (updated_by);

create table centroordenpropiedadvalor
(
    id                      bigserial
        primary key,
    centroorden_fk          bigint not null
        constraint centroordenpropiedadvalor_centroorden_fk
            references centroorden,
    centroordenpropiedad_fk bigint not null
        constraint centroordenpropiedadvalor_centroordenpropiedad_fk
            references centroordenpropiedad,
    valor                   varchar(100) default NULL::character varying,
    created                 timestamp    default CURRENT_TIMESTAMP,
    updated                 timestamp,
    created_by              bigint
        constraint centroordenpropiedadvalor_created_by_fk
            references usuario,
    updated_by              bigint
        constraint centroordenpropiedadvalor_updated_by_fk
            references usuario,
    constraint centroordenpropiedadvalor_uq
        unique (centroorden_fk, centroordenpropiedad_fk)
);

alter table centroordenpropiedadvalor
    owner to postgres;

create index centroordenpropiedadvalor_centroordenpropiedad_fk_idx
    on centroordenpropiedadvalor (centroordenpropiedad_fk);

create index centroordenpropiedadvalor_created_by_idx
    on centroordenpropiedadvalor (created_by);

create index centroordenpropiedadvalor_updated_by_idx
    on centroordenpropiedadvalor (updated_by);

create table centroordenrelacion
(
    id              bigserial
        primary key,
    centroordena_fk bigint not null
        constraint centroordenrelacion_centroordena_fk
            references centroorden,
    centroordenb_fk bigint not null
        constraint centroordenrelacion_centroordenb_fk
            references centroorden,
    tiporelacion    varchar(50) default NULL::character varying,
    created         timestamp,
    updated         timestamp,
    created_by      bigint
        constraint centroordenrelacion_created_by_fk
            references usuario,
    updated_by      bigint
        constraint centroordenrelacion_updated_by_fk
            references usuario
);

alter table centroordenrelacion
    owner to postgres;

create index centroordenrelacion_centroordena_fk_idx
    on centroordenrelacion (centroordena_fk);

create index centroordenrelacion_centroordenb_fk_idx
    on centroordenrelacion (centroordenb_fk);

create index centroordenrelacion_created_by_idx
    on centroordenrelacion (created_by);

create index centroordenrelacion_updated_by_idx
    on centroordenrelacion (updated_by);

create index centroproducto_centro_fk_idx
    on centroproducto (centro_fk);

create index centroproducto_created_by_idx
    on centroproducto (created_by);

create index centroproducto_producto_fk_idx
    on centroproducto (producto_fk);

create index centroproducto_receta_fk_idx
    on centroproducto (receta_fk);

create index centroproducto_updated_by_idx
    on centroproducto (updated_by);

create table centroproductoenergiaactividadobjetivo
(
    centro_fk           bigint           not null
        constraint centroproductoenergiaactividadobjetivo_centro_fk
            references centro,
    producto_fk         bigint           not null
        constraint centroproductoenergiaactividadobjetivo_producto_fk
            references producto,
    energiaactividad_fk bigint           not null
        constraint centroproductoenergiaactividadobjetivo_energiaactividad_fk
            references energiaactividad,
    objetivo            double precision not null,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint centroproductoenergiaactividadobjetivo_created_by_fk
            references usuario,
    updated_by          bigint
        constraint centroproductoenergiaactividadobjetivo_updated_by_fk
            references usuario,
    primary key (centro_fk, producto_fk, energiaactividad_fk)
);

alter table centroproductoenergiaactividadobjetivo
    owner to postgres;

create index centroproductoenergiaactividadobjetivo_created_by_idx
    on centroproductoenergiaactividadobjetivo (created_by);

create index centroproductoenergiaactividadobjetivo_energiaactividad_fk_idx
    on centroproductoenergiaactividadobjetivo (energiaactividad_fk);

create index centroproductoenergiaactividadobjetivo_producto_fk_idx
    on centroproductoenergiaactividadobjetivo (producto_fk);

create index centroproductoenergiaactividadobjetivo_updated_by_idx
    on centroproductoenergiaactividadobjetivo (updated_by);

create table centropropiedad
(
    id                      bigserial
        primary key,
    centro_fk               bigint not null
        constraint centropropiedad_centro_fk
            references centro,
    centroclasepropiedad_fk bigint not null
        constraint centropropiedad_centroclasepropiedad_fk
            references centroclasepropiedad,
    valor                   varchar(255) default NULL::character varying,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint
        constraint centropropiedad_created_by_fk
            references usuario,
    updated_by              bigint
        constraint centropropiedad_updated_by_fk
            references usuario,
    variable_fk             bigint
        constraint centropropiedad_variable_fk
            references variable_industrial
            on delete set null,
    constraint centropropiedad_centro_centroclasepropiedad_uq
        unique (centro_fk, centroclasepropiedad_fk)
);

alter table centropropiedad
    owner to postgres;

create index centropropiedad_centroclasepropiedad_fk_idx
    on centropropiedad (centroclasepropiedad_fk);

create index centropropiedad_created_by_idx
    on centropropiedad (created_by);

create index centropropiedad_updated_by_idx
    on centropropiedad (updated_by);

create index centropropiedad_variable_fk_idx
    on centropropiedad (variable_fk);

create table centroresponsable
(
    id                     bigserial
        primary key,
    centro_fk              bigint not null
        constraint centroresponsable_centro_fk
            references centro,
    turno_fk               bigint not null
        constraint centroresponsable_turno_fk
            references turno,
    operario_fk            bigint not null
        constraint centroresponsable_operario_fk
            references operario,
    operarioresponsable_fk bigint
        constraint centroresponsable_operarioresponsable_fk
            references operario,
    fechaturno             timestamp,
    fechainicio            timestamp,
    created                timestamp,
    updated                timestamp,
    created_by             bigint
        constraint centroresponsable_created_by_fk
            references usuario,
    updated_by             bigint
        constraint centroresponsable_updated_by_fk
            references usuario
);

alter table centroresponsable
    owner to postgres;

create index centroresponsable_centro_fk_idx
    on centroresponsable (centro_fk);

create index centroresponsable_created_by_idx
    on centroresponsable (created_by);

create index centroresponsable_operario_fk_idx
    on centroresponsable (operario_fk);

create index centroresponsable_operarioresponsable_fk_idx
    on centroresponsable (operarioresponsable_fk);

create index centroresponsable_turno_fk_idx
    on centroresponsable (turno_fk);

create index centroresponsable_updated_by_idx
    on centroresponsable (updated_by);

create table centroterminal
(
    id          bigserial
        primary key,
    centro_fk   bigint not null
        constraint centroterminal_centro_fk
            references centro,
    terminal_fk bigint not null
        constraint centroterminal_terminal_fk
            references terminal,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint centroterminal_created_by_fk
            references usuario,
    updated_by  bigint
        constraint centroterminal_updated_by_fk
            references usuario
);

alter table centroterminal
    owner to postgres;

create index centroterminal_centro_fk_idx
    on centroterminal (centro_fk);

create index centroterminal_created_by_idx
    on centroterminal (created_by);

create index centroterminal_terminal_fk_idx
    on centroterminal (terminal_fk);

create index centroterminal_updated_by_idx
    on centroterminal (updated_by);

create table consumobasestandar
(
    id                bigserial
        primary key,
    producto_fk       bigint               not null
        constraint consumobasestandar_producto_fk
            references producto,
    centro_fk         bigint               not null
        constraint consumobasestandar_centro_fk
            references centro,
    cantidad_teorica  numeric(12, 4)       not null,
    cantidad_objetivo numeric(12, 4),
    unidadproducto_fk bigint               not null
        constraint consumobasestandar_unidadproducto_fk
            references unidad,
    unidadmaterial_fk bigint               not null
        constraint consumobasestandar_unidadmaterial_fk
            references unidad,
    activo            boolean default true not null,
    created           timestamp,
    updated           timestamp,
    created_by        bigint
        constraint consumobasestandar_created_by
            references usuario,
    updated_by        bigint
        constraint consumobasestandar_updated_by
            references usuario,
    recurso_fk        bigint               not null
        references producto,
    constraint unique_producto_centro_recurso
        unique (producto_fk, centro_fk, recurso_fk)
);

alter table consumobasestandar
    owner to postgres;

create table conversion
(
    id                bigserial
        primary key,
    unidadde          bigint           not null
        constraint conversion_unidadde_fk
            references unidad,
    unidada           bigint           not null
        constraint conversion_unidada_fk
            references unidad,
    ratio             double precision not null,
    centroproducto_fk bigint
        constraint conversion_centroproducto_fk
            references centroproducto,
    created           timestamp,
    updated           timestamp,
    created_by        bigint
        constraint conversion_created_by_fk
            references usuario,
    updated_by        bigint
        constraint conversion_updated_by_fk
            references usuario
);

alter table conversion
    owner to postgres;

create index conversion_centroproducto_fk_idx
    on conversion (centroproducto_fk);

create index conversion_created_by_idx
    on conversion (created_by);

create index conversion_unidada_fk_idx
    on conversion (unidada);

create index conversion_unidadde_fk_idx
    on conversion (unidadde);

create index conversion_updated_by_idx
    on conversion (updated_by);

create table dic_centro
(
    id              bigserial
        primary key,
    centro_fk       bigint
        constraint dic_centro_centro_fk
            references centro,
    lineaproduccion varchar(45) default NULL::character varying,
    created         timestamp,
    updated         timestamp,
    created_by      bigint
        constraint dic_centro_created_by_fk
            references usuario,
    updated_by      bigint
        constraint dic_centro_updated_by_fk
            references usuario
);

alter table dic_centro
    owner to postgres;

create index dic_centro_centro_fk_idx
    on dic_centro (centro_fk);

create index dic_centro_created_by_idx
    on dic_centro (created_by);

create index dic_centro_updated_by_idx
    on dic_centro (updated_by);

create table dic_centroalmacenubicacion
(
    id         bigserial
        primary key,
    centro_fk  bigint       not null
        constraint dic_centroalmacenubicacion_centro_fk
            references centro,
    almacen    varchar(100) not null,
    ubicacion  varchar(100) not null,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint dic_centroalmacenubicacion_created_by_fk
            references usuario,
    updated_by bigint
        constraint dic_centroalmacenubicacion_updated_by_fk
            references usuario
);

alter table dic_centroalmacenubicacion
    owner to postgres;

create index dic_centroalmacenubicacion_centro_fk_idx
    on dic_centroalmacenubicacion (centro_fk);

create index dic_centroalmacenubicacion_created_by_idx
    on dic_centroalmacenubicacion (created_by);

create index dic_centroalmacenubicacion_updated_by_idx
    on dic_centroalmacenubicacion (updated_by);

create table dic_centroorden_kpicalidad
(
    id             bigserial
        primary key,
    centroorden_fk bigint           not null
        constraint dic_centroorden_kpicalidad_uq
            unique
        constraint dic_centroorden_kpicalidad_centroorden_fk
            references centroorden,
    kpicalidad     double precision not null,
    created        timestamp,
    updated        timestamp,
    created_by     bigint
        constraint dic_centroorden_kpicalidad_created_by_fk
            references usuario,
    updated_by     bigint
        constraint dic_centroorden_kpicalidad_updated_by_fk
            references usuario,
    finicio        timestamp,
    ffin           timestamp
);

alter table dic_centroorden_kpicalidad
    owner to postgres;

create index dic_centroorden_kpicalidad_centroorden_fk_idx
    on dic_centroorden_kpicalidad (centroorden_fk);

create index dic_centroorden_kpicalidad_created_by_idx
    on dic_centroorden_kpicalidad (created_by);

create index dic_centroorden_kpicalidad_updated_by_idx
    on dic_centroorden_kpicalidad (updated_by);

create table energiaactividadcentro
(
    id           serial
        primary key,
    actividad_fk bigint                     not null
        constraint energiaactividadcentro_actividad_fk
            references energiaactividad,
    centro_fk    bigint                     not null
        constraint energiaactividadcentro_centro_fk
            references centro,
    coeficiente  double precision default 0 not null,
    created      timestamp,
    updated      timestamp,
    created_by   bigint
        constraint energiaactividadcentro_created_by_fk
            references usuario,
    updated_by   bigint
        constraint energiaactividadcentro_updated_by_fk
            references usuario
);

alter table energiaactividadcentro
    owner to postgres;

create index energiaactividadcentro_actividad_fk_idx
    on energiaactividadcentro (actividad_fk);

create index energiaactividadcentro_centro_fk_idx
    on energiaactividadcentro (centro_fk);

create index energiaactividadcentro_created_by_idx
    on energiaactividadcentro (created_by);

create index energiaactividadcentro_updated_by_idx
    on energiaactividadcentro (updated_by);

create table energiaactividadmedidacentro
(
    id         bigserial
        primary key,
    medida_fk  bigint not null
        constraint energiaactividadmedidacentro_medida_fk
            references energiaactividadmedida
            on delete cascade,
    centro_fk  bigint not null
        constraint energiaactividadmedidacentro_centro_fk
            references centro,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint energiaactividadmedidacentro_created_by_fk
            references usuario,
    updated_by bigint
        constraint energiaactividadmedidacentro_updated_by_fk
            references usuario
);

alter table energiaactividadmedidacentro
    owner to postgres;

create index energiaactividadmedidacentro_centro_fk_idx
    on energiaactividadmedidacentro (centro_fk);

create index energiaactividadmedidacentro_created_by_idx
    on energiaactividadmedidacentro (created_by);

create index energiaactividadmedidacentro_medida_fk_idx
    on energiaactividadmedidacentro (medida_fk);

create index energiaactividadmedidacentro_updated_by_idx
    on energiaactividadmedidacentro (updated_by);

create table energiacontador
(
    id                       bigserial
        primary key,
    nombre                   varchar(45)                    not null,
    vbleindustrialvalor_fk   bigint
        constraint energiacontador_vbleindustrialvalor_fk
            references variable_industrial,
    vbleindustrialreparto_fk bigint
        constraint energiacontador_vbleindustrialreparto_fk
            references variable_industrial,
    conectado                boolean          default false not null,
    valoropcactual           double precision default 0     not null,
    fechaopcactual           timestamp,
    tipo_fk                  bigint                         not null
        constraint energiacontador_tipo_fk
            references energiacontadortipo,
    created                  timestamp,
    updated                  timestamp,
    created_by               bigint
        constraint energiacontador_created_by_fk
            references usuario,
    updated_by               bigint
        constraint energiacontador_updated_by_fk
            references usuario
);

alter table energiacontador
    owner to postgres;

create index energiacontador_created_by_idx
    on energiacontador (created_by);

create index energiacontador_tipo_fk_idx
    on energiacontador (tipo_fk);

create index energiacontador_updated_by_idx
    on energiacontador (updated_by);

create index energiacontador_vbleindustrialreparto_fk_idx
    on energiacontador (vbleindustrialreparto_fk);

create index energiacontador_vbleindustrialvalor_fk_idx
    on energiacontador (vbleindustrialvalor_fk);

create table energiacontador_energiacontadorgrupo
(
    energiacontadorgrupo_id bigint                     not null
        constraint energiacontador_energiacontadorgrupo_grupo_fk
            references energiacontadorgrupo,
    energiacontador_id      bigint                     not null
        constraint energiacontador_energiacontadorgrupo_contador_fk
            references energiacontador,
    coeficiente             double precision default 0 not null,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint
        constraint energiacontador_energiacontadorgrupo_created_by_fk
            references usuario,
    updated_by              bigint
        constraint energiacontador_energiacontadorgrupo_updated_by_fk
            references usuario,
    primary key (energiacontadorgrupo_id, energiacontador_id)
);

alter table energiacontador_energiacontadorgrupo
    owner to postgres;

create index energiacontador_energiacontadorgrupo_contador_idx
    on energiacontador_energiacontadorgrupo (energiacontador_id);

create index energiacontador_energiacontadorgrupo_created_by_idx
    on energiacontador_energiacontadorgrupo (created_by);

create index energiacontador_energiacontadorgrupo_grupo_idx
    on energiacontador_energiacontadorgrupo (energiacontadorgrupo_id);

create index energiacontador_energiacontadorgrupo_updated_by_idx
    on energiacontador_energiacontadorgrupo (updated_by);

create table energiacontadoratributo
(
    id                bigserial
        primary key,
    contador_fk       bigint                     not null
        constraint energiacontadoratributo_contador_fk
            references energiacontador,
    tipoatributo_fk   bigint                     not null
        constraint energiacontadoratributo_tipoatributo_fk
            references energiacontadortipoatributo,
    vbleindustrial_fk bigint
        constraint energiacontadoratributo_vbleindustrial_fk
            references variable_industrial,
    valoropcactual    double precision default 0 not null,
    created           timestamp,
    updated           timestamp,
    created_by        bigint
        constraint energiacontadoratributo_created_by_fk
            references usuario,
    updated_by        bigint
        constraint energiacontadoratributo_updated_by_fk
            references usuario
);

alter table energiacontadoratributo
    owner to postgres;

create index energiacontadoratributo_contador_fk_idx
    on energiacontadoratributo (contador_fk);

create index energiacontadoratributo_created_by_idx
    on energiacontadoratributo (created_by);

create index energiacontadoratributo_tipoatributo_fk_idx
    on energiacontadoratributo (tipoatributo_fk);

create index energiacontadoratributo_updated_by_idx
    on energiacontadoratributo (updated_by);

create index energiacontadoratributo_vbleindustrial_fk_idx
    on energiacontadoratributo (vbleindustrial_fk);

create table energiamedida
(
    id                     bigserial
        primary key,
    contador_fk            bigint                         not null
        constraint energiamedida_contador_fk
            references energiacontador,
    fechainicio            timestamp                      not null,
    fechafin               timestamp                      not null,
    duracion               double precision default 0     not null,
    fechajornada           timestamp                      not null,
    turno_fk               bigint                         not null
        constraint energiamedida_turno_fk
            references turno,
    valoropc               double precision default 0     not null,
    valor                  double precision default 0     not null,
    valorreparto           integer          default 0     not null,
    unidad_fk              bigint                         not null
        constraint energiamedida_unidad_fk
            references unidad,
    historico              boolean          default false not null,
    actualizacionactividad boolean          default true  not null,
    created                timestamp,
    updated                timestamp,
    created_by             bigint
        constraint energiamedida_created_by_fk
            references usuario,
    updated_by             bigint
        constraint energiamedida_updated_by_fk
            references usuario
);

alter table energiamedida
    owner to postgres;

create index energiamedida_contador_fk_idx
    on energiamedida (contador_fk);

create index energiamedida_created_by_idx
    on energiamedida (created_by);

create index energiamedida_fechafin_idx
    on energiamedida (fechafin);

create index energiamedida_fechainicio_idx
    on energiamedida (fechainicio);

create index energiamedida_turno_fk_idx
    on energiamedida (turno_fk);

create index energiamedida_unidad_fk_idx
    on energiamedida (unidad_fk);

create index energiamedida_updated_by_idx
    on energiamedida (updated_by);

create table energiamedida_energiacontadoratributo
(
    energiamedida_id           bigint                     not null
        constraint energiamedida_energiacontadoratributo_medida_fk
            references energiamedida,
    energiacontadoratributo_id bigint                     not null
        constraint energiamedida_energiacontadoratributo_atributo_fk
            references energiacontadoratributo,
    valoropc                   double precision default 0 not null,
    valor                      double precision default 0 not null,
    unidad_fk                  bigint                     not null
        constraint energiamedida_energiacontadoratributo_unidad_fk
            references unidad,
    created                    timestamp,
    updated                    timestamp,
    created_by                 bigint
        constraint energiamedida_energiacontadoratributo_created_by_fk
            references usuario,
    updated_by                 bigint
        constraint energiamedida_energiacontadoratributo_updated_by_fk
            references usuario,
    primary key (energiamedida_id, energiacontadoratributo_id)
);

alter table energiamedida_energiacontadoratributo
    owner to postgres;

create index energiamedida_energiacontadoratributo_atributo_idx
    on energiamedida_energiacontadoratributo (energiacontadoratributo_id);

create index energiamedida_energiacontadoratributo_created_by_idx
    on energiamedida_energiacontadoratributo (created_by);

create index energiamedida_energiacontadoratributo_medida_idx
    on energiamedida_energiacontadoratributo (energiamedida_id);

create index energiamedida_energiacontadoratributo_unidad_fk_idx
    on energiamedida_energiacontadoratributo (unidad_fk);

create index energiamedida_energiacontadoratributo_updated_by_idx
    on energiamedida_energiacontadoratributo (updated_by);

create table equipopropiedad
(
    id                      bigserial
        primary key,
    equipo_fk               bigint not null
        constraint equipopropiedad_equipo_fk
            references equipo,
    equipoclasepropiedad_fk bigint
        constraint equipopropiedad_equipoclasepropiedad_fk
            references equipoclasepropiedad,
    valor                   varchar(150)     default NULL::character varying,
    unidad                  varchar(50)      default NULL::character varying,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint
        constraint equipopropiedad_created_by_fk
            references usuario,
    updated_by              bigint
        constraint equipopropiedad_updated_by_fk
            references usuario,
    variable_industrial_fk  bigint
        constraint equipopropiedad_variable_industrial_fk
            references variable_industrial,
    factor_multiplicativo   double precision default 1.0,
    factor_offset           double precision default 0.0,
    constraint equipopropiedad_equipo_clasepropiedad_uq
        unique (equipo_fk, equipoclasepropiedad_fk)
);

alter table equipopropiedad
    owner to postgres;

create index equipopropiedad_created_by_idx
    on equipopropiedad (created_by);

create index equipopropiedad_equipo_fk_idx
    on equipopropiedad (equipo_fk);

create index equipopropiedad_equipoclasepropiedad_fk_idx
    on equipopropiedad (equipoclasepropiedad_fk);

create index equipopropiedad_updated_by_idx
    on equipopropiedad (updated_by);

create table equipopropiedadvalor
(
    id                    bigserial,
    variableindustrial_fk bigint                   not null
        constraint equipopropiedadvalor_variable_fk
            references variable_industrial,
    fecha                 timestamp with time zone not null,
    valor_double          double precision,
    valor_string          varchar(200),
    created               timestamp,
    created_by            bigint
        constraint equipopropiedadvalor_created_by
            references usuario,
    primary key (id, fecha)
);

alter table equipopropiedadvalor
    owner to postgres;

create index equipopropiedadvalor_fecha_idx
    on equipopropiedadvalor (fecha desc);

create index idx_equipopropiedadvalor_variable_fecha
    on equipopropiedadvalor (variableindustrial_fk asc, fecha desc);

create table eventodisparador
(
    id                      bigserial
        primary key,
    opcnodo_fk              bigint
        constraint eventodisparador_opcnodo_fk
            references opcnodo,
    opcnodoconfirmacion_fk  bigint
        constraint eventodisparador_opcnodoconfirmacion_fk
            references opcnodo,
    estado_fk               bigint
        constraint eventodisparador_estado_fk
            references estado,
    puntoestandarizacion_fk bigint
        constraint eventodisparador_puntoestandarizacion_fk
            references puntoestandarizacion,
    tipo                    varchar(45) default NULL::character varying,
    centro_fk               bigint
        constraint eventodisparador_centro_fk
            references centro,
    centroatributo_fk       bigint
        constraint eventodisparador_centroatributo_fk
            references centroatributo,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint
        constraint eventodisparador_created_by_fk
            references usuario,
    updated_by              bigint
        constraint eventodisparador_updated_by_fk
            references usuario
);

alter table eventodisparador
    owner to postgres;

create index eventodisparador_centro_fk_idx
    on eventodisparador (centro_fk);

create index eventodisparador_centroatributo_fk_idx
    on eventodisparador (centroatributo_fk);

create index eventodisparador_created_by_idx
    on eventodisparador (created_by);

create index eventodisparador_estado_fk_idx
    on eventodisparador (estado_fk);

create index eventodisparador_opcnodo_fk_idx
    on eventodisparador (opcnodo_fk);

create index eventodisparador_opcnodoconfirmacion_fk_idx
    on eventodisparador (opcnodoconfirmacion_fk);

create index eventodisparador_puntoestandarizacion_fk_idx
    on eventodisparador (puntoestandarizacion_fk);

create index eventodisparador_updated_by_idx
    on eventodisparador (updated_by);

create table eventovalor
(
    id                  bigserial
        primary key,
    fecha               timestamp,
    valoralarma         boolean,
    valorid             varchar(45) default NULL::character varying,
    eventodisparador_fk bigint
        constraint eventovalor_eventodisparador_fk
            references eventodisparador,
    created             timestamp,
    updated             timestamp,
    created_by          bigint
        constraint eventovalor_created_by_fk
            references usuario,
    updated_by          bigint
        constraint eventovalor_updated_by_fk
            references usuario
);

alter table eventovalor
    owner to postgres;

create index eventovalor_created_by_idx
    on eventovalor (created_by);

create index eventovalor_eventodisparador_fk_idx
    on eventovalor (eventodisparador_fk);

create index eventovalor_updated_by_idx
    on eventovalor (updated_by);

create table ficherointercambiolinea
(
    id                       bigserial
        primary key,
    nombrefichero            varchar(50)  default NULL::character varying,
    linea                    varchar(500) default NULL::character varying,
    error                    boolean      default false,
    errordescripcion         varchar(150) default NULL::character varying,
    procesado                boolean      default false,
    fechaproceso             timestamp,
    campoorden               varchar(55)  default NULL::character varying,
    campoproducto            varchar(55)  default NULL::character varying,
    campofechamedida         varchar(55)  default NULL::character varying,
    campovalormedida         varchar(55)  default NULL::character varying,
    campoatributonumeropalet varchar(55)  default NULL::character varying,
    campolineaproduccion     varchar(45)  default NULL::character varying,
    centroorden_fk           bigint
        constraint ficherointercambiolinea_centroorden_fk
            references centroorden,
    producto_fk              bigint
        constraint ficherointercambiolinea_producto_fk
            references producto,
    fechamedida              timestamp,
    valormedida              bigint,
    atributonumeropalet      varchar(20)  default NULL::character varying,
    created                  timestamp,
    updated                  timestamp,
    created_by               bigint
        constraint ficherointercambiolinea_created_by_fk
            references usuario,
    updated_by               bigint
        constraint ficherointercambiolinea_updated_by_fk
            references usuario
);

alter table ficherointercambiolinea
    owner to postgres;

create index ficherointercambiolinea_centroorden_fk_idx
    on ficherointercambiolinea (centroorden_fk);

create index ficherointercambiolinea_created_by_idx
    on ficherointercambiolinea (created_by);

create index ficherointercambiolinea_fechamedida_idx
    on ficherointercambiolinea (fechamedida);

create index ficherointercambiolinea_producto_fk_idx
    on ficherointercambiolinea (producto_fk);

create index ficherointercambiolinea_updated_by_idx
    on ficherointercambiolinea (updated_by);

create table ficherointercambiolineahistorico
(
    id                       bigserial
        primary key,
    nombrefichero            varchar(50)  default NULL::character varying,
    linea                    varchar(500) default NULL::character varying,
    error                    boolean      default false,
    errordescripcion         varchar(100) default NULL::character varying,
    procesado                boolean      default false,
    fechaproceso             timestamp,
    campoorden               varchar(20)  default NULL::character varying,
    campofechamedida         varchar(20)  default NULL::character varying,
    campovalormedida         varchar(20)  default NULL::character varying,
    campoatributonumeropalet varchar(20)  default NULL::character varying,
    centroorden_fk           bigint
        constraint ficherointercambiolineahistorico_centroorden_fk
            references centroorden,
    fechamedida              timestamp,
    valormedida              bigint,
    atributonumeropalet      varchar(20)  default NULL::character varying,
    created                  timestamp,
    updated                  timestamp,
    created_by               bigint
        constraint ficherointercambiolineahistorico_created_by_fk
            references usuario,
    updated_by               bigint
        constraint ficherointercambiolineahistorico_updated_by_fk
            references usuario
);

alter table ficherointercambiolineahistorico
    owner to postgres;

create index ficherointercambiolineahistorico_centroorden_fk_idx
    on ficherointercambiolineahistorico (centroorden_fk);

create index ficherointercambiolineahistorico_created_by_idx
    on ficherointercambiolineahistorico (created_by);

create index ficherointercambiolineahistorico_updated_by_idx
    on ficherointercambiolineahistorico (updated_by);

create table formacionpuestotrabajocentro
(
    id               bigserial
        primary key,
    centro_fk        bigint            not null
        constraint formacionpuestotrabajocentro_centro_fk
            references centro,
    puestotrabajo_fk bigint            not null
        constraint formacionpuestotrabajocentro_puestotrabajo_fk
            references formacionpuestotrabajo,
    numeropuestos    integer default 0 not null,
    activo           boolean,
    created          timestamp,
    updated          timestamp,
    created_by       bigint
        constraint formacionpuestotrabajocentro_created_by_fk
            references usuario,
    updated_by       bigint
        constraint formacionpuestotrabajocentro_updated_by_fk
            references usuario,
    constraint formacionpuestotrabajocentro_uq
        unique (centro_fk, puestotrabajo_fk)
);

alter table formacionpuestotrabajocentro
    owner to postgres;

create index formacionpuestotrabajocentro_centro_fk_idx
    on formacionpuestotrabajocentro (centro_fk);

create index formacionpuestotrabajocentro_created_by_idx
    on formacionpuestotrabajocentro (created_by);

create index formacionpuestotrabajocentro_puestotrabajo_fk_idx
    on formacionpuestotrabajocentro (puestotrabajo_fk);

create index formacionpuestotrabajocentro_updated_by_idx
    on formacionpuestotrabajocentro (updated_by);

create table log
(
    id          bigserial
        primary key,
    fecha       timestamp,
    accion      varchar(255) default NULL::character varying,
    descripcion text,
    cenfro_fk   bigint
        constraint log_cenfro_fk
            references centro,
    severidad   varchar,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table log
    owner to postgres;

create table medida
(
    id                        bigserial
        primary key,
    finicio                   timestamp,
    ffin                      timestamp,
    valormedida               double precision default 0,
    centroestado_fk           bigint
        constraint medida_centroestado_fk
            references centroestado,
    centroproducto_fk         bigint
        constraint medida_centroproducto_fk
            references centroproducto,
    grupo                     varchar(45)      default NULL::character varying,
    incidencia                varchar(255)     default NULL::character varying,
    justificacion             varchar(255)     default NULL::character varying,
    justificada               boolean          default false not null,
    orden                     varchar(255)     default NULL::character varying,
    tipomedida                varchar(255)     default NULL::character varying,
    valoropc                  double precision default 0     not null,
    valorideal                bigint           default 0     not null,
    valorobjetivo             bigint           default 0     not null,
    valornarmario             varchar(255)     default NULL::character varying,
    valornpalet               varchar(255)     default NULL::character varying,
    valorpesomedio            varchar(255)     default NULL::character varying,
    valornplacas              varchar(255)     default NULL::character varying,
    valorfaltapeso            varchar(255)     default NULL::character varying,
    valorgruesas              varchar(255)     default NULL::character varying,
    turno_fk                  bigint
        constraint medida_turno_fk
            references turno,
    duracion                  double precision default 0     not null,
    automatica                boolean,
    valormedidaxmin           double precision,
    umbralmaxxmin             double precision default 0     not null,
    umbralminxmin             double precision default 0     not null,
    ordensuperada             boolean          default false not null,
    centroorden_fk            bigint
        constraint medida_centroorden_fk
            references centroorden,
    inconsistenciacentroorden boolean          default false,
    created                   timestamp,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint,
    operario_fk               bigint
        constraint medida_operario_fk
            references operario,
    operarioresponsable_fk    bigint
        constraint medida_operarioresponsable_fk
            references operario,
    documento                 varchar(20)      default NULL::character varying,
    lote                      varchar(45)      default NULL::character varying,
    documentoanulado          varchar(20)      default NULL::character varying,
    centro_fk                 bigint,
    cerrada                   boolean,
    "abierta_estados_Key"     varchar(255) generated always as (
        CASE
            WHEN (((tipomedida)::text = 'estados'::text) AND (ffin IS NULL) AND (cerrada = false))
                THEN ('ESTADOS_'::text || (centro_fk)::text)
            ELSE NULL::text
            END) stored
);

alter table medida
    owner to postgres;

create table incidencia_old
(
    id                           bigserial
        primary key,
    fechaapertura                timestamp,
    centro_fk                    bigint
        constraint incidencia_old_centro_fk
            references centro,
    orden                        varchar(45)  default NULL::character varying,
    duracion                     bigint,
    incidenciatipo_fk            bigint
        constraint incidencia_old_incidenciatipo_fk
            references incidenciatipo,
    operario_fk                  bigint
        constraint incidencia_old_operario_fk
            references operario,
    descripcion                  varchar(500) default NULL::character varying,
    acciones                     varchar(500) default NULL::character varying,
    estado                       enum_incidencia_old_estado,
    medida_fk                    bigint
        constraint incidencia_old_medida_fk
            references medida,
    calidadcontrol_fk            bigint
        constraint incidencia_old_calidadcontrol_fk
            references calidadcontrol,
    puntoestandarizacionvalor_fk bigint,
    operarioafectado_fk          bigint
        constraint incidencia_old_operarioafectado_fk
            references operario,
    fechacierre                  timestamp,
    created                      timestamp,
    updated                      timestamp,
    created_by                   bigint,
    updated_by                   bigint
);

alter table incidencia_old
    owner to postgres;

create index idx_medida_centroestado
    on medida (centroestado_fk);

create index idx_medida_centroorden
    on medida (centroorden_fk);

create index idx_medida_centroproducto
    on medida (centroproducto_fk);

create index idx_medida_composite_group
    on medida (centroorden_fk, centroestado_fk, grupo, turno_fk, operarioresponsable_fk, centroproducto_fk);

create index idx_medida_estados_covering
    on medida (tipomedida, grupo, centroorden_fk) include (finicio, ffin, id, valormedida, duracion, centroestado_fk, turno_fk, operarioresponsable_fk, centroproducto_fk)
    where ((tipomedida)::text = 'estados'::text);

create index idx_medida_fechas_centroproducto
    on medida (finicio, ffin, centroproducto_fk);

create index idx_medida_operario
    on medida (operario_fk);

create index idx_medida_produccion_covering
    on medida (tipomedida, centroorden_fk) include (valormedida)
    where ((tipomedida)::text = ANY
           (ARRAY [('produccion'::character varying)::text, ('cantidadDesechada'::character varying)::text]));

create index idx_medida_tipomedida_centroorden_fechas
    on medida (tipomedida, centroorden_fk, ffin, finicio);

create index idx_medida_tipomedida_grupo
    on medida (tipomedida, grupo) include (finicio, ffin, duracion, centroestado_fk, centroorden_fk, turno_fk, operarioresponsable_fk);

create index idx_medida_turno
    on medida (turno_fk);

create table medidaatributo
(
    id             bigserial
        primary key,
    medida_fk      bigint
        constraint medidaatributo_medida_fk
            references medida,
    atributo_fk    bigint
        constraint medidaatributo_atributo_fk
            references centroatributo,
    valor          varchar(100) default NULL::character varying,
    nombreatributo varchar(100) default NULL::character varying,
    nsecuencia     integer,
    descripcion    varchar(45)  default NULL::character varying,
    created        timestamp,
    updated        timestamp,
    created_by     bigint,
    updated_by     bigint
);

alter table medidaatributo
    owner to postgres;

create table medidaatributoautocompletar
(
    id          bigserial
        primary key,
    atributo_fk bigint
        constraint medidaatributoautocompletar_atributo_fk
            references centroatributo,
    valor       varchar(100) default NULL::character varying,
    descripcion varchar(255) default NULL::character varying,
    created     date,
    updated     date,
    created_by  bigint,
    updated_by  bigint
);

alter table medidaatributoautocompletar
    owner to postgres;

create table medidahist
(
    id                          bigserial
        primary key,
    estado_fk                   bigint                     not null
        constraint medidahist_estado_fk
            references estado,
    estadotipo_fk               bigint                     not null
        constraint medidahist_estadotipo_fk
            references estadotipo,
    centro_fk                   bigint                     not null
        constraint medidahist_centro_fk
            references centro,
    producto_fk                 bigint                     not null
        constraint medidahist_producto_fk
            references producto,
    turno_fk                    bigint                     not null
        constraint medidahist_turno_fk
            references turno,
    fechajornada                timestamp,
    centroorden_fk              bigint
        constraint medidahist_centroorden_fk
            references centroorden,
    finicio                     timestamp                  not null,
    ffin                        timestamp                  not null,
    grupo                       varchar(45)      default NULL::character varying,
    orden                       varchar(255)     default NULL::character varying,
    cantidad                    double precision default 0 not null,
    unidadconteo_fk             bigint
        constraint medidahist_unidadconteo_fk
            references unidad,
    unidadprincipal_fk          bigint
        constraint medidahist_unidadprincipal_fk
            references unidad,
    unidadsecundaria_fk         bigint
        constraint medidahist_unidadsecundaria_fk
            references unidad,
    unidadeficiencia_fk         bigint
        constraint medidahist_unidadeficiencia_fk
            references unidad,
    ratioconteoprincipal        double precision default 1,
    ratioprincipalsecundaria    double precision default 0,
    ratioprincipaleficiencia    double precision default 1,
    duracion                    double precision,
    justificada                 boolean,
    justificacion               varchar(255)     default NULL::character varying,
    toperacional                double precision,
    tproduccion                 double precision,
    tproductivo                 double precision,
    tfallo                      double precision,
    tparorutinario              double precision,
    tnoplanificado              double precision,
    tefectivo                   double precision,
    tobjetivo                   double precision,
    tmaximo                     integer          default 0,
    talarma                     double precision default 0 not null,
    talarmatotal                double precision default 0 not null,
    numalarmas                  integer          default 0 not null,
    numalarmastotal             integer          default 0 not null,
    vobjetivo                   double precision default 0,
    vteoria                     double precision default 0,
    rvelocidad                  double precision,
    rvelocidadobj               double precision,
    dpobjetivo                  double precision default 0,
    doobjetivo                  double precision default 0,
    epobjetivo                  double precision default 0,
    eoobjetivo                  double precision default 0,
    cantidadobjep               double precision,
    cantidadobjeo               double precision,
    created                     timestamp,
    updated                     timestamp,
    created_by                  bigint,
    updated_by                  bigint,
    dp                          double precision,
    dop                         double precision,
    ep                          double precision,
    eo                          double precision,
    cantidadretrasoep           double precision,
    cantidadretrasoeo           double precision,
    toperacionalobj             double precision,
    tproductivoobj              double precision,
    duracionretrasoep           double precision,
    duracionretrasoeo           double precision,
    operario_fk                 bigint
        constraint medidahist_operario_fk
            references operario,
    operarioresponsable_fk      bigint
        constraint medidahist_operarioresponsable_fk
            references operario,
    revisada                    boolean          default false,
    prodestandar                double precision default 0,
    unidadproductividad_fk      bigint
        constraint medidahist_unidadproductividad_fk
            references unidad,
    ratioprincipalproductividad double precision default 1,
    tipotiempoeficiencia        varchar(45)      default 'horas'::character varying,
    cantidaddesechada           double precision default 0 not null,
    calidadobjetivo             double precision default 1,
    calidadreal                 double precision default 1 not null,
    duracionmicroparada         double precision,
    tnooperativo                double precision default 0,
    tnoplanificadoconocupacion  double precision default 0,
    ratioprincipalauxiliar      double precision default 0,
    unidadauxiliar_fk           integer
);

alter table medidahist
    owner to postgres;

create table centroalarmahist
(
    id            bigserial
        primary key,
    centro_fk     bigint           not null
        constraint centroalarmahist_centro_fk
            references centro,
    estado_fk     bigint           not null
        constraint centroalarmahist_estado_fk
            references estado,
    fechainicio   timestamp        not null,
    fechafin      timestamp        not null,
    duracion      bigint default 0 not null,
    created       timestamp,
    updated       timestamp,
    created_by    bigint
        constraint centroalarmahist_created_by_fk
            references usuario,
    updated_by    bigint
        constraint centroalarmahist_updated_by_fk
            references usuario,
    medidahist_fk bigint
        constraint centroalarmahist_medidahist_fk
            references medidahist
);

alter table centroalarmahist
    owner to postgres;

create index centroalarmahist_centro_fk_idx
    on centroalarmahist (centro_fk);

create index centroalarmahist_created_by_idx
    on centroalarmahist (created_by);

create index centroalarmahist_estado_fk_idx
    on centroalarmahist (estado_fk);

create index centroalarmahist_fechafin_idx
    on centroalarmahist (fechafin);

create index centroalarmahist_fechainicio_idx
    on centroalarmahist (fechainicio);

create index centroalarmahist_medidahist_fk_idx
    on centroalarmahist (medidahist_fk);

create index centroalarmahist_updated_by_idx
    on centroalarmahist (updated_by);

create table medidadesechadahist
(
    id                        bigserial
        primary key,
    medidahist_fk             bigint
        constraint medidadesechadahist_medidahist_fk
            references medidahist,
    finicio                   timestamp        default '1970-01-01 00:00:00'::timestamp without time zone not null,
    ffin                      timestamp        default '1970-01-01 00:00:00'::timestamp without time zone not null,
    valormedida               double precision default 0,
    estado_fk                 bigint
        constraint medidadesechadahist_estado_fk
            references estado,
    centro_fk                 bigint
        constraint medidadesechadahist_centro_fk
            references centro,
    producto_fk               bigint
        constraint medidadesechadahist_producto_fk
            references producto,
    vlimite                   double precision default 0                                                  not null,
    vobjetivo                 double precision default 0                                                  not null,
    vteoria                   double precision default 0                                                  not null,
    disponibilidad            double precision,
    prodobjetivo              double precision default 0,
    turno_fk                  bigint
        constraint medidadesechadahist_turno_fk
            references turno,
    grupo                     varchar(45)      default NULL::character varying,
    incidencia                varchar(255)     default NULL::character varying,
    justificacion             varchar(255)     default NULL::character varying,
    justificada               boolean          default false                                              not null,
    orden                     varchar(255)     default NULL::character varying,
    tipomedida                varchar(255)     default NULL::character varying,
    valoropc                  bigint           default 0                                                  not null,
    valorideal                bigint           default 0                                                  not null,
    valorobjetivo             bigint           default 0                                                  not null,
    valornarmario             varchar(255)     default NULL::character varying,
    valornpalet               varchar(255)     default NULL::character varying,
    valorpesomedio            varchar(255)     default NULL::character varying,
    valornplacas              varchar(255)     default NULL::character varying,
    valorfaltapeso            varchar(255)     default NULL::character varying,
    valorgruesas              varchar(255)     default NULL::character varying,
    duracion                  double precision,
    automatica                boolean,
    valormedidaxmin           double precision,
    umbralmaxxmin             double precision,
    umbralminxmin             double precision,
    ordensuperada             boolean,
    centroorden_fk            bigint
        constraint medidadesechadahist_centroorden_fk
            references centroorden,
    inconsistenciacentroorden boolean          default false,
    created                   timestamp,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table medidadesechadahist
    owner to postgres;

create table medidadesechadaatributohist
(
    id                     bigserial
        primary key,
    medidadesechadahist_fk bigint
        constraint medidadesechadaatributohist_medidadesechadahist_fk
            references medidadesechadahist,
    atributo_fk            bigint
        constraint medidadesechadaatributohist_atributo_fk
            references centroatributo,
    valor                  varchar(100) default NULL::character varying,
    nombreatributo         varchar(100) default NULL::character varying,
    nsecuencia             integer,
    descripcion            varchar(45)  default NULL::character varying,
    created                timestamp,
    updated                timestamp,
    created_by             bigint,
    updated_by             bigint
);

alter table medidadesechadaatributohist
    owner to postgres;

create index idx_medidadesechadahist_orden_finicio
    on medidadesechadahist (centroorden_fk, finicio, tipomedida) include (valormedida);

create index idx_medidadesechadahist_orden_finicio_desech
    on medidadesechadahist (centroorden_fk, finicio) include (valormedida);

create table medidaestadohist
(
    id                        bigserial
        primary key,
    medidahist_fk             bigint
        constraint medidaestadohist_medidahist_fk
            references medidahist,
    finicio                   timestamp,
    ffin                      timestamp,
    valormedida               bigint           default 0,
    estado_fk                 bigint
        constraint medidaestadohist_estado_fk
            references estado,
    centro_fk                 bigint
        constraint medidaestadohist_centro_fk
            references centro,
    producto_fk               bigint
        constraint medidaestadohist_producto_fk
            references producto,
    vlimite                   double precision default 0     not null,
    vobjetivo                 double precision default 0     not null,
    vteoria                   double precision default 0     not null,
    disponibilidad            double precision,
    prodobjetivo              double precision default 0,
    turno_fk                  bigint
        constraint medidaestadohist_turno_fk
            references turno,
    grupo                     varchar(45)      default NULL::character varying,
    incidencia                varchar(255)     default NULL::character varying,
    justificacion             varchar(255)     default NULL::character varying,
    justificada               boolean          default false not null,
    orden                     varchar(255)     default NULL::character varying,
    tipomedida                varchar(255)     default NULL::character varying,
    valoropc                  bigint           default 0     not null,
    valorideal                bigint           default 0     not null,
    valorobjetivo             bigint           default 0     not null,
    valornarmario             varchar(255)     default NULL::character varying,
    valornpalet               varchar(255)     default NULL::character varying,
    valorpesomedio            varchar(255)     default NULL::character varying,
    valornplacas              varchar(255)     default NULL::character varying,
    valorfaltapeso            varchar(255)     default NULL::character varying,
    valorgruesas              varchar(255)     default NULL::character varying,
    duracion                  double precision,
    automatica                boolean,
    valormedidaxmin           double precision,
    umbralmaxxmin             double precision,
    umbralminxmin             double precision,
    ordensuperada             boolean,
    centroorden_fk            bigint
        constraint medidaestadohist_centroorden_fk
            references centroorden,
    inconsistenciacentroorden boolean          default false,
    created                   timestamp,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table medidaestadohist
    owner to postgres;

create index idx_medidaestadohist_medida_covering
    on medidaestadohist (medidahist_fk) include (finicio, ffin, valormedida, turno_fk, centroorden_fk, valoropc);

create index idx_medidahist_centro_fecha_covering
    on medidahist (centro_fk, finicio, ffin) include (id, duracion, cantidad, cantidaddesechada, producto_fk, centroorden_fk, turno_fk, estadotipo_fk, estado_fk, fechajornada);

create index idx_medidahist_centroorden
    on medidahist (centroorden_fk);

create index idx_medidahist_centroorden_fecha
    on medidahist (centroorden_fk asc, finicio asc, ffin desc) include (centro_fk, cantidad, cantidaddesechada);

create index idx_medidahist_estado
    on medidahist (estado_fk);

create index idx_medidahist_estado_centro
    on medidahist (estado_fk, centro_fk);

create index idx_medidahist_estadotipo
    on medidahist (estadotipo_fk);

create index idx_medidahist_fechajornada
    on medidahist (fechajornada);

create index idx_medidahist_fechas
    on medidahist (finicio, ffin);

create index idx_medidahist_id_finicio
    on medidahist (id asc, finicio desc);

create index idx_medidahist_operarioresponsable
    on medidahist (operarioresponsable_fk);

create index idx_medidahist_producto
    on medidahist (producto_fk);

create index idx_medidahist_producto_fecha
    on medidahist (producto_fk asc, finicio asc, ffin desc) include (centro_fk, cantidad);

create index idx_medidahist_turno
    on medidahist (turno_fk);

create table medidahistenergiaactividadobjetivo
(
    medidahist_fk       bigint           not null
        constraint medidahistenergiaactividadobjetivo_medidahist_fk
            references medidahist,
    energiaactividad_fk bigint           not null
        constraint medidahistenergiaactividadobjetivo_energiaactividad_fk
            references energiaactividad,
    objetivo            double precision not null,
    created             date,
    updated             date,
    created_by          bigint,
    updated_by          bigint,
    primary key (medidahist_fk, energiaactividad_fk)
);

alter table medidahistenergiaactividadobjetivo
    owner to postgres;

create table medidaproduccionhist
(
    id                        bigserial
        primary key,
    medidahist_fk             bigint
        constraint medidaproduccionhist_medidahist_fk
            references medidahist,
    finicio                   timestamp                      not null,
    ffin                      timestamp                      not null,
    valormedida               double precision default 0,
    estado_fk                 bigint
        constraint medidaproduccionhist_estado_fk
            references estado,
    centro_fk                 bigint
        constraint medidaproduccionhist_centro_fk
            references centro,
    producto_fk               bigint
        constraint medidaproduccionhist_producto_fk
            references producto,
    vlimite                   double precision default 0     not null,
    vobjetivo                 double precision default 0     not null,
    vteoria                   double precision default 0     not null,
    disponibilidad            double precision,
    prodobjetivo              double precision default 0,
    turno_fk                  bigint
        constraint medidaproduccionhist_turno_fk
            references turno,
    grupo                     varchar(45)      default NULL::character varying,
    incidencia                varchar(255)     default NULL::character varying,
    justificacion             varchar(255)     default NULL::character varying,
    justificada               boolean          default false not null,
    orden                     varchar(255)     default NULL::character varying,
    tipomedida                varchar(255)     default NULL::character varying,
    valoropc                  double precision default 0,
    valorideal                bigint           default 0     not null,
    valorobjetivo             bigint           default 0     not null,
    valornarmario             varchar(255)     default NULL::character varying,
    valornpalet               varchar(255)     default NULL::character varying,
    valorpesomedio            varchar(255)     default NULL::character varying,
    valornplacas              varchar(255)     default NULL::character varying,
    valorfaltapeso            varchar(255)     default NULL::character varying,
    valorgruesas              varchar(255)     default NULL::character varying,
    duracion                  double precision,
    automatica                boolean,
    valormedidaxmin           double precision,
    umbralmaxxmin             double precision,
    umbralminxmin             double precision,
    ordensuperada             boolean,
    centroorden_fk            bigint
        constraint medidaproduccionhist_centroorden_fk
            references centroorden,
    inconsistenciacentroorden boolean          default false,
    created                   timestamp,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint,
    documento                 varchar(20)      default NULL::character varying,
    lote                      varchar(45)      default NULL::character varying,
    documentoanulado          varchar(20)      default NULL::character varying
);

alter table medidaproduccionhist
    owner to postgres;

create table medidaproduccionatributohist
(
    id             bigserial
        primary key,
    medida_fk      bigint
        constraint medidaproduccionatributohist_medida_fk
            references medidaproduccionhist,
    atributo_fk    bigint
        constraint medidaproduccionatributohist_atributo_fk
            references centroatributo,
    valor          varchar(100) default NULL::character varying,
    nombreatributo varchar(100) default NULL::character varying,
    nsecuencia     integer,
    descripcion    varchar(45)  default NULL::character varying,
    created        timestamp    default CURRENT_TIMESTAMP,
    updated        timestamp    default '1970-01-01 00:00:00'::timestamp without time zone,
    created_by     bigint,
    updated_by     bigint
);

alter table medidaproduccionatributohist
    owner to postgres;

create index idx_medidaproduccionhist_orden_finicio
    on medidaproduccionhist (centroorden_fk, finicio, tipomedida) include (valormedida);

create index idx_medidaproduccionhist_orden_finicio_prod
    on medidaproduccionhist (centroorden_fk, finicio) include (valormedida);

create table medidasubcentrohist
(
    id                   bigserial
        primary key,
    estado_fk            bigint                     not null
        constraint medidasubcentrohist_estado_fk
            references estado,
    estadotipo_fk        bigint                     not null
        constraint medidasubcentrohist_estadotipo_fk
            references estadotipo,
    centro_fk            bigint                     not null
        constraint medidasubcentrohist_centro_fk
            references centro,
    turno_fk             bigint                     not null
        constraint medidasubcentrohist_turno_fk
            references turno,
    fechajornada         timestamp,
    finicio              timestamp                  not null,
    ffin                 timestamp                  not null,
    grupo                varchar(45)      default NULL::character varying,
    orden                varchar(255)     default NULL::character varying,
    cantidad             bigint           default 0,
    unidadconteo_fk      bigint
        constraint medidasubcentrohist_unidadconteo_fk
            references unidad,
    operario_fk          bigint
        constraint medidasubcentrohist_operario_fk
            references operario,
    duracion             double precision,
    justificada          boolean,
    justificacion        varchar(255)     default NULL::character varying,
    toperacional         bigint,
    tproduccion          bigint,
    tproductivo          bigint,
    tfallo               bigint,
    tparorutinario       bigint,
    tnoplanificado       bigint,
    tobjetivo            double precision,
    tmaximo              integer          default 0,
    tipotiempoeficiencia varchar(45)      default 'horas'::character varying,
    cantidaddesechada    double precision default 0,
    calidadreal          double precision default 1 not null,
    created              timestamp,
    updated              timestamp,
    created_by           bigint,
    updated_by           bigint
);

alter table medidasubcentrohist
    owner to postgres;

create table observacion
(
    id                  bigserial
        primary key,
    tipo_fk             bigint
        constraint observacion_tipo_fk
            references observaciontipo,
    centro_fk           bigint
        constraint observacion_centro_fk
            references centro,
    fichero_fk          bigint
        constraint observacion_fichero_fk
            references fichero,
    operario_fk         bigint
        constraint observacion_operario_fk
            references operario,
    operarioafectado_fk bigint
        constraint observacion_operarioafectado_fk
            references operario,
    estado              varchar(50)  default NULL::character varying,
    norma               integer      default 0,
    constancianorma     integer      default 0,
    fechaapertura       timestamp,
    fechacierre         timestamp,
    descripcion         varchar(500) default NULL::character varying,
    acciones            varchar(500) default NULL::character varying,
    accionespreventivas varchar(500) default NULL::character varying,
    analisis            varchar(500) default NULL::character varying,
    responsable_fk      bigint
        constraint observacion_responsable_fk
            references usuario,
    usuario_fk          bigint
        constraint observacion_usuario_fk
            references usuario,
    created             timestamp,
    updated             timestamp,
    created_by          bigint,
    updated_by          bigint
);

alter table observacion
    owner to postgres;

create table observacionoperariogrupo
(
    id             bigserial
        primary key,
    observacion_fk bigint not null
        constraint observacionoperariogrupo_observacion_fk
            references observacion,
    operario_fk    bigint not null
        constraint observacionoperariogrupo_operario_fk
            references operario,
    created        timestamp,
    updated        timestamp,
    created_by     bigint,
    updated_by     bigint
);

alter table observacionoperariogrupo
    owner to postgres;

create table ordenestadohist
(
    id             bigserial
        primary key,
    centroorden_fk bigint
        constraint ordenestadohist_centroorden_fk
            references centroorden,
    ordenestado_fk bigint
        constraint ordenestadohist_ordenestado_fk
            references ordenestado,
    origen         varchar(50) default NULL::character varying,
    created        timestamp,
    updated        timestamp,
    created_by     bigint,
    updated_by     bigint
);

alter table ordenestadohist
    owner to postgres;

create table parte
(
    id                bigserial
        primary key,
    orden_fk          bigint                                               not null
        constraint parte_orden_fk
            references centroorden,
    unidad_fk         bigint                                               not null
        constraint parte_unidad_fk
            references unidad,
    usuario_fk        bigint
        constraint parte_usuario_fk
            references usuario,
    codigo            varchar(45)  default NULL::character varying,
    fechainicio       timestamp,
    fechafin          timestamp,
    cantidadorden     bigint,
    cantidadproducida double precision,
    cantidadreportada bigint,
    created           timestamp,
    updated           timestamp,
    created_by        bigint,
    updated_by        bigint,
    tipo              varchar(255) default 'produccion'::character varying not null
);

alter table parte
    owner to postgres;

create table parteeficiencia
(
    id                    bigint default nextval('parteeficiencia_id_seq'::regclass) not null
        primary key,
    parte_fk              bigint
        constraint parteeficiencia_parte_fk
            references parte,
    tiempoproduccion      bigint,
    tiempovelocidadlenta  bigint,
    tiempofallo           bigint,
    tiempototal           bigint,
    tiempoefectivo        bigint,
    tiempoparorutinario   bigint,
    tiempoexceso          bigint,
    velocidadmaxima       double precision,
    velocidadactual       double precision,
    velocidadobjetivo     double precision,
    cantidadvelocidadreal double precision,
    calidadobjetivo       double precision,
    doobjetivo            double precision,
    created               timestamp,
    updated               timestamp,
    created_by            bigint,
    updated_by            bigint
);

alter table parteeficiencia
    owner to postgres;

create table parteeficienciaatributo
(
    id                 bigint      default nextval('parteeficienciaatributo_id_seq'::regclass) not null
        primary key,
    parteeficiencia_fk bigint
        constraint parteeficienciaatributo_parteeficiencia_fk
            references parteeficiencia,
    atributo_fk        bigint
        constraint parteeficienciaatributo_atributo_fk
            references centroatributo,
    codigo             varchar(45) default NULL::character varying,
    cantidad           double precision,
    valor              varchar(45) default NULL::character varying,
    created            timestamp,
    updated            timestamp,
    created_by         bigint,
    updated_by         bigint
);

alter table parteeficienciaatributo
    owner to postgres;

create table partemermas
(
    id          bigint default nextval('partemermas_id_seq'::regclass) not null
        primary key,
    parte_fk    bigint
        constraint partemermas_parte_fk
            references parte,
    producto_fk bigint
        constraint partemermas_producto_fk
            references producto,
    valor       double precision,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table partemermas
    owner to postgres;

create table parteproductividad
(
    id                    bigint default nextval('parteproductividad_id_seq'::regclass) not null
        primary key,
    parte_fk              bigint                                                        not null
        constraint parteproductividad_parte_fk
            references parte,
    tiempotrabajoreal     bigint,
    tiempotrabajoobjetivo bigint,
    productividadreal     double precision,
    productividadobjetivo double precision,
    created               timestamp,
    updated               timestamp,
    created_by            bigint,
    updated_by            bigint
);

alter table parteproductividad
    owner to postgres;

create table parteproductividadoperario
(
    id                    bigint default nextval('parteproductividadoperario_id_seq'::regclass) not null
        primary key,
    parteproductividad_fk bigint
        constraint parteproductividadoperario_parteproductividad_fk
            references parteproductividad,
    operario_fk           bigint
        constraint parteproductividadoperario_operario_fk
            references operario,
    tipooperario_fk       bigint
        constraint parteproductividadoperario_tipooperario_fk
            references tipooperario,
    tiemporegistrado      bigint,
    created               timestamp,
    updated               timestamp,
    created_by            bigint,
    updated_by            bigint
);

alter table parteproductividadoperario
    owner to postgres;

create table planificacionproduccionlinea
(
    id                         bigserial
        primary key,
    planificacionproduccion_fk bigint                     not null,
    ordencodigo                varchar(45)                not null,
    ordenfecha                 timestamp,
    ordenestado                varchar(45)  default NULL::character varying,
    ordencantidad              bigint,
    ordensecuencia             bigint,
    centronombre               varchar(45)  default NULL::character varying,
    centro_fk                  bigint
        constraint planificacionproduccionlinea_centro_fk
            references centro,
    productocodigo             varchar(255) default NULL::character varying,
    productonombre             varchar(255) default NULL::character varying,
    producto_fk                bigint
        constraint planificacionproduccionlinea_producto_fk
            references producto,
    centroorden_fk             bigint
        constraint planificacionproduccionlinea_centroorden_fk
            references centroorden,
    error                      boolean      default false not null,
    errordescripcion           varchar(255) default NULL::character varying,
    ean13                      varchar(13)  default NULL::character varying,
    procesada                  boolean      default false not null,
    fechaproceso               timestamp,
    cantidadunidadprincipal    boolean      default true  not null,
    created                    timestamp,
    updated                    timestamp,
    created_by                 bigint,
    updated_by                 bigint
);

alter table planificacionproduccionlinea
    owner to postgres;

create table productividadasignacion
(
    id               bigserial
        primary key,
    planificacion_fk bigint
        constraint productividadasignacion_planificacion_fk
            references productividadplanificacion,
    operario_fk      bigint                     not null
        constraint productividadasignacion_operario_fk
            references operario,
    centro_fk        bigint                     not null
        constraint productividadasignacion_centro_fk
            references centro,
    turno_fk         bigint                     not null
        constraint productividadasignacion_turno_fk
            references turno,
    tipooperario_fk  bigint                     not null
        constraint productividadasignacion_tipooperario_fk
            references tipooperario,
    puestotrabajo_fk bigint
        constraint productividadasignacion_puestotrabajo_fk
            references formacionpuestotrabajo,
    intensidad       double precision default 0 not null,
    fechajornada     timestamp,
    fechavalidez     timestamp,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table productividadasignacion
    owner to postgres;

create table productividadasignacioncentroorden
(
    id               bigserial
        primary key,
    centroorden_fk   bigint           not null
        constraint productividadasignacioncentroorden_centroorden_fk
            references centroorden,
    tipooperario_fk  bigint           not null
        constraint productividadasignacioncentroorden_tipooperario_fk
            references tipooperario,
    puestotrabajo_fk bigint
        constraint productividadasignacioncentroorden_puestotrabajo_fk
            references formacionpuestotrabajo,
    cantidad         double precision not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint,
    constraint uq_productividadasignacioncentroorden
        unique (centroorden_fk, tipooperario_fk)
);

alter table productividadasignacioncentroorden
    owner to postgres;

create table productividadmedidacentro
(
    id               bigserial
        primary key,
    medida_fk        bigint           not null
        constraint productividadmedidacentro_medida_fk
            references productividadmedida,
    centro_fk        bigint           not null
        constraint productividadmedidacentro_centro_fk
            references centro,
    tipooperario_fk  bigint
        constraint productividadmedidacentro_tipooperario_fk
            references tipooperario,
    puestotrabajo_fk bigint
        constraint productividadmedidacentro_puestotrabajo_fk
            references formacionpuestotrabajo,
    centroorden_fk   bigint
        constraint productividadmedidacentro_centroorden_fk
            references centroorden,
    intensidad       double precision not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint,
    constraint uk_productividadmedidacentro_medida_centro
        unique (medida_fk, centro_fk)
);

alter table productividadmedidacentro
    owner to postgres;

create index idx_productividadmedidacentro_centro
    on productividadmedidacentro (centro_fk);

create index idx_productividadmedidacentro_composite
    on productividadmedidacentro (medida_fk, centro_fk);

create index idx_productividadmedidacentro_tipooper
    on productividadmedidacentro (tipooperario_fk);

create table productividadmedidacentrohist
(
    id               bigserial
        primary key,
    medida_fk        bigint           not null
        constraint productividadmedidacentrohist_medida_fk
            references productividadmedidahist,
    centro_fk        bigint           not null
        constraint productividadmedidacentrohist_centro_fk
            references centro,
    tipooperario_fk  bigint
        constraint productividadmedidacentrohist_tipooperario_fk
            references tipooperario,
    puestotrabajo_fk bigint
        constraint productividadmedidacentrohist_puestotrabajo_fk
            references formacionpuestotrabajo,
    centroorden_fk   bigint
        constraint productividadmedidacentrohist_centroorden_fk
            references centroorden,
    intensidad       double precision not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table productividadmedidacentrohist
    owner to postgres;

create index idx_prodmedidacentrohist_centro
    on productividadmedidacentrohist (centro_fk);

create index idx_prodmedidacentrohist_composite
    on productividadmedidacentrohist (medida_fk, centro_fk, tipooperario_fk);

create index idx_prodmedidacentrohist_tipooper
    on productividadmedidacentrohist (tipooperario_fk);

create table productividadmedidainconsistentecentrohist
(
    id               bigserial
        primary key,
    medida_fk        bigint           not null
        constraint productividadmedidainconsistentecentrohist_medida_fk
            references productividadmedidainconsistentehist,
    centro_fk        bigint           not null
        constraint productividadmedidainconsistentecentrohist_centro_fk
            references centro,
    tipooperario_fk  bigint           not null
        constraint productividadmedidainconsistentecentrohist_tipooperario_fk
            references tipooperario,
    puestotrabajo_fk bigint
        constraint productividadmedidainconsistentecentrohist_puestotrabajo_fk
            references formacionpuestotrabajo,
    intensidad       double precision not null,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table productividadmedidainconsistentecentrohist
    owner to postgres;

create table productividadplanificacionficherolinea
(
    id                 bigserial
        primary key,
    planificacion_fk   bigint                         not null
        constraint productividadplanificacionficherolinea_planificacion_fk
            references productividadplanificacionfichero,
    operariocodigo     varchar(45)      default NULL::character varying,
    centronombre       varchar(45)      default NULL::character varying,
    turnoidentificador varchar(45)      default NULL::character varying,
    intensidad         double precision default 0     not null,
    categorianombre    varchar(45)      default NULL::character varying,
    operario_fk        bigint
        constraint productividadplanificacionficherolinea_operario_fk
            references operario,
    centro_fk          bigint
        constraint productividadplanificacionficherolinea_centro_fk
            references centro,
    turno_fk           bigint
        constraint productividadplanificacionficherolinea_turno_fk
            references turno,
    categoria_fk       bigint
        constraint productividadplanificacionficherolinea_categoria_fk
            references tipooperario,
    error              boolean          default false not null,
    errordescripcion   varchar(150)     default NULL::character varying,
    created            timestamp,
    updated            timestamp,
    created_by         bigint,
    updated_by         bigint
);

alter table productividadplanificacionficherolinea
    owner to postgres;

create table productividadplanificacionpuestotrabajoespecial
(
    id               bigserial
        primary key,
    centro_fk        bigint not null
        constraint productividadplanificacionpuestotrabajoespecial_centro_fk
            references centro,
    puestotrabajo_fk bigint not null
        constraint prodplan_puestotrabajoespecial_puestotrabajo_fk
            references formacionpuestotrabajo,
    tipooperario_fk  bigint not null
        constraint productividadplanificacionpuestotrabajoespecial_tipooperario_fk
            references tipooperario,
    created          timestamp,
    updated          timestamp,
    created_by       bigint,
    updated_by       bigint
);

alter table productividadplanificacionpuestotrabajoespecial
    owner to postgres;

create table productividadplanificacionpuestotrabajo
(
    id                       bigserial
        primary key,
    planificacion_fk         bigint                     not null
        constraint productividadplanificacionpuestotrabajo_planificacion_fk
            references productividadplanificacion,
    turno_fk                 bigint                     not null
        constraint productividadplanificacionpuestotrabajo_turno_fk
            references turno,
    puestotrabajocentro_fk   bigint
        constraint productividadplanificacionpuestotrabajo_puestotrabajocentro_fk
            references formacionpuestotrabajocentro,
    puestotrabajoespecial_fk bigint
        constraint prodplan_puestotrabajo_puestotrabajoespecial_fk
            references productividadplanificacionpuestotrabajoespecial,
    numeracionpuesto         integer,
    fecha                    timestamp                  not null,
    operariocodigo           varchar(45)      default NULL::character varying,
    centronombre             varchar(45)      default NULL::character varying,
    turnoidentificador       varchar(45)      default NULL::character varying,
    intensidad               double precision default 0 not null,
    categorianombre          varchar(45)      default NULL::character varying,
    created                  timestamp,
    updated                  timestamp,
    created_by               bigint,
    updated_by               bigint
);

alter table productividadplanificacionpuestotrabajo
    owner to postgres;

create table productividadplanificacionpuestotrabajooperario
(
    id                                         bigserial
        primary key,
    productividadplanificacionpuestotrabajo_fk bigint not null
        constraint prodplan_puestotrabajooperario_prodplan_puestotrabajo_fk
            references productividadplanificacionpuestotrabajo,
    operario_fk                                bigint not null
        constraint productividadplanificacionpuestotrabajooperario_operario_fk
            references operario,
    created                                    timestamp,
    updated                                    timestamp,
    created_by                                 bigint,
    updated_by                                 bigint
);

alter table productividadplanificacionpuestotrabajooperario
    owner to postgres;

create table puntoestandarizacioncentro
(
    id                      bigserial
        primary key,
    puntoestandarizacion_fk bigint
        constraint puntoestandarizacioncentro_puntoestandarizacion_fk
            references puntoestandarizacion,
    centro_fk               bigint
        constraint puntoestandarizacioncentro_centro_fk
            references centro,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint,
    updated_by              bigint
);

alter table puntoestandarizacioncentro
    owner to postgres;

create table puntoestandarizacioncentrovariable
(
    id                            bigserial
        primary key,
    puntoestandarizacioncentro_fk bigint
        constraint puntoestand_centrovariable_puntoestand_centro_fk
            references puntoestandarizacioncentro,
    variable_fk                   bigint not null
        constraint puntoestandarizacioncentrovariable_variable_fk
            references variable_industrial,
    valorconfirmacion             boolean default false,
    created                       timestamp,
    updated                       timestamp,
    created_by                    bigint,
    updated_by                    bigint
);

alter table puntoestandarizacioncentrovariable
    owner to postgres;

create table puntoestandarizacionvalor
(
    id                            bigserial
        primary key,
    puntoestandarizacioncentro_fk bigint
        constraint puntoestandarizacionvalor_puntoestandarizacioncentro_fk
            references puntoestandarizacioncentro,
    producto_fk                   bigint
        constraint puntoestandarizacionvalor_producto_fk
            references producto,
    variableindustrial_fk         bigint
        constraint puntoestandarizacionvalor_variableindustrial_fk
            references variable_industrial,
    ingrediente_producto_fk       bigint
        constraint puntoestandarizacionvalor_ingrediente_producto_fk
            references producto,
    toleranciamas                 double precision,
    toleranciamenos               double precision,
    glaseo                        boolean          default false not null,
    control                       boolean          default false not null,
    valor                         varchar(255)     default NULL::character varying,
    imagencabecera                boolean          default false,
    coeficiente                   double precision default 1,
    created                       timestamp,
    updated                       timestamp,
    created_by                    bigint,
    updated_by                    bigint
);

alter table puntoestandarizacionvalor
    owner to postgres;

create table incidencia
(
    id                           bigserial
        primary key,
    fechaapertura                timestamp,
    centro_fk                    bigint
        constraint incidencia_centro_fk
            references centro,
    orden                        varchar(45)  default NULL::character varying,
    duracion                     bigint       default 0,
    incidenciatipo_fk            bigint
        constraint incidencia_incidenciatipo_fk
            references incidenciatipo,
    operario_fk                  bigint
        constraint incidencia_operario_fk
            references operario,
    descripcion                  varchar(500) default NULL::character varying,
    acciones                     varchar(500) default NULL::character varying,
    accionespreventivas          varchar(500) default NULL::character varying,
    prioridad                    integer      default 1,
    estado                       varchar(45)  default NULL::character varying
        constraint chk_incidencia_estado
            check ((estado)::text = ANY
                   ((ARRAY ['abierta'::character varying, 'cerrada'::character varying, 'desestimada'::character varying])::text[])),
    analisis                     varchar(500) default NULL::character varying,
    incidenciafichero_fk         bigint
        constraint incidencia_incidenciafichero_fk
            references fichero,
    medida_fk                    bigint
        constraint incidencia_medida_fk
            references medida,
    medidahist_fk                bigint
        constraint incidencia_medidahist_fk
            references medidahist,
    calidadcontrol_fk            bigint
        constraint incidencia_calidadcontrol_fk
            references calidadcontrol,
    calidadcontrolhist_fk        bigint
        constraint incidencia_calidadcontrolhist_fk
            references calidadcontrolhist,
    fechacierre                  timestamp,
    operarioafectado_fk          bigint
        constraint incidencia_operarioafectado_fk
            references operario,
    responsable_fk               bigint
        constraint incidencia_responsable_fk
            references usuario,
    usuario_fk                   bigint
        constraint incidencia_usuario_fk
            references usuario,
    created                      timestamp,
    updated                      timestamp,
    created_by                   bigint,
    updated_by                   bigint,
    puntoestandarizacionvalor_fk bigint
        constraint incidencia_puntoestandarizacionvalor_fk
            references puntoestandarizacionvalor
);

alter table incidencia
    owner to postgres;

create table defecto
(
    id                      bigserial
        primary key,
    centro_fk               bigint
        constraint defecto_centro_fk
            references centro,
    tipo_fk                 bigint
        constraint defecto_tipo_fk
            references defectotipo,
    operario_fk             bigint,
    responsablesolucion_fk  bigint
        constraint defecto_responsablesolucion_fk
            references operario,
    autorsolucion_fk        bigint
        constraint defecto_autorsolucion_fk
            references operario,
    incidencia_fk           bigint
        constraint defecto_incidencia_fk
            references incidencia,
    observacion_fk          bigint
        constraint defecto_observacion_fk
            references observacion,
    maquina                 varchar(45)  default NULL::character varying,
    elemento                varchar(100) default NULL::character varying,
    descripcion             varchar(500) default NULL::character varying,
    prioridad               varchar(45)  default NULL::character varying
        constraint chk_defecto_prioridad
            check ((prioridad)::text = ANY
                   ((ARRAY ['alta'::character varying, 'meida'::character varying, 'baja'::character varying])::text[])),
    departamentoresponsable varchar(45)  default NULL::character varying,
    solucionenproceso       boolean,
    fechasolucion           timestamp,
    fechaapertura           timestamp,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint
        constraint defecto_created_by_fk
            references usuario,
    updated_by              bigint
        constraint defecto_updated_by_fk
            references usuario,
    estado                  varchar(45)  default NULL::character varying
        constraint chk_defecto_estado
            check ((estado)::text = ANY
                   ((ARRAY ['abierto'::character varying, 'en curso'::character varying, 'cerrado'::character varying, 'desestimado'::character varying])::text[]))
);

alter table defecto
    owner to postgres;

create index defecto_autorsolucion_fk_idx
    on defecto (autorsolucion_fk);

create index defecto_centro_fk_idx
    on defecto (centro_fk);

create index defecto_created_by_idx
    on defecto (created_by);

create index defecto_incidencia_fk_idx
    on defecto (incidencia_fk);

create index defecto_observacion_fk_idx
    on defecto (observacion_fk);

create index defecto_responsablesolucion_fk_idx
    on defecto (responsablesolucion_fk);

create index defecto_tipo_fk_idx
    on defecto (tipo_fk);

create index defecto_updated_by_idx
    on defecto (updated_by);

create index defecto_estado_idx
    on defecto (estado);

create table defectofichero
(
    id         bigserial
        primary key,
    defecto_fk bigint not null
        constraint defectofichero_defecto_fk
            references defecto,
    fichero_fk bigint not null
        constraint defectofichero_fichero_fk
            references fichero,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint defectofichero_created_by_fk
            references usuario,
    updated_by bigint
        constraint defectofichero_updated_by_fk
            references usuario,
    constraint defectofichero_uq
        unique (defecto_fk, fichero_fk)
);

alter table defectofichero
    owner to postgres;

create index defectofichero_created_by_idx
    on defectofichero (created_by);

create index defectofichero_fichero_fk_idx
    on defectofichero (fichero_fk);

create index defectofichero_updated_by_idx
    on defectofichero (updated_by);

create table recurso
(
    id           bigserial
        primary key,
    frecmuestreo bigint not null,
    limite       bigint not null,
    nombre       varchar(255) default NULL::character varying,
    objetivo     bigint not null,
    unidad       varchar(255) default NULL::character varying,
    centro_fk    bigint
        constraint recurso_centro_fk
            references centro,
    tipo_fk      bigint
        constraint recurso_tipo_fk
            references recursotipo,
    created      timestamp,
    updated      timestamp,
    created_by   bigint,
    updated_by   bigint
);

alter table recurso
    owner to postgres;

create table equipomedida
(
    id         bigserial
        primary key,
    nodeidopc  varchar(255) default NULL::character varying,
    nombre     varchar(255) default NULL::character varying,
    recurso_fk bigint
        constraint equipomedida_recurso_fk
            references recurso,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint equipomedida_created_by_fk
            references usuario,
    updated_by bigint
        constraint equipomedida_updated_by_fk
            references usuario
);

alter table equipomedida
    owner to postgres;

create index equipomedida_created_by_idx
    on equipomedida (created_by);

create index equipomedida_recurso_fk_idx
    on equipomedida (recurso_fk);

create index equipomedida_updated_by_idx
    on equipomedida (updated_by);

create table stocktemporal
(
    id          bigserial
        primary key,
    centro_fk   bigint           not null
        constraint stocktemporal_centro_fk
            references centro,
    producto_fk bigint           not null
        constraint stocktemporal_producto_fk
            references producto,
    orden       varchar(45) default NULL::character varying,
    lote        varchar(45) default NULL::character varying,
    numpalet    varchar(45) default NULL::character varying,
    tipopalet   varchar(45) default NULL::character varying,
    numwipin    integer,
    cantidad    double precision not null,
    fecha       timestamp        not null,
    created     timestamp,
    updated     timestamp,
    created_by  bigint,
    updated_by  bigint
);

alter table stocktemporal
    owner to postgres;

create table sugerencia
(
    id             bigserial
        primary key,
    tipo_fk        bigint
        constraint sugerencia_tipo_fk
            references sugerenciatipo,
    centro_fk      bigint
        constraint sugerencia_centro_fk
            references centro,
    fichero_fk     bigint,
    operario_fk    bigint
        constraint sugerencia_operario_fk
            references operario,
    estado         varchar(50)  default NULL::character varying,
    fechaapertura  timestamp,
    fechacierre    timestamp,
    descripcion    varchar(500) default NULL::character varying,
    analisis       varchar(500) default NULL::character varying,
    responsable_fk bigint
        constraint sugerencia_responsable_fk
            references usuario,
    usuario_fk     bigint
        constraint sugerencia_usuario_fk
            references usuario,
    created        timestamp,
    updated        timestamp,
    created_by     bigint,
    updated_by     bigint
);

alter table sugerencia
    owner to postgres;

create table accion
(
    id                     bigserial
        primary key,
    estado                 varchar(50),
    descripcion            varchar(500) default NULL::character varying,
    operarioresponsable_fk bigint
        constraint accion_operarioresponsable_fk
            references operario,
    operario_fk            bigint
        constraint accion_operario_fk
            references operario,
    incidencia_fk          bigint
        constraint accion_incidencia_fk
            references incidencia,
    sugerencia_fk          bigint
        constraint accion_sugerencia_fk
            references sugerencia,
    observacion_fk         bigint
        constraint accion_observacion_fk
            references observacion,
    fechaapertura          timestamp,
    fecharevision          timestamp,
    fechacierre            timestamp,
    prioridad              integer      default 1,
    resultado              varchar(500) default NULL::character varying,
    created                timestamp,
    updated                timestamp,
    created_by             bigint
        constraint accion_created_by_fk
            references usuario,
    updated_by             bigint
        constraint accion_updated_by_fk
            references usuario
);

alter table accion
    owner to postgres;

create table incidenciaaccion
(
    incidencia_fk bigint not null
        constraint incidenciaaccion_incidencia_fk
            references incidencia,
    accion_fk     bigint not null
        constraint incidenciaaccion_accion_fk
            references accion,
    created       timestamp,
    updated       timestamp,
    created_by    bigint,
    updated_by    bigint,
    primary key (incidencia_fk, accion_fk)
);

alter table incidenciaaccion
    owner to postgres;

create table mejora
(
    id                bigserial
        primary key,
    centro_fk         bigint
        constraint mejora_centro_fk
            references centro,
    mejoratipo_fk     bigint
        constraint mejora_mejoratipo_fk
            references mejoratipo,
    perdidatipo_fk    bigint
        constraint mejora_perdidatipo_fk
            references perdidatipo,
    responsable_fk    bigint
        constraint mejora_responsable_fk
            references operario,
    proponente_fk     bigint
        constraint mejora_proponente_fk
            references operario,
    incidencia_fk     bigint
        constraint mejora_incidencia_fk
            references incidencia,
    observacion_fk    bigint
        constraint mejora_observacion_fk
            references observacion,
    sugerencia_fk     bigint
        constraint mejora_sugerencia_fk
            references sugerencia,
    estado            enum_mejora_estado,
    fechapresentacion timestamp,
    ahorro            enum_mejora_ahorro,
    inversion         double precision default 0,
    created           timestamp,
    updated           timestamp,
    created_by        bigint,
    updated_by        bigint,
    fechaalta         timestamp,
    prioridad         integer          default 1,
    descripcion       varchar(500)     default NULL::character varying,
    ahorrocantidad    double precision default 0,
    colectivo         enum_mejora_colectivo,
    mejorafichero_fk  bigint
        constraint mejora_mejorafichero_fk
            references fichero
);

alter table mejora
    owner to postgres;

create table grupocomunicacioncomunicacion
(
    id                   bigserial
        primary key,
    grupocomunicacion_fk bigint not null
        constraint grupocomunicacioncomunicacion_grupocomunicacion_fk
            references grupocomunicacion,
    incidencia_fk        bigint
        constraint grupocomunicacioncomunicacion_incidencia_fk
            references incidencia,
    observacion_fk       bigint
        constraint grupocomunicacioncomunicacion_observacion_fk
            references observacion,
    sugerencia_fk        bigint
        constraint grupocomunicacioncomunicacion_sugerencia_fk
            references sugerencia,
    accion_fk            bigint
        constraint grupocomunicacioncomunicacion_accion_fk
            references accion,
    mejora_fk            bigint
        constraint grupocomunicacioncomunicacion_mejora_fk
            references mejora,
    defecto_fk           bigint
        constraint grupocomunicacioncomunicacion_defecto_fk
            references defecto,
    created              timestamp,
    updated              timestamp,
    created_by           bigint,
    updated_by           bigint,
    constraint grupocomunicacioncomunicacion_incidencia_uq
        unique (grupocomunicacion_fk, incidencia_fk),
    constraint grupocomunicacioncomunicacion_observacion_uq
        unique (grupocomunicacion_fk, observacion_fk),
    constraint grupocomunicacioncomunicacion_sugerencia_uq
        unique (grupocomunicacion_fk, sugerencia_fk)
);

alter table grupocomunicacioncomunicacion
    owner to postgres;

create index grupocomunicacioncomunicacion_accion_fk_idx
    on grupocomunicacioncomunicacion (accion_fk);

create index grupocomunicacioncomunicacion_created_by_idx
    on grupocomunicacioncomunicacion (created_by);

create index grupocomunicacioncomunicacion_defecto_fk_idx
    on grupocomunicacioncomunicacion (defecto_fk);

create index grupocomunicacioncomunicacion_grupocomunicacion_fk_idx
    on grupocomunicacioncomunicacion (grupocomunicacion_fk);

create index grupocomunicacioncomunicacion_incidencia_fk_idx
    on grupocomunicacioncomunicacion (incidencia_fk);

create index grupocomunicacioncomunicacion_mejora_fk_idx
    on grupocomunicacioncomunicacion (mejora_fk);

create index grupocomunicacioncomunicacion_observacion_fk_idx
    on grupocomunicacioncomunicacion (observacion_fk);

create index grupocomunicacioncomunicacion_sugerencia_fk_idx
    on grupocomunicacioncomunicacion (sugerencia_fk);

create index grupocomunicacioncomunicacion_updated_by_idx
    on grupocomunicacioncomunicacion (updated_by);

create table mejorafichero
(
    id         bigserial
        primary key,
    mejora_fk  bigint not null
        constraint mejorafichero_mejora_fk
            references mejora,
    fichero_fk bigint not null
        constraint mejorafichero_fichero_fk
            references fichero,
    created    timestamp,
    updated    timestamp,
    created_by bigint,
    updated_by bigint
);

alter table mejorafichero
    owner to postgres;

create table observacionaccion
(
    observacion_fk bigint not null
        constraint observacionaccion_observacion_fk
            references observacion,
    accion_fk      bigint not null
        constraint observacionaccion_accion_fk
            references accion,
    created        timestamp,
    updated        timestamp,
    created_by     bigint,
    updated_by     bigint,
    primary key (observacion_fk, accion_fk)
);

alter table observacionaccion
    owner to postgres;

create table sugerenciaaccion
(
    sugerencia_fk bigint not null
        constraint sugerenciaaccion_sugerencia_fk
            references sugerencia,
    accion_fk     bigint not null
        constraint sugerenciaaccion_accion_fk
            references accion,
    created       timestamp,
    updated       timestamp,
    created_by    bigint,
    updated_by    bigint,
    primary key (sugerencia_fk, accion_fk)
);

alter table sugerenciaaccion
    owner to postgres;

create table sugerenciafichero
(
    id            bigserial
        primary key,
    sugerencia_fk bigint not null
        constraint sugerenciafichero_sugerencia_fk
            references sugerencia,
    fichero_fk    bigint not null
        constraint sugerenciafichero_fichero_fk
            references fichero,
    created       timestamp,
    updated       timestamp,
    created_by    bigint,
    updated_by    bigint
);

alter table sugerenciafichero
    owner to postgres;

create table usuariocentropreferencia
(
    id         bigserial
        primary key,
    usuario_fk bigint not null
        constraint usuariocentropreferencia_usuario_fk
            references usuario,
    centro_fk  bigint not null
        constraint usuariocentropreferencia_centro_fk
            references centro
            on delete cascade,
    created    timestamp,
    updated    timestamp,
    created_by bigint
        constraint usuariocentropreferencia_created_by
            references usuario,
    updated_by bigint
        constraint usuariocentropreferencia_updated_by
            references usuario,
    constraint usuariocentropreferencia_unique
        unique (usuario_fk, centro_fk)
);

alter table usuariocentropreferencia
    owner to postgres;

create table validaciontiempos
(
    id                 bigserial
        primary key,
    centroorden_fk     bigint    not null
        constraint validaciontiempos_centroorden_fk
            references centroorden,
    fechajornada       timestamp not null,
    turno_fk           bigint    not null
        constraint validaciontiempos_turno_fk
            references turno,
    cantidad           double precision default 0,
    toperativo         double precision default 0,
    operarios          double precision default 0,
    tmanoobradirecta   double precision default 0,
    tmanoobraindirecta double precision default 0,
    responsable_fk     bigint
        constraint validaciontiempos_responsable_fk
            references operario,
    idnotificacion     varchar(100)     default NULL::character varying,
    idconfirmacion     varchar(100)     default NULL::character varying,
    created            timestamp        default CURRENT_TIMESTAMP,
    updated            timestamp,
    created_by         bigint,
    updated_by         bigint
);

alter table validaciontiempos
    owner to postgres;

create index idx_variable_industrial_servidor_fk
    on variable_industrial (servidor_fk);

create table variableclasepropiedad
(
    id                        bigserial
        primary key,
    descripcion               varchar(255) default NULL::character varying,
    valor                     varchar(50)  default NULL::character varying,
    tipovalor                 varchar(20)  default 'STRING'::character varying not null,
    variableclasepropiedad_fk bigint,
    variableclase_fk          bigint                                           not null,
    created                   timestamp    default CURRENT_TIMESTAMP,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table variableclasepropiedad
    owner to postgres;

create table servidorpropiedad
(
    id                        bigserial
        primary key,
    servidor_fk               bigint not null
        constraint servidorpropiedad_servidor_fk
            references servidor,
    servidorclasepropiedad_fk bigint not null
        constraint servidorpropiedad_servidorclasepropiedad_fk
            references variableclasepropiedad,
    valor                     varchar(100) default NULL::character varying,
    activo                    boolean,
    created                   timestamp    default CURRENT_TIMESTAMP,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table servidorpropiedad
    owner to postgres;

create index idx_variableclasepropiedad_descripcion
    on variableclasepropiedad (descripcion);

create index idx_variableclasepropiedad_variableclase_fk
    on variableclasepropiedad (variableclase_fk);

create table variablepropiedad
(
    id                        bigserial
        primary key,
    variable_fk               bigint       not null
        constraint variablepropiedad_variable_fk
            references variable_industrial,
    variableclasepropiedad_fk bigint       not null
        constraint variablepropiedad_variableclasepropiedad_fk
            references variableclasepropiedad,
    valor                     varchar(150) not null,
    created                   timestamp default CURRENT_TIMESTAMP,
    updated                   timestamp,
    created_by                bigint,
    updated_by                bigint
);

alter table variablepropiedad
    owner to postgres;

create index idx_variablepropiedad_variable_fk
    on variablepropiedad (variable_fk);

create index idx_variablepropiedad_variableclasepropiedad_fk
    on variablepropiedad (variableclasepropiedad_fk);

create table wipin
(
    id              bigserial
        primary key,
    centro_fk       bigint                    not null
        constraint wipin_centro_fk
            references centro,
    codigo          varchar(15)               not null,
    nombre          varchar(45)               not null,
    tipo            varchar(20) default NULL::character varying,
    stockdisponible boolean     default false not null,
    stockenproceso  boolean     default false not null,
    stockcerrado    boolean     default false not null,
    created         timestamp,
    updated         timestamp,
    created_by      bigint,
    updated_by      bigint
);

comment on table wipin is 'Tabla de ubicaciones de centro (Work In Process)';

alter table wipin
    owner to postgres;

create table centroordenwipinmaterial
(
    id                   bigserial
        primary key,
    centroorden_fk       bigint
        constraint centroordenwipinmaterial_centroorden_fk
            references centroorden,
    wipin_fk             bigint
        constraint centroordenwipinmaterial_wipin_fk
            references wipin,
    producto_fk          bigint
        constraint centroordenwipinmaterial_producto_fk
            references producto,
    unidad_fk            bigint
        constraint centroordenwipinmaterial_unidad_fk
            references unidad,
    ratioconsumomaterial double precision,
    created              timestamp,
    updated              timestamp,
    created_by           bigint,
    updated_by           bigint,
    porcentaje           integer not null
);

alter table centroordenwipinmaterial
    owner to postgres;

create index centroordenwipinmaterial_centroorden_fk_idx
    on centroordenwipinmaterial (centroorden_fk);

create index centroordenwipinmaterial_producto_fk_idx
    on centroordenwipinmaterial (producto_fk);

create index centroordenwipinmaterial_unidad_fk_idx
    on centroordenwipinmaterial (unidad_fk);

create index centroordenwipinmaterial_wipin_fk_idx
    on centroordenwipinmaterial (wipin_fk);

create table consumo
(
    id                      bigserial
        primary key,
    producto_fk             bigint
        constraint consumo_producto_fk
            references producto,
    wipin_fk                bigint
        constraint consumo_wipin_fk
            references wipin,
    centroorden_fk          bigint                     not null
        constraint consumo_centroorden_fk
            references centroorden,
    unidad_fk               bigint
        constraint consumo_unidad_fk
            references unidad,
    consumocarga_fk         bigint
        constraint consumo_consumocarga_fk
            references consumo,
    numwipin                integer,
    fecha                   timestamp                  not null,
    lote                    varchar(45)      default NULL::character varying,
    numpalet                varchar(45)      default NULL::character varying,
    tipopalet               varchar(45)      default NULL::character varying,
    simulado                boolean          default false,
    valorvariableindustrial double precision,
    valorconsumo            double precision default 0 not null,
    tipooperacion           varchar(20)                not null,
    almacenubicacion        varchar(45)      default NULL::character varying,
    reservado               boolean,
    created                 timestamp,
    updated                 timestamp,
    created_by              bigint
        constraint consumo_created_by_fk
            references usuario,
    updated_by              bigint
        constraint consumo_updated_by_fk
            references usuario,
    recetaingrediente_fk    bigint
        constraint consumo_recetaingrediente_fk
            references recetaingrediente,
    turno_fk                bigint
        constraint consumo_turno_fk
            references turno,
    documento               varchar(20)      default NULL::character varying,
    documentoanulado        varchar(20)      default NULL::character varying
);

alter table consumo
    owner to postgres;

create index consumo_centroorden_fk_idx
    on consumo (centroorden_fk);

create index consumo_consumocarga_fk_idx
    on consumo (consumocarga_fk);

create index consumo_created_by_idx
    on consumo (created_by);

create index consumo_lote_idx
    on consumo (lote);

create index consumo_producto_fk_idx
    on consumo (producto_fk);

create index consumo_recetaingrediente_fk_idx
    on consumo (recetaingrediente_fk);

create index consumo_tipooperacion_idx
    on consumo (tipooperacion);

create index consumo_turno_fk_idx
    on consumo (turno_fk);

create index consumo_unidad_fk_idx
    on consumo (unidad_fk);

create index consumo_updated_by_idx
    on consumo (updated_by);

create index consumo_wipin_fk_idx
    on consumo (wipin_fk);

create index idx_consumo_orden_tipo_fecha
    on consumo (centroorden_fk, tipooperacion, fecha);

create table consumohist
(
    id                   bigserial
        primary key,
    producto_fk          bigint           not null
        constraint consumohist_producto_fk
            references producto,
    wipin_fk             bigint
        constraint consumohist_wipin_fk
            references wipin,
    centroorden_fk       bigint           not null
        constraint consumohist_centroorden_fk
            references centroorden,
    medidahist_fk        bigint           not null
        constraint consumohist_medidahist_fk
            references medidahist,
    unidad_fk            bigint
        constraint consumohist_unidad_fk
            references unidad,
    fechainicio          timestamp        not null,
    fechafin             timestamp        not null,
    numwipin             integer,
    lote                 varchar(45) default NULL::character varying,
    numpalet             varchar(45) default NULL::character varying,
    tipopalet            varchar(45) default NULL::character varying,
    simulado             boolean     default false,
    valorconsumo         double precision not null,
    tipooperacion        varchar(45)      not null,
    almacenubicacion     varchar(45) default NULL::character varying,
    created              timestamp,
    updated              timestamp,
    created_by           bigint
        constraint consumohist_created_by_fk
            references usuario,
    updated_by           bigint
        constraint consumohist_updated_by_fk
            references usuario,
    valoropc             double precision,
    recetaingrediente_fk bigint
        constraint consumohist_recetaingrediente_fk
            references recetaingrediente,
    turno_fk             bigint
        constraint consumohist_turno_fk
            references turno,
    documento            varchar(20) default NULL::character varying,
    documentoanulado     varchar(20) default NULL::character varying
);

alter table consumohist
    owner to postgres;

create index consumohist_centroorden_fk_idx
    on consumohist (centroorden_fk);

create index consumohist_created_by_idx
    on consumohist (created_by);

create index consumohist_lote_idx
    on consumohist (lote);

create index consumohist_medidahist_fk_idx
    on consumohist (medidahist_fk);

create index consumohist_producto_fk_idx
    on consumohist (producto_fk);

create index consumohist_recetaingrediente_fk_idx
    on consumohist (recetaingrediente_fk);

create index consumohist_turno_fk_idx
    on consumohist (turno_fk);

create index consumohist_unidad_fk_idx
    on consumohist (unidad_fk);

create index consumohist_updated_by_idx
    on consumohist (updated_by);

create index consumohist_wipin_fk_idx
    on consumohist (wipin_fk);

create index idx_consumohist_orden_tipo_fechainicio
    on consumohist (centroorden_fk, tipooperacion, fechainicio) include (valorconsumo);

create table contadorwipin
(
    id                   bigserial
        primary key,
    producto_fk          bigint
        constraint contadorwipin_producto_fk
            references producto,
    wipin_fk             bigint       not null
        constraint contadorwipin_wipin_fk
            references wipin,
    unidad_fk            bigint       not null
        constraint contadorwipin_unidad_fk
            references unidad,
    variable_fk          bigint       not null
        constraint contadorwipin_variable_industrial_fk
            references variable_industrial,
    valorinicial         double precision,
    usarvalorinicial     boolean,
    frecopcmin           integer      not null,
    ratioconsumomaterial double precision,
    created              timestamp,
    updated              timestamp,
    created_by           bigint
        constraint contadorwipin_created_by_fk
            references usuario,
    updated_by           bigint
        constraint contadorwipin_updated_by_fk
            references usuario,
    nombre               varchar(100) not null
        constraint contadorwipin_nombre_uq
            unique
);

alter table contadorwipin
    owner to postgres;

create index contadorwipin_created_by_idx
    on contadorwipin (created_by);

create index contadorwipin_producto_fk_idx
    on contadorwipin (producto_fk);

create index contadorwipin_unidad_fk_idx
    on contadorwipin (unidad_fk);

create index contadorwipin_updated_by_idx
    on contadorwipin (updated_by);

create index contadorwipin_variable_fk_idx
    on contadorwipin (variable_fk);

create index contadorwipin_wipin_fk_idx
    on contadorwipin (wipin_fk);

create table formacionactividad
(
    id          bigserial
        primary key,
    formador_fk bigint
        constraint formacionactividad_formador_fk
            references formador,
    curso_fk    bigint
        constraint formacionactividad_curso_fk
            references formacioncurso,
    evento_fk   bigint
        constraint formacionactividad_calendarioevento_fk
            references calendarioevento,
    tarea_fk    bigint
        constraint formacionactividad_tarea_fk
            references formaciontarea,
    wipin_fk    bigint
        constraint formacionactividad_wipin_fk
            references wipin,
    fechainicio timestamp,
    fechafin    timestamp,
    created     timestamp,
    updated     timestamp,
    created_by  bigint
        constraint formacionactividad_created_by_fk
            references usuario,
    updated_by  bigint
        constraint formacionactividad_updated_by_fk
            references usuario
);

alter table formacionactividad
    owner to postgres;

create index formacionactividad_calendarioevento_fk_idx
    on formacionactividad (evento_fk);

create index formacionactividad_created_by_idx
    on formacionactividad (created_by);

create index formacionactividad_curso_fk_idx
    on formacionactividad (curso_fk);

create index formacionactividad_formador_fk_idx
    on formacionactividad (formador_fk);

create index formacionactividad_tarea_fk_idx
    on formacionactividad (tarea_fk);

create index formacionactividad_updated_by_idx
    on formacionactividad (updated_by);

create index formacionactividad_wipin_fk_idx
    on formacionactividad (wipin_fk);

create table formacionactividadoperarioasistencia
(
    id               bigserial
        primary key,
    operario_fk      bigint  not null
        constraint formacionactividadoperarioasistencia_operario_fk
            references operario,
    actividad_fk     bigint  not null
        constraint formacionactividadoperarioasistencia_actividad_fk
            references formacionactividad,
    horascontraturno integer default 0,
    horariolaboral   boolean not null,
    fechainicio      timestamp,
    fechafin         timestamp,
    created          timestamp,
    updated          timestamp,
    created_by       bigint
        constraint formacionactividadoperarioasistencia_created_by_fk
            references usuario,
    updated_by       bigint
        constraint formacionactividadoperarioasistencia_updated_by_fk
            references usuario
);

alter table formacionactividadoperarioasistencia
    owner to postgres;

create index formacionactividadoperarioasistencia_actividad_fk_idx
    on formacionactividadoperarioasistencia (actividad_fk);

create index formacionactividadoperarioasistencia_created_by_idx
    on formacionactividadoperarioasistencia (created_by);

create index formacionactividadoperarioasistencia_operario_fk_idx
    on formacionactividadoperarioasistencia (operario_fk);

create index formacionactividadoperarioasistencia_updated_by_idx
    on formacionactividadoperarioasistencia (updated_by);

create table productostock
(
    id                 bigserial
        primary key,
    entrada_fk         bigint                     not null
        constraint productostock_entrada_fk
            references productoentrada,
    producto_fk        bigint                     not null
        constraint productostock_producto_fk
            references producto,
    ubicacion_fk       bigint                     not null
        constraint productostock_ubicacion_fk
            references wipin,
    cantidad           double precision default 0 not null,
    lote               varchar(20)                not null,
    numeroserie        varchar(20)                not null,
    fechaentrada       timestamp                  not null,
    fechacaducidad     timestamp                  not null,
    fechatopeenproceso timestamp,
    fechaproduccion    timestamp                  not null,
    estado             integer          default 0 not null,
    conformidad        integer          default 0 not null,
    created            timestamp,
    updated            timestamp,
    created_by         bigint,
    updated_by         bigint
);

alter table productostock
    owner to postgres;

create table productostockmovimiento
(
    id                  bigserial
        primary key,
    tipo                integer          default 0 not null,
    fechaentrada        timestamp                  not null,
    entrada_fk          bigint                     not null
        constraint productostockmovimiento_entrada_fk
            references productoentrada,
    productostock_fk    bigint                     not null
        constraint productostockmovimiento_productostock_fk
            references productostock,
    lote                varchar(20)                not null,
    numeroserie         varchar(20)                not null,
    cantidad            double precision default 0 not null,
    ubicacionorigen_fk  bigint                     not null
        constraint productostockmovimiento_ubicacionorigen_fk
            references wipin,
    ubicaciondestino_fk bigint                     not null
        constraint productostockmovimiento_ubicaciondestino_fk
            references wipin,
    estadoorigen        integer                    not null,
    conformidadorigen   integer                    not null,
    estadodestino       integer                    not null,
    conformidaddestino  integer                    not null,
    created             timestamp,
    updated             timestamp,
    created_by          bigint,
    updated_by          bigint
);

alter table productostockmovimiento
    owner to postgres;

create table recetaingredientewipin
(
    id                   bigserial
        primary key,
    wipin_fk             bigint not null
        constraint recetaingredientewipin_wipin_fk
            references wipin,
    producto_fk          bigint not null
        constraint recetaingredientewipin_producto_fk
            references producto,
    receta_fk            bigint not null
        constraint recetaingredientewipin_receta_fk
            references receta,
    ratioconsumomaterial double precision,
    porcentaje           double precision,
    created              timestamp,
    updated              timestamp,
    created_by           bigint,
    updated_by           bigint,
    recetaingrediente_fk bigint
        constraint recetaingredientewipin_recetaingrediente_fk
            references recetaingrediente,
    constraint uq_recetaingredientewipin
        unique (wipin_fk, recetaingrediente_fk)
);

alter table recetaingredientewipin
    owner to postgres;

create table unidadproductoratio
(
    productofabricado_fk bigint           not null
        constraint unidadproductoratio_productofabricado_fk
            references producto,
    unidad_fk            bigint           not null
        constraint unidadproductoratio_unidad_fk
            references unidad,
    producto_fk          bigint           not null,
    centroubicacion_fk   bigint           not null,
    contadorwipin_fk     bigint
        constraint unidadproductoratio_contadorwipin_fk
            references contadorwipin,
    valor                double precision not null,
    created              timestamp,
    updated              timestamp,
    created_by           bigint,
    updated_by           bigint,
    primary key (productofabricado_fk, unidad_fk, producto_fk, centroubicacion_fk)
);

alter table unidadproductoratio
    owner to postgres;

create table wipininsertar
(
    centro               varchar(100) default NULL::character varying,
    nombrewipin          varchar(255) default NULL::character varying,
    tipo                 varchar(30)  default NULL::character varying,
    codigowipin          varchar(20)  default NULL::character varying,
    unidad               varchar(20)  default NULL::character varying,
    frecopcmin           integer,
    ratioconsumomaterial double precision,
    urivariable          varchar(50)  default NULL::character varying,
    opcserver            varchar(50)  default NULL::character varying,
    posvector            integer
);

comment on table wipininsertar is 'Tabla temporal para inserción masiva de wipin';

alter table wipininsertar
    owner to postgres;

create table calculated_value
(
    time       timestamp with time zone not null,
    datanodeid integer                  not null,
    value      double precision         not null,
    parameters jsonb                    not null,
    primary key (time, datanodeid)
);

alter table calculated_value
    owner to postgres;

create index calculated_value_time_idx
    on calculated_value (time desc);

create view valarmashistmag
            (tipomedida, medidaid, medidafechainicio, medidafechafin, medidaduracion, operarioid, justificacion,
             justificada, cantidad, grupo, centroalarmaid, alarmafechainicio, alarmafechafin, alarmaduracion, centroid,
             centronombre, productoid, productocodigo, productonombre, estadoid, estadonombre, estadotipoid,
             estadotiponombre, turnoid, turnoidentificador, centroordenid, centroordencodigo, centroordencantidad,
             centroproductoid)
as
SELECT 'historico'::text        AS tipomedida,
       m.id                     AS medidaid,
       m.finicio                AS medidafechainicio,
       m.ffin                   AS medidafechafin,
       m.duracion               AS medidaduracion,
       m.operarioresponsable_fk AS operarioid,
       m.justificacion,
       m.justificada,
       m.cantidad,
       m.grupo,
       ca.id                    AS centroalarmaid,
       ca.fechainicio           AS alarmafechainicio,
       ca.fechafin              AS alarmafechafin,
       ca.duracion              AS alarmaduracion,
       c.id                     AS centroid,
       c.nombre                 AS centronombre,
       p.id                     AS productoid,
       p.codigo                 AS productocodigo,
       p.nombre                 AS productonombre,
       e.id                     AS estadoid,
       e.nombre                 AS estadonombre,
       et.id                    AS estadotipoid,
       et.nombre                AS estadotiponombre,
       t.id                     AS turnoid,
       t.identificador          AS turnoidentificador,
       co.id                    AS centroordenid,
       co.codigo                AS centroordencodigo,
       co.cantidad              AS centroordencantidad,
       cp.id                    AS centroproductoid
FROM medidahist m
         JOIN centro c ON m.centro_fk = c.id
         JOIN producto p ON m.producto_fk = p.id
         JOIN centroorden co ON m.centroorden_fk = co.id
         JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         JOIN centroalarmahist ca ON ca.medidahist_fk = m.id
         JOIN estado e ON ca.estado_fk = e.id
         JOIN estadotipo et ON e.tipo_fk = et.id
         JOIN turno t ON m.turno_fk = t.id;

alter table valarmashistmag
    owner to postgres;

create view valarmasmag
            (tipomedida, medidaid, medidafechainicio, medidafechafin, medidaduracion, operarioid, justificacion,
             justificada, cantidad, grupo, centroalarmaid, alarmafechainicio, alarmafechafin, alarmaduracion, centroid,
             centronombre, productoid, productocodigo, productonombre, estadoid, estadonombre, estadotipoid,
             estadotiponombre, turnoid, turnoidentificador, centroordenid, centroordencodigo, centroordencantidad,
             centroproductoid)
as
WITH medida_agrup AS (SELECT min(m_1.id)                                          AS id,
                             min(m_1.justificacion::text)::character varying(255) AS justificacion,
                             every(m_1.justificada)                               AS justificada,
                             m_1.grupo,
                             m_1.centroorden_fk,
                             m_1.operarioresponsable_fk,
                             m_1.operario_fk,
                             m_1.centroestado_fk,
                             m_1.centroproducto_fk,
                             m_1.turno_fk,
                             min(m_1.finicio)                                     AS finicio,
                             max(m_1.ffin)                                        AS ffin,
                             sum(m_1.duracion)                                    AS duraciontotal,
                             sum(m_1.valormedida)                                 AS cantidad
                      FROM medida m_1
                      WHERE m_1.tipomedida::text = 'estados'::text
                      GROUP BY m_1.grupo, m_1.centroorden_fk, m_1.operarioresponsable_fk, m_1.operario_fk,
                               m_1.centroestado_fk, m_1.centroproducto_fk, m_1.turno_fk)
SELECT 'monitorizador'::text                                                                AS tipomedida,
       m.id                                                                                 AS medidaid,
       m.finicio                                                                            AS medidafechainicio,
       m.ffin                                                                               AS medidafechafin,
       m.duraciontotal                                                                      AS medidaduracion,
       m.operarioresponsable_fk                                                             AS operarioid,
       m.justificacion,
       m.justificada,
       m.cantidad,
       m.grupo,
       ca.id                                                                                AS centroalarmaid,
       GREATEST(m.finicio, ca.fechainicio)                                                  AS alarmafechainicio,
       LEAST(m.ffin, ca.fechafin)                                                           AS alarmafechafin,
       EXTRACT(epoch FROM LEAST(m.ffin, ca.fechafin) - GREATEST(m.finicio, ca.fechainicio)) AS alarmaduracion,
       c.id                                                                                 AS centroid,
       c.nombre                                                                             AS centronombre,
       p.id                                                                                 AS productoid,
       p.codigo                                                                             AS productocodigo,
       p.nombre                                                                             AS productonombre,
       e.id                                                                                 AS estadoid,
       e.nombre                                                                             AS estadonombre,
       et.id                                                                                AS estadotipoid,
       et.nombre                                                                            AS estadotiponombre,
       t.id                                                                                 AS turnoid,
       t.identificador                                                                      AS turnoidentificador,
       co.id                                                                                AS centroordenid,
       co.codigo                                                                            AS centroordencodigo,
       co.cantidad                                                                          AS centroordencantidad,
       cp.id                                                                                AS centroproductoid
FROM medida_agrup m
         JOIN centroproducto cp ON m.centroproducto_fk = cp.id
         JOIN centro c ON cp.centro_fk = c.id
         JOIN producto p ON cp.producto_fk = p.id
         JOIN centroorden co ON m.centroorden_fk = co.id
         JOIN centroalarma ca ON ca.centro_fk = c.id AND ca.fechafin > m.finicio AND ca.fechainicio < m.ffin
         JOIN estado e ON ca.estado_fk = e.id
         JOIN estadotipo et ON e.tipo_fk = et.id
         JOIN turno t ON m.turno_fk = t.id;

alter table valarmasmag
    owner to postgres;

create view vbaseindicadoreshistorico
            (medidaid, medidahistorico, medidafechajornada, medidafechainicio, medidafechafin, centroordenid, centroid,
             productoid, turnoid, qrealup, qrealus, qrealuv, qscrapup, qscrapus, qscrapuv, qtotalup, qtotalus, qtotaluv,
             unidadprincipalid, unidadsecundariaid, unidadproductividadid, unidadproductividadtiempo,
             tmicroparojustificado, tparonoprogramado, tparoexceso, tfallo, tparoprogramado, ttotalparada,
             tnoplanificado, tproduccion, tvelocidadreducida, toperacional, tproductivo, ttotal, tnetoreal,
             ttotalmicroparos, tmicroparonojustificado, tefectivo, tproductivoobjetivo, tproduccionobjetivo,
             toperacionalobjetivo, tproductivofinalobjetivo, tnetoobjetivo, tefectivoobjetivo,
             tefectivoobjetivooperacional, tefectivoobjetivoproductivo, disponibilidadtotalobjetivo, vteoria, vobjetivo,
             ratioprincipalsecundaria, ratioprincipaleficiencia, tproductividadhobjetivo, tproductividadhreal,
             tdiferenciahproductividad, ratioprincipalproductividad, productividadestandar, qobjetivoproductivauv,
             qobjetivooperacionaluv, qobjetivooperacionalup, qobjetivoproductivaup, unidadprincipalnombre,
             unidadsecundarianombre, unidadvelocidadid, unidadvelocidadnombre, unidadproductividadnombre,
             disponibilidadprodobjetivo, disponibilidadoperacionalobjetivo, calidadobjetivo)
as
WITH t AS (SELECT mh.id                                                            AS medidaid,
                  mh.finicio                                                       AS medidafechainicio,
                  mh.ffin                                                          AS medidafechafin,
                  mh.fechajornada                                                  AS medidafechajornada,
                  mh.duracion                                                      AS medidaduracion,
                  mh.centro_fk                                                     AS centroid,
                  mh.producto_fk                                                   AS productoid,
                  mh.centroorden_fk                                                AS centroordenid,
                  mh.turno_fk                                                      AS turnoid,
                  mh.estadotipo_fk                                                 AS estadotipoid,
                  mh.cantidad                                                      AS qtotalup,
                  mh.cantidad * mh.ratioprincipalsecundaria                        AS qtotalus,
                  mh.cantidad * mh.ratioprincipaleficiencia                        AS qtotaluv,
                  mh.cantidaddesechada                                             AS qscrapup,
                  mh.cantidaddesechada * mh.ratioprincipalsecundaria               AS qscrapus,
                  mh.cantidaddesechada * mh.ratioprincipaleficiencia               AS qscrapuv,
                  CASE
                      WHEN mh.tmaximo > 0 AND (mh.duracion - mh.tmaximo::double precision) > 0::double precision
                          THEN mh.duracion - mh.tmaximo::double precision
                      ELSE 0::double precision
                      END                                                          AS tparoexceso,
                  mh.tproduccion,
                  CASE
                      WHEN mh.estado_fk = 3 THEN mh.duracion
                      ELSE 0::double precision
                      END                                                          AS tvelocidadreducida,
                  mh.tparorutinario                                                AS tparoprogramado,
                  mh.tfallo,
                  mh.tnoplanificado,
                  mh.toperacional,
                  mh.tproductivo                                                   AS tproductividadhreal,
                  mh.tobjetivo                                                     AS medidatiempoobjetivo,
                  mh.ratioconteoprincipal,
                  mh.ratioprincipalsecundaria,
                  mh.ratioprincipalproductividad,
                  mh.unidadprincipal_fk                                            AS unidadprincipalid,
                  mh.unidadsecundaria_fk                                           AS unidadsecundariaid,
                  mh.unidadproductividad_fk                                        AS unidadproductividadid,
                  mh.unidadeficiencia_fk                                           AS unidadeficienciaid,
                  mh.tipotiempoeficiencia                                          AS unidadproductividadtiempo,
                  mh.prodestandar                                                  AS productividadestandar,
                  mh.rvelocidadobj                                                 AS ratiovelocidadobjetivo,
                  CASE
                      WHEN mh.dpobjetivo > 0::double precision THEN mh.dpobjetivo
                      ELSE 1::double precision
                      END                                                          AS disponibilidadprodobjetivo,
                  CASE
                      WHEN mh.doobjetivo > 0::double precision THEN mh.doobjetivo
                      ELSE 1::double precision
                      END                                                          AS disponibilidadoperacionalobjetivo,
                  mh.calidadobjetivo,
                  mh.vteoria,
                  mh.vobjetivo,
                  mh.ratioprincipaleficiencia,
                  true                                                             AS medidahistorico,
                  COALESCE(mh.talarma, 0::double precision) / 60::double precision AS tmicroparojustificado,
                  mh.epobjetivo                                                    AS eficienciaprodobjetivo,
                  mh.eoobjetivo                                                    AS eficienciaoperobjetivo,
                  mh.cantidadobjep                                                 AS cantidadobjetivoep,
                  mh.cantidadretrasoep
           FROM medidahist mh),
     r AS (SELECT t.medidaid,
                  t.medidafechainicio,
                  t.medidafechafin,
                  t.medidafechajornada,
                  t.medidaduracion,
                  t.centroid,
                  t.productoid,
                  t.centroordenid,
                  t.turnoid,
                  t.estadotipoid,
                  t.qtotalup,
                  t.qtotalus,
                  t.qtotaluv,
                  t.qscrapup,
                  t.qscrapus,
                  t.qscrapuv,
                  t.tparoexceso,
                  t.tproduccion,
                  t.tvelocidadreducida,
                  t.tparoprogramado,
                  t.tfallo,
                  t.tnoplanificado,
                  t.toperacional,
                  t.tproductividadhreal,
                  t.medidatiempoobjetivo,
                  t.ratioconteoprincipal,
                  t.ratioprincipalsecundaria,
                  t.ratioprincipalproductividad,
                  t.unidadprincipalid,
                  t.unidadsecundariaid,
                  t.unidadproductividadid,
                  t.unidadeficienciaid,
                  t.unidadproductividadtiempo,
                  t.productividadestandar,
                  t.ratiovelocidadobjetivo,
                  t.disponibilidadprodobjetivo,
                  t.disponibilidadoperacionalobjetivo,
                  t.calidadobjetivo,
                  t.vteoria,
                  t.vobjetivo,
                  t.ratioprincipaleficiencia,
                  t.medidahistorico,
                  t.tmicroparojustificado,
                  t.eficienciaprodobjetivo,
                  t.eficienciaoperobjetivo,
                  t.cantidadobjetivoep,
                  t.cantidadretrasoep,
                  t.qtotalup - t.qscrapup                                                             AS qrealup,
                  t.qtotalus - t.qscrapus                                                             AS qrealus,
                  t.qtotaluv - t.qscrapuv                                                             AS qrealuv,
                  t.tfallo - t.tparoexceso                                                            AS tparonoprogramado,
                  t.tfallo + t.tparoprogramado                                                        AS ttotalparada,
                  t.toperacional - t.tparoprogramado                                                  AS tproductivo,
                  t.medidaduracion                                                                    AS ttotal,
                  COALESCE(t.qtotaluv / NULLIF(t.vteoria, 0::double precision), 0::double precision)  AS tnetoreal,
                  COALESCE(t.qscrapup / NULLIF(t.vteoria, 0::double precision), 0::double precision)  AS tnocalidad,
                  COALESCE(t.qtotalup * t.calidadobjetivo / NULLIF(t.vteoria, 0::double precision),
                           0::double precision)                                                       AS tnocalidadobjetivo,
                  t.disponibilidadoperacionalobjetivo * t.disponibilidadprodobjetivo *
                  t.toperacional                                                                      AS tproductivoobjetivo,
                  t.vobjetivo / NULLIF(t.vteoria, 0::double precision)                                AS pcvobjetivo,
                  (t.qtotalup - t.qscrapup) * t.ratioprincipalproductividad                           AS tproductividadhobjetivo,
                  t.disponibilidadoperacionalobjetivo * t.disponibilidadprodobjetivo                  AS disponibilidadtotalobjetivo
           FROM t),
     s AS (SELECT r.medidaid,
                  r.medidafechainicio,
                  r.medidafechafin,
                  r.medidafechajornada,
                  r.medidaduracion,
                  r.centroid,
                  r.productoid,
                  r.centroordenid,
                  r.turnoid,
                  r.estadotipoid,
                  r.qtotalup,
                  r.qtotalus,
                  r.qtotaluv,
                  r.qscrapup,
                  r.qscrapus,
                  r.qscrapuv,
                  r.tparoexceso,
                  r.tproduccion,
                  r.tvelocidadreducida,
                  r.tparoprogramado,
                  r.tfallo,
                  r.tnoplanificado,
                  r.toperacional,
                  r.tproductividadhreal,
                  r.medidatiempoobjetivo,
                  r.ratioconteoprincipal,
                  r.ratioprincipalsecundaria,
                  r.ratioprincipalproductividad,
                  r.unidadprincipalid,
                  r.unidadsecundariaid,
                  r.unidadproductividadid,
                  r.unidadeficienciaid,
                  r.unidadproductividadtiempo,
                  r.productividadestandar,
                  r.ratiovelocidadobjetivo,
                  r.disponibilidadprodobjetivo,
                  r.disponibilidadoperacionalobjetivo,
                  r.calidadobjetivo,
                  r.vteoria,
                  r.vobjetivo,
                  r.ratioprincipaleficiencia,
                  r.medidahistorico,
                  r.tmicroparojustificado,
                  r.eficienciaprodobjetivo,
                  r.eficienciaoperobjetivo,
                  r.cantidadobjetivoep,
                  r.cantidadretrasoep,
                  r.qrealup,
                  r.qrealus,
                  r.qrealuv,
                  r.tparonoprogramado,
                  r.ttotalparada,
                  r.tproductivo,
                  r.ttotal,
                  r.tnetoreal,
                  r.tnocalidad,
                  r.tnocalidadobjetivo,
                  r.tproductivoobjetivo,
                  r.pcvobjetivo,
                  r.tproductividadhobjetivo,
                  r.disponibilidadtotalobjetivo,
                  r.tproduccion - r.tnetoreal                                                      AS ttotalmicroparos,
                  r.tproduccion - r.tnetoreal - r.tmicroparojustificado                            AS tmicroparonojustificado,
                  r.tnetoreal - r.tnocalidad                                                       AS tefectivo,
                  r.disponibilidadprodobjetivo * r.tproductivo                                     AS tproduccionobjetivo,
                  r.tproduccion * r.pcvobjetivo                                                    AS tnetoobjetivo,
                  r.tnetoreal * r.calidadobjetivo                                                  AS tefectivoobjetivo,
                  r.toperacional * r.disponibilidadoperacionalobjetivo * r.disponibilidadprodobjetivo * r.pcvobjetivo *
                  r.calidadobjetivo                                                                AS tefectivoobjetivooperacional,
                  r.tproductivo * r.disponibilidadprodobjetivo * r.pcvobjetivo *
                  r.calidadobjetivo                                                                AS tefectivoobjetivoproductivo,
                  r.tproductividadhobjetivo - r.tproductividadhreal                                AS tdiferenciahproductividad
           FROM r),
     u AS (SELECT s.medidaid,
                  s.medidahistorico,
                  s.medidafechajornada,
                  s.medidafechainicio,
                  s.medidafechafin,
                  s.centroordenid,
                  s.centroid,
                  s.productoid,
                  s.turnoid,
                  s.qrealup,
                  s.qrealus,
                  s.qrealuv,
                  s.qscrapup,
                  s.qscrapus,
                  s.qscrapuv,
                  s.qtotalup,
                  s.qtotalus,
                  s.qtotaluv,
                  s.unidadprincipalid,
                  s.unidadsecundariaid,
                  s.unidadproductividadid,
                  s.unidadproductividadtiempo,
                  CASE
                      WHEN s.tmicroparojustificado > 0::double precision THEN s.tmicroparojustificado
                      ELSE 0::double precision
                      END                                                                                             AS tmicroparojustificado,
                  s.tparonoprogramado,
                  s.tparoexceso,
                  s.tfallo,
                  s.tparoprogramado,
                  s.ttotalparada,
                  s.tnoplanificado,
                  s.tproduccion,
                  s.tvelocidadreducida,
                  s.toperacional,
                  s.tproductivo,
                  s.ttotal,
                  s.tnetoreal,
                  s.ttotalmicroparos,
                  s.tmicroparonojustificado,
                  s.tefectivo,
                  s.tproductivoobjetivo,
                  s.tproduccionobjetivo,
                  s.tproductivoobjetivo                                                                               AS toperacionalobjetivo,
                  s.tproduccionobjetivo                                                                               AS tproductivofinalobjetivo,
                  s.tnetoobjetivo,
                  s.tefectivoobjetivo,
                  s.tefectivoobjetivooperacional,
                  s.tefectivoobjetivoproductivo,
                  s.disponibilidadtotalobjetivo,
                  s.vteoria,
                  s.vobjetivo,
                  s.ratioprincipalsecundaria,
                  s.ratioprincipaleficiencia,
                  s.tproductividadhobjetivo,
                  s.tproductividadhreal,
                  s.tdiferenciahproductividad,
                  s.ratioprincipalproductividad,
                  s.productividadestandar,
                  s.disponibilidadprodobjetivo,
                  s.disponibilidadoperacionalobjetivo,
                  s.calidadobjetivo,
                  s.tefectivoobjetivoproductivo * s.vteoria                                                           AS qobjetivoproductivauv,
                  s.tefectivoobjetivooperacional * s.vteoria                                                          AS qobjetivooperacionaluv,
                  s.tefectivoobjetivooperacional * s.vteoria /
                  NULLIF(s.ratioprincipaleficiencia, 0::double precision)                                             AS qobjetivooperacionalup,
                  s.tefectivoobjetivoproductivo * s.vteoria /
                  NULLIF(s.ratioprincipaleficiencia, 0::double precision)                                             AS qobjetivoproductivaup,
                  up.nombre                                                                                           AS unidadprincipalnombre,
                  us.nombre                                                                                           AS unidadsecundarianombre,
                  uv.id                                                                                               AS unidadvelocidadid,
                  uv.nombre                                                                                           AS unidadvelocidadnombre,
                  uprod.nombre                                                                                        AS unidadproductividadnombre
           FROM s
                    LEFT JOIN unidad up ON up.id = s.unidadprincipalid
                    LEFT JOIN unidad us ON us.id = s.unidadsecundariaid
                    LEFT JOIN unidad uv ON uv.id = s.unidadeficienciaid
                    LEFT JOIN unidad uprod ON uprod.id = s.unidadproductividadid)
SELECT medidaid,
       medidahistorico,
       medidafechajornada,
       medidafechainicio,
       medidafechafin,
       centroordenid,
       centroid,
       productoid,
       turnoid,
       qrealup,
       qrealus,
       qrealuv,
       qscrapup,
       qscrapus,
       qscrapuv,
       qtotalup,
       qtotalus,
       qtotaluv,
       unidadprincipalid,
       unidadsecundariaid,
       unidadproductividadid,
       unidadproductividadtiempo,
       tmicroparojustificado,
       tparonoprogramado,
       tparoexceso,
       tfallo,
       tparoprogramado,
       ttotalparada,
       tnoplanificado,
       tproduccion,
       tvelocidadreducida,
       toperacional,
       tproductivo,
       ttotal,
       tnetoreal,
       ttotalmicroparos,
       tmicroparonojustificado,
       tefectivo,
       tproductivoobjetivo,
       tproduccionobjetivo,
       tproductivoobjetivo AS toperacionalobjetivo,
       tproduccionobjetivo AS tproductivofinalobjetivo,
       tnetoobjetivo,
       tefectivoobjetivo,
       tefectivoobjetivooperacional,
       tefectivoobjetivoproductivo,
       disponibilidadtotalobjetivo,
       vteoria,
       vobjetivo,
       ratioprincipalsecundaria,
       ratioprincipaleficiencia,
       tproductividadhobjetivo,
       tproductividadhreal,
       tdiferenciahproductividad,
       ratioprincipalproductividad,
       productividadestandar,
       qobjetivoproductivauv,
       qobjetivooperacionaluv,
       qobjetivooperacionalup,
       qobjetivoproductivaup,
       unidadprincipalnombre,
       unidadsecundarianombre,
       unidadvelocidadid,
       unidadvelocidadnombre,
       unidadproductividadnombre,
       disponibilidadprodobjetivo,
       disponibilidadoperacionalobjetivo,
       calidadobjetivo
FROM u;

alter table vbaseindicadoreshistorico
    owner to postgres;

create view vbaseindicadoreshistoricomag
            (medidafechainicio, medidafechafin, centroid, unidadprincipalid, unidadprincipalnombre, unidadsecundariaid,
             unidadsecundarianombre, unidadvelocidadid, unidadvelocidadnombre, unidadproductividadid,
             unidadproductividadnombre, tipotiempoproductividad, centrotipotiempoeficiencia, qrealup, qrealus, qrealuv,
             qscrapup, qscrapus, qscrapuv, qtotalup, qtotalus, qtotaluv, tmicroparojustificado, tparonoprogramado,
             tparoexceso, tfallo, tparoprogramado, ttotalparada, tnoplanificado, tproduccion, ttotal, tnetoreal,
             ttotalmicroparos, tmicroparonojustificado, tefectivo, tproductivoobjetivo, tproduccionobjetivo,
             tnetoobjetivo, tefectivoobjetivo, tefectivoobjetivooperacional, tefectivoobjetivoproductivo,
             tproductividadhobjetivo, tproductividadhreal, qobjetivooperacionalup, qobjetivoproductivaup,
             tvelocidadreducida, toperacional, tproductivo, productoid, turnoid, centroordenid, operarioresponsableid,
             productividadestandar, medidafechajornada, toperacionalobjetivo, ratioprincipaleficiencia,
             ratioprincipalsecundaria, estadoid, tnooperativo, tnoplanificadoconocupacion, unidadauxiliarid,
             unidadauxiliarnombre, ratioprincipalauxiliar)
as
WITH base AS NOT MATERIALIZED (SELECT mh.id                     AS medidaid,
                                      mh.finicio                AS medidafechainicio,
                                      mh.ffin                   AS medidafechafin,
                                      mh.fechajornada           AS medidafechajornada,
                                      mh.duracion               AS medidaduracion,
                                      mh.centro_fk              AS centroid,
                                      mh.producto_fk            AS productoid,
                                      mh.centroorden_fk         AS centroordenid,
                                      mh.turno_fk               AS turnoid,
                                      mh.estadotipo_fk          AS estadotipoid,
                                      mh.estado_fk              AS estadoid,
                                      mh.cantidad               AS medidacantidad,
                                      mh.cantidaddesechada      AS medidacantidaddesechada,
                                      mh.tproduccion,
                                      mh.tparorutinario         AS tparoprogramado,
                                      mh.tfallo,
                                      mh.tnoplanificado,
                                      mh.operarioresponsable_fk AS operarioresponsableid,
                                      mh.operario_fk            AS operarioid,
                                      mh.toperacional,
                                      mh.tproductivo            AS tproductividadhreal,
                                      mh.tobjetivo              AS medidatiempoobjetivo,
                                      mh.tnoplanificadoconocupacion,
                                      mh.tnooperativo,
                                      mh.ratioconteoprincipal,
                                      mh.ratioprincipalsecundaria,
                                      mh.ratioprincipalproductividad,
                                      mh.ratioprincipalauxiliar,
                                      mh.unidadprincipal_fk     AS unidadprincipalid,
                                      mh.unidadsecundaria_fk    AS unidadsecundariaid,
                                      mh.unidadproductividad_fk AS unidadproductividadid,
                                      mh.unidadeficiencia_fk    AS unidadeficienciaid,
                                      mh.unidadauxiliar_fk      AS unidadauxiliarid,
                                      mh.tipotiempoeficiencia   AS centrotipotiempoeficiencia,
                                      mh.rvelocidadobj          AS ratiovelocidadobjetivo,
                                      mh.vteoria,
                                      mh.vobjetivo,
                                      mh.ratioprincipaleficiencia,
                                      mh.talarma,
                                      mh.epobjetivo             AS eficienciaprodobjetivo,
                                      mh.eoobjetivo             AS eficienciaoperobjetivo,
                                      mh.cantidadobjep          AS cantidadobjetivoep,
                                      mh.cantidadretrasoep,
                                      mh.tmaximo,
                                      c.tipotiempoproductividad,
                                      c.tipounidadproductividad,
                                      CASE
                                          WHEN c.tipotiempoproductividad::text = 'horas'::text
                                              THEN mh.prodestandar / 60::double precision
                                          ELSE mh.prodestandar
                                          END                   AS productividadestandar,
                                      CASE
                                          WHEN mh.dpobjetivo > 0::double precision THEN mh.dpobjetivo
                                          ELSE 1::double precision
                                          END                   AS disponibilidadprodobjetivo,
                                      CASE
                                          WHEN mh.doobjetivo > 0::double precision THEN mh.doobjetivo
                                          ELSE 1::double precision
                                          END                   AS disponibilidadoperacionalobjetivo,
                                      CASE
                                          WHEN mh.calidadobjetivo > 0::double precision THEN mh.calidadobjetivo
                                          ELSE 1::double precision
                                          END                   AS calidadobjetivo
                               FROM medidahist mh
                                        JOIN centro c ON mh.centro_fk = c.id),
     calculos AS NOT MATERIALIZED (SELECT b.medidaid,
                                          b.medidafechainicio,
                                          b.medidafechafin,
                                          b.medidafechajornada,
                                          b.medidaduracion,
                                          b.centroid,
                                          b.productoid,
                                          b.centroordenid,
                                          b.turnoid,
                                          b.estadotipoid,
                                          b.estadoid,
                                          b.medidacantidad,
                                          b.medidacantidaddesechada,
                                          b.tproduccion,
                                          b.tparoprogramado,
                                          b.tfallo,
                                          b.tnoplanificado,
                                          b.operarioresponsableid,
                                          b.operarioid,
                                          b.toperacional,
                                          b.tproductividadhreal,
                                          b.medidatiempoobjetivo,
                                          b.tnoplanificadoconocupacion,
                                          b.tnooperativo,
                                          b.ratioconteoprincipal,
                                          b.ratioprincipalsecundaria,
                                          b.ratioprincipalproductividad,
                                          b.ratioprincipalauxiliar,
                                          b.unidadprincipalid,
                                          b.unidadsecundariaid,
                                          b.unidadproductividadid,
                                          b.unidadeficienciaid,
                                          b.unidadauxiliarid,
                                          b.centrotipotiempoeficiencia,
                                          b.ratiovelocidadobjetivo,
                                          b.vteoria,
                                          b.vobjetivo,
                                          b.ratioprincipaleficiencia,
                                          b.talarma,
                                          b.eficienciaprodobjetivo,
                                          b.eficienciaoperobjetivo,
                                          b.cantidadobjetivoep,
                                          b.cantidadretrasoep,
                                          b.tmaximo,
                                          b.tipotiempoproductividad,
                                          b.tipounidadproductividad,
                                          b.productividadestandar,
                                          b.disponibilidadprodobjetivo,
                                          b.disponibilidadoperacionalobjetivo,
                                          b.calidadobjetivo,
                                          b.medidacantidad - b.medidacantidaddesechada                                AS qrealup,
                                          b.medidacantidaddesechada                                                   AS qscrapup,
                                          b.medidacantidad                                                            AS qtotalup,
                                          CASE
                                              WHEN b.tmaximo > 0 AND (b.medidaduracion - b.tmaximo::double precision) >
                                                                     0::double precision
                                                  THEN b.medidaduracion - b.tmaximo::double precision
                                              ELSE 0::double precision
                                              END                                                                     AS tparoexceso,
                                          CASE
                                              WHEN b.estadoid = 3 THEN b.medidaduracion
                                              ELSE 0::double precision
                                              END                                                                     AS tvelocidadreducida,
                                          CASE
                                              WHEN b.estadotipoid = 2
                                                  THEN COALESCE(b.talarma / 60::double precision, 0::double precision)
                                              ELSE 0::double precision
                                              END                                                                     AS tmicroparojustificado,
                                          (b.medidacantidad - b.medidacantidaddesechada) *
                                          b.ratioprincipalsecundaria                                                  AS qrealus,
                                          (b.medidacantidad - b.medidacantidaddesechada) *
                                          b.ratioprincipaleficiencia                                                  AS qrealuv,
                                          b.medidacantidaddesechada * b.ratioprincipalsecundaria                      AS qscrapus,
                                          b.medidacantidaddesechada * b.ratioprincipaleficiencia                      AS qscrapuv,
                                          b.medidacantidad * b.ratioprincipalsecundaria                               AS qtotalus,
                                          b.medidacantidad * b.ratioprincipaleficiencia                               AS qtotaluv
                                   FROM base b),
     tiempos AS NOT MATERIALIZED (SELECT c.medidaid,
                                         c.medidafechainicio,
                                         c.medidafechafin,
                                         c.medidafechajornada,
                                         c.medidaduracion,
                                         c.centroid,
                                         c.productoid,
                                         c.centroordenid,
                                         c.turnoid,
                                         c.estadotipoid,
                                         c.estadoid,
                                         c.medidacantidad,
                                         c.medidacantidaddesechada,
                                         c.tproduccion,
                                         c.tparoprogramado,
                                         c.tfallo,
                                         c.tnoplanificado,
                                         c.operarioresponsableid,
                                         c.operarioid,
                                         c.toperacional,
                                         c.tproductividadhreal,
                                         c.medidatiempoobjetivo,
                                         c.tnoplanificadoconocupacion,
                                         c.tnooperativo,
                                         c.ratioconteoprincipal,
                                         c.ratioprincipalsecundaria,
                                         c.ratioprincipalproductividad,
                                         c.ratioprincipalauxiliar,
                                         c.unidadprincipalid,
                                         c.unidadsecundariaid,
                                         c.unidadproductividadid,
                                         c.unidadeficienciaid,
                                         c.unidadauxiliarid,
                                         c.centrotipotiempoeficiencia,
                                         c.ratiovelocidadobjetivo,
                                         c.vteoria,
                                         c.vobjetivo,
                                         c.ratioprincipaleficiencia,
                                         c.talarma,
                                         c.eficienciaprodobjetivo,
                                         c.eficienciaoperobjetivo,
                                         c.cantidadobjetivoep,
                                         c.cantidadretrasoep,
                                         c.tmaximo,
                                         c.tipotiempoproductividad,
                                         c.tipounidadproductividad,
                                         c.productividadestandar,
                                         c.disponibilidadprodobjetivo,
                                         c.disponibilidadoperacionalobjetivo,
                                         c.calidadobjetivo,
                                         c.qrealup,
                                         c.qscrapup,
                                         c.qtotalup,
                                         c.tparoexceso,
                                         c.tvelocidadreducida,
                                         c.tmicroparojustificado,
                                         c.qrealus,
                                         c.qrealuv,
                                         c.qscrapus,
                                         c.qscrapuv,
                                         c.qtotalus,
                                         c.qtotaluv,
                                         c.tfallo + c.tparoexceso                                           AS tparonoprogramado,
                                         c.tfallo + c.tparoprogramado                                       AS ttotalparada,
                                         c.toperacional - c.tparoprogramado                                 AS tproductivo,
                                         c.medidaduracion                                                   AS ttotal,
                                         CASE
                                             WHEN c.centrotipotiempoeficiencia::text = 'minutos'::text
                                                 THEN COALESCE(c.qtotaluv / c.vteoria, 0::double precision)
                                             WHEN c.centrotipotiempoeficiencia::text = 'horas'::text THEN COALESCE(
                                                     c.qtotaluv / c.vteoria * 60::double precision, 0::double precision)
                                             ELSE 0::double precision
                                             END                                                            AS tnetoreal,
                                         CASE
                                             WHEN c.centrotipotiempoeficiencia::text = 'minutos'::text
                                                 THEN COALESCE(c.qtotaluv / c.vobjetivo, 0::double precision)
                                             WHEN c.centrotipotiempoeficiencia::text = 'horas'::text THEN COALESCE(
                                                     c.qtotaluv / c.vobjetivo * 60::double precision,
                                                     0::double precision)
                                             ELSE 0::double precision
                                             END                                                            AS tnetoobjetivo,
                                         CASE
                                             WHEN c.centrotipotiempoeficiencia::text = 'minutos'::text
                                                 THEN COALESCE(c.qscrapuv / c.vteoria, 0::double precision)
                                             WHEN c.centrotipotiempoeficiencia::text = 'horas'::text THEN COALESCE(
                                                     c.qscrapuv / c.vteoria * 60::double precision, 0::double precision)
                                             ELSE 0::double precision
                                             END                                                            AS tnocalidad,
                                         CASE
                                             WHEN c.centrotipotiempoeficiencia::text = 'minutos'::text THEN COALESCE(
                                                     c.qtotaluv * (1::double precision - c.calidadobjetivo) / c.vteoria,
                                                     0::double precision)
                                             WHEN c.centrotipotiempoeficiencia::text = 'horas'::text THEN COALESCE(
                                                     c.qtotaluv * (1::double precision - c.calidadobjetivo) /
                                                     c.vteoria * 60::double precision, 0::double precision)
                                             ELSE 0::double precision
                                             END                                                            AS tnocalidadobjetivo,
                                         c.vobjetivo / c.vteoria                                            AS pcvobjetivo,
                                         c.qrealup * c.ratioprincipalproductividad                          AS tproductividadhobjetivo,
                                         c.disponibilidadoperacionalobjetivo * c.disponibilidadprodobjetivo AS disponibilidadtotalobjetivo,
                                         CASE
                                             WHEN c.tipounidadproductividad::text = 'principal'::text
                                                 THEN c.qrealup * c.productividadestandar
                                             ELSE c.qrealus * c.productividadestandar
                                             END                                                            AS tiempoestandarproductividad
                                  FROM calculos c),
     metricas AS NOT MATERIALIZED (SELECT t.medidaid,
                                          t.medidafechainicio,
                                          t.medidafechafin,
                                          t.medidafechajornada,
                                          t.medidaduracion,
                                          t.centroid,
                                          t.productoid,
                                          t.centroordenid,
                                          t.turnoid,
                                          t.estadotipoid,
                                          t.estadoid,
                                          t.medidacantidad,
                                          t.medidacantidaddesechada,
                                          t.tproduccion,
                                          t.tparoprogramado,
                                          t.tfallo,
                                          t.tnoplanificado,
                                          t.operarioresponsableid,
                                          t.operarioid,
                                          t.toperacional,
                                          t.tproductividadhreal,
                                          t.medidatiempoobjetivo,
                                          t.tnoplanificadoconocupacion,
                                          t.tnooperativo,
                                          t.ratioconteoprincipal,
                                          t.ratioprincipalsecundaria,
                                          t.ratioprincipalproductividad,
                                          t.ratioprincipalauxiliar,
                                          t.unidadprincipalid,
                                          t.unidadsecundariaid,
                                          t.unidadproductividadid,
                                          t.unidadeficienciaid,
                                          t.unidadauxiliarid,
                                          t.centrotipotiempoeficiencia,
                                          t.ratiovelocidadobjetivo,
                                          t.vteoria,
                                          t.vobjetivo,
                                          t.ratioprincipaleficiencia,
                                          t.talarma,
                                          t.eficienciaprodobjetivo,
                                          t.eficienciaoperobjetivo,
                                          t.cantidadobjetivoep,
                                          t.cantidadretrasoep,
                                          t.tmaximo,
                                          t.tipotiempoproductividad,
                                          t.tipounidadproductividad,
                                          t.productividadestandar,
                                          t.disponibilidadprodobjetivo,
                                          t.disponibilidadoperacionalobjetivo,
                                          t.calidadobjetivo,
                                          t.qrealup,
                                          t.qscrapup,
                                          t.qtotalup,
                                          t.tparoexceso,
                                          t.tvelocidadreducida,
                                          t.tmicroparojustificado,
                                          t.qrealus,
                                          t.qrealuv,
                                          t.qscrapus,
                                          t.qscrapuv,
                                          t.qtotalus,
                                          t.qtotaluv,
                                          t.tparonoprogramado,
                                          t.ttotalparada,
                                          t.tproductivo,
                                          t.ttotal,
                                          t.tnetoreal,
                                          t.tnetoobjetivo,
                                          t.tnocalidad,
                                          t.tnocalidadobjetivo,
                                          t.pcvobjetivo,
                                          t.tproductividadhobjetivo,
                                          t.disponibilidadtotalobjetivo,
                                          t.tiempoestandarproductividad,
                                          t.tproduccion - t.tnetoreal                                      AS ttotalmicroparos,
                                          t.tproduccion - t.tnetoreal - t.tmicroparojustificado            AS tmicroparonojustificado,
                                          t.tnetoreal - t.tnocalidad                                       AS tefectivo,
                                          t.tnetoobjetivo * t.calidadobjetivo                              AS tefectivoobjetivo,
                                          t.tnetoobjetivo                                                  AS tproduccionobjetivo,
                                          t.toperacional * t.disponibilidadoperacionalobjetivo *
                                          t.disponibilidadprodobjetivo * t.pcvobjetivo *
                                          t.calidadobjetivo                                                AS tefectivoobjetivooperacional,
                                          t.tproductivo * t.disponibilidadprodobjetivo * t.pcvobjetivo *
                                          t.calidadobjetivo                                                AS tefectivoobjetivoproductivo,
                                          t.tproductividadhobjetivo - t.tproductividadhreal                AS tdiferenciahproductividad
                                   FROM tiempos t),
     objetivos AS NOT MATERIALIZED (SELECT m.medidaid,
                                           m.medidafechainicio,
                                           m.medidafechafin,
                                           m.medidafechajornada,
                                           m.medidaduracion,
                                           m.centroid,
                                           m.productoid,
                                           m.centroordenid,
                                           m.turnoid,
                                           m.estadotipoid,
                                           m.estadoid,
                                           m.medidacantidad,
                                           m.medidacantidaddesechada,
                                           m.tproduccion,
                                           m.tparoprogramado,
                                           m.tfallo,
                                           m.tnoplanificado,
                                           m.operarioresponsableid,
                                           m.operarioid,
                                           m.toperacional,
                                           m.tproductividadhreal,
                                           m.medidatiempoobjetivo,
                                           m.tnoplanificadoconocupacion,
                                           m.tnooperativo,
                                           m.ratioconteoprincipal,
                                           m.ratioprincipalsecundaria,
                                           m.ratioprincipalproductividad,
                                           m.ratioprincipalauxiliar,
                                           m.unidadprincipalid,
                                           m.unidadsecundariaid,
                                           m.unidadproductividadid,
                                           m.unidadeficienciaid,
                                           m.unidadauxiliarid,
                                           m.centrotipotiempoeficiencia,
                                           m.ratiovelocidadobjetivo,
                                           m.vteoria,
                                           m.vobjetivo,
                                           m.ratioprincipaleficiencia,
                                           m.talarma,
                                           m.eficienciaprodobjetivo,
                                           m.eficienciaoperobjetivo,
                                           m.cantidadobjetivoep,
                                           m.cantidadretrasoep,
                                           m.tmaximo,
                                           m.tipotiempoproductividad,
                                           m.tipounidadproductividad,
                                           m.productividadestandar,
                                           m.disponibilidadprodobjetivo,
                                           m.disponibilidadoperacionalobjetivo,
                                           m.calidadobjetivo,
                                           m.qrealup,
                                           m.qscrapup,
                                           m.qtotalup,
                                           m.tparoexceso,
                                           m.tvelocidadreducida,
                                           m.tmicroparojustificado,
                                           m.qrealus,
                                           m.qrealuv,
                                           m.qscrapus,
                                           m.qscrapuv,
                                           m.qtotalus,
                                           m.qtotaluv,
                                           m.tparonoprogramado,
                                           m.ttotalparada,
                                           m.tproductivo,
                                           m.ttotal,
                                           m.tnetoreal,
                                           m.tnetoobjetivo,
                                           m.tnocalidad,
                                           m.tnocalidadobjetivo,
                                           m.pcvobjetivo,
                                           m.tproductividadhobjetivo,
                                           m.disponibilidadtotalobjetivo,
                                           m.tiempoestandarproductividad,
                                           m.ttotalmicroparos,
                                           m.tmicroparonojustificado,
                                           m.tefectivo,
                                           m.tefectivoobjetivo,
                                           m.tproduccionobjetivo,
                                           m.tefectivoobjetivooperacional,
                                           m.tefectivoobjetivoproductivo,
                                           m.tdiferenciahproductividad,
                                           CASE
                                               WHEN m.centrotipotiempoeficiencia::text = 'minutos'::text
                                                   THEN m.tefectivoobjetivoproductivo * m.vteoria
                                               ELSE m.tefectivoobjetivoproductivo * m.vteoria / 60::double precision
                                               END                                               AS qobjetivoproductivauv,
                                           CASE
                                               WHEN m.centrotipotiempoeficiencia::text = 'minutos'::text
                                                   THEN m.tefectivoobjetivooperacional * m.vteoria
                                               ELSE m.tefectivoobjetivooperacional * m.vteoria / 60::double precision
                                               END                                               AS qobjetivooperacionaluv,
                                           m.tproduccionobjetivo / m.disponibilidadprodobjetivo  AS tproductivoobjetivo,
                                           m.tproduccionobjetivo / m.disponibilidadtotalobjetivo AS toperacionalobjetivo
                                    FROM metricas m),
     con_unidades AS (SELECT o.medidaid,
                             o.medidafechainicio,
                             o.medidafechafin,
                             o.medidafechajornada,
                             o.medidaduracion,
                             o.centroid,
                             o.productoid,
                             o.centroordenid,
                             o.turnoid,
                             o.estadotipoid,
                             o.estadoid,
                             o.medidacantidad,
                             o.medidacantidaddesechada,
                             o.tproduccion,
                             o.tparoprogramado,
                             o.tfallo,
                             o.tnoplanificado,
                             o.operarioresponsableid,
                             o.operarioid,
                             o.toperacional,
                             o.tproductividadhreal,
                             o.medidatiempoobjetivo,
                             o.tnoplanificadoconocupacion,
                             o.tnooperativo,
                             o.ratioconteoprincipal,
                             o.ratioprincipalsecundaria,
                             o.ratioprincipalproductividad,
                             o.ratioprincipalauxiliar,
                             o.unidadprincipalid,
                             o.unidadsecundariaid,
                             o.unidadproductividadid,
                             o.unidadeficienciaid,
                             o.unidadauxiliarid,
                             o.centrotipotiempoeficiencia,
                             o.ratiovelocidadobjetivo,
                             o.vteoria,
                             o.vobjetivo,
                             o.ratioprincipaleficiencia,
                             o.talarma,
                             o.eficienciaprodobjetivo,
                             o.eficienciaoperobjetivo,
                             o.cantidadobjetivoep,
                             o.cantidadretrasoep,
                             o.tmaximo,
                             o.tipotiempoproductividad,
                             o.tipounidadproductividad,
                             o.productividadestandar,
                             o.disponibilidadprodobjetivo,
                             o.disponibilidadoperacionalobjetivo,
                             o.calidadobjetivo,
                             o.qrealup,
                             o.qscrapup,
                             o.qtotalup,
                             o.tparoexceso,
                             o.tvelocidadreducida,
                             o.tmicroparojustificado,
                             o.qrealus,
                             o.qrealuv,
                             o.qscrapus,
                             o.qscrapuv,
                             o.qtotalus,
                             o.qtotaluv,
                             o.tparonoprogramado,
                             o.ttotalparada,
                             o.tproductivo,
                             o.ttotal,
                             o.tnetoreal,
                             o.tnetoobjetivo,
                             o.tnocalidad,
                             o.tnocalidadobjetivo,
                             o.pcvobjetivo,
                             o.tproductividadhobjetivo,
                             o.disponibilidadtotalobjetivo,
                             o.tiempoestandarproductividad,
                             o.ttotalmicroparos,
                             o.tmicroparonojustificado,
                             o.tefectivo,
                             o.tefectivoobjetivo,
                             o.tproduccionobjetivo,
                             o.tefectivoobjetivooperacional,
                             o.tefectivoobjetivoproductivo,
                             o.tdiferenciahproductividad,
                             o.qobjetivoproductivauv,
                             o.qobjetivooperacionaluv,
                             o.tproductivoobjetivo,
                             o.toperacionalobjetivo,
                             up.nombre    AS unidadprincipalnombre,
                             us.nombre    AS unidadsecundarianombre,
                             uv.id        AS unidadvelocidadid,
                             uv.nombre    AS unidadvelocidadnombre,
                             ua.nombre    AS unidadauxiliarnombre,
                             uprod.nombre AS unidadproductividadnombre
                      FROM objetivos o
                               LEFT JOIN unidad up ON up.id = o.unidadprincipalid
                               LEFT JOIN unidad us ON us.id = o.unidadsecundariaid
                               LEFT JOIN unidad uv ON uv.id = o.unidadeficienciaid
                               LEFT JOIN unidad ua ON ua.id = o.unidadauxiliarid
                               LEFT JOIN unidad uprod ON uprod.id = o.unidadproductividadid),
     datos_finales AS (SELECT u.medidaid,
                              u.medidafechainicio,
                              u.medidafechafin,
                              u.medidafechajornada,
                              u.medidaduracion,
                              u.centroid,
                              u.productoid,
                              u.centroordenid,
                              u.turnoid,
                              u.estadotipoid,
                              u.estadoid,
                              u.medidacantidad,
                              u.medidacantidaddesechada,
                              u.tproduccion,
                              u.tparoprogramado,
                              u.tfallo,
                              u.tnoplanificado,
                              u.operarioresponsableid,
                              u.operarioid,
                              u.toperacional,
                              u.tproductividadhreal,
                              u.medidatiempoobjetivo,
                              u.tnoplanificadoconocupacion,
                              u.tnooperativo,
                              u.ratioconteoprincipal,
                              u.ratioprincipalsecundaria,
                              u.ratioprincipalproductividad,
                              u.ratioprincipalauxiliar,
                              u.unidadprincipalid,
                              u.unidadsecundariaid,
                              u.unidadproductividadid,
                              u.unidadeficienciaid,
                              u.unidadauxiliarid,
                              u.centrotipotiempoeficiencia,
                              u.ratiovelocidadobjetivo,
                              u.vteoria,
                              u.vobjetivo,
                              u.ratioprincipaleficiencia,
                              u.talarma,
                              u.eficienciaprodobjetivo,
                              u.eficienciaoperobjetivo,
                              u.cantidadobjetivoep,
                              u.cantidadretrasoep,
                              u.tmaximo,
                              u.tipotiempoproductividad,
                              u.tipounidadproductividad,
                              u.productividadestandar,
                              u.disponibilidadprodobjetivo,
                              u.disponibilidadoperacionalobjetivo,
                              u.calidadobjetivo,
                              u.qrealup,
                              u.qscrapup,
                              u.qtotalup,
                              u.tparoexceso,
                              u.tvelocidadreducida,
                              u.tmicroparojustificado,
                              u.qrealus,
                              u.qrealuv,
                              u.qscrapus,
                              u.qscrapuv,
                              u.qtotalus,
                              u.qtotaluv,
                              u.tparonoprogramado,
                              u.ttotalparada,
                              u.tproductivo,
                              u.ttotal,
                              u.tnetoreal,
                              u.tnetoobjetivo,
                              u.tnocalidad,
                              u.tnocalidadobjetivo,
                              u.pcvobjetivo,
                              u.tproductividadhobjetivo,
                              u.disponibilidadtotalobjetivo,
                              u.tiempoestandarproductividad,
                              u.ttotalmicroparos,
                              u.tmicroparonojustificado,
                              u.tefectivo,
                              u.tefectivoobjetivo,
                              u.tproduccionobjetivo,
                              u.tefectivoobjetivooperacional,
                              u.tefectivoobjetivoproductivo,
                              u.tdiferenciahproductividad,
                              u.qobjetivoproductivauv,
                              u.qobjetivooperacionaluv,
                              u.tproductivoobjetivo,
                              u.toperacionalobjetivo,
                              u.unidadprincipalnombre,
                              u.unidadsecundarianombre,
                              u.unidadvelocidadid,
                              u.unidadvelocidadnombre,
                              u.unidadauxiliarnombre,
                              u.unidadproductividadnombre,
                              u.qobjetivooperacionaluv / u.ratioprincipaleficiencia AS qobjetivooperacionalup,
                              u.qobjetivoproductivauv / u.ratioprincipaleficiencia  AS qobjetivoproductivaup
                       FROM con_unidades u)
SELECT medidafechainicio,
       medidafechafin,
       centroid,
       unidadprincipalid,
       unidadprincipalnombre,
       unidadsecundariaid,
       unidadsecundarianombre,
       unidadvelocidadid,
       unidadvelocidadnombre,
       unidadproductividadid,
       unidadproductividadnombre,
       tipotiempoproductividad,
       centrotipotiempoeficiencia,
       qrealup,
       qrealus,
       qrealuv,
       qscrapup,
       qscrapus,
       qscrapuv,
       qtotalup,
       qtotalus,
       qtotaluv,
       tmicroparojustificado,
       tparonoprogramado,
       tparoexceso,
       tfallo,
       tparoprogramado,
       ttotalparada,
       tnoplanificado,
       tproduccion,
       ttotal,
       tnetoreal,
       ttotalmicroparos,
       tmicroparonojustificado,
       tefectivo,
       tproductivoobjetivo,
       tproduccionobjetivo,
       tnetoobjetivo,
       tefectivoobjetivo,
       tefectivoobjetivooperacional,
       tefectivoobjetivoproductivo,
       tproductividadhobjetivo,
       tproductividadhreal,
       qobjetivooperacionalup,
       qobjetivoproductivaup,
       tvelocidadreducida,
       toperacional,
       tproductivo,
       productoid,
       turnoid,
       centroordenid,
       operarioresponsableid,
       productividadestandar,
       medidafechajornada,
       toperacionalobjetivo,
       ratioprincipaleficiencia,
       ratioprincipalsecundaria,
       estadoid,
       tnooperativo,
       tnoplanificadoconocupacion,
       unidadauxiliarid,
       unidadauxiliarnombre,
       ratioprincipalauxiliar
FROM datos_finales;

alter table vbaseindicadoreshistoricomag
    owner to postgres;

create view vmedida
            (id, finicio, ffin, valormedida, centroestado_fk, centroproducto_fk, grupo, incidencia, justificacion,
             justificada, orden, tipomedida, valoropc, valorideal, valorobjetivo, valornarmario, valornpalet,
             valorpesomedio, valornplacas, valorfaltapeso, valorgruesas, turno_fk, duracion, automatica,
             valormedidaxmin, umbralmaxxmin, umbralminxmin, ordensuperada, centroorden_fk, inconsistenciacentroorden,
             created, updated, operario_fk, operarioresponsable_fk, documento, cerrada, centro_fk)
as
SELECT id,
       finicio,
       COALESCE(ffin::timestamp with time zone, now()) AS ffin,
       valormedida,
       centroestado_fk,
       centroproducto_fk,
       grupo,
       incidencia,
       justificacion,
       justificada,
       orden,
       tipomedida,
       valoropc,
       valorideal,
       valorobjetivo,
       valornarmario,
       valornpalet,
       valorpesomedio,
       valornplacas,
       valorfaltapeso,
       valorgruesas,
       turno_fk,
       EXTRACT(epoch FROM COALESCE(ffin::timestamp with time zone, now()) - finicio::timestamp with time zone) /
       60::numeric                                     AS duracion,
       automatica,
       valormedidaxmin,
       umbralmaxxmin,
       umbralminxmin,
       ordensuperada,
       centroorden_fk,
       inconsistenciacentroorden,
       created,
       updated,
       operario_fk,
       operarioresponsable_fk,
       documento,
       cerrada,
       centro_fk
FROM medida m;

alter table vmedida
    owner to postgres;

create view vbaseindicadoresmag
            (medidafechainicio, medidafechafin, centroid, unidadprincipalid, unidadprincipalnombre, unidadsecundariaid,
             unidadsecundarianombre, unidadvelocidadid, unidadvelocidadnombre, unidadproductividadid,
             unidadproductividadnombre, tipotiempoproductividad, centrotipotiempoeficiencia, qrealup, qrealus, qrealuv,
             qscrapup, qscrapus, qscrapuv, qtotalup, qtotalus, qtotaluv, tmicroparojustificado, tparonoprogramado,
             tparoexceso, tfallo, tparoprogramado, ttotalparada, tnoplanificado, tproduccion, ttotal, tnetoreal,
             ttotalmicroparos, tmicroparonojustificado, tefectivo, tproductivoobjetivo, tproduccionobjetivo,
             tnetoobjetivo, tefectivoobjetivo, tefectivoobjetivooperacional, tefectivoobjetivoproductivo,
             tproductividadhobjetivo, tproductividadhreal, qobjetivooperacionalup, qobjetivoproductivaup,
             tvelocidadreducida, toperacional, tproductivo, productoid, turnoid, centroordenid, operarioresponsableid,
             productividadestandar, medidafechajornada, toperacionalobjetivo, ratioprincipaleficiencia,
             ratioprincipalsecundaria, estadoid, tnooperativo, tnoplanificadoconocupacion, unidadauxiliarid,
             unidadauxiliarnombre, ratioprincipalauxiliar)
as
WITH medidasbase AS (SELECT min(m.finicio)     AS finicio,
                            max(m.ffin)        AS ffin,
                            min(m.id)          AS id,
                            m.centroorden_fk,
                            m.centroestado_fk,
                            m.grupo,
                            m.turno_fk,
                            m.operarioresponsable_fk,
                            m.centroproducto_fk,
                            sum(m.valormedida) AS valormedida,
                            sum(m.duracion)    AS duracion
                     FROM vmedida m
                     WHERE m.tipomedida::text = 'estados'::text
                     GROUP BY m.centroorden_fk, m.centroestado_fk, m.grupo, m.turno_fk, m.operarioresponsable_fk,
                              m.centroproducto_fk),
     medidas_produccion_raw AS (SELECT mp.centroorden_fk,
                                       mp.ffin,
                                       mp.tipomedida,
                                       mp.valormedida
                                FROM medida mp
                                WHERE mp.tipomedida::text = ANY
                                      (ARRAY ['produccion'::character varying, 'cantidaddesechada'::character varying]::text[])),
     medidas_consumo_raw AS (SELECT c.centroorden_fk,
                                    c.fecha,
                                    c.tipooperacion,
                                    c.valorconsumo
                             FROM consumo c
                             WHERE c.tipooperacion::text = ANY
                                   (ARRAY ['PRODUCCION'::character varying, 'CANTIDADDESECHADA'::character varying]::text[])),
     medidas_produccion AS (SELECT m.id                                            AS medida_id,
                                   COALESCE(sum(
                                                    CASE
                                                        WHEN mp.tipomedida::text = 'produccion'::text
                                                            THEN mp.valormedida
                                                        ELSE 0::double precision
                                                        END), 0::double precision) AS cantidad,
                                   COALESCE(sum(
                                                    CASE
                                                        WHEN mp.tipomedida::text = 'cantidaddesechada'::text
                                                            THEN mp.valormedida
                                                        ELSE 0::double precision
                                                        END), 0::double precision) AS cantidaddesechada
                            FROM medidasbase m
                                     LEFT JOIN medidas_produccion_raw mp
                                               ON mp.centroorden_fk = m.centroorden_fk AND m.finicio < mp.ffin AND
                                                  m.ffin >= mp.ffin
                            GROUP BY m.id),
     medidas_consumo AS (SELECT m.id                                            AS medida_id,
                                COALESCE(sum(
                                                 CASE
                                                     WHEN mc.tipooperacion::text = 'PRODUCCION'::text
                                                         THEN mc.valorconsumo
                                                     ELSE 0::double precision
                                                     END), 0::double precision) AS consumo,
                                COALESCE(sum(
                                                 CASE
                                                     WHEN mc.tipooperacion::text = 'CANTIDADDESECHADA'::text
                                                         THEN mc.valorconsumo
                                                     ELSE 0::double precision
                                                     END), 0::double precision) AS consumodesechado
                         FROM medidasbase m
                                  LEFT JOIN medidas_consumo_raw mc
                                            ON mc.centroorden_fk = m.centroorden_fk AND m.finicio < mc.fecha AND
                                               m.ffin >= mc.fecha
                         GROUP BY m.id),
     medidas_productividad AS (SELECT m.id                                           AS medida_id,
                                      sum(EXTRACT(epoch FROM
                                                  LEAST(COALESCE(pm.fechafin::timestamp with time zone, now()),
                                                        COALESCE(m.ffin, now())) -
                                                  GREATEST(pm.fechainicio, m.finicio)::timestamp with time zone)::double precision *
                                          pmc.intensidad / 6000.0::double precision) AS tiempoproductividadminutos
                               FROM medidasbase m
                                        LEFT JOIN centroproducto cp ON m.centroproducto_fk = cp.id
                                        LEFT JOIN productividadmedidacentro pmc ON pmc.centro_fk = cp.centro_fk
                                        LEFT JOIN productividadmedida pm ON pm.id = pmc.medida_fk
                                        LEFT JOIN estadooperario eo ON eo.id = pm.estado_fk AND eo.tiempoproductivo = true
                               WHERE eo.id IS NOT NULL
                                 AND COALESCE(m.ffin, now()) > pm.fechainicio
                                 AND m.finicio < COALESCE(pm.fechafin::timestamp with time zone, now())
                               GROUP BY m.id),
     calculos AS (SELECT m.id                                                                         AS medidaid,
                         m.finicio                                                                    AS medidafechainicio,
                         m.ffin                                                                       AS medidafechafin,
                         date_trunc('day'::text, m.finicio)                                           AS medidafechajornada,
                         m.valormedida,
                         EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0      AS medidaduracion,
                         cp.centro_fk                                                                 AS centroid,
                         cp.producto_fk                                                               AS productoid,
                         m.centroorden_fk                                                             AS centroordenid,
                         m.turno_fk                                                                   AS turnoid,
                         m.operarioresponsable_fk                                                     AS operarioresponsableid,
                         e.id                                                                         AS estadoid,
                         et.id                                                                        AS estadotipoid,
                         COALESCE(mp.cantidad, 0::double precision)                                   AS medidacantidad,
                         COALESCE(mp.cantidaddesechada, 0::double precision)                          AS medidacantidaddesechada,
                         COALESCE(mc.consumo, 0::double precision)                                    AS medidaconsumo,
                         COALESCE(mc.consumodesechado, 0::double precision)                           AS medidaconsumodesechada,
                         COALESCE(mprod.tiempoproductividadminutos, 0::double precision)              AS tiemporealproductividadminutos,
                         cp.ratioconteoprincipal,
                         cp.ratioprincipalsecundaria,
                         cp.ratioprincipalauxiliar,
                         cp.ratioprincipaleficiencia,
                         cp.vteoria,
                         cp.vobjetivo,
                         cp.prodestandar                                                              AS productividadestandar,
                         c.unidadprincipal_fk                                                         AS unidadprincipalid,
                         c.unidadsecundaria_fk                                                        AS unidadsecundariaid,
                         c.unidadauxiliar_fk                                                          AS unidadauxiliarid,
                         CASE
                             WHEN c.tipounidadproductividad::text = 'principal'::text THEN c.unidadprincipal_fk
                             ELSE c.unidadsecundaria_fk
                             END                                                                      AS unidadproductividadid,
                         c.unidadeficiencia_fk                                                        AS unidadvelocidadid,
                         c.tipotiempoeficiencia                                                       AS centrotipotiempoeficiencia,
                         c.tipounidadproductividad,
                         c.tipotiempoproductividad,
                         c.vbleestadosesproductiva,
                         COALESCE(cp.disponibilidad * 0.01::double precision,
                                  1.0::double precision)                                              AS disponibilidadprodobjetivo,
                         COALESCE(cp.doobjetivo * 0.01::double precision,
                                  1.0::double precision)                                              AS disponibilidadoperacionalobjetivo,
                         COALESCE(cp.calidadobjetivo * 0.01::double precision,
                                  1.0::double precision)                                              AS calidadobjetivo,
                         cp.vobjetivo / NULLIF(cp.vteoria, 0::double precision)                       AS ratiovelocidadobjetivo,
                         CASE
                             WHEN ce.tmaximo > 0 AND m.duracion > ce.tmaximo::numeric THEN m.duracion - ce.tmaximo::numeric
                             ELSE 0::numeric
                             END                                                                      AS tparoexceso,
                         CASE
                             WHEN et.id = 2 THEN COALESCE((SELECT sum(EXTRACT(epoch FROM
                                                                              LEAST(ca.fechafin::timestamp with time zone, m.ffin) -
                                                                              GREATEST(ca.fechainicio, m.finicio)::timestamp with time zone) /
                                                                      60.0) AS sum
                                                           FROM centroalarma ca
                                                           WHERE ca.centro_fk = c.id
                                                             AND ca.fechainicio <= m.ffin
                                                             AND ca.fechafin >= m.finicio), 0::numeric)
                             ELSE 0::numeric
                             END                                                                      AS tmicroparojustificado,
                         CASE
                             WHEN et.id = 2 THEN EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0
                             ELSE 0::numeric
                             END                                                                      AS tproduccion,
                         CASE
                             WHEN et.id = 2 AND e.id = 3
                                 THEN EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0
                             ELSE 0::numeric
                             END                                                                      AS tvelocidadreducida,
                         CASE
                             WHEN et.id = 3 THEN EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0
                             ELSE 0::numeric
                             END                                                                      AS tparoprogramado,
                         CASE
                             WHEN et.id = 4 THEN EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0
                             ELSE 0::numeric
                             END                                                                      AS tfallo,
                         CASE
                             WHEN et.id = ANY (ARRAY [5::bigint, 6::bigint])
                                 THEN EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0
                             ELSE 0::numeric
                             END                                                                      AS tnoplanificado,
                         CASE
                             WHEN et.id = 6 THEN EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0
                             ELSE 0::numeric
                             END                                                                      AS tnooperativo,
                         CASE
                             WHEN e.id = 9 THEN EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0
                             ELSE 0::numeric
                             END                                                                      AS tnoplanificadoconocupacion,
                         CASE
                             WHEN et.id = ANY (ARRAY [2::bigint, 3::bigint, 4::bigint])
                                 THEN EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0
                             ELSE 0::numeric
                             END                                                                      AS toperacional,
                         EXTRACT(epoch FROM m.ffin - m.finicio::timestamp with time zone) / 60.0      AS ttotal,
                         up.nombre                                                                    AS unidadprincipalnombre,
                         us.nombre                                                                    AS unidadsecundarianombre,
                         uv.nombre                                                                    AS unidadvelocidadnombre,
                         uprod.nombre                                                                 AS unidadproductividadnombre,
                         ua.nombre                                                                    AS unidadauxiliarnombre
                  FROM medidasbase m
                           LEFT JOIN centroproducto cp ON m.centroproducto_fk = cp.id
                           LEFT JOIN centro c ON cp.centro_fk = c.id
                           LEFT JOIN centroestado ce ON m.centroestado_fk = ce.id
                           LEFT JOIN estado e ON ce.estado_fk = e.id
                           LEFT JOIN estadotipo et ON e.tipo_fk = et.id
                           LEFT JOIN medidas_produccion mp ON mp.medida_id = m.id
                           LEFT JOIN medidas_consumo mc ON mc.medida_id = m.id
                           LEFT JOIN medidas_productividad mprod ON mprod.medida_id = m.id
                           LEFT JOIN unidad up ON up.id = c.unidadprincipal_fk
                           LEFT JOIN unidad us ON us.id = c.unidadsecundaria_fk
                           LEFT JOIN unidad uv ON uv.id = c.unidadeficiencia_fk
                           LEFT JOIN unidad uprod ON uprod.id =
                                                     CASE
                                                         WHEN c.tipounidadproductividad::text = 'principal'::text
                                                             THEN c.unidadprincipal_fk
                                                         ELSE c.unidadsecundaria_fk
                                                         END
                           LEFT JOIN unidad ua ON ua.id = c.unidadauxiliar_fk)
SELECT medidafechainicio,
       medidafechafin,
       centroid,
       unidadprincipalid,
       unidadprincipalnombre,
       unidadsecundariaid,
       unidadsecundarianombre,
       unidadvelocidadid,
       unidadvelocidadnombre,
       unidadproductividadid,
       unidadproductividadnombre,
       tipotiempoproductividad,
       centrotipotiempoeficiencia,
       medidacantidad + medidaconsumo - (medidacantidaddesechada + medidaconsumodesechada) AS qrealup,
       (medidacantidad + medidaconsumo - (medidacantidaddesechada + medidaconsumodesechada)) *
       ratioprincipalsecundaria                                                            AS qrealus,
       (medidacantidad + medidaconsumo - (medidacantidaddesechada + medidaconsumodesechada)) *
       ratioprincipaleficiencia                                                            AS qrealuv,
       medidacantidaddesechada + medidaconsumodesechada                                    AS qscrapup,
       (medidacantidaddesechada + medidaconsumodesechada) * ratioprincipalsecundaria       AS qscrapus,
       (medidacantidaddesechada + medidaconsumodesechada) * ratioprincipaleficiencia       AS qscrapuv,
       medidacantidad + medidaconsumo                                                      AS qtotalup,
       (medidacantidad + medidaconsumo) * ratioprincipalsecundaria                         AS qtotalus,
       (medidacantidad + medidaconsumo) * ratioprincipaleficiencia                         AS qtotaluv,
       tmicroparojustificado,
       tfallo + tparoexceso                                                                AS tparonoprogramado,
       tparoexceso,
       tfallo,
       tparoprogramado,
       tfallo + tparoprogramado                                                            AS ttotalparada,
       tnoplanificado,
       tproduccion,
       ttotal,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vteoria, 0::double precision)
           ELSE (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vteoria, 0::double precision) *
                60.0::double precision
           END                                                                             AS tnetoreal,
       tproduccion::double precision -
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vteoria, 0::double precision)
           ELSE (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vteoria, 0::double precision) *
                60.0::double precision
           END                                                                             AS ttotalmicroparos,
       tproduccion::double precision -
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vteoria, 0::double precision)
           ELSE (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vteoria, 0::double precision) *
                60.0::double precision
           END - COALESCE(tmicroparojustificado, 0::numeric)::double precision             AS tmicroparonojustificado,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vteoria, 0::double precision) -
               (medidacantidaddesechada + medidaconsumodesechada) * ratioprincipaleficiencia /
               NULLIF(vteoria, 0::double precision)
           ELSE ((medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vteoria, 0::double precision) -
                 (medidacantidaddesechada + medidaconsumodesechada) * ratioprincipaleficiencia /
                 NULLIF(vteoria, 0::double precision)) * 60.0::double precision
           END                                                                             AS tefectivo,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision)
           ELSE (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision) *
                60.0::double precision
           END / NULLIF(disponibilidadprodobjetivo, 0::double precision)                   AS tproductivoobjetivo,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision)
           ELSE (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision) *
                60.0::double precision
           END                                                                             AS tproduccionobjetivo,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision)
           ELSE (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision) *
                60.0::double precision
           END                                                                             AS tnetoobjetivo,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision) *
               calidadobjetivo
           ELSE (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision) *
                60.0::double precision * calidadobjetivo
           END                                                                             AS tefectivoobjetivo,
       toperacional::double precision * disponibilidadoperacionalobjetivo * disponibilidadprodobjetivo *
       ratiovelocidadobjetivo *
       calidadobjetivo                                                                     AS tefectivoobjetivooperacional,
       (toperacional - tparoprogramado)::double precision * disponibilidadprodobjetivo * ratiovelocidadobjetivo *
       calidadobjetivo                                                                     AS tefectivoobjetivoproductivo,
       CASE
           WHEN tipounidadproductividad::text = 'principal'::text THEN
               (medidacantidad + medidaconsumo - (medidacantidaddesechada + medidaconsumodesechada)) *
               productividadestandar
           ELSE (medidacantidad + medidaconsumo - (medidacantidaddesechada + medidaconsumodesechada)) *
                ratioprincipalsecundaria * productividadestandar
           END                                                                             AS tproductividadhobjetivo,
       CASE
           WHEN estadotipoid = 2 THEN medidaduracion
           WHEN estadotipoid = 3 AND tparoexceso > 0::numeric THEN tparoexceso
           WHEN estadotipoid = 4 THEN medidaduracion
           ELSE 0::numeric
           END                                                                             AS tproductividadhreal,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               toperacional::double precision * disponibilidadoperacionalobjetivo * disponibilidadprodobjetivo *
               ratiovelocidadobjetivo * calidadobjetivo * vteoria /
               NULLIF(ratioprincipaleficiencia, 0::double precision)
           ELSE toperacional::double precision * disponibilidadoperacionalobjetivo * disponibilidadprodobjetivo *
                ratiovelocidadobjetivo * calidadobjetivo * vteoria / 60.0::double precision /
                NULLIF(ratioprincipaleficiencia, 0::double precision)
           END                                                                             AS qobjetivooperacionalup,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (toperacional - tparoprogramado)::double precision * disponibilidadprodobjetivo *
               ratiovelocidadobjetivo * calidadobjetivo * vteoria /
               NULLIF(ratioprincipaleficiencia, 0::double precision)
           ELSE (toperacional - tparoprogramado)::double precision * disponibilidadprodobjetivo *
                ratiovelocidadobjetivo * calidadobjetivo * vteoria / 60.0::double precision /
                NULLIF(ratioprincipaleficiencia, 0::double precision)
           END                                                                             AS qobjetivoproductivaup,
       tvelocidadreducida,
       toperacional,
       toperacional - tparoprogramado                                                      AS tproductivo,
       productoid,
       turnoid,
       centroordenid,
       operarioresponsableid,
       productividadestandar,
       medidafechajornada,
       CASE
           WHEN centrotipotiempoeficiencia::text = 'minutos'::text THEN
               (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision)
           ELSE (medidacantidad + medidaconsumo) * ratioprincipaleficiencia / NULLIF(vobjetivo, 0::double precision) *
                60.0::double precision
           END / NULLIF(disponibilidadprodobjetivo, 0::double precision)                   AS toperacionalobjetivo,
       ratioprincipaleficiencia,
       ratioprincipalsecundaria,
       estadoid,
       tnooperativo,
       tnoplanificadoconocupacion,
       unidadauxiliarid,
       unidadauxiliarnombre,
       ratioprincipalauxiliar
FROM calculos;

alter table vbaseindicadoresmag
    owner to postgres;

create view vbaseindicadorestotalmag
            (medidafechainicio, medidafechafin, centroid, unidadprincipalid, unidadprincipalnombre, unidadsecundariaid,
             unidadsecundarianombre, unidadvelocidadid, unidadvelocidadnombre, unidadproductividadid,
             unidadproductividadnombre, tipotiempoproductividad, centrotipotiempoeficiencia, qrealup, qrealus, qrealuv,
             qscrapup, qscrapus, qscrapuv, qtotalup, qtotalus, qtotaluv, tmicroparojustificado, tparonoprogramado,
             tparoexceso, tfallo, tparoprogramado, ttotalparada, tnoplanificado, tproduccion, ttotal, tnetoreal,
             ttotalmicroparos, tmicroparonojustificado, tefectivo, tproductivoobjetivo, tproduccionobjetivo,
             tnetoobjetivo, tefectivoobjetivo, tefectivoobjetivooperacional, tefectivoobjetivoproductivo,
             tproductividadhobjetivo, tproductividadhreal, qobjetivooperacionalup, qobjetivoproductivaup,
             tvelocidadreducida, toperacional, tproductivo, productoid, turnoid, centroordenid, operarioresponsableid,
             productividadestandar, medidafechajornada, toperacionalobjetivo)
as
SELECT vbih.medidafechainicio,
       vbih.medidafechafin,
       vbih.centroid,
       vbih.unidadprincipalid,
       vbih.unidadprincipalnombre,
       vbih.unidadsecundariaid,
       vbih.unidadsecundarianombre,
       vbih.unidadvelocidadid,
       vbih.unidadvelocidadnombre,
       vbih.unidadproductividadid,
       vbih.unidadproductividadnombre,
       vbih.tipotiempoproductividad,
       vbih.centrotipotiempoeficiencia,
       vbih.qrealup,
       vbih.qrealus,
       vbih.qrealuv,
       vbih.qscrapup,
       vbih.qscrapus,
       vbih.qscrapuv,
       vbih.qtotalup,
       vbih.qtotalus,
       vbih.qtotaluv,
       vbih.tmicroparojustificado,
       vbih.tparonoprogramado,
       vbih.tparoexceso,
       vbih.tfallo,
       vbih.tparoprogramado,
       vbih.ttotalparada,
       vbih.tnoplanificado,
       vbih.tproduccion,
       vbih.ttotal,
       vbih.tnetoreal,
       vbih.ttotalmicroparos,
       vbih.tmicroparonojustificado,
       vbih.tefectivo,
       vbih.tproductivoobjetivo,
       vbih.tproduccionobjetivo,
       vbih.tnetoobjetivo,
       vbih.tefectivoobjetivo,
       vbih.tefectivoobjetivooperacional,
       vbih.tefectivoobjetivoproductivo,
       vbih.tproductividadhobjetivo,
       vbih.tproductividadhreal,
       vbih.qobjetivooperacionalup,
       vbih.qobjetivoproductivaup,
       vbih.tvelocidadreducida,
       vbih.toperacional,
       vbih.tproductivo,
       vbih.productoid,
       vbih.turnoid,
       vbih.centroordenid,
       vbih.operarioresponsableid,
       vbih.productividadestandar,
       vbih.medidafechajornada,
       vbih.toperacionalobjetivo
FROM vbaseindicadoreshistoricomag vbih
UNION
SELECT vbim.medidafechainicio,
       vbim.medidafechafin,
       vbim.centroid,
       vbim.unidadprincipalid,
       vbim.unidadprincipalnombre,
       vbim.unidadsecundariaid,
       vbim.unidadsecundarianombre,
       vbim.unidadvelocidadid,
       vbim.unidadvelocidadnombre,
       vbim.unidadproductividadid,
       vbim.unidadproductividadnombre,
       vbim.tipotiempoproductividad,
       vbim.centrotipotiempoeficiencia,
       vbim.qrealup,
       vbim.qrealus,
       vbim.qrealuv,
       vbim.qscrapup,
       vbim.qscrapus,
       vbim.qscrapuv,
       vbim.qtotalup,
       vbim.qtotalus,
       vbim.qtotaluv,
       vbim.tmicroparojustificado,
       vbim.tparonoprogramado,
       vbim.tparoexceso,
       vbim.tfallo,
       vbim.tparoprogramado,
       vbim.ttotalparada,
       vbim.tnoplanificado,
       vbim.tproduccion,
       vbim.ttotal,
       vbim.tnetoreal,
       vbim.ttotalmicroparos,
       vbim.tmicroparonojustificado,
       vbim.tefectivo,
       vbim.tproductivoobjetivo,
       vbim.tproduccionobjetivo,
       vbim.tnetoobjetivo,
       vbim.tefectivoobjetivo,
       vbim.tefectivoobjetivooperacional,
       vbim.tefectivoobjetivoproductivo,
       vbim.tproductividadhobjetivo,
       vbim.tproductividadhreal,
       vbim.qobjetivooperacionalup,
       vbim.qobjetivoproductivaup,
       vbim.tvelocidadreducida,
       vbim.toperacional,
       vbim.tproductivo,
       vbim.productoid,
       vbim.turnoid,
       vbim.centroordenid,
       vbim.operarioresponsableid,
       vbim.productividadestandar,
       vbim.medidafechajornada,
       vbim.toperacionalobjetivo
FROM vbaseindicadoresmag vbim;

alter table vbaseindicadorestotalmag
    owner to postgres;

create view vcomunicaciontipo
            (uid, categoria, id, nombre, descripcion, activo, operarioafectado, incidenciatipopadre_fk,
             observaciontipopadre_fk, sugerenciatipopadre_fk)
as
SELECT uid,
       categoria,
       id,
       nombre,
       descripcion,
       activo,
       operarioafectado,
       incidenciatipopadre_fk,
       observaciontipopadre_fk,
       sugerenciatipopadre_fk
FROM (SELECT concat('it_', it.id) AS uid,
             'incidencia'::text   AS categoria,
             it.id,
             it.nombre,
             it.descripcion,
             it.activo,
             it.operarioafectado,
             it.tipopadre_fk      AS incidenciatipopadre_fk,
             NULL::bigint         AS observaciontipopadre_fk,
             NULL::bigint         AS sugerenciatipopadre_fk
      FROM incidenciatipo it
      UNION
      SELECT concat('ot_', ot.id) AS uid,
             'observacion'::text  AS categoria,
             ot.id,
             ot.nombre,
             ot.descripcion,
             NULL::boolean        AS activo,
             NULL::boolean        AS operarioafectado,
             NULL::bigint         AS incidenciatipopadre_fk,
             ot.observaciontipopadre_fk,
             NULL::bigint         AS sugerenciatipopadre_fk
      FROM observaciontipo ot
      UNION
      SELECT concat('st_', st.id) AS uid,
             'sugerencia'::text   AS categoria,
             st.id,
             st.nombre,
             st.descripcion,
             NULL::boolean        AS activo,
             NULL::boolean        AS operarioafectado,
             NULL::bigint         AS incidenciatipopadre_fk,
             NULL::bigint         AS observaciontipopadre_fk,
             st.sugerenciatipopadre_fk
      FROM sugerenciatipo st) t
ORDER BY incidenciatipopadre_fk, observaciontipopadre_fk, sugerenciatipopadre_fk, nombre;

alter table vcomunicaciontipo
    owner to postgres;

create view vconsumoshistmag
            (recetaid, recetanombre, recetacantidad, productoidreceta, versionpordefecto,
             recetaingredienteconsumoteorico, recetaingredienteconsumomanual, recetaingredienteconsumoobjetivo,
             recetaingredienteconsumodescuento, recetaingredienteunidadid, recetaingredienteunidadnombre, productoid,
             productonombre, productocodigo, consumouid, consumoid, consumohistorizado, consumolote, consumonumpalet,
             consumotipopalet, consumoalmacenubicacion, consumotipooperacion, consumonumwipin, centroordenid,
             consumoreservado, consumovalorconsumo, consumofecha, nombrewipin, tipowipin, porcentajewipin,
             tipoingrediente, centroordencodigo, centroid, centronombre, productofinalid, productofinalnombre, wipinid,
             codigowipin, medidahistid, turnoid, turnoidentificador, recetaingredienteid, usuarioid, usuarionombre,
             recetaingredienteposicion, recetaingredienteposicionreserva, recetaingredientealmacen,
             recetaingredientenumeroreserva, consumodocumento, consumodocumentoanulado)
as
WITH consumos AS (SELECT concat('H_', ch.id)     AS uid,
                         ch.id,
                         ch.lote,
                         ch.numpalet,
                         ch.tipopalet,
                         ch.tipooperacion,
                         ch.almacenubicacion,
                         ch.valorconsumo,
                         ch.fechainicio          AS fecha,
                         ch.centroorden_fk       AS centroordenid,
                         ch.producto_fk,
                         ch.numwipin,
                         false                   AS reservado,
                         true                    AS historico,
                         ch.wipin_fk             AS wipinid,
                         ch.medidahist_fk        AS medidahistid,
                         ch.recetaingrediente_fk AS recetaingredienteid,
                         ch.created_by           AS usuarioid,
                         ch.documento,
                         ch.documentoanulado
                  FROM consumohist ch)
SELECT DISTINCT r.id                                          AS recetaid,
                r.nombre                                      AS recetanombre,
                r.cantidad                                    AS recetacantidad,
                r.producto_fk                                 AS productoidreceta,
                r.versionpordefecto,
                ri.consumo_teorico                            AS recetaingredienteconsumoteorico,
                ri.consumomanual                              AS recetaingredienteconsumomanual,
                ri.consumo_objetivo                           AS recetaingredienteconsumoobjetivo,
                ri.consumodescuento                           AS recetaingredienteconsumodescuento,
                u.id                                          AS recetaingredienteunidadid,
                u.nombre                                      AS recetaingredienteunidadnombre,
                p.id                                          AS productoid,
                p.nombre                                      AS productonombre,
                p.codigo                                      AS productocodigo,
                c.uid                                         AS consumouid,
                c.id                                          AS consumoid,
                c.historico                                   AS consumohistorizado,
                c.lote                                        AS consumolote,
                c.numpalet                                    AS consumonumpalet,
                c.tipopalet                                   AS consumotipopalet,
                c.almacenubicacion                            AS consumoalmacenubicacion,
                c.tipooperacion                               AS consumotipooperacion,
                wp.id                                         AS consumonumwipin,
                c.centroordenid,
                c.reservado                                   AS consumoreservado,
                COALESCE(c.valorconsumo, 0::double precision) AS consumovalorconsumo,
                c.fecha                                       AS consumofecha,
                wp.nombre::text                               AS nombrewipin,
                CASE
                    WHEN wp.tipo IS NOT NULL THEN wp.tipo
                    WHEN wp1.tipo IS NOT NULL THEN wp1.tipo
                    WHEN ri.consumomanual THEN 'manual'::character varying
                    ELSE NULL::character varying
                    END                                       AS tipowipin,
                cowm.porcentaje                               AS porcentajewipin,
                ri.tipo                                       AS tipoingrediente,
                co.codigo                                     AS centroordencodigo,
                c1.id                                         AS centroid,
                c1.nombre                                     AS centronombre,
                p1.id                                         AS productofinalid,
                p1.nombre                                     AS productofinalnombre,
                COALESCE(wp.id, wp1.id)                       AS wipinid,
                COALESCE(wp.codigo, wp1.codigo)               AS codigowipin,
                c.medidahistid,
                t.id                                          AS turnoid,
                t.identificador                               AS turnoidentificador,
                c.recetaingredienteid,
                c.usuarioid,
                us.nombre                                     AS usuarionombre,
                ri.posicion                                   AS recetaingredienteposicion,
                ri.posicion_reserva                           AS recetaingredienteposicionreserva,
                ri.almacen                                    AS recetaingredientealmacen,
                ri.numero_reserva                             AS recetaingredientenumeroreserva,
                c.documento                                   AS consumodocumento,
                c.documentoanulado                            AS consumodocumentoanulado
FROM consumos c
         JOIN centroorden co ON c.centroordenid = co.id
         JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         JOIN producto p1 ON cp.producto_fk = p1.id
         JOIN centro c1 ON cp.centro_fk = c1.id
         JOIN producto p ON c.producto_fk = p.id
         JOIN medidahist mh ON mh.id = c.medidahistid
         LEFT JOIN turno t ON t.id = mh.turno_fk
         LEFT JOIN receta r ON co.receta_fk = r.id
         LEFT JOIN recetaingrediente ri ON ri.id = c.recetaingredienteid
         LEFT JOIN unidad u ON ri.unidad_fk = u.id
         LEFT JOIN recetaingredientewipin cowm ON ri.id = cowm.recetaingrediente_fk
         LEFT JOIN wipin wp ON cowm.wipin_fk = wp.id
         LEFT JOIN wipin wp1 ON wp1.id = c.wipinid
         LEFT JOIN usuario us ON us.id = c.usuarioid;

alter table vconsumoshistmag
    owner to postgres;

create view vconsumosmedidamag
            (recetaid, recetanombre, recetacantidad, productoidreceta, versionpordefecto,
             recetaingredienteconsumoteorico, recetaingredienteconsumomanual, recetaingredienteconsumoobjetivo,
             recetaingredienteconsumodescuento, recetaingredienteunidadid, recetaingredienteunidadnombre, productoid,
             productonombre, productocodigo, consumouid, consumoid, consumohistorizado, consumolote, consumonumpalet,
             consumotipopalet, consumoalmacenubicacion, consumotipooperacion, consumonumwipin, centroordenid,
             consumoreservado, consumovalorconsumo, consumofecha, nombrewipin, tipowipin, porcentajewipin,
             tipoingrediente, centroordencodigo, centroid, centronombre, productofinalid, productofinalnombre, wipinid,
             codigowipin, medidaid, turnoid, turnoidentificador, recetaingredienteid, usuarioid, usuarionombre,
             recetaingredienteposicion, recetaingredienteposicionreserva, recetaingredientealmacen,
             recetaingredientenumeroreserva, consumodocumento, consumodocumentoanulado)
as
WITH consumos AS (SELECT concat('R_', c_1.id)     AS uid,
                         c_1.id,
                         c_1.lote,
                         c_1.numpalet,
                         c_1.tipopalet,
                         c_1.tipooperacion,
                         c_1.almacenubicacion,
                         c_1.valorconsumo,
                         c_1.fecha,
                         c_1.centroorden_fk       AS centroordenid,
                         c_1.producto_fk,
                         c_1.numwipin,
                         c_1.reservado,
                         false                    AS historico,
                         c_1.wipin_fk             AS wipinid,
                         c_1.recetaingrediente_fk AS recetaingredienteid,
                         c_1.created_by           AS usuarioid,
                         c_1.documento,
                         c_1.documentoanulado,
                         c_1.turno_fk
                  FROM consumo c_1)
SELECT DISTINCT r.id                                          AS recetaid,
                r.nombre                                      AS recetanombre,
                r.cantidad                                    AS recetacantidad,
                r.producto_fk                                 AS productoidreceta,
                r.versionpordefecto,
                ri.consumo_teorico                            AS recetaingredienteconsumoteorico,
                ri.consumomanual                              AS recetaingredienteconsumomanual,
                ri.consumo_objetivo                           AS recetaingredienteconsumoobjetivo,
                ri.consumodescuento                           AS recetaingredienteconsumodescuento,
                u.id                                          AS recetaingredienteunidadid,
                u.nombre                                      AS recetaingredienteunidadnombre,
                p.id                                          AS productoid,
                p.nombre                                      AS productonombre,
                p.codigo                                      AS productocodigo,
                c.uid                                         AS consumouid,
                c.id                                          AS consumoid,
                c.historico                                   AS consumohistorizado,
                c.lote                                        AS consumolote,
                c.numpalet                                    AS consumonumpalet,
                c.tipopalet                                   AS consumotipopalet,
                c.almacenubicacion                            AS consumoalmacenubicacion,
                c.tipooperacion                               AS consumotipooperacion,
                wp.id                                         AS consumonumwipin,
                c.centroordenid,
                c.reservado                                   AS consumoreservado,
                COALESCE(c.valorconsumo, 0::double precision) AS consumovalorconsumo,
                c.fecha                                       AS consumofecha,
                wp.nombre::text                               AS nombrewipin,
                CASE
                    WHEN wp.tipo IS NOT NULL THEN wp.tipo
                    WHEN wp1.tipo IS NOT NULL THEN wp1.tipo
                    WHEN ri.consumomanual THEN 'manual'::character varying
                    ELSE NULL::character varying
                    END                                       AS tipowipin,
                cowm.porcentaje                               AS porcentajewipin,
                ri.tipo                                       AS tipoingrediente,
                co.codigo                                     AS centroordencodigo,
                c1.id                                         AS centroid,
                c1.nombre                                     AS centronombre,
                p1.id                                         AS productofinalid,
                p1.nombre                                     AS productofinalnombre,
                COALESCE(wp.id, wp1.id)                       AS wipinid,
                COALESCE(wp.codigo, wp1.codigo)               AS codigowipin,
                NULL::bigint                                  AS medidaid,
                c.turno_fk                                    AS turnoid,
                tu.identificador                              AS turnoidentificador,
                c.recetaingredienteid,
                c.usuarioid,
                us.nombre                                     AS usuarionombre,
                ri.posicion                                   AS recetaingredienteposicion,
                ri.posicion_reserva                           AS recetaingredienteposicionreserva,
                ri.almacen                                    AS recetaingredientealmacen,
                ri.numero_reserva                             AS recetaingredientenumeroreserva,
                c.documento                                   AS consumodocumento,
                c.documentoanulado                            AS consumodocumentoanulado
FROM consumos c
         JOIN centroorden co ON c.centroordenid = co.id
         JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         JOIN producto p1 ON cp.producto_fk = p1.id
         JOIN centro c1 ON cp.centro_fk = c1.id
         JOIN producto p ON c.producto_fk = p.id
         LEFT JOIN receta r ON co.receta_fk = r.id
         LEFT JOIN recetaingrediente ri ON ri.id = c.recetaingredienteid
         LEFT JOIN unidad u ON ri.unidad_fk = u.id
         LEFT JOIN recetaingredientewipin cowm ON cowm.recetaingrediente_fk = ri.id
         LEFT JOIN wipin wp ON cowm.wipin_fk = wp.id
         LEFT JOIN wipin wp1 ON wp1.id = c.wipinid
         LEFT JOIN usuario us ON us.id = c.usuarioid
         LEFT JOIN turno tu ON tu.id = c.turno_fk;

alter table vconsumosmedidamag
    owner to postgres;

create view vmedidasproductividadmag
            (fechainicio, fechafin, intensidad, operarioid, centroid, estadooperarioid, tipooperarionombre,
             nombreoperario, codigooperario, estadooperarionombre)
as
WITH productividades AS (SELECT pmh.fechainicio,
                                pmh.fechafin,
                                pmho.intensidad,
                                pmh.operario_fk AS operarioid,
                                pmho.centro_fk  AS centroid,
                                pmh.estado_fk   AS estadooperarioid,
                                t.nombre        AS tipooperarionombre
                         FROM productividadmedidahist pmh
                                  JOIN productividadmedidacentrohist pmho ON pmh.id = pmho.medida_fk
                                  LEFT JOIN tipooperario t ON pmho.tipooperario_fk = t.id
                         UNION ALL
                         SELECT pm.fechainicio,
                                LEAST(pm.fechafin::timestamp with time zone, now()) AS fechafin,
                                pmc.intensidad,
                                pm.operario_fk                                      AS operarioid,
                                pmc.centro_fk                                       AS centroid,
                                pm.estado_fk                                        AS estadooperarioid,
                                t.nombre                                            AS tipooperarionombre
                         FROM productividadmedida pm
                                  JOIN productividadmedidacentro pmc ON pm.id = pmc.medida_fk
                                  LEFT JOIN tipooperario t ON pmc.tipooperario_fk = t.id)
SELECT p.fechainicio,
       p.fechafin,
       p.intensidad,
       p.operarioid,
       p.centroid,
       p.estadooperarioid,
       p.tipooperarionombre,
       o.nombre  AS nombreoperario,
       o.codigo  AS codigooperario,
       eo.nombre AS estadooperarionombre
FROM productividades p
         JOIN operario o ON p.operarioid = o.id
         LEFT JOIN estadooperario eo ON eo.id = p.estadooperarioid;

alter table vmedidasproductividadmag
    owner to postgres;

create view veficienciaproductividadcentroordenjornadaturno
            (fechainicio, fechafin, centroid, centronombre, productoid, productonombre, productocodigo, centroordenid,
             cantidadorden, centroordencodigo, qobjetivooperacionalup, qobjetivoproductivaup, productividadestandar,
             unidadproductividadtiempo, unidadprincipalid, unidadprincipalnombre, unidadsecundariaid,
             unidadsecundarianombre, unidadvelocidadid, unidadvelocidadnombre, unidadproductividadid,
             unidadproductividadnombre, centrotipotiempoeficiencia, qrealup, qrealus, qrealuv, qscrapup, qscrapus,
             qscrapuv, qtotalup, qtotalus, qtotaluv, tmicroparojustificado, tparonoprogramado, tparoexceso, tfallo,
             tparoprogramado, ttotalparada, tnoplanificado, tproduccion, tvelocidadreducida, toperacional, tproductivo,
             ttotal, tnetoreal, ttotalmicroparos, tmicroparonojustificado, tefectivo, tproductivoobjetivo,
             tproduccionobjetivo, tnetoobjetivo, tefectivoobjetivo, tefectivoobjetivooperacional,
             tefectivoobjetivoproductivo, tproductividadhobjetivo, tproductividadhreal, pcvreal, tnoqualidad, pcvobj,
             vreal, vobj, qrealupobjetivooperacional, qrealupobjetivoproductiva, vteorica, pcdisponibilidadtotal,
             pcdisponibilidadtotalobjetivo, pcdisponibilidadoperacional, pcdisponibilidadoperacionalobjetivo,
             pcdisponibilidadproductiva, pcdisponibilidadproductivaobjetivo, pcqreal, pcqobjetivo,
             productividadobjetivo, productividadreal, pcoee, pcope, oeeobjetivo, opeobjetivo, teep,
             tiempoestandarproductividad, tiemporealproductividadminutos, tiemporealproductividad,
             diferenciahorasproductividad, ratioproductividadreal, ratioproductividadestandar)
as
WITH datosbase AS (SELECT min(vbi.medidafechainicio)                                                        AS fechainicio,
                          max(vbi.medidafechafin)                                                           AS fechafin,
                          vbi.centroid,
                          max(c.nombre::text)                                                               AS centronombre,
                          vbi.productoid,
                          max(p.nombre::text)                                                               AS productonombre,
                          max(p.codigo::text)                                                               AS productocodigo,
                          vbi.centroordenid,
                          max(co.cantidad)                                                                  AS cantidadorden,
                          max(co.codigo::text)                                                              AS centroordencodigo,
                          sum(vbi.qobjetivooperacionalup)                                                   AS qobjetivooperacionalup,
                          sum(vbi.qobjetivoproductivaup)                                                    AS qobjetivoproductivaup,
                          max(vbi.productividadestandar)                                                    AS productividadestandar,
                          max(vbi.tipotiempoproductividad::text)                                            AS unidadproductividadtiempo,
                          max(vbi.unidadprincipalid)                                                        AS unidadprincipalid,
                          max(vbi.unidadprincipalnombre::text)                                              AS unidadprincipalnombre,
                          max(vbi.unidadsecundariaid)                                                       AS unidadsecundariaid,
                          max(vbi.unidadsecundarianombre::text)                                             AS unidadsecundarianombre,
                          max(vbi.unidadvelocidadid)                                                        AS unidadvelocidadid,
                          max(vbi.unidadvelocidadnombre::text)                                              AS unidadvelocidadnombre,
                          max(vbi.unidadproductividadid)                                                    AS unidadproductividadid,
                          max(vbi.unidadproductividadnombre::text)                                          AS unidadproductividadnombre,
                          max(vbi.centrotipotiempoeficiencia::text)                                         AS centrotipotiempoeficiencia,
                          sum(vbi.qrealup)                                                                  AS qrealup,
                          sum(vbi.qrealus)                                                                  AS qrealus,
                          sum(vbi.qrealuv)                                                                  AS qrealuv,
                          sum(vbi.qscrapup)                                                                 AS qscrapup,
                          sum(vbi.qscrapus)                                                                 AS qscrapus,
                          sum(vbi.qscrapuv)                                                                 AS qscrapuv,
                          sum(vbi.qtotalup)                                                                 AS qtotalup,
                          sum(vbi.qtotalus)                                                                 AS qtotalus,
                          sum(vbi.qtotaluv)                                                                 AS qtotaluv,
                          sum(COALESCE(vbi.tmicroparojustificado, 0::double precision))                     AS tmicroparojustificado,
                          sum(vbi.tparonoprogramado)                                                        AS tparonoprogramado,
                          sum(vbi.tparoexceso)                                                              AS tparoexceso,
                          sum(vbi.tfallo)                                                                   AS tfallo,
                          sum(vbi.tparoprogramado)                                                          AS tparoprogramado,
                          sum(vbi.ttotalparada)                                                             AS ttotalparada,
                          sum(vbi.tnoplanificado)                                                           AS tnoplanificado,
                          sum(vbi.tproduccion)                                                              AS tproduccion,
                          sum(vbi.tvelocidadreducida)                                                       AS tvelocidadreducida,
                          sum(vbi.toperacional)                                                             AS toperacional,
                          sum(vbi.tproductivo)                                                              AS tproductivo,
                          sum(vbi.ttotal)                                                                   AS ttotal,
                          sum(vbi.tnetoreal)                                                                AS tnetoreal,
                          sum(vbi.ttotalmicroparos)                                                         AS ttotalmicroparos,
                          GREATEST(sum(COALESCE(vbi.tmicroparonojustificado, 0::double precision)),
                                   0::double precision)                                                     AS tmicroparonojustificado,
                          sum(vbi.tefectivo)                                                                AS tefectivo,
                          sum(vbi.tproductivoobjetivo)                                                      AS tproductivoobjetivo,
                          sum(vbi.tproduccionobjetivo)                                                      AS tproduccionobjetivo,
                          sum(vbi.tnetoobjetivo)                                                            AS tnetoobjetivo,
                          sum(vbi.tefectivoobjetivo)                                                        AS tefectivoobjetivo,
                          sum(vbi.tefectivoobjetivooperacional)                                             AS tefectivoobjetivooperacional,
                          sum(vbi.tefectivoobjetivoproductivo)                                              AS tefectivoobjetivoproductivo,
                          sum(vbi.tproductividadhobjetivo)                                                  AS tproductividadhobjetivo,
                          sum(vbi.tproductividadhreal)                                                      AS tproductividadhreal,
                          COALESCE(sum(vbi.tnetoreal) / NULLIF(sum(vbi.tproduccion), 0::double precision),
                                   0::double precision)                                                     AS pcvreal,
                          sum(vbi.tnetoreal - vbi.tefectivo)                                                AS tnoqualidad,
                          COALESCE(sum(vbi.tnetoobjetivo) / NULLIF(sum(vbi.tproduccion), 0::double precision),
                                   0::double precision)                                                     AS pcvobj,
                          COALESCE(sum(vbi.tnetoreal) / NULLIF(sum(vbi.tproduccion), 0::double precision) *
                                   sum(vbi.qtotaluv) / NULLIF(sum(
                                                                      CASE
                                                                          WHEN vbi.centrotipotiempoeficiencia::text = 'minutos'::text
                                                                              THEN vbi.tnetoreal
                                                                          ELSE vbi.tnetoreal / 60::double precision
                                                                          END), 0::double precision),
                                   0::double precision)                                                     AS vreal,
                          COALESCE(sum(vbi.tnetoobjetivo) / NULLIF(sum(vbi.tproduccion), 0::double precision) *
                                   sum(vbi.qtotaluv) / NULLIF(sum(
                                                                      CASE
                                                                          WHEN vbi.centrotipotiempoeficiencia::text = 'minutos'::text
                                                                              THEN vbi.tnetoreal
                                                                          ELSE vbi.tnetoreal / 60::double precision
                                                                          END), 0::double precision),
                                   0::double precision)                                                     AS vobj,
                          sum(vbi.qobjetivooperacionalup)                                                   AS qrealupobjetivooperacional,
                          sum(vbi.qobjetivoproductivaup)                                                    AS qrealupobjetivoproductiva,
                          COALESCE(sum(vbi.qtotaluv) / NULLIF(sum(vbi.tnetoreal), 0::double precision),
                                   0::double precision)                                                     AS vteorica,
                          COALESCE(sum(vbi.tproduccion) / NULLIF(sum(vbi.toperacional), 0::double precision),
                                   0::double precision)                                                     AS pcdisponibilidadtotal,
                          COALESCE(sum(vbi.tproductivoobjetivo) / NULLIF(sum(vbi.toperacional), 0::double precision) *
                                   (sum(vbi.tproduccionobjetivo) / NULLIF(sum(vbi.tproductivo), 0::double precision)),
                                   0::double precision)                                                     AS pcdisponibilidadtotalobjetivo,
                          COALESCE(sum(vbi.tproductivo) / NULLIF(sum(vbi.toperacional), 0::double precision),
                                   0::double precision)                                                     AS pcdisponibilidadoperacional,
                          COALESCE(sum(vbi.tproductivoobjetivo) / NULLIF(sum(vbi.toperacional), 0::double precision),
                                   0::double precision)                                                     AS pcdisponibilidadoperacionalobjetivo,
                          COALESCE(sum(vbi.tproduccion) / NULLIF(sum(vbi.tproductivo), 0::double precision),
                                   0::double precision)                                                     AS pcdisponibilidadproductiva,
                          COALESCE(sum(vbi.tproduccionobjetivo) / NULLIF(sum(vbi.tproductivo), 0::double precision),
                                   0::double precision)                                                     AS pcdisponibilidadproductivaobjetivo,
                          COALESCE(sum(vbi.tefectivo) / NULLIF(sum(vbi.tnetoreal), 0::double precision),
                                   0::double precision)                                                     AS pcqreal,
                          COALESCE(sum(vbi.tefectivoobjetivo) / NULLIF(sum(vbi.tnetoreal), 0::double precision),
                                   0::double precision)                                                     AS pcqobjetivo,
                          COALESCE(sum(vbi.tproduccionobjetivo) / NULLIF(sum(
                                                                                 CASE
                                                                                     WHEN vbi.unidadproductividadid = vbi.unidadprincipalid
                                                                                         THEN vbi.qtotalup
                                                                                     ELSE vbi.qtotalus
                                                                                     END), 0::double precision),
                                   0::double precision)                                                     AS productividadobjetivo,
                          COALESCE(sum(vbi.tproduccion) / NULLIF(sum(
                                                                         CASE
                                                                             WHEN vbi.unidadproductividadid = vbi.unidadprincipalid
                                                                                 THEN vbi.qtotalup
                                                                             ELSE vbi.qtotalus
                                                                             END), 0::double precision),
                                   0::double precision)                                                     AS productividadreal,
                          COALESCE(sum(vbi.tefectivo) / NULLIF(sum(vbi.toperacional), 0::double precision),
                                   0::double precision)                                                     AS pcoee,
                          COALESCE(sum(vbi.tefectivo) / NULLIF(sum(vbi.tproductivo), 0::double precision),
                                   0::double precision)                                                     AS pcope,
                          COALESCE(sum(vbi.tefectivoobjetivooperacional) /
                                   NULLIF(sum(vbi.toperacional), 0::double precision),
                                   0::double precision)                                                     AS oeeobjetivo,
                          COALESCE(sum(vbi.tefectivoobjetivoproductivo) /
                                   NULLIF(sum(vbi.tproductivo), 0::double precision),
                                   0::double precision)                                                     AS opeobjetivo,
                          COALESCE(sum(vbi.tefectivo) / NULLIF(sum(vbi.ttotal), 0::double precision),
                                   0::double precision)                                                     AS teep,
                          COALESCE(sum(
                                           CASE
                                               WHEN vbi.unidadproductividadid = vbi.unidadprincipalid
                                                   THEN vbi.qrealup * vbi.productividadestandar
                                               WHEN vbi.unidadproductividadid = vbi.unidadsecundariaid
                                                   THEN vbi.qrealus * vbi.productividadestandar
                                               ELSE NULL::double precision
                                               END),
                                   0::double precision)                                                     AS tiempoestandarproductividad
                   FROM vbaseindicadorestotalmag vbi
                            LEFT JOIN centro c ON vbi.centroid = c.id
                            LEFT JOIN producto p ON vbi.productoid = p.id
                            LEFT JOIN turno t ON vbi.turnoid = t.id
                            LEFT JOIN unidad up ON vbi.unidadprincipalid = up.id
                            LEFT JOIN unidad us ON vbi.unidadsecundariaid = us.id
                            LEFT JOIN unidad uprod ON vbi.unidadproductividadid = uprod.id
                            LEFT JOIN centroorden co ON vbi.centroordenid = co.id
                            LEFT JOIN centroproducto cp ON co.centroproducto_fk = cp.id
                   GROUP BY vbi.centroid, vbi.productoid, vbi.centroordenid, cp.id, vbi.medidafechajornada,
                            vbi.turnoid),
     datosfinales AS (SELECT db.fechainicio,
                             db.fechafin,
                             db.centroid,
                             db.centronombre,
                             db.productoid,
                             db.productonombre,
                             db.productocodigo,
                             db.centroordenid,
                             db.cantidadorden,
                             db.centroordencodigo,
                             db.qobjetivooperacionalup,
                             db.qobjetivoproductivaup,
                             db.productividadestandar,
                             db.unidadproductividadtiempo,
                             db.unidadprincipalid,
                             db.unidadprincipalnombre,
                             db.unidadsecundariaid,
                             db.unidadsecundarianombre,
                             db.unidadvelocidadid,
                             db.unidadvelocidadnombre,
                             db.unidadproductividadid,
                             db.unidadproductividadnombre,
                             db.centrotipotiempoeficiencia,
                             db.qrealup,
                             db.qrealus,
                             db.qrealuv,
                             db.qscrapup,
                             db.qscrapus,
                             db.qscrapuv,
                             db.qtotalup,
                             db.qtotalus,
                             db.qtotaluv,
                             db.tmicroparojustificado,
                             db.tparonoprogramado,
                             db.tparoexceso,
                             db.tfallo,
                             db.tparoprogramado,
                             db.ttotalparada,
                             db.tnoplanificado,
                             db.tproduccion,
                             db.tvelocidadreducida,
                             db.toperacional,
                             db.tproductivo,
                             db.ttotal,
                             db.tnetoreal,
                             db.ttotalmicroparos,
                             db.tmicroparonojustificado,
                             db.tefectivo,
                             db.tproductivoobjetivo,
                             db.tproduccionobjetivo,
                             db.tnetoobjetivo,
                             db.tefectivoobjetivo,
                             db.tefectivoobjetivooperacional,
                             db.tefectivoobjetivoproductivo,
                             db.tproductividadhobjetivo,
                             db.tproductividadhreal,
                             db.pcvreal,
                             db.tnoqualidad,
                             db.pcvobj,
                             db.vreal,
                             db.vobj,
                             db.qrealupobjetivooperacional,
                             db.qrealupobjetivoproductiva,
                             db.vteorica,
                             db.pcdisponibilidadtotal,
                             db.pcdisponibilidadtotalobjetivo,
                             db.pcdisponibilidadoperacional,
                             db.pcdisponibilidadoperacionalobjetivo,
                             db.pcdisponibilidadproductiva,
                             db.pcdisponibilidadproductivaobjetivo,
                             db.pcqreal,
                             db.pcqobjetivo,
                             db.productividadobjetivo,
                             db.productividadreal,
                             db.pcoee,
                             db.pcope,
                             db.oeeobjetivo,
                             db.opeobjetivo,
                             db.teep,
                             db.tiempoestandarproductividad,
                             COALESCE((SELECT sum(
                                                      CASE
                                                          WHEN db.fechafin > p.fechainicio AND db.fechainicio < p.fechafin
                                                              THEN EXTRACT(epoch FROM LEAST(db.fechafin, p.fechafin) -
                                                                                      GREATEST(db.fechainicio, p.fechainicio)::timestamp with time zone)::double precision *
                                                                   p.intensidad / 100::double precision /
                                                                   60::double precision
                                                          ELSE NULL::double precision
                                                          END) AS sum
                                       FROM vmedidasproductividadmag p
                                       WHERE p.fechafin > db.fechainicio
                                         AND p.fechainicio < db.fechafin
                                         AND p.centroid = db.centroid),
                                      0::double precision) AS tiemporealproductividadminutos
                      FROM datosbase db),
     final AS (SELECT df.fechainicio,
                      df.fechafin,
                      df.centroid,
                      df.centronombre,
                      df.productoid,
                      df.productonombre,
                      df.productocodigo,
                      df.centroordenid,
                      df.cantidadorden,
                      df.centroordencodigo,
                      df.qobjetivooperacionalup,
                      df.qobjetivoproductivaup,
                      df.productividadestandar,
                      df.unidadproductividadtiempo,
                      df.unidadprincipalid,
                      df.unidadprincipalnombre,
                      df.unidadsecundariaid,
                      df.unidadsecundarianombre,
                      df.unidadvelocidadid,
                      df.unidadvelocidadnombre,
                      df.unidadproductividadid,
                      df.unidadproductividadnombre,
                      df.centrotipotiempoeficiencia,
                      df.qrealup,
                      df.qrealus,
                      df.qrealuv,
                      df.qscrapup,
                      df.qscrapus,
                      df.qscrapuv,
                      df.qtotalup,
                      df.qtotalus,
                      df.qtotaluv,
                      df.tmicroparojustificado,
                      df.tparonoprogramado,
                      df.tparoexceso,
                      df.tfallo,
                      df.tparoprogramado,
                      df.ttotalparada,
                      df.tnoplanificado,
                      df.tproduccion,
                      df.tvelocidadreducida,
                      df.toperacional,
                      df.tproductivo,
                      df.ttotal,
                      df.tnetoreal,
                      df.ttotalmicroparos,
                      df.tmicroparonojustificado,
                      df.tefectivo,
                      df.tproductivoobjetivo,
                      df.tproduccionobjetivo,
                      df.tnetoobjetivo,
                      df.tefectivoobjetivo,
                      df.tefectivoobjetivooperacional,
                      df.tefectivoobjetivoproductivo,
                      df.tproductividadhobjetivo,
                      df.tproductividadhreal,
                      df.pcvreal,
                      df.tnoqualidad,
                      df.pcvobj,
                      df.vreal,
                      df.vobj,
                      df.qrealupobjetivooperacional,
                      df.qrealupobjetivoproductiva,
                      df.vteorica,
                      df.pcdisponibilidadtotal,
                      df.pcdisponibilidadtotalobjetivo,
                      df.pcdisponibilidadoperacional,
                      df.pcdisponibilidadoperacionalobjetivo,
                      df.pcdisponibilidadproductiva,
                      df.pcdisponibilidadproductivaobjetivo,
                      df.pcqreal,
                      df.pcqobjetivo,
                      df.productividadobjetivo,
                      df.productividadreal,
                      df.pcoee,
                      df.pcope,
                      df.oeeobjetivo,
                      df.opeobjetivo,
                      df.teep,
                      df.tiempoestandarproductividad,
                      df.tiemporealproductividadminutos,
                      CASE
                          WHEN df.unidadproductividadtiempo = 'horas'::text
                              THEN df.tiemporealproductividadminutos / 60::double precision
                          ELSE df.tiemporealproductividadminutos
                          END AS tiemporealproductividad
               FROM datosfinales df)
SELECT fechainicio,
       fechafin,
       centroid,
       centronombre,
       productoid,
       productonombre,
       productocodigo,
       centroordenid,
       cantidadorden,
       centroordencodigo,
       qobjetivooperacionalup,
       qobjetivoproductivaup,
       productividadestandar,
       unidadproductividadtiempo,
       unidadprincipalid,
       unidadprincipalnombre,
       unidadsecundariaid,
       unidadsecundarianombre,
       unidadvelocidadid,
       unidadvelocidadnombre,
       unidadproductividadid,
       unidadproductividadnombre,
       centrotipotiempoeficiencia,
       qrealup,
       qrealus,
       qrealuv,
       qscrapup,
       qscrapus,
       qscrapuv,
       qtotalup,
       qtotalus,
       qtotaluv,
       tmicroparojustificado,
       tparonoprogramado,
       tparoexceso,
       tfallo,
       tparoprogramado,
       ttotalparada,
       tnoplanificado,
       tproduccion,
       tvelocidadreducida,
       toperacional,
       tproductivo,
       ttotal,
       tnetoreal,
       ttotalmicroparos,
       tmicroparonojustificado,
       tefectivo,
       tproductivoobjetivo,
       tproduccionobjetivo,
       tnetoobjetivo,
       tefectivoobjetivo,
       tefectivoobjetivooperacional,
       tefectivoobjetivoproductivo,
       tproductividadhobjetivo,
       tproductividadhreal,
       pcvreal,
       tnoqualidad,
       pcvobj,
       vreal,
       vobj,
       qrealupobjetivooperacional,
       qrealupobjetivoproductiva,
       vteorica,
       pcdisponibilidadtotal,
       pcdisponibilidadtotalobjetivo,
       pcdisponibilidadoperacional,
       pcdisponibilidadoperacionalobjetivo,
       pcdisponibilidadproductiva,
       pcdisponibilidadproductivaobjetivo,
       pcqreal,
       pcqobjetivo,
       productividadobjetivo,
       productividadreal,
       pcoee,
       pcope,
       oeeobjetivo,
       opeobjetivo,
       teep,
       tiempoestandarproductividad,
       tiemporealproductividadminutos,
       tiemporealproductividad,
       tiempoestandarproductividad - tiemporealproductividad AS diferenciahorasproductividad,
       CASE
           WHEN qrealup > 0::double precision THEN
               CASE
                   WHEN unidadproductividadnombre = unidadprincipalnombre THEN tiemporealproductividad / qrealup
                   WHEN unidadproductividadnombre = unidadsecundarianombre THEN tiemporealproductividad / qrealus
                   ELSE NULL::double precision
                   END
           ELSE 0::double precision
           END                                               AS ratioproductividadreal,
       CASE
           WHEN qrealup > 0::double precision THEN
               CASE
                   WHEN unidadproductividadnombre = unidadprincipalnombre THEN tiempoestandarproductividad / qrealup
                   WHEN unidadproductividadnombre = unidadsecundarianombre THEN tiempoestandarproductividad / qrealus
                   ELSE NULL::double precision
                   END
           ELSE 0::double precision
           END                                               AS ratioproductividadestandar
FROM final f;

alter table veficienciaproductividadcentroordenjornadaturno
    owner to postgres;

create view vestadoshistmag
            (tipomedida, finicio, ffin, turnoid, operarioid, medidaid, estadoid, estadonombre, estadotipoid,
             estadotiponombre, centroid, centroordenid, grupo, justificacion, justificada, orden, duracion, cantidad,
             producto_fk, centroestadoid, duracionmicroparada, centronombre, centroordencodigo, centroordencantidad,
             centroordencantidadproducida, centroproductoid, productoid, productonombre, productocodigo,
             medidahisttiempomaximo)
as
SELECT 'historico'::text         AS tipomedida,
       mh.finicio,
       mh.ffin,
       mh.turno_fk               AS turnoid,
       mh.operarioresponsable_fk AS operarioid,
       mh.id                     AS medidaid,
       mh.estado_fk              AS estadoid,
       e.nombre                  AS estadonombre,
       et.id                     AS estadotipoid,
       et.nombre                 AS estadotiponombre,
       mh.centro_fk              AS centroid,
       mh.centroorden_fk         AS centroordenid,
       mh.grupo,
       mh.justificacion,
       mh.justificada,
       mh.orden,
       mh.duracion,
       mh.cantidad,
       mh.producto_fk,
       ce.id                     AS centroestadoid,
       mh.duracionmicroparada,
       c.nombre                  AS centronombre,
       co.codigo                 AS centroordencodigo,
       co.cantidad               AS centroordencantidad,
       co.cantidadproducida      AS centroordencantidadproducida,
       cp.id                     AS centroproductoid,
       p.id                      AS productoid,
       p.nombre                  AS productonombre,
       p.codigo                  AS productocodigo,
       mh.tmaximo                AS medidahisttiempomaximo
FROM medidahist mh
         LEFT JOIN estado e ON e.id = mh.estado_fk
         LEFT JOIN estadotipo et ON e.tipo_fk = et.id
         LEFT JOIN centroestado ce ON mh.estado_fk = ce.estado_fk AND mh.centro_fk = ce.centro_fk
         LEFT JOIN centroorden co ON co.id = mh.centroorden_fk
         LEFT JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         LEFT JOIN centro c ON c.id = cp.centro_fk
         LEFT JOIN producto p ON cp.producto_fk = p.id;

alter table vestadoshistmag
    owner to postgres;

create view vestadosmag
            (tipomedida, finicio, ffin, turnoid, operarioid, medidaid, estadoid, estadonombre, estadotipoid,
             estadotiponombre, centroid, centroordenid, grupo, justificacion, justificada, orden, duracion, cantidad,
             producto_fk, centroestadoid, duracionmicroparada, centronombre, centroordencodigo, centroordencantidad,
             centroordencantidadproducida, centroproductoid, productoid, productonombre, productocodigo,
             medidatiempomaximo)
as
SELECT 'monitorizador'::text     AS tipomedida,
       min(m.finicio)            AS finicio,
       max(m.ffin)               AS ffin,
       m.turno_fk                AS turnoid,
       m.operarioresponsable_fk  AS operarioid,
       m.id                      AS medidaid,
       e.id                      AS estadoid,
       e.nombre                  AS estadonombre,
       et.id                     AS estadotipoid,
       et.nombre                 AS estadotiponombre,
       c.id                      AS centroid,
       m.centroorden_fk          AS centroordenid,
       m.grupo,
       m.justificacion,
       m.justificada,
       m.orden,
       sum(m.duracion)           AS duracion,
       0                         AS cantidad,
       p.id                      AS producto_fk,
       m.centroestado_fk         AS centroestadoid,
       0                         AS duracionmicroparada,
       max(c.nombre::text)       AS centronombre,
       max(co.codigo::text)      AS centroordencodigo,
       max(co.cantidad)          AS centroordencantidad,
       max(co.cantidadproducida) AS centroordencantidadproducida,
       max(cp.id)                AS centroproductoid,
       p.id                      AS productoid,
       max(p.nombre::text)       AS productonombre,
       max(p.codigo::text)       AS productocodigo,
       max(ce.tmaximo)           AS medidatiempomaximo
FROM vmedida m
         LEFT JOIN centroestado ce ON m.centroestado_fk = ce.id
         LEFT JOIN estado e ON ce.estado_fk = e.id
         LEFT JOIN estadotipo et ON e.tipo_fk = et.id
         LEFT JOIN centroorden co ON m.centroorden_fk = co.id
         LEFT JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         LEFT JOIN producto p ON cp.producto_fk = p.id
         LEFT JOIN centro c ON cp.centro_fk = c.id
WHERE m.tipomedida::text = 'estados'::text
GROUP BY m.turno_fk, m.operarioresponsable_fk, m.id, e.id, e.nombre, et.id, et.nombre, c.id, m.centroorden_fk, m.grupo,
         m.justificacion, m.justificada, m.orden, p.id, m.centroestado_fk;

alter table vestadosmag
    owner to postgres;

create view vestadostotalmag
            (tipomedida, finicio, ffin, turno_fk, operario_fk, id, estado_fk, estadonombre, estadotipo_fk,
             estadotiponombre, centro_fk, centroorden_fk, grupo, justificacion, justificada, orden, duracion, cantidad,
             producto_fk, centroestado_fk)
as
SELECT 'monitorizador'::text    AS tipomedida,
       min(m.finicio)           AS finicio,
       max(m.ffin)              AS ffin,
       m.turno_fk,
       m.operarioresponsable_fk AS operario_fk,
       m.id,
       e.id                     AS estado_fk,
       e.nombre                 AS estadonombre,
       et.id                    AS estadotipo_fk,
       et.nombre                AS estadotiponombre,
       c.id                     AS centro_fk,
       m.centroorden_fk,
       m.grupo,
       m.justificacion,
       m.justificada,
       m.orden,
       sum(m.duracion)          AS duracion,
       0                        AS cantidad,
       p.id                     AS producto_fk,
       m.centroestado_fk
FROM vmedida m
         LEFT JOIN centroestado ce ON m.centroestado_fk = ce.id
         LEFT JOIN estado e ON ce.estado_fk = e.id
         LEFT JOIN estadotipo et ON e.tipo_fk = et.id
         LEFT JOIN centroorden co ON m.centroorden_fk = co.id
         LEFT JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         LEFT JOIN producto p ON cp.producto_fk = p.id
         LEFT JOIN centro c ON cp.centro_fk = c.id
WHERE m.tipomedida::text = 'estados'::text
GROUP BY m.grupo, m.turno_fk, m.operarioresponsable_fk, m.id, e.id, e.nombre, et.id, et.nombre, c.id, m.centroorden_fk,
         m.justificacion, m.justificada, m.orden, p.id, m.centroestado_fk
UNION
SELECT 'historico'::text         AS tipomedida,
       mh.finicio,
       mh.ffin,
       mh.turno_fk,
       mh.operarioresponsable_fk AS operario_fk,
       mh.id,
       mh.estado_fk,
       e.nombre                  AS estadonombre,
       et.id                     AS estadotipo_fk,
       et.nombre                 AS estadotiponombre,
       mh.centro_fk,
       mh.centroorden_fk,
       mh.grupo,
       mh.justificacion,
       mh.justificada,
       mh.orden,
       mh.duracion,
       mh.cantidad,
       mh.producto_fk,
       ce.id                     AS centroestado_fk
FROM medidahist mh
         LEFT JOIN estado e ON e.id = mh.estado_fk
         LEFT JOIN estadotipo et ON e.tipo_fk = et.id
         LEFT JOIN centroestado ce ON mh.estado_fk = ce.estado_fk AND mh.centro_fk = ce.centro_fk;

alter table vestadostotalmag
    owner to postgres;

create view vmedidahistproductividaddetalle
            (id, medida_fk, operario_fk, estado_fk, tipooperario_fk, intensidad, fechainicio, fechafin, duracion,
             tiempoproductivo) as
SELECT m.id::double precision *
       power(10::double precision, 1::double precision + ceiling(log10(pmc.id::double precision))) +
       pmc.id::double precision       AS id,
       m.id                           AS medida_fk,
       pm.operario_fk,
       pm.estado_fk,
       pmc.tipooperario_fk,
       pmc.intensidad,
       CASE
           WHEN m.finicio > pm.fechainicio THEN m.finicio
           ELSE pm.fechainicio
           END                        AS fechainicio,
       CASE
           WHEN m.ffin < pm.fechafin THEN m.ffin
           ELSE pm.fechafin
           END                        AS fechafin,
       EXTRACT(epoch FROM
               CASE
                   WHEN m.ffin < pm.fechafin THEN m.ffin
                   ELSE pm.fechafin
                   END -
               CASE
                   WHEN m.finicio > pm.fechainicio THEN m.finicio
                   ELSE pm.fechainicio
                   END) / 60::numeric AS duracion,
       pm.tiempoproductivo
FROM medidahist m
         JOIN productividadmedidahist pm ON true
         JOIN productividadmedidacentrohist pmc ON pm.id = pmc.medida_fk
WHERE m.centro_fk = pmc.centro_fk
  AND pm.fechainicio < m.ffin
  AND pm.fechafin > m.finicio;

alter table vmedidahistproductividaddetalle
    owner to postgres;

create view vmedidahistproductividad(id, medida_fk, numoperarios, duracionproductivo, duracionnoproductivo) as
SELECT medida_fk                   AS id,
       medida_fk,
       count(DISTINCT operario_fk) AS numoperarios,
       sum(
               CASE
                   WHEN tiempoproductivo THEN duracion::double precision * intensidad * 0.01::double precision
                   ELSE 0::double precision
                   END)            AS duracionproductivo,
       sum(
               CASE
                   WHEN NOT tiempoproductivo THEN duracion::double precision * intensidad * 0.01::double precision
                   ELSE 0::double precision
                   END)            AS duracionnoproductivo
FROM vmedidahistproductividaddetalle
GROUP BY medida_fk;

alter table vmedidahistproductividad
    owner to postgres;

create view vmedidahistproductividaddetalle2
            (id, medida_fk, operario_fk, estado_fk, tipooperario_fk, intensidad, fechainicioreal, fechafinreal,
             fechainicio, fechafin, duracion, tiempoproductivo)
as
SELECT m.id::double precision *
       power(10::double precision, 1::double precision + ceiling(log10(pmc.id::double precision))) +
       pmc.id::double precision       AS id,
       m.id                           AS medida_fk,
       pm.operario_fk,
       pm.estado_fk,
       pmc.tipooperario_fk,
       pmc.intensidad,
       pm.fechainicio                 AS fechainicioreal,
       pm.fechafin                    AS fechafinreal,
       CASE
           WHEN m.finicio > pm.fechainicio THEN m.finicio
           ELSE pm.fechainicio
           END                        AS fechainicio,
       CASE
           WHEN m.ffin < pm.fechafin THEN m.ffin
           ELSE pm.fechafin
           END                        AS fechafin,
       EXTRACT(epoch FROM
               CASE
                   WHEN m.ffin < pm.fechafin THEN m.ffin
                   ELSE pm.fechafin
                   END -
               CASE
                   WHEN m.finicio > pm.fechainicio THEN m.finicio
                   ELSE pm.fechainicio
                   END) / 60::numeric AS duracion,
       pm.tiempoproductivo
FROM medidahist m
         JOIN productividadmedidahist pm ON true
         JOIN productividadmedidacentrohist pmc ON pm.id = pmc.medida_fk
WHERE m.centro_fk = pmc.centro_fk
  AND pm.fechainicio < m.ffin
  AND pm.fechafin > m.finicio;

alter table vmedidahistproductividaddetalle2
    owner to postgres;

create view vmedidahistproductividaddetalle4
            (id, medida_fk, operario_fk, estado_fk, tipooperario_fk, intensidad, fechainicio, fechafin, duracion,
             tiempoproductivo) as
SELECT m.id::double precision *
       power(10::double precision, 1::double precision + ceiling(log10(pmc.id::double precision))) +
       pmc.id::double precision       AS id,
       m.id                           AS medida_fk,
       pm.operario_fk,
       pm.estado_fk,
       pmc.tipooperario_fk,
       pmc.intensidad,
       CASE
           WHEN m.finicio > pm.fechainicio THEN m.finicio
           ELSE pm.fechainicio
           END                        AS fechainicio,
       CASE
           WHEN m.ffin < pm.fechafin THEN m.ffin
           ELSE pm.fechafin
           END                        AS fechafin,
       EXTRACT(epoch FROM
               CASE
                   WHEN m.ffin < pm.fechafin THEN m.ffin
                   ELSE pm.fechafin
                   END -
               CASE
                   WHEN m.finicio > pm.fechainicio THEN m.finicio
                   ELSE pm.fechainicio
                   END) / 60::numeric AS duracion,
       pm.tiempoproductivo
FROM medidahist m
         JOIN productividadmedidahist pm ON pm.fechainicio < m.ffin AND pm.fechafin > m.finicio
         JOIN productividadmedidacentrohist pmc ON pm.id = pmc.medida_fk
         JOIN centro cpmc ON pmc.centro_fk = cpmc.id
WHERE m.centro_fk = pmc.centro_fk
   OR m.centro_fk = cpmc.centropadre_fk;

alter table vmedidahistproductividaddetalle4
    owner to postgres;

create view vmedidaproductividaddetalle
            (id, medida_fk, operario_fk, estado_fk, tipooperario_fk, intensidad, fechainicio, fechafin, duracion,
             tiempoproductivo) as
SELECT m.id::double precision *
       power(10::double precision, 1::double precision + ceiling(log10(pmc.id::double precision))) +
       pmc.id::double precision       AS id,
       m.id                           AS medida_fk,
       pm.operario_fk,
       pm.estado_fk,
       pmc.tipooperario_fk,
       pmc.intensidad,
       CASE
           WHEN m.finicio > pm.fechainicio THEN m.finicio
           ELSE pm.fechainicio
           END                        AS fechainicio,
       CASE
           WHEN m.ffin < pm.fechafin THEN m.ffin
           ELSE pm.fechafin
           END                        AS fechafin,
       EXTRACT(epoch FROM
               CASE
                   WHEN m.ffin < pm.fechafin THEN m.ffin
                   ELSE pm.fechafin
                   END -
               CASE
                   WHEN m.finicio > pm.fechainicio THEN m.finicio
                   ELSE pm.fechainicio
                   END) / 60::numeric AS duracion,
       eo.tiempoproductivo
FROM medida m
         JOIN centroproducto cp ON m.centroproducto_fk = cp.id
         JOIN productividadmedida pm ON pm.fechainicio < m.ffin AND pm.fechafin > m.finicio
         JOIN productividadmedidacentro pmc ON pm.id = pmc.medida_fk AND cp.centro_fk = pmc.centro_fk
         JOIN estadooperario eo ON pm.estado_fk = eo.id
WHERE m.tipomedida::text = 'estados'::text;

alter table vmedidaproductividaddetalle
    owner to postgres;

create view vmedidaproductividad (id, medida_fk, numoperarios, duracion, duracionproductivo, duracionnoproductivo) as
SELECT medida_fk                                                             AS id,
       medida_fk,
       count(DISTINCT operario_fk)                                           AS numoperarios,
       sum(duracion::double precision * intensidad * 0.01::double precision) AS duracion,
       sum(
               CASE
                   WHEN tiempoproductivo = 1::boolean
                       THEN duracion::double precision * intensidad * 0.01::double precision
                   ELSE 0::double precision
                   END)                                                      AS duracionproductivo,
       sum(
               CASE
                   WHEN tiempoproductivo = 0::boolean
                       THEN duracion::double precision * intensidad * 0.01::double precision
                   ELSE 0::double precision
                   END)                                                      AS duracionnoproductivo
FROM vmedidaproductividaddetalle
GROUP BY medida_fk;

alter table vmedidaproductividad
    owner to postgres;

create view vpartes(fecha, centro, codorden, codproducto, cantidadreportada, unidadparte) as
SELECT p.fechafin  AS fecha,
       c.codigo    AS centro,
       co.codigo   AS codorden,
       prod.codigo AS codproducto,
       p.cantidadreportada,
       u.nombre    AS unidadparte
FROM parte p
         JOIN centroorden co ON co.id = p.orden_fk
         JOIN centroproducto cp ON cp.id = co.centroproducto_fk
         JOIN producto prod ON cp.producto_fk = prod.id
         JOIN centro c ON cp.centro_fk = c.id
         JOIN unidad u ON p.unidad_fk = u.id;

alter table vpartes
    owner to postgres;

create view vpartes_consumo(codorden, fecha, codproducto, lote, valorconsumo) as
SELECT co.codigo AS codorden,
       c.fecha,
       p.codigo  AS codproducto,
       c.lote,
       c.valorconsumo
FROM consumo c
         JOIN producto p ON c.producto_fk = p.id
         JOIN centroorden co ON co.id = c.centroorden_fk;

alter table vpartes_consumo
    owner to postgres;

create view vproduccionesmedidamag
            (medidaid, fecha, turnoid, centroordenid, operarioresponsableid, operarioid, cantidadproddesechada,
             cantidadproduccion, automatica, orden, centroordencodigo, centroordenfecha, cantidadprogramadaorden,
             centroproductoid, ratioprincipaleficiencia, ratioprinciplasecundaria, prodestandar,
             centroproductoratioprincipalsecundaria, centroproductovelocidadobjetivo, ratioconteoprincipal,
             ratioeficienciaconteo, productoid, productocodigo, productonombre, productothumbnail, centroid, centro,
             centroconectado, gestionmanualestados, tipocapturaestado, tipocapturaproduccion, centroordenactualid,
             centrovariableestadosproductiva, centrotipo, tipotiempoeficiencia, centrogestionmanualestados,
             centrotipocapturaestado, centrotipocapturaproduccion, centroactivo, unidadmermasid, unidadprincipalid,
             unidadprincipal, unidadsecundariaid, unidadsecundaria, unidadeficienciaid, unidadeficiencia, unidadmermas,
             productofamiliaid, productofamilianombre, plantaid, plantanombre, seccionid, seccionnombre, areaid,
             areanombre, unidadauxiliarid, unidadauxiliarnombre, ratioprincipalauxiliar, tipomedida)
as
SELECT mh.id                       AS medidaid,
       mh.ffin                     AS fecha,
       mh.turno_fk                 AS turnoid,
       mh.centroorden_fk           AS centroordenid,
       mh.operarioresponsable_fk   AS operarioresponsableid,
       mh.operario_fk              AS operarioid,
       CASE
           WHEN mh.tipomedida::text = 'cantidaddesechada'::text THEN mh.valormedida
           ELSE 0::double precision
           END                     AS cantidadproddesechada,
       CASE
           WHEN mh.tipomedida::text = 'produccion'::text THEN mh.valormedida
           ELSE 0::double precision
           END                     AS cantidadproduccion,
       mh.automatica,
       co.codigo                   AS orden,
       co.codigo                   AS centroordencodigo,
       co.fecha                    AS centroordenfecha,
       co.cantidad                 AS cantidadprogramadaorden,
       cp.id                       AS centroproductoid,
       cp.ratioprincipaleficiencia,
       cp.ratioprincipalsecundaria AS ratioprinciplasecundaria,
       cp.prodestandar,
       cp.ratioprincipalsecundaria AS centroproductoratioprincipalsecundaria,
       cp.vobjetivo                AS centroproductovelocidadobjetivo,
       cp.ratioconteoprincipal,
       cp.ratioeficienciaconteo,
       p.id                        AS productoid,
       p.codigo                    AS productocodigo,
       p.nombre                    AS productonombre,
       p.thumbnail                 AS productothumbnail,
       c.id                        AS centroid,
       c.nombre                    AS centro,
       c.conectado                 AS centroconectado,
       c.gestionmanualestados,
       c.tipocapturaestado,
       c.tipocapturaproduccion,
       c.centroordenactual_fk      AS centroordenactualid,
       c.vbleestadosesproductiva   AS centrovariableestadosproductiva,
       c.tipo                      AS centrotipo,
       c.tipotiempoeficiencia,
       c.gestionmanualestados      AS centrogestionmanualestados,
       c.tipocapturaestado         AS centrotipocapturaestado,
       c.tipocapturaproduccion     AS centrotipocapturaproduccion,
       c.activo                    AS centroactivo,
       c.unidadmermas_fk           AS unidadmermasid,
       u.id                        AS unidadprincipalid,
       u.nombre                    AS unidadprincipal,
       u1.id                       AS unidadsecundariaid,
       u1.nombre                   AS unidadsecundaria,
       u2.id                       AS unidadeficienciaid,
       u2.nombre                   AS unidadeficiencia,
       u3.nombre                   AS unidadmermas,
       pf.id                       AS productofamiliaid,
       pf.nombre                   AS productofamilianombre,
       pl.id                       AS plantaid,
       pl.nombre                   AS plantanombre,
       s.id                        AS seccionid,
       s.nombre                    AS seccionnombre,
       a.id                        AS areaid,
       a.nombre                    AS areanombre,
       u4.id                       AS unidadauxiliarid,
       u4.nombre                   AS unidadauxiliarnombre,
       cp.ratioprincipalauxiliar,
       'R'::text                   AS tipomedida
FROM medida mh
         JOIN centroorden co ON co.id = mh.centroorden_fk
         JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         LEFT JOIN producto p ON p.id = cp.producto_fk
         JOIN centro c ON cp.centro_fk = c.id
         LEFT JOIN seccion s ON c.seccion_fk = s.id
         LEFT JOIN area a ON s.area_fk = a.id
         LEFT JOIN planta pl ON a.planta_fk = pl.id
         LEFT JOIN unidad u ON u.id = c.unidadprincipal_fk
         LEFT JOIN unidad u1 ON u1.id = c.unidadsecundaria_fk
         LEFT JOIN unidad u2 ON u2.id = c.unidadeficiencia_fk
         LEFT JOIN unidad u3 ON u3.id = c.unidadmermas_fk
         LEFT JOIN unidad u4 ON u4.id = c.unidadauxiliar_fk
         LEFT JOIN productofamilia pf ON p.familia_fk = pf.id
WHERE mh.tipomedida::text = ANY
      (ARRAY ['produccion'::character varying::text, 'cantidaddesechada'::character varying::text]);

alter table vproduccionesmedidamag
    owner to postgres;

create view vpuntoestandarizacioncentro
            (puntoestandarizacionid, puntoestandarizacionnombre, puntoestandarizaciontipo,
             puntoestandarizaciondescripcion, puntoestandarizacionorden, puntoestandarizacionpadreid,
             puntoestandarizacionpadrenombre, puntoestandarizacionpadretipo, puntoestandarizacionpadredescripcion,
             puntoestandarizacionpadreorden, puntoestandarizacioncentroid, centroid, centronombre)
as
SELECT pe.id               AS puntoestandarizacionid,
       pe.nombre           AS puntoestandarizacionnombre,
       pe.tipo             AS puntoestandarizaciontipo,
       pe.descripcion      AS puntoestandarizaciondescripcion,
       pe.orden            AS puntoestandarizacionorden,
       pepadre.id          AS puntoestandarizacionpadreid,
       pepadre.nombre      AS puntoestandarizacionpadrenombre,
       pepadre.tipo        AS puntoestandarizacionpadretipo,
       pepadre.descripcion AS puntoestandarizacionpadredescripcion,
       pepadre.orden       AS puntoestandarizacionpadreorden,
       pec.id              AS puntoestandarizacioncentroid,
       c.id                AS centroid,
       c.nombre            AS centronombre
FROM puntoestandarizacioncentro pec
         LEFT JOIN puntoestandarizacion pe ON pec.puntoestandarizacion_fk = pe.id
         LEFT JOIN puntoestandarizacion pepadre ON pe.puntoestandarizacionpadre_fk = pepadre.id
         LEFT JOIN centro c ON pec.centro_fk = c.id;

alter table vpuntoestandarizacioncentro
    owner to postgres;

create view vregistrosvelocidadesmag
            (ffin, finicio, centroid, valormedidaest, unidadvelocidad, unidadtiempovelocidad, varestadosproductiva,
             vlimite, vobjetivo, vblestadosproductiva, tipo_estado, duracion, valormedidaprod)
as
WITH datos AS (SELECT m.ffin,
                      m.finicio,
                      c.id                                                       AS centroid,
                      m.valormedida                                              AS valormedidaest,
                      u.nombre                                                   AS unidadvelocidad,
                      c.tipotiempoeficiencia                                     AS unidadtiempovelocidad,
                      c.vbleestadosesproductiva                                  AS varestadosproductiva,
                      cp.vlimite,
                      cp.vobjetivo,
                      c.vbleestadosesproductiva                                  AS vblestadosproductiva,
                      CASE
                          WHEN e.tipo_fk = 2 THEN 'produccion'::text
                          ELSE 'otros'::text
                          END                                                    AS tipo_estado,
                      CASE
                          WHEN e.tipo_fk = 2 THEN
                              CASE
                                  WHEN c.tipotiempoeficiencia::text = 'minutos'::text THEN m.duracion
                                  WHEN c.tipotiempoeficiencia::text = 'horas'::text THEN m.duracion / 60.0
                                  ELSE 0::numeric
                                  END
                          ELSE 0::numeric
                          END                                                    AS duracion,
                      COALESCE(prod.total_produccion, 0::double precision) *
                      COALESCE(cp.ratioprincipaleficiencia, 1::double precision) +
                      COALESCE(cons.total_consumo, 0::double precision) *
                      COALESCE(cp.ratioprincipaleficiencia, 1::double precision) AS valormedidaprod
               FROM vmedida m
                        LEFT JOIN centroorden co ON m.centroorden_fk = co.id
                        LEFT JOIN centroproducto cp ON cp.id = co.centroproducto_fk
                        LEFT JOIN centro c ON cp.centro_fk = c.id
                        LEFT JOIN unidad u ON c.unidadeficiencia_fk = u.id
                        LEFT JOIN centroestado ce ON m.centroestado_fk = ce.id
                        LEFT JOIN estado e ON ce.estado_fk = e.id
                        LEFT JOIN LATERAL ( SELECT sum(mp.valormedida) AS total_produccion
                                            FROM medida mp
                                            WHERE mp.tipomedida::text = 'produccion'::text
                                              AND mp.centroorden_fk = m.centroorden_fk
                                              AND m.finicio < mp.ffin
                                              AND m.ffin >= mp.ffin) prod ON true
                        LEFT JOIN LATERAL ( SELECT sum(cs.valorconsumo) AS total_consumo
                                            FROM consumo cs
                                            WHERE cs.tipooperacion::text = 'PRODUCCION'::text
                                              AND cs.centroorden_fk = m.centroorden_fk
                                              AND m.finicio < cs.fecha
                                              AND m.ffin >= cs.fecha) cons ON true
               WHERE m.tipomedida::text = 'estados'::text)
SELECT ffin,
       finicio,
       centroid,
       valormedidaest,
       unidadvelocidad,
       unidadtiempovelocidad,
       varestadosproductiva,
       vlimite,
       vobjetivo,
       vblestadosproductiva,
       tipo_estado,
       duracion,
       valormedidaprod
FROM datos
WHERE tipo_estado = 'produccion'::text
   OR tipo_estado = 'otros'::text AND valormedidaprod > 0::double precision
ORDER BY ffin DESC;

alter table vregistrosvelocidadesmag
    owner to postgres;

create view vusuariorealm(login, password) as
SELECT usuario.login,
       usuario.password
FROM usuario
WHERE usuario.activo = 1::boolean
UNION
SELECT 'topview'::character varying                          AS login,
       '827ccb0eea8a706c4c34a16891f84e7b'::character varying AS password;

comment on view vusuariorealm is 'Vista que lista usuarios activos para autenticación (realm).
Incluye usuarios de la tabla usuario con activo=1 más el usuario especial topview.';

alter table vusuariorealm
    owner to postgres;

create view vusuariorolrealm(login, rol) as
SELECT u.login,
       'topview'::character varying AS rol
FROM usuario u
WHERE u.activo = 1::boolean
UNION ALL
SELECT 'topview'::character varying AS login,
       'admin'::character varying   AS rol
UNION ALL
SELECT 'topview'::character varying        AS login,
       'manager-script'::character varying AS rol
UNION ALL
SELECT 'topview'::character varying     AS login,
       'manager-gui'::character varying AS rol;

alter table vusuariorolrealm
    owner to postgres;

create view vproduccioneshistmag
            (medidaid, fecha, turnoid, centroordenid, operarioresponsableid, operarioid, cantidadproddesechada,
             cantidadproduccion, automatica, orden, centroordencodigo, centroordenfecha, cantidadprogramadaorden,
             centroproductoid, ratioprincipaleficiencia, ratioprinciplasecundaria, prodestandar,
             centroproductoratioproincipalsecundaria, centroproductovelocidadobjetivo, ratioconteoprincipal,
             ratioeficienciaconteo, productoid, productocodigo, productonombre, productothumbnail, centroid, centro,
             centroconectado, gestionmanualestados, tipocapturaestado, tipocapturaproduccion, centroordenactualid,
             centrovariableestadosproductiva, centrotipo, tipotiempoeficiencia, centrogestionmanualestados,
             centrotipocapturaestado, centrotipocapturaproduccion, centroactivo, unidadmermasid, unidadprincipalid,
             unidadprincipal, unidadsecundariaid, unidadsecundaria, unidadeficienciaid, unidadeficiencia, unidadmermas,
             productofamiliaid, productofamilianombre, plantaid, plantanombre, seccionid, seccionnombre, areaid,
             areanombre, unidadauxiliarid, unidadauxiliarnombre, ratioprincipalauxiliar, tipomedida)
as
WITH medidas_union AS (SELECT mph.medidahist_fk  AS medidahist_id,
                              mph.valormedida,
                              mph.automatica,
                              'PRODUCCION'::text AS tipo
                       FROM medidaproduccionhist mph
                       WHERE mph.medidahist_fk IS NOT NULL)
SELECT mh.id                                 AS medidaid,
       mh.ffin                               AS fecha,
       mh.turno_fk                           AS turnoid,
       mh.centroorden_fk                     AS centroordenid,
       mh.operarioresponsable_fk             AS operarioresponsableid,
       mh.operario_fk                        AS operarioid,
       COALESCE(
               CASE
                   WHEN mu.tipo = 'DESECHADA'::text THEN mu.valormedida
                   ELSE NULL::double precision
                   END, 0::double precision) AS cantidadproddesechada,
       COALESCE(
               CASE
                   WHEN mu.tipo = 'PRODUCCION'::text THEN mu.valormedida
                   ELSE NULL::double precision
                   END, 0::double precision) AS cantidadproduccion,
       mu.automatica,
       co.codigo                             AS orden,
       co.codigo                             AS centroordencodigo,
       co.fecha                              AS centroordenfecha,
       co.cantidad                           AS cantidadprogramadaorden,
       cp.id                                 AS centroproductoid,
       cp.ratioprincipaleficiencia,
       cp.ratioprincipalsecundaria           AS ratioprinciplasecundaria,
       cp.prodestandar,
       cp.ratioprincipalsecundaria           AS centroproductoratioproincipalsecundaria,
       cp.vobjetivo                          AS centroproductovelocidadobjetivo,
       cp.ratioconteoprincipal,
       cp.ratioeficienciaconteo,
       p.id                                  AS productoid,
       p.codigo                              AS productocodigo,
       p.nombre                              AS productonombre,
       p.thumbnail                           AS productothumbnail,
       c.id                                  AS centroid,
       c.nombre                              AS centro,
       c.conectado                           AS centroconectado,
       c.gestionmanualestados,
       c.tipocapturaestado,
       c.tipocapturaproduccion,
       c.centroordenactual_fk                AS centroordenactualid,
       c.vbleestadosesproductiva             AS centrovariableestadosproductiva,
       c.tipo                                AS centrotipo,
       c.tipotiempoeficiencia,
       c.gestionmanualestados                AS centrogestionmanualestados,
       c.tipocapturaestado                   AS centrotipocapturaestado,
       c.tipocapturaproduccion               AS centrotipocapturaproduccion,
       c.activo                              AS centroactivo,
       c.unidadmermas_fk                     AS unidadmermasid,
       u.id                                  AS unidadprincipalid,
       u.nombre                              AS unidadprincipal,
       u1.id                                 AS unidadsecundariaid,
       u1.nombre                             AS unidadsecundaria,
       u2.id                                 AS unidadeficienciaid,
       u2.nombre                             AS unidadeficiencia,
       u3.nombre                             AS unidadmermas,
       pf.id                                 AS productofamiliaid,
       pf.nombre                             AS productofamilianombre,
       pl.id                                 AS plantaid,
       pl.nombre                             AS plantanombre,
       s.id                                  AS seccionid,
       s.nombre                              AS seccionnombre,
       a.id                                  AS areaid,
       a.nombre                              AS areanombre,
       u4.id                                 AS unidadauxiliarid,
       u4.nombre                             AS unidadauxiliarnombre,
       cp.ratioprincipalauxiliar,
       'H'::text                             AS tipomedida
FROM medidahist mh
         LEFT JOIN medidas_union mu ON mu.medidahist_id = mh.id
         JOIN centroorden co ON co.id = mh.centroorden_fk
         JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         JOIN centro c ON cp.centro_fk = c.id
         LEFT JOIN producto p ON p.id = cp.producto_fk
         LEFT JOIN productofamilia pf ON p.familia_fk = pf.id
         LEFT JOIN seccion s ON c.seccion_fk = s.id
         LEFT JOIN area a ON s.area_fk = a.id
         LEFT JOIN planta pl ON a.planta_fk = pl.id
         LEFT JOIN unidad u ON u.id = c.unidadprincipal_fk
         LEFT JOIN unidad u1 ON u1.id = c.unidadsecundaria_fk
         LEFT JOIN unidad u2 ON u2.id = c.unidadeficiencia_fk
         LEFT JOIN unidad u3 ON u3.id = c.unidadmermas_fk
         LEFT JOIN unidad u4 ON u4.id = c.unidadauxiliar_fk;

alter table vproduccioneshistmag
    owner to postgres;

create view vproduccionesdesechadashistmag
            (medidaid, fecha, turnoid, centroordenid, operarioresponsableid, operarioid, cantidadproddesechada,
             cantidadproduccion, automatica, orden, centroordencodigo, centroordenfecha, cantidadprogramadaorden,
             centroproductoid, ratioprincipaleficiencia, ratioprinciplasecundaria, prodestandar,
             centroproductoratioproincipalsecundaria, centroproductovelocidadobjetivo, ratioconteoprincipal,
             ratioeficienciaconteo, productoid, productocodigo, productonombre, productothumbnail, centroid, centro,
             centroconectado, gestionmanualestados, tipocapturaestado, tipocapturaproduccion, centroordenactualid,
             centrovariableestadosproductiva, centrotipo, tipotiempoeficiencia, centrogestionmanualestados,
             centrotipocapturaestado, centrotipocapturaproduccion, centroactivo, unidadmermasid, unidadprincipalid,
             unidadprincipal, unidadsecundariaid, unidadsecundaria, unidadeficienciaid, unidadeficiencia, unidadmermas,
             productofamiliaid, productofamilianombre, plantaid, plantanombre, seccionid, seccionnombre, areaid,
             areanombre, unidadauxiliarid, unidadauxiliarnombre, ratioprincipalauxiliar, tipomedida)
as
WITH medidas_union AS (SELECT mdh.medidahist_fk AS medidahist_id,
                              mdh.valormedida,
                              mdh.automatica,
                              'DESECHADA'::text AS tipo
                       FROM medidadesechadahist mdh
                       WHERE mdh.medidahist_fk IS NOT NULL)
SELECT mh.id                                 AS medidaid,
       mh.ffin                               AS fecha,
       mh.turno_fk                           AS turnoid,
       mh.centroorden_fk                     AS centroordenid,
       mh.operarioresponsable_fk             AS operarioresponsableid,
       mh.operario_fk                        AS operarioid,
       COALESCE(
               CASE
                   WHEN mu.tipo = 'DESECHADA'::text THEN mu.valormedida
                   ELSE NULL::double precision
                   END, 0::double precision) AS cantidadproddesechada,
       COALESCE(
               CASE
                   WHEN mu.tipo = 'PRODUCCION'::text THEN mu.valormedida
                   ELSE NULL::double precision
                   END, 0::double precision) AS cantidadproduccion,
       mu.automatica,
       co.codigo                             AS orden,
       co.codigo                             AS centroordencodigo,
       co.fecha                              AS centroordenfecha,
       co.cantidad                           AS cantidadprogramadaorden,
       cp.id                                 AS centroproductoid,
       cp.ratioprincipaleficiencia,
       cp.ratioprincipalsecundaria           AS ratioprinciplasecundaria,
       cp.prodestandar,
       cp.ratioprincipalsecundaria           AS centroproductoratioproincipalsecundaria,
       cp.vobjetivo                          AS centroproductovelocidadobjetivo,
       cp.ratioconteoprincipal,
       cp.ratioeficienciaconteo,
       p.id                                  AS productoid,
       p.codigo                              AS productocodigo,
       p.nombre                              AS productonombre,
       p.thumbnail                           AS productothumbnail,
       c.id                                  AS centroid,
       c.nombre                              AS centro,
       c.conectado                           AS centroconectado,
       c.gestionmanualestados,
       c.tipocapturaestado,
       c.tipocapturaproduccion,
       c.centroordenactual_fk                AS centroordenactualid,
       c.vbleestadosesproductiva             AS centrovariableestadosproductiva,
       c.tipo                                AS centrotipo,
       c.tipotiempoeficiencia,
       c.gestionmanualestados                AS centrogestionmanualestados,
       c.tipocapturaestado                   AS centrotipocapturaestado,
       c.tipocapturaproduccion               AS centrotipocapturaproduccion,
       c.activo                              AS centroactivo,
       c.unidadmermas_fk                     AS unidadmermasid,
       u.id                                  AS unidadprincipalid,
       u.nombre                              AS unidadprincipal,
       u1.id                                 AS unidadsecundariaid,
       u1.nombre                             AS unidadsecundaria,
       u2.id                                 AS unidadeficienciaid,
       u2.nombre                             AS unidadeficiencia,
       u3.nombre                             AS unidadmermas,
       pf.id                                 AS productofamiliaid,
       pf.nombre                             AS productofamilianombre,
       pl.id                                 AS plantaid,
       pl.nombre                             AS plantanombre,
       s.id                                  AS seccionid,
       s.nombre                              AS seccionnombre,
       a.id                                  AS areaid,
       a.nombre                              AS areanombre,
       u4.id                                 AS unidadauxiliarid,
       u4.nombre                             AS unidadauxiliarnombre,
       cp.ratioprincipalauxiliar,
       'H'::text                             AS tipomedida
FROM medidahist mh
         LEFT JOIN medidas_union mu ON mu.medidahist_id = mh.id
         JOIN centroorden co ON co.id = mh.centroorden_fk
         JOIN centroproducto cp ON co.centroproducto_fk = cp.id
         JOIN centro c ON cp.centro_fk = c.id
         LEFT JOIN producto p ON p.id = cp.producto_fk
         LEFT JOIN productofamilia pf ON p.familia_fk = pf.id
         LEFT JOIN seccion s ON c.seccion_fk = s.id
         LEFT JOIN area a ON s.area_fk = a.id
         LEFT JOIN planta pl ON a.planta_fk = pl.id
         LEFT JOIN unidad u ON u.id = c.unidadprincipal_fk
         LEFT JOIN unidad u1 ON u1.id = c.unidadsecundaria_fk
         LEFT JOIN unidad u2 ON u2.id = c.unidadeficiencia_fk
         LEFT JOIN unidad u3 ON u3.id = c.unidadmermas_fk
         LEFT JOIN unidad u4 ON u4.id = c.unidadauxiliar_fk;

alter table vproduccionesdesechadashistmag
    owner to postgres;

create view vcomunicacion
            (uid, id, incidencia_fk, observacion_fk, sugerencia_fk, grupocomunicacion_fk, fechaapertura,
             tipocomunicacion, orden, seccion_fk, centro_fk, incidenciatipo_fk, observaciontipo_fk, sugerenciatipo_fk,
             operario_fk, operarioafectado_fk, usuario_fk, responsable_fk, duracion, estado, descripcion, acciones,
             accionespreventivas, analisis, prioridad, nombretipo, estado_fk, accionespendientes, accionestotales,
             defectospendientes, defectostotales, mejoraspendientes, mejorastotales)
as
SELECT uid,
       id,
       incidencia_fk,
       observacion_fk,
       sugerencia_fk,
       grupocomunicacion_fk,
       fechaapertura,
       tipocomunicacion,
       orden,
       seccion_fk,
       centro_fk,
       incidenciatipo_fk,
       observaciontipo_fk,
       sugerenciatipo_fk,
       operario_fk,
       operarioafectado_fk,
       usuario_fk,
       responsable_fk,
       duracion,
       estado,
       descripcion,
       acciones,
       accionespreventivas,
       analisis,
       prioridad,
       nombretipo,
       estado_fk,
       accionespendientes,
       accionestotales,
       defectospendientes,
       defectostotales,
       mejoraspendientes,
       mejorastotales
FROM (SELECT concat('i_', i.id)                 AS uid,
             i.id,
             i.id                               AS incidencia_fk,
             NULL::bigint                       AS observacion_fk,
             NULL::bigint                       AS sugerencia_fk,
             i.fechaapertura,
             'incidencia'::text                 AS tipocomunicacion,
             i.orden,
             c.seccion_fk,
             c.id                               AS centro_fk,
             i.incidenciatipo_fk,
             NULL::bigint                       AS observaciontipo_fk,
             NULL::bigint                       AS sugerenciatipo_fk,
             i.operario_fk,
             i.operarioafectado_fk,
             i.usuario_fk,
             i.responsable_fk,
             i.duracion,
             i.estado::text                     AS estado,
             i.descripcion,
             i.acciones,
             i.accionespreventivas,
             i.analisis,
             i.prioridad,
             it.nombre                          AS nombretipo,
             COALESCE(e.id, eh.id)              AS estado_fk,
             COALESCE(ai.pendientes, 0::bigint) AS accionespendientes,
             COALESCE(ai.total, 0::bigint)      AS accionestotales,
             COALESCE(di.pendientes, 0::bigint) AS defectospendientes,
             COALESCE(di.total, 0::bigint)      AS defectostotales,
             COALESCE(mi.pendientes, 0::bigint) AS mejoraspendientes,
             COALESCE(mi.total, 0::bigint)      AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM incidencia i
               LEFT JOIN centro c ON c.id = i.centro_fk
               LEFT JOIN incidenciatipo it ON it.id = i.incidenciatipo_fk
               LEFT JOIN medida m ON m.id = i.medida_fk
               LEFT JOIN centroestado ce ON ce.id = m.centroestado_fk
               LEFT JOIN medidahist mh ON mh.id = i.medidahist_fk
               LEFT JOIN estado e ON e.id = ce.estado_fk
               LEFT JOIN estado eh ON eh.id = mh.estado_fk
               LEFT JOIN (SELECT a.incidencia_fk  AS incidenciafk,
                                 count(a.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN a.estado::text = ANY
                                                  (ARRAY ['abierta'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM accion a
                          GROUP BY a.incidencia_fk) ai ON ai.incidenciafk = i.id
               LEFT JOIN (SELECT d.incidencia_fk  AS incidenciafk,
                                 count(d.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN d.estado::text = ANY
                                                  (ARRAY ['abierto'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM defecto d
                          GROUP BY d.incidencia_fk) di ON di.incidenciafk = i.id
               LEFT JOIN (SELECT m_1.incidencia_fk AS incidenciafk,
                                 count(m_1.id)     AS total,
                                 sum(
                                         CASE
                                             WHEN m_1.estado = ANY
                                                  (ARRAY ['abierta'::enum_mejora_estado, 'en curso'::enum_mejora_estado])
                                                 THEN 1
                                             ELSE 0
                                             END)  AS pendientes
                          FROM mejora m_1
                          GROUP BY m_1.incidencia_fk) mi ON mi.incidenciafk = i.id
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.incidencia_fk = i.id
      UNION
      SELECT concat('o_', o.id)                  AS uid,
             o.id,
             NULL::bigint                        AS incidencia_fk,
             o.id                                AS observacion_fk,
             NULL::bigint                        AS sugerencia_fk,
             o.fechaapertura,
             'observacion'::text                 AS tipocomunicacion,
             NULL::character varying             AS orden,
             c.seccion_fk,
             c.id                                AS centro_fk,
             NULL::bigint                        AS incidenciatipo_fk,
             o.tipo_fk                           AS observaciontipo_fk,
             NULL::bigint                        AS sugerenciatipo_fk,
             o.operario_fk,
             o.operarioafectado_fk,
             o.usuario_fk,
             o.responsable_fk,
             NULL::bigint                        AS duracion,
             o.estado::text                      AS estado,
             o.descripcion,
             o.acciones,
             o.accionespreventivas,
             o.analisis,
             NULL::integer                       AS prioridad,
             ot.nombre                           AS nombretipo,
             NULL::bigint                        AS estado_fk,
             COALESCE(aob.pendientes, 0::bigint) AS accionespendientes,
             COALESCE(aob.total, 0::bigint)      AS accionestotales,
             COALESCE(dob.pendientes, 0::bigint) AS defectospendientes,
             COALESCE(dob.total, 0::bigint)      AS defectostotales,
             COALESCE(mob.pendientes, 0::bigint) AS mejoraspendientes,
             COALESCE(mob.total, 0::bigint)      AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM observacion o
               LEFT JOIN centro c ON c.id = o.centro_fk
               LEFT JOIN observaciontipo ot ON ot.id = o.tipo_fk
               LEFT JOIN (SELECT a.observacion_fk AS observacionfk,
                                 count(a.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN a.estado::text = ANY
                                                  (ARRAY ['abierta'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM accion a
                          GROUP BY a.observacion_fk) aob ON aob.observacionfk = o.id
               LEFT JOIN (SELECT d.observacion_fk AS observacionfk,
                                 count(d.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN d.estado::text = ANY
                                                  (ARRAY ['abierto'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM defecto d
                          GROUP BY d.observacion_fk) dob ON dob.observacionfk = o.id
               LEFT JOIN (SELECT m.observacion_fk AS observacionfk,
                                 count(m.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN m.estado = ANY
                                                  (ARRAY ['abierta'::enum_mejora_estado, 'en curso'::enum_mejora_estado])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM mejora m
                          GROUP BY m.observacion_fk) mob ON mob.observacionfk = o.id
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.observacion_fk = o.id
      UNION
      SELECT concat('s_', s.id)                 AS uid,
             s.id,
             NULL::bigint                       AS incidencia_fk,
             NULL::bigint                       AS observacion_fk,
             s.id                               AS sugerencia_fk,
             s.fechaapertura,
             'sugerencia'::text                 AS tipocomunicacion,
             NULL::character varying            AS orden,
             c.seccion_fk,
             c.id                               AS centro_fk,
             NULL::bigint                       AS incidenciatipo_fk,
             NULL::bigint                       AS observaciontipo_fk,
             s.tipo_fk                          AS sugerenciatipo_fk,
             s.operario_fk,
             NULL::bigint                       AS operarioafectado_fk,
             s.usuario_fk,
             s.responsable_fk,
             NULL::bigint                       AS duracion,
             s.estado::text                     AS estado,
             s.descripcion,
             NULL::character varying            AS acciones,
             NULL::character varying            AS accionespreventivas,
             s.analisis,
             NULL::integer                      AS prioridad,
             st.nombre                          AS nombretipo,
             NULL::bigint                       AS estado_fk,
             COALESCE(si.pendientes, 0::bigint) AS accionespendientes,
             COALESCE(si.total, 0::bigint)      AS accionestotales,
             0                                  AS defectospendientes,
             0                                  AS defectostotales,
             COALESCE(mi.pendientes, 0::bigint) AS mejoraspendientes,
             COALESCE(mi.total, 0::bigint)      AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM sugerencia s
               LEFT JOIN centro c ON c.id = s.centro_fk
               LEFT JOIN sugerenciatipo st ON st.id = s.tipo_fk
               LEFT JOIN (SELECT a.sugerencia_fk  AS sugerenciafk,
                                 count(a.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN a.estado::text = ANY
                                                  (ARRAY ['abierta'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM accion a
                          GROUP BY a.sugerencia_fk) si ON si.sugerenciafk = s.id
               LEFT JOIN (SELECT m.sugerencia_fk  AS sugerenciafk,
                                 count(m.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN m.estado = ANY
                                                  (ARRAY ['abierta'::enum_mejora_estado, 'en curso'::enum_mejora_estado])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM mejora m
                          GROUP BY m.sugerencia_fk) mi ON mi.sugerenciafk = s.id
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.sugerencia_fk = s.id) t
ORDER BY fechaapertura DESC;

alter table vcomunicacion
    owner to postgres;

create view vcomunicaciongrupo
            (uid, id, incidencia_fk, observacion_fk, sugerencia_fk, accion_fk, mejora_fk, defecto_fk,
             grupocomunicacion_fk, fechaapertura, tipocomunicacion, orden, seccion_fk, centro_fk, incidenciatipo_fk,
             observaciontipo_fk, sugerenciatipo_fk, mejoratipo_fk, defectotipo_fk, operario_fk, operarioafectado_fk,
             duracion, estado, descripcion, acciones, accionespreventivas, analisis, prioridad, nombretipo, estado_fk,
             accionespendientes, accionestotales, defectospendientes, defectostotales, mejoraspendientes,
             mejorastotales)
as
SELECT uid,
       id,
       incidencia_fk,
       observacion_fk,
       sugerencia_fk,
       accion_fk,
       mejora_fk,
       defecto_fk,
       grupocomunicacion_fk,
       fechaapertura,
       tipocomunicacion,
       orden,
       seccion_fk,
       centro_fk,
       incidenciatipo_fk,
       observaciontipo_fk,
       sugerenciatipo_fk,
       mejoratipo_fk,
       defectotipo_fk,
       operario_fk,
       operarioafectado_fk,
       duracion,
       estado,
       descripcion,
       acciones,
       accionespreventivas,
       analisis,
       prioridad,
       nombretipo,
       estado_fk,
       accionespendientes,
       accionestotales,
       defectospendientes,
       defectostotales,
       mejoraspendientes,
       mejorastotales
FROM (SELECT concat('i_', i.id)                 AS uid,
             i.id,
             i.id                               AS incidencia_fk,
             NULL::bigint                       AS observacion_fk,
             NULL::bigint                       AS sugerencia_fk,
             NULL::bigint                       AS accion_fk,
             NULL::bigint                       AS mejora_fk,
             NULL::bigint                       AS defecto_fk,
             i.fechaapertura,
             'incidencia'::text                 AS tipocomunicacion,
             i.orden,
             c.seccion_fk,
             c.id                               AS centro_fk,
             i.incidenciatipo_fk,
             NULL::bigint                       AS observaciontipo_fk,
             NULL::bigint                       AS sugerenciatipo_fk,
             NULL::bigint                       AS mejoratipo_fk,
             NULL::bigint                       AS defectotipo_fk,
             i.operario_fk,
             i.operarioafectado_fk,
             i.duracion,
             i.estado::text                     AS estado,
             i.descripcion,
             i.acciones,
             i.accionespreventivas,
             i.analisis,
             i.prioridad::text                  AS prioridad,
             it.nombre                          AS nombretipo,
             COALESCE(e.id, eh.id)              AS estado_fk,
             COALESCE(ai.pendientes, 0::bigint) AS accionespendientes,
             COALESCE(ai.total, 0::bigint)      AS accionestotales,
             COALESCE(di.pendientes, 0::bigint) AS defectospendientes,
             COALESCE(di.total, 0::bigint)      AS defectostotales,
             COALESCE(mi.pendientes, 0::bigint) AS mejoraspendientes,
             COALESCE(mi.total, 0::bigint)      AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM incidencia i
               LEFT JOIN centro c ON c.id = i.centro_fk
               LEFT JOIN incidenciatipo it ON it.id = i.incidenciatipo_fk
               LEFT JOIN medida m ON m.id = i.medida_fk
               LEFT JOIN centroestado ce ON ce.id = m.centroestado_fk
               LEFT JOIN medidahist mh ON mh.id = i.medidahist_fk AND mh.estadotipo_fk = 4
               LEFT JOIN estado e ON e.tipo_fk = 4 AND e.id = ce.estado_fk
               LEFT JOIN estado eh ON eh.id = mh.estado_fk
               LEFT JOIN (SELECT a.incidencia_fk  AS incidenciafk,
                                 count(a.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN a.estado::text = ANY
                                                  (ARRAY ['abierta'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM accion a
                          GROUP BY a.incidencia_fk) ai ON ai.incidenciafk = i.id
               LEFT JOIN (SELECT d.incidencia_fk  AS incidenciafk,
                                 count(d.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN d.estado::text = ANY
                                                  (ARRAY ['abierto'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM defecto d
                          GROUP BY d.incidencia_fk) di ON di.incidenciafk = i.id
               LEFT JOIN (SELECT m_1.incidencia_fk AS incidenciafk,
                                 count(m_1.id)     AS total,
                                 sum(
                                         CASE
                                             WHEN m_1.estado = ANY
                                                  (ARRAY ['abierta'::enum_mejora_estado, 'en curso'::enum_mejora_estado])
                                                 THEN 1
                                             ELSE 0
                                             END)  AS pendientes
                          FROM mejora m_1
                          GROUP BY m_1.incidencia_fk) mi ON mi.incidenciafk = i.id
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.incidencia_fk = i.id
      UNION
      SELECT concat('o_', o.id)                  AS uid,
             o.id,
             NULL::bigint                        AS incidencia_fk,
             o.id                                AS observacion_fk,
             NULL::bigint                        AS sugerencia_fk,
             NULL::bigint                        AS accion_fk,
             NULL::bigint                        AS mejora_fk,
             NULL::bigint                        AS defecto_fk,
             o.fechaapertura,
             'observacion'::text                 AS tipocomunicacion,
             NULL::character varying             AS orden,
             c.seccion_fk,
             c.id                                AS centro_fk,
             NULL::bigint                        AS incidenciatipo_fk,
             o.tipo_fk                           AS observaciontipo_fk,
             NULL::bigint                        AS sugerenciatipo_fk,
             NULL::bigint                        AS mejoratipo_fk,
             NULL::bigint                        AS defectotipo_fk,
             o.operario_fk,
             o.operarioafectado_fk,
             NULL::numeric                       AS duracion,
             o.estado::text                      AS estado,
             o.descripcion,
             o.acciones,
             o.accionespreventivas,
             o.analisis,
             NULL::text                          AS prioridad,
             ot.nombre                           AS nombretipo,
             NULL::bigint                        AS estado_fk,
             COALESCE(aob.pendientes, 0::bigint) AS accionespendientes,
             COALESCE(aob.total, 0::bigint)      AS accionestotales,
             0                                   AS defectospendientes,
             0                                   AS defectostotales,
             COALESCE(mob.pendientes, 0::bigint) AS mejoraspendientes,
             COALESCE(mob.total, 0::bigint)      AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM observacion o
               LEFT JOIN centro c ON c.id = o.centro_fk
               LEFT JOIN observaciontipo ot ON ot.id = o.tipo_fk
               LEFT JOIN (SELECT a.observacion_fk AS observacionfk,
                                 count(a.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN a.estado::text = ANY
                                                  (ARRAY ['abierta'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM accion a
                          GROUP BY a.observacion_fk) aob ON aob.observacionfk = o.id
               LEFT JOIN (SELECT m.observacion_fk AS observacionfk,
                                 count(m.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN m.estado = ANY
                                                  (ARRAY ['abierta'::enum_mejora_estado, 'en curso'::enum_mejora_estado])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM mejora m
                          GROUP BY m.observacion_fk) mob ON mob.observacionfk = o.id
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.observacion_fk = o.id
      UNION
      SELECT concat('s_', s.id)                 AS uid,
             s.id,
             NULL::bigint                       AS incidencia_fk,
             NULL::bigint                       AS observacion_fk,
             s.id                               AS sugerencia_fk,
             NULL::bigint                       AS accion_fk,
             NULL::bigint                       AS mejora_fk,
             NULL::bigint                       AS defecto_fk,
             s.fechaapertura,
             'sugerencia'::text                 AS tipocomunicacion,
             NULL::character varying            AS orden,
             c.seccion_fk,
             c.id                               AS centro_fk,
             NULL::bigint                       AS incidenciatipo_fk,
             NULL::bigint                       AS observaciontipo_fk,
             s.tipo_fk                          AS sugerenciatipo_fk,
             NULL::bigint                       AS mejoratipo_fk,
             NULL::bigint                       AS defectotipo_fk,
             s.operario_fk,
             NULL::bigint                       AS operarioafectado_fk,
             NULL::numeric                      AS duracion,
             s.estado::text                     AS estado,
             s.descripcion,
             NULL::character varying            AS acciones,
             NULL::character varying            AS accionespreventivas,
             s.analisis,
             NULL::text                         AS prioridad,
             st.nombre                          AS nombretipo,
             NULL::bigint                       AS estado_fk,
             COALESCE(si.pendientes, 0::bigint) AS accionespendientes,
             COALESCE(si.total, 0::bigint)      AS accionestotales,
             0                                  AS defectospendientes,
             0                                  AS defectostotales,
             COALESCE(mi.pendientes, 0::bigint) AS mejoraspendientes,
             COALESCE(mi.total, 0::bigint)      AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM sugerencia s
               LEFT JOIN centro c ON c.id = s.centro_fk
               LEFT JOIN sugerenciatipo st ON st.id = s.tipo_fk
               LEFT JOIN (SELECT a.sugerencia_fk  AS sugerenciafk,
                                 count(a.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN a.estado::text = ANY
                                                  (ARRAY ['abierta'::character varying, 'en curso'::character varying]::text[])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM accion a
                          GROUP BY a.sugerencia_fk) si ON si.sugerenciafk = s.id
               LEFT JOIN (SELECT m.sugerencia_fk  AS sugerenciafk,
                                 count(m.id)      AS total,
                                 sum(
                                         CASE
                                             WHEN m.estado = ANY
                                                  (ARRAY ['abierta'::enum_mejora_estado, 'en curso'::enum_mejora_estado])
                                                 THEN 1
                                             ELSE 0
                                             END) AS pendientes
                          FROM mejora m
                          GROUP BY m.sugerencia_fk) mi ON mi.sugerenciafk = s.id
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.sugerencia_fk = s.id
      UNION
      SELECT concat('a_', a.id)      AS uid,
             a.id,
             NULL::bigint            AS incidencia_fk,
             NULL::bigint            AS observacion_fk,
             NULL::bigint            AS sugerencia_fk,
             a.id                    AS accion_fk,
             NULL::bigint            AS mejora_fk,
             NULL::bigint            AS defecto_fk,
             a.fechaapertura,
             'accion'::text          AS tipocomunicacion,
             NULL::character varying AS orden,
             c.seccion_fk,
             c.id                    AS centro_fk,
             NULL::bigint            AS incidenciatipo_fk,
             NULL::bigint            AS observaciontipo_fk,
             NULL::bigint            AS sugerenciatipo_fk,
             NULL::bigint            AS mejoratipo_fk,
             NULL::bigint            AS defectotipo_fk,
             a.operario_fk,
             NULL::bigint            AS operarioafectado_fk,
             NULL::numeric           AS duracion,
             a.estado::text          AS estado,
             a.descripcion,
             NULL::character varying AS acciones,
             NULL::character varying AS accionespreventivas,
             NULL::character varying AS analisis,
             a.prioridad::text       AS prioridad,
             NULL::character varying AS nombretipo,
             NULL::bigint            AS estado_fk,
             0                       AS accionespendientes,
             0                       AS accionestotales,
             0                       AS defectospendientes,
             0                       AS defectostotales,
             0                       AS mejoraspendientes,
             0                       AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM accion a
               LEFT JOIN incidencia i ON i.id = a.incidencia_fk
               LEFT JOIN observacion o ON o.id = a.observacion_fk
               LEFT JOIN sugerencia s ON s.id = a.sugerencia_fk
               LEFT JOIN centro c ON c.id = i.centro_fk OR c.id = o.centro_fk OR c.id = s.centro_fk
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.accion_fk = a.id
      UNION
      SELECT concat('m_', m.id)      AS uid,
             m.id,
             NULL::bigint            AS incidencia_fk,
             NULL::bigint            AS observacion_fk,
             NULL::bigint            AS sugerencia_fk,
             NULL::bigint            AS accion_fk,
             m.id                    AS mejora_fk,
             NULL::bigint            AS defecto_fk,
             m.fechaalta             AS fechaapertura,
             'mejora'::text          AS tipocomunicacion,
             NULL::character varying AS orden,
             c.seccion_fk,
             c.id                    AS centro_fk,
             NULL::bigint            AS incidenciatipo_fk,
             NULL::bigint            AS observaciontipo_fk,
             NULL::bigint            AS sugerenciatipo_fk,
             m.mejoratipo_fk,
             NULL::bigint            AS defectotipo_fk,
             m.proponente_fk         AS operario_fk,
             NULL::bigint            AS operarioafectado_fk,
             NULL::numeric           AS duracion,
             m.estado::text          AS estado,
             m.descripcion,
             NULL::character varying AS acciones,
             NULL::character varying AS accionespreventivas,
             NULL::character varying AS analisis,
             m.prioridad::text       AS prioridad,
             mt.nombre               AS nombretipo,
             NULL::bigint            AS estado_fk,
             0                       AS accionespendientes,
             0                       AS accionestotales,
             0                       AS defectospendientes,
             0                       AS defectostotales,
             0                       AS mejoraspendientes,
             0                       AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM mejora m
               LEFT JOIN mejoratipo mt ON mt.id = m.mejoratipo_fk
               LEFT JOIN centro c ON c.id = m.centro_fk
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.mejora_fk = m.id
      UNION
      SELECT concat('d_', d.id)      AS uid,
             d.id,
             NULL::bigint            AS incidencia_fk,
             NULL::bigint            AS observacion_fk,
             NULL::bigint            AS sugerencia_fk,
             NULL::bigint            AS accion_fk,
             NULL::bigint            AS mejora_fk,
             d.id                    AS defecto_fk,
             d.fechaapertura,
             'defecto'::text         AS tipocomunicacion,
             NULL::character varying AS orden,
             c.seccion_fk,
             c.id                    AS centro_fk,
             NULL::bigint            AS incidenciatipo_fk,
             NULL::bigint            AS observaciontipo_fk,
             NULL::bigint            AS sugerenciatipo_fk,
             NULL::bigint            AS mejoratipo_fk,
             d.tipo_fk               AS defectotipo_fk,
             d.autorsolucion_fk      AS operario_fk,
             NULL::bigint            AS operarioafectado_fk,
             NULL::numeric           AS duracion,
             d.estado::text          AS estado,
             d.descripcion,
             NULL::character varying AS acciones,
             NULL::character varying AS accionespreventivas,
             NULL::character varying AS analisis,
             d.prioridad::text       AS prioridad,
             dt.nombre               AS nombretipo,
             NULL::bigint            AS estado_fk,
             0                       AS accionespendientes,
             0                       AS accionestotales,
             0                       AS defectospendientes,
             0                       AS defectostotales,
             0                       AS mejoraspendientes,
             0                       AS mejorastotales,
             gcc.grupocomunicacion_fk
      FROM defecto d
               LEFT JOIN defectotipo dt ON dt.id = d.tipo_fk
               LEFT JOIN centro c ON c.id = d.centro_fk
               LEFT JOIN grupocomunicacioncomunicacion gcc ON gcc.defecto_fk = d.id) t
ORDER BY fechaapertura DESC;

alter table vcomunicaciongrupo
    owner to postgres;

create function set_integer_now_func(hypertable regclass, integer_now_func regproc, replace_if_exists boolean default false) returns void
    strict
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function set_integer_now_func(regclass, regproc, boolean) owner to postgres;

create procedure detach_chunk(chunk regclass)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure detach_chunk(regclass) owner to postgres;

create procedure attach_chunk(hypertable regclass, chunk regclass, slices jsonb)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure attach_chunk(regclass, regclass, jsonb) owner to postgres;

create function create_hypertable(relation regclass, time_column_name name, partitioning_column name default NULL::name, number_partitions integer default NULL::integer, associated_schema_name name default NULL::name, associated_table_prefix name default NULL::name, chunk_time_interval anyelement default NULL::bigint, create_default_indexes boolean default true, if_not_exists boolean default false, partitioning_func regproc default NULL::regproc, migrate_data boolean default false, chunk_target_size text default NULL::text, chunk_sizing_func regproc default '_timescaledb_functions.calculate_chunk_interval'::regproc, time_partitioning_func regproc default NULL::regproc) returns setof table("hypertable_id" integer, "schema_name" name, "table_name" name, "created" boolean)
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function create_hypertable(regclass, name, name, integer, name, name, anyelement, boolean, boolean, regproc, boolean, text, regproc, regproc) owner to postgres;

create function create_hypertable(relation regclass, dimension _timescaledb_internal.dimension_info, create_default_indexes boolean default true, if_not_exists boolean default false, migrate_data boolean default false) returns setof table("hypertable_id" integer, "created" boolean)
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function create_hypertable(regclass, _timescaledb_internal.dimension_info, boolean, boolean, boolean) owner to postgres;

create function set_adaptive_chunking(hypertable regclass, chunk_target_size text, inout chunk_sizing_func regproc default '_timescaledb_functions.calculate_chunk_interval'::regproc, out chunk_target_size bigint) returns record
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function set_adaptive_chunking(regclass, text, inout regproc, out bigint) owner to postgres;

create function set_chunk_time_interval(hypertable regclass, chunk_time_interval anyelement, dimension_name name default NULL::name) returns void
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function set_chunk_time_interval(regclass, anyelement, name) owner to postgres;

create function set_partitioning_interval(hypertable regclass, partition_interval anyelement, dimension_name name default NULL::name) returns void
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function set_partitioning_interval(regclass, anyelement, name) owner to postgres;

create function set_number_partitions(hypertable regclass, number_partitions integer, dimension_name name default NULL::name) returns void
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function set_number_partitions(regclass, integer, name) owner to postgres;

create function drop_chunks(relation regclass, older_than "any" default NULL::unknown, newer_than "any" default NULL::unknown, "verbose" boolean default false, created_before "any" default NULL::unknown, created_after "any" default NULL::unknown) returns setof setof text
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function drop_chunks(regclass, "any", "any", boolean, "any", "any") owner to postgres;

create function show_chunks(relation regclass, older_than "any" default NULL::unknown, newer_than "any" default NULL::unknown, created_before "any" default NULL::unknown, created_after "any" default NULL::unknown) returns setof setof regclass
    stable
    parallel safe
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function show_chunks(regclass, "any", "any", "any", "any") owner to postgres;

create function add_dimension(hypertable regclass, column_name name, number_partitions integer default NULL::integer, chunk_time_interval anyelement default NULL::bigint, partitioning_func regproc default NULL::regproc, if_not_exists boolean default false) returns setof table("dimension_id" integer, "schema_name" name, "table_name" name, "column_name" name, "created" boolean)
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function add_dimension(regclass, name, integer, anyelement, regproc, boolean) owner to postgres;

create function add_dimension(hypertable regclass, dimension _timescaledb_internal.dimension_info, if_not_exists boolean default false) returns setof table("dimension_id" integer, "created" boolean)
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function add_dimension(regclass, _timescaledb_internal.dimension_info, boolean) owner to postgres;

create function enable_chunk_skipping(hypertable regclass, column_name name, if_not_exists boolean default false) returns setof table("column_stats_id" integer, "enabled" boolean)
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function enable_chunk_skipping(regclass, name, boolean) owner to postgres;

create function disable_chunk_skipping(hypertable regclass, column_name name, if_not_exists boolean default false) returns setof table("hypertable_id" integer, "column_name" name, "disabled" boolean)
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function disable_chunk_skipping(regclass, name, boolean) owner to postgres;

create function by_hash(column_name name, number_partitions integer, partition_func regproc default NULL::regproc) returns _timescaledb_internal.dimension_info
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function by_hash(name, integer, regproc) owner to postgres;

create function by_range(column_name name, partition_interval anyelement default NULL::bigint, partition_func regproc default NULL::regproc) returns _timescaledb_internal.dimension_info
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function by_range(name, anyelement, regproc) owner to postgres;

create function attach_tablespace(tablespace name, hypertable regclass, if_not_attached boolean default false) returns void
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function attach_tablespace(name, regclass, boolean) owner to postgres;

create function detach_tablespace(tablespace name, hypertable regclass default NULL::regclass, if_attached boolean default false) returns integer
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function detach_tablespace(name, regclass, boolean) owner to postgres;

create function detach_tablespaces(hypertable regclass) returns integer
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function detach_tablespaces(regclass) owner to postgres;

create function show_tablespaces(hypertable regclass) returns setof setof name
    strict
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function show_tablespaces(regclass) owner to postgres;

create procedure refresh_continuous_aggregate(continuous_aggregate regclass, window_start "any", window_end "any", force boolean default false, options jsonb default NULL::jsonb)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure refresh_continuous_aggregate(regclass, "any", "any", boolean, jsonb) owner to postgres;

create function time_bucket(bucket_width interval, ts timestamp) returns timestamp
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, timestamp) owner to postgres;

create function time_bucket(bucket_width interval, ts timestamp with time zone) returns timestamp with time zone
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, timestamp with time zone) owner to postgres;

create function time_bucket(bucket_width interval, ts date) returns date
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, date) owner to postgres;

create function time_bucket(bucket_width interval, ts uuid) returns timestamp with time zone
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, uuid) owner to postgres;

create function time_bucket(bucket_width interval, ts timestamp, origin timestamp) returns timestamp
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, timestamp, timestamp) owner to postgres;

create function time_bucket(bucket_width interval, ts timestamp with time zone, origin timestamp with time zone) returns timestamp with time zone
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, timestamp with time zone, timestamp with time zone) owner to postgres;

create function time_bucket(bucket_width interval, ts date, origin date) returns date
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, date, date) owner to postgres;

create function time_bucket(bucket_width interval, ts uuid, origin timestamp with time zone) returns timestamp with time zone
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, uuid, timestamp with time zone) owner to postgres;

create function time_bucket(bucket_width interval, ts timestamp, "offset" interval) returns timestamp
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, timestamp, interval) owner to postgres;

create function time_bucket(bucket_width interval, ts timestamp with time zone, "offset" interval) returns timestamp with time zone
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, timestamp with time zone, interval) owner to postgres;

create function time_bucket(bucket_width interval, ts date, "offset" interval) returns date
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, date, interval) owner to postgres;

create function time_bucket(bucket_width interval, ts uuid, "offset" interval) returns timestamp with time zone
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, uuid, interval) owner to postgres;

create function time_bucket(bucket_width interval, ts timestamp with time zone, timezone text, origin timestamp with time zone default NULL::timestamp with time zone, "offset" interval default NULL::interval) returns timestamp with time zone
    immutable
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, timestamp with time zone, text, timestamp with time zone, interval) owner to postgres;

create function time_bucket(bucket_width interval, ts uuid, timezone text, origin timestamp with time zone default NULL::timestamp with time zone, "offset" interval default NULL::interval) returns timestamp with time zone
    immutable
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(interval, uuid, text, timestamp with time zone, interval) owner to postgres;

create function time_bucket(bucket_width smallint, ts smallint) returns smallint
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(smallint, smallint) owner to postgres;

create function time_bucket(bucket_width integer, ts integer) returns integer
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(integer, integer) owner to postgres;

create function time_bucket(bucket_width bigint, ts bigint) returns bigint
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(bigint, bigint) owner to postgres;

create function time_bucket(bucket_width smallint, ts smallint, "offset" smallint) returns smallint
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(smallint, smallint, smallint) owner to postgres;

create function time_bucket(bucket_width integer, ts integer, "offset" integer) returns integer
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(integer, integer, integer) owner to postgres;

create function time_bucket(bucket_width bigint, ts bigint, "offset" bigint) returns bigint
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket(bigint, bigint, bigint) owner to postgres;

create function hypertable_detailed_size(hypertable regclass)
    returns TABLE(table_bytes bigint, index_bytes bigint, toast_bytes bigint, total_bytes bigint, node_name name)
    strict
    SET search_path = pg_catalog, pg_temp
    language plpgsql
as
$$
DECLARE
        table_name       NAME = NULL;
        schema_name      NAME = NULL;
BEGIN
        SELECT relname, nspname
        INTO table_name, schema_name
        FROM pg_class c
        INNER JOIN pg_namespace n ON (n.OID = c.relnamespace)
        INNER JOIN _timescaledb_catalog.hypertable ht ON (ht.schema_name = n.nspname AND ht.table_name = c.relname)
        WHERE c.OID = hypertable;

        IF table_name IS NULL THEN
                SELECT h.schema_name, h.table_name
                INTO schema_name, table_name
                FROM pg_class c
                INNER JOIN pg_namespace n ON (n.OID = c.relnamespace)
                INNER JOIN _timescaledb_catalog.continuous_agg a ON (a.user_view_schema = n.nspname AND a.user_view_name = c.relname)
                INNER JOIN _timescaledb_catalog.hypertable h ON h.id = a.mat_hypertable_id
                WHERE c.OID = hypertable;

	        IF table_name IS NULL THEN
                        RETURN;
                END IF;
        END IF;

			RETURN QUERY
			SELECT *, NULL::name
			FROM _timescaledb_functions.hypertable_local_size(schema_name, table_name);
END;
$$;

alter function hypertable_detailed_size(regclass) owner to postgres;

create function hypertable_size(hypertable regclass) returns bigint
    strict
    SET search_path = pg_catalog, pg_temp
    language sql
as
$$
   SELECT total_bytes::bigint FROM public.hypertable_detailed_size(hypertable);
$$;

alter function hypertable_size(regclass) owner to postgres;

create function hypertable_approximate_detailed_size(relation regclass) returns setof table("table_bytes" bigint, "index_bytes" bigint, "toast_bytes" bigint, "total_bytes" bigint)
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function hypertable_approximate_detailed_size(regclass) owner to postgres;

create function hypertable_approximate_size(hypertable regclass) returns bigint
    strict
    SET search_path = pg_catalog, pg_temp
    language sql
as
$$
   SELECT sum(total_bytes)::bigint
   FROM public.hypertable_approximate_detailed_size(hypertable);
$$;

alter function hypertable_approximate_size(regclass) owner to postgres;

create function chunks_detailed_size(hypertable regclass)
    returns TABLE(chunk_schema name, chunk_name name, table_bytes bigint, index_bytes bigint, toast_bytes bigint, total_bytes bigint, node_name name)
    strict
    SET search_path = pg_catalog, pg_temp
    language plpgsql
as
$$
DECLARE
        table_name       NAME;
        schema_name      NAME;
BEGIN
        SELECT relname, nspname
        INTO table_name, schema_name
        FROM pg_class c
        INNER JOIN pg_namespace n ON (n.OID = c.relnamespace)
        INNER JOIN _timescaledb_catalog.hypertable ht ON (ht.schema_name = n.nspname AND ht.table_name = c.relname)
        WHERE c.OID = hypertable;

        IF table_name IS NULL THEN
            SELECT h.schema_name, h.table_name
            INTO schema_name, table_name
            FROM pg_class c
            INNER JOIN pg_namespace n ON (n.OID = c.relnamespace)
            INNER JOIN _timescaledb_catalog.continuous_agg a ON (a.user_view_schema = n.nspname AND a.user_view_name = c.relname)
            INNER JOIN _timescaledb_catalog.hypertable h ON h.id = a.mat_hypertable_id
            WHERE c.OID = hypertable;

            IF table_name IS NULL THEN
                RETURN;
            END IF;
		END IF;

    RETURN QUERY SELECT chl.chunk_schema, chl.chunk_name, chl.table_bytes, chl.index_bytes,
                        chl.toast_bytes, chl.total_bytes, NULL::NAME
            FROM _timescaledb_functions.chunks_local_size(schema_name, table_name) chl;
END;
$$;

alter function chunks_detailed_size(regclass) owner to postgres;

create function approximate_row_count(relation regclass) returns bigint
    strict
    SET search_path = pg_catalog, pg_temp
    language plpgsql
as
$$
DECLARE
    v_mat_ht REGCLASS = NULL;
    v_name NAME = NULL;
    v_schema NAME = NULL;
    v_hypertable_id INTEGER;
BEGIN
    -- Check if input relation is continuous aggregate view then
    -- get the corresponding materialized hypertable and schema name
    SELECT format('%I.%I', ht.schema_name, ht.table_name)::regclass INTO v_mat_ht
      FROM pg_class c
      JOIN pg_namespace n ON (n.OID = c.relnamespace)
      JOIN _timescaledb_catalog.continuous_agg a ON (a.user_view_schema = n.nspname AND a.user_view_name = c.relname)
      JOIN _timescaledb_catalog.hypertable ht ON (a.mat_hypertable_id = ht.id)
      WHERE c.OID = relation;

    IF FOUND THEN
        relation = v_mat_ht;
    END IF;

    SELECT nspname, relname FROM pg_class c
    INNER JOIN pg_namespace n ON (n.OID = c.relnamespace)
    INTO v_schema, v_name
    WHERE c.OID = relation;

    -- for hypertables return the sum of the row counts of all chunks
    SELECT id FROM _timescaledb_catalog.hypertable INTO v_hypertable_id WHERE table_name = v_name AND schema_name = v_schema;
    IF FOUND THEN
        RETURN (SELECT coalesce(sum(_timescaledb_functions.get_approx_row_count(format('%I.%I',schema_name,table_name))),0)
          FROM _timescaledb_catalog.chunk
          WHERE hypertable_id = v_hypertable_id);
    END IF;

		IF EXISTS (SELECT FROM pg_inherits WHERE inhparent = relation) THEN
		RETURN (
        SELECT _timescaledb_functions.get_approx_row_count(relation) + COALESCE(SUM(public.approximate_row_count(i.inhrelid)),0) FROM pg_inherits i
        WHERE i.inhparent = relation
     );
    END IF;

    -- Check for input relation is Plain RELATION
    RETURN _timescaledb_functions.get_approx_row_count(relation);
END;
$$;

alter function approximate_row_count(regclass) owner to postgres;

create function chunk_compression_stats(hypertable regclass)
    returns TABLE(chunk_schema name, chunk_name name, compression_status text, before_compression_table_bytes bigint, before_compression_index_bytes bigint, before_compression_toast_bytes bigint, before_compression_total_bytes bigint, after_compression_table_bytes bigint, after_compression_index_bytes bigint, after_compression_toast_bytes bigint, after_compression_total_bytes bigint, node_name name)
    stable
    strict
    SET search_path = pg_catalog, pg_temp
    language plpgsql
as
$$
DECLARE
    table_name name;
    schema_name name;
BEGIN
    SELECT
      relname, nspname
    INTO
	    table_name, schema_name
    FROM
        pg_class c
        INNER JOIN pg_namespace n ON (n.OID = c.relnamespace)
        INNER JOIN _timescaledb_catalog.hypertable ht ON (ht.schema_name = n.nspname
                AND ht.table_name = c.relname)
    WHERE
        c.OID = hypertable;

    IF table_name IS NULL THEN
	    RETURN;
	END IF;

  RETURN QUERY
  SELECT
      *,
      NULL::name
  FROM
      _timescaledb_functions.compressed_chunk_local_stats(schema_name, table_name);
END;
$$;

alter function chunk_compression_stats(regclass) owner to postgres;

create function chunk_columnstore_stats(hypertable regclass)
    returns TABLE(chunk_schema name, chunk_name name, compression_status text, before_compression_table_bytes bigint, before_compression_index_bytes bigint, before_compression_toast_bytes bigint, before_compression_total_bytes bigint, after_compression_table_bytes bigint, after_compression_index_bytes bigint, after_compression_toast_bytes bigint, after_compression_total_bytes bigint, node_name name)
    stable
    strict
    SET search_path = pg_catalog, pg_temp
    language sql
as
$$SELECT * FROM public.chunk_compression_stats($1)$$;

alter function chunk_columnstore_stats(regclass) owner to postgres;

create function hypertable_compression_stats(hypertable regclass)
    returns TABLE(total_chunks bigint, number_compressed_chunks bigint, before_compression_table_bytes bigint, before_compression_index_bytes bigint, before_compression_toast_bytes bigint, before_compression_total_bytes bigint, after_compression_table_bytes bigint, after_compression_index_bytes bigint, after_compression_toast_bytes bigint, after_compression_total_bytes bigint, node_name name)
    stable
    strict
    SET search_path = pg_catalog, pg_temp
    language sql
as
$$
	SELECT
        count(*)::bigint AS total_chunks,
        (count(*) FILTER (WHERE ch.compression_status = 'Compressed'))::bigint AS number_compressed_chunks,
        sum(ch.before_compression_table_bytes)::bigint AS before_compression_table_bytes,
        sum(ch.before_compression_index_bytes)::bigint AS before_compression_index_bytes,
        sum(ch.before_compression_toast_bytes)::bigint AS before_compression_toast_bytes,
        sum(ch.before_compression_total_bytes)::bigint AS before_compression_total_bytes,
        sum(ch.after_compression_table_bytes)::bigint AS after_compression_table_bytes,
        sum(ch.after_compression_index_bytes)::bigint AS after_compression_index_bytes,
        sum(ch.after_compression_toast_bytes)::bigint AS after_compression_toast_bytes,
        sum(ch.after_compression_total_bytes)::bigint AS after_compression_total_bytes,
        ch.node_name
    FROM
	    public.chunk_compression_stats(hypertable) ch
    GROUP BY
        ch.node_name;
$$;

alter function hypertable_compression_stats(regclass) owner to postgres;

create function hypertable_columnstore_stats(hypertable regclass)
    returns TABLE(total_chunks bigint, number_compressed_chunks bigint, before_compression_table_bytes bigint, before_compression_index_bytes bigint, before_compression_toast_bytes bigint, before_compression_total_bytes bigint, after_compression_table_bytes bigint, after_compression_index_bytes bigint, after_compression_toast_bytes bigint, after_compression_total_bytes bigint, node_name name)
    stable
    strict
    SET search_path = pg_catalog, pg_temp
    language sql
as
$$SELECT * FROM public.hypertable_compression_stats($1)$$;

alter function hypertable_columnstore_stats(regclass) owner to postgres;

create function hypertable_index_size(index_name regclass) returns bigint
    strict
    SET search_path = pg_catalog, pg_temp
    language sql
as
$$
  SELECT
  	pg_relation_size(ht_i.indexrelid) + COALESCE(sum(pg_relation_size(ch_i.indexrelid)), 0)
  FROM pg_index ht_i
  LEFT JOIN pg_inherits ch on ch.inhparent = ht_i.indrelid
  LEFT JOIN pg_index ch_i on ch_i.indrelid = ch.inhrelid and _timescaledb_functions.index_matches(ht_i.indexrelid, ch_i.indexrelid)
  WHERE ht_i.indexrelid = index_name
  GROUP BY ht_i.indexrelid;
$$;

alter function hypertable_index_size(regclass) owner to postgres;

create function generate_uuidv7() returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function generate_uuidv7() owner to postgres;

create function to_uuidv7(ts timestamp with time zone) returns uuid
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function to_uuidv7(timestamp with time zone) owner to postgres;

create function to_uuidv7_boundary(ts timestamp with time zone) returns uuid
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function to_uuidv7_boundary(timestamp with time zone) owner to postgres;

create function uuid_timestamp(uuid uuid) returns timestamp with time zone
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_timestamp(uuid) owner to postgres;

create function uuid_timestamp_micros(uuid uuid) returns timestamp with time zone
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_timestamp_micros(uuid) owner to postgres;

create function uuid_version(uuid uuid) returns integer
    immutable
    strict
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function uuid_version(uuid) owner to postgres;

create function time_bucket_gapfill(bucket_width smallint, ts smallint, start smallint default NULL::smallint, finish smallint default NULL::smallint) returns smallint
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket_gapfill(smallint, smallint, smallint, smallint) owner to postgres;

create function time_bucket_gapfill(bucket_width integer, ts integer, start integer default NULL::integer, finish integer default NULL::integer) returns integer
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket_gapfill(integer, integer, integer, integer) owner to postgres;

create function time_bucket_gapfill(bucket_width bigint, ts bigint, start bigint default NULL::bigint, finish bigint default NULL::bigint) returns bigint
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket_gapfill(bigint, bigint, bigint, bigint) owner to postgres;

create function time_bucket_gapfill(bucket_width interval, ts date, start date default NULL::date, finish date default NULL::date) returns date
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket_gapfill(interval, date, date, date) owner to postgres;

create function time_bucket_gapfill(bucket_width interval, ts timestamp, start timestamp default NULL::timestamp without time zone, finish timestamp default NULL::timestamp without time zone) returns timestamp
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket_gapfill(interval, timestamp, timestamp, timestamp) owner to postgres;

create function time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, start timestamp with time zone default NULL::timestamp with time zone, finish timestamp with time zone default NULL::timestamp with time zone) returns timestamp with time zone
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket_gapfill(interval, timestamp with time zone, timestamp with time zone, timestamp with time zone) owner to postgres;

create function time_bucket_gapfill(bucket_width interval, ts timestamp with time zone, timezone text, start timestamp with time zone default NULL::timestamp with time zone, finish timestamp with time zone default NULL::timestamp with time zone) returns timestamp with time zone
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function time_bucket_gapfill(interval, timestamp with time zone, text, timestamp with time zone, timestamp with time zone) owner to postgres;

create function locf(value anyelement, prev anyelement default NULL::unknown, treat_null_as_missing boolean default false) returns anyelement
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function locf(anyelement, anyelement, boolean) owner to postgres;

create function interpolate(value smallint, prev record default NULL::record, next record default NULL::record) returns smallint
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function interpolate(smallint, record, record) owner to postgres;

create function interpolate(value integer, prev record default NULL::record, next record default NULL::record) returns integer
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function interpolate(integer, record, record) owner to postgres;

create function interpolate(value bigint, prev record default NULL::record, next record default NULL::record) returns bigint
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function interpolate(bigint, record, record) owner to postgres;

create function interpolate(value real, prev record default NULL::record, next record default NULL::record) returns real
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function interpolate(real, record, record) owner to postgres;

create function interpolate(value double precision, prev record default NULL::record, next record default NULL::record) returns double precision
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function interpolate(double precision, record, record) owner to postgres;

create function reorder_chunk(chunk regclass, index regclass default NULL::regclass, "verbose" boolean default false) returns void
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function reorder_chunk(regclass, regclass, boolean) owner to postgres;

create function move_chunk(chunk regclass, destination_tablespace name, index_destination_tablespace name default NULL::name, reorder_index regclass default NULL::regclass, "verbose" boolean default false) returns void
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function move_chunk(regclass, name, name, regclass, boolean) owner to postgres;

create function compress_chunk(uncompressed_chunk regclass, if_not_compressed boolean default true, recompress boolean default false) returns regclass
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function compress_chunk(regclass, boolean, boolean) owner to postgres;

create procedure convert_to_columnstore(chunk regclass, if_not_columnstore boolean default true, recompress boolean default false)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure convert_to_columnstore(regclass, boolean, boolean) owner to postgres;

create function decompress_chunk(uncompressed_chunk regclass, if_compressed boolean default true) returns regclass
    strict
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function decompress_chunk(regclass, boolean) owner to postgres;

create procedure convert_to_rowstore(chunk regclass, if_columnstore boolean default true)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure convert_to_rowstore(regclass, boolean) owner to postgres;

create procedure merge_chunks(chunk1 regclass, chunk2 regclass, concurrently boolean default false)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure merge_chunks(regclass, regclass, boolean) owner to postgres;

create procedure merge_chunks(chunks regclass[])
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure merge_chunks(regclass[]) owner to postgres;

create procedure merge_chunks_concurrently(chunks regclass[])
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure merge_chunks_concurrently(regclass[]) owner to postgres;

create procedure split_chunk(chunk regclass, split_at "any" default NULL::unknown)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure split_chunk(regclass, "any") owner to postgres;

create procedure recompress_chunk(IN chunk regclass, IN if_not_compressed boolean DEFAULT true)
    SET search_path = pg_catalog, pg_temp
    language plpgsql
as
$$
BEGIN
  IF current_setting('timescaledb.enable_deprecation_warnings', true)::bool THEN
    RAISE WARNING 'procedure public.recompress_chunk(regclass,boolean) is deprecated and the functionality is now included in public.compress_chunk. this compatibility function will be removed in a future version.';
  END IF;
  PERFORM public.compress_chunk(chunk, if_not_compressed);
END$$;

alter procedure recompress_chunk(regclass, boolean) owner to postgres;

create function timescaledb_pre_restore() returns boolean
    SET search_path = pg_catalog, pg_temp
    language plpgsql
as
$fun$
DECLARE
    db text;
BEGIN
    SELECT current_database() INTO db;
    EXECUTE format($$ALTER DATABASE %I SET timescaledb.restoring ='on'$$, db);
    SET SESSION timescaledb.restoring = 'on';
    PERFORM _timescaledb_functions.stop_background_workers();
    RETURN true;
END
$fun$;

alter function timescaledb_pre_restore() owner to postgres;

create function timescaledb_post_restore() returns boolean
    SET search_path = pg_catalog, pg_temp
    language plpgsql
as
$fun$
DECLARE
    db text;
    catalog_version text;
BEGIN
    SELECT m.value INTO catalog_version FROM pg_extension x
    JOIN _timescaledb_catalog.metadata m ON m.key='timescaledb_version'
    WHERE x.extname='timescaledb' AND x.extversion <> m.value;

    -- check that a loaded dump is compatible with the currently running code
    IF FOUND THEN
        RAISE EXCEPTION 'catalog version mismatch, expected "%" seen "%"', '2.26.1', catalog_version;
    END IF;

    SELECT current_database() INTO db;
    EXECUTE format($$ALTER DATABASE %I RESET timescaledb.restoring $$, db);
    -- we cannot use reset here because the reset_val might not be off
    SET timescaledb.restoring TO off;
    PERFORM _timescaledb_functions.restart_background_workers();

    RETURN true;
END
$fun$;

alter function timescaledb_post_restore() owner to postgres;

create function add_job(proc regproc, schedule_interval interval, config jsonb default NULL::jsonb, initial_start timestamp with time zone default NULL::timestamp with time zone, scheduled boolean default true, check_config regproc default NULL::regproc, fixed_schedule boolean default true, timezone text default NULL::text, job_name text default NULL::text) returns integer
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function add_job(regproc, interval, jsonb, timestamp with time zone, boolean, regproc, boolean, text, text) owner to postgres;

create function delete_job(job_id integer) returns void
    strict
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function delete_job(integer) owner to postgres;

create procedure run_job(job_id integer)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure run_job(integer) owner to postgres;

create function alter_job(job_id integer, schedule_interval interval default NULL::interval, max_runtime interval default NULL::interval, max_retries integer default NULL::integer, retry_period interval default NULL::interval, scheduled boolean default NULL::boolean, config jsonb default NULL::jsonb, next_start timestamp with time zone default NULL::timestamp with time zone, if_exists boolean default false, check_config regproc default NULL::regproc, fixed_schedule boolean default NULL::boolean, initial_start timestamp with time zone default NULL::timestamp with time zone, timezone text default NULL::text, job_name text default NULL::text) returns setof table("job_id" integer, "schedule_interval" interval, "max_runtime" interval, "max_retries" integer, "retry_period" interval, "scheduled" boolean, "config" jsonb, "next_start" timestamp with time zone, "check_config" text, "fixed_schedule" boolean, "initial_start" timestamp with time zone, "timezone" text, "application_name" name)
    language c
as
$$
begin
-- missing source code
end;

$$;

alter function alter_job(integer, interval, interval, integer, interval, boolean, jsonb, timestamp with time zone, boolean, regproc, boolean, timestamp with time zone, text, text) owner to postgres;

create function add_retention_policy(relation regclass, drop_after "any" default NULL::unknown, if_not_exists boolean default false, schedule_interval interval default NULL::interval, initial_start timestamp with time zone default NULL::timestamp with time zone, timezone text default NULL::text, drop_created_before interval default NULL::interval) returns integer
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function add_retention_policy(regclass, "any", boolean, interval, timestamp with time zone, text, interval) owner to postgres;

create function remove_retention_policy(relation regclass, if_exists boolean default false) returns void
    strict
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function remove_retention_policy(regclass, boolean) owner to postgres;

create function add_reorder_policy(hypertable regclass, index_name name, if_not_exists boolean default false, initial_start timestamp with time zone default NULL::timestamp with time zone, timezone text default NULL::text) returns integer
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function add_reorder_policy(regclass, name, boolean, timestamp with time zone, text) owner to postgres;

create function remove_reorder_policy(hypertable regclass, if_exists boolean default false) returns void
    strict
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function remove_reorder_policy(regclass, boolean) owner to postgres;

create function add_compression_policy(hypertable regclass, compress_after "any" default NULL::unknown, if_not_exists boolean default false, schedule_interval interval default NULL::interval, initial_start timestamp with time zone default NULL::timestamp with time zone, timezone text default NULL::text, compress_created_before interval default NULL::interval) returns integer
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function add_compression_policy(regclass, "any", boolean, interval, timestamp with time zone, text, interval) owner to postgres;

create procedure add_columnstore_policy(hypertable regclass, after "any" default NULL::unknown, if_not_exists boolean default false, schedule_interval interval default NULL::interval, initial_start timestamp with time zone default NULL::timestamp with time zone, timezone text default NULL::text, created_before interval default NULL::interval)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure add_columnstore_policy(regclass, "any", boolean, interval, timestamp with time zone, text, interval) owner to postgres;

create function remove_compression_policy(hypertable regclass, if_exists boolean default false) returns boolean
    strict
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function remove_compression_policy(regclass, boolean) owner to postgres;

create procedure remove_columnstore_policy(hypertable regclass, if_exists boolean default false)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure remove_columnstore_policy(regclass, boolean) owner to postgres;

create function add_continuous_aggregate_policy(continuous_aggregate regclass, start_offset "any", end_offset "any", schedule_interval interval, if_not_exists boolean default false, initial_start timestamp with time zone default NULL::timestamp with time zone, timezone text default NULL::text, include_tiered_data boolean default NULL::boolean, buckets_per_batch integer default NULL::integer, max_batches_per_execution integer default NULL::integer, refresh_newest_first boolean default NULL::boolean) returns integer
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function add_continuous_aggregate_policy(regclass, "any", "any", interval, boolean, timestamp with time zone, text, boolean, integer, integer, boolean) owner to postgres;

create function remove_continuous_aggregate_policy(continuous_aggregate regclass, if_not_exists boolean default false, if_exists boolean default NULL::boolean) returns void
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function remove_continuous_aggregate_policy(regclass, boolean, boolean) owner to postgres;

create procedure add_process_hypertable_invalidations_policy(hypertable regclass, schedule_interval interval, if_not_exists boolean default false, initial_start timestamp with time zone default NULL::timestamp with time zone, timezone text default NULL::text)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure add_process_hypertable_invalidations_policy(regclass, interval, boolean, timestamp with time zone, text) owner to postgres;

create procedure remove_process_hypertable_invalidations_policy(hypertable regclass, if_exists boolean default false)
    language c
as
$$
begin
-- missing source code
end;
$$;

alter procedure remove_process_hypertable_invalidations_policy(regclass, boolean) owner to postgres;

create function get_telemetry_report() returns jsonb
    stable
    parallel safe
    language c
as
$$
begin
-- missing source code
end;
$$;

alter function get_telemetry_report() owner to postgres;

create procedure actualizarproductividadmedidasproducto(IN p_codigo character varying, IN fechatope timestamp without time zone)
    language plpgsql
as
$$
BEGIN
    UPDATE medidahist m
    SET prodestandar = cp.prodestandar
    FROM centro c
    INNER JOIN producto p ON p.id = m.producto_fk
    INNER JOIN centroproducto cp ON cp.centro_fk = c.id AND cp.producto_fk = p.id
    WHERE m.centro_fk = c.id
      AND p.codigo LIKE p_codigo
      AND m.finicio >= fechaTope;
END;
$$;

alter procedure actualizarproductividadmedidasproducto(varchar, timestamp) owner to postgres;

create function calculareficiencia(pfechainicio timestamp without time zone, pfechafin timestamp without time zone, pidcentro bigint)
    returns TABLE(t_produccion numeric, t_velocidad_reducida numeric, t_fallo numeric, t_total numeric, t_efectivo double precision, t_paros_rutinarios numeric, contador_tiempo_exceso_total numeric, velocidad_maxima double precision, velocidad_instantanea double precision, velocidad_objetivo_tiempo_total numeric, velocidad_limite_tiempo_total numeric, velocidad_objetivo numeric, cantidad_velocidad_real double precision, ratio_velocidad_objetivo_tt double precision, calidad_objetivo_tiempo_total numeric, dp_objetivo_tiempo_total double precision, do_objetivo_tiempo_total double precision, ep_objetivo_tiempo_total double precision, eo_objetivo_tiempo_total double precision, cantidad_total_producida double precision, cantidad_total_conforme double precision, cantidad_total_desechada double precision, contador_notificaciones integer)
    language plpgsql
as
$$
DECLARE
    -- VARIABLES CURSOR
    v_tipomedida                        varchar(255);
    v_valormedida                       double precision;
    v_duracion                          bigint;
    v_justificada                       boolean;
    v_ratioconteoprincipal              double precision;
    v_ratioprincipaleficiencia          double precision;
    v_unidadcantidaddesechada           bigint;
    v_ratioprincipaldesechada           double precision;
    v_velocidadteorica                  double precision;
    v_velocidadlimite                   double precision;
    v_velocidadobjetivo                 double precision;
    v_calidadobjetivo                   bigint;
    v_disponibilidad                    double precision;
    v_doobjetivo                        double precision;
    v_vbleestadosesproductiva           boolean;
    v_frecestadoopcmin                  int;
    v_tipotiempoeficiencia              varchar(255);
    v_estadotipo                        bigint;
    v_estado                            bigint;
    v_fechainicio                       timestamp;
    v_fechafin                          timestamp;
    v_tiempomaximo                      bigint;

    -- CONTADORES
    v_velocidad_maxima                  double precision := 0;
    v_velocidad_instantanea             double precision := 0;
    v_cantidad_velocidad_real           double precision := 0;
    v_tiempo_produccion_instantaneo     bigint := 0;

    -- CANTIDADES
    v_cantidad_total_conforme           double precision := 0;
    v_cantidad_total_desechada          double precision := 0;
    v_cantidad_total_producida          double precision := 0;

    -- CONTADORES TIEMPO ESTADOS
    v_t_produccion                      bigint := 0;
    v_t_velocidad_reducida              bigint := 0;
    v_t_fallo                           bigint := 0;

    -- CONTADORES TIEMPO
    v_t_total                           bigint := 0;
    v_t_operacional                     bigint := 0;
    v_t_paro                            bigint := 0;
    v_t_efectivo_neto                   double precision := 0;
    v_t_perdida_velocidad               bigint := 0;
    v_t_efectivo                        double precision := 0;
    v_t_perdida_calidad                 double precision := 0;

    -- TIEMPO EXCESO Y PAROS RUTINARIOS
    v_fecha_fin_anterior                timestamp;
    v_estado_anterior                   bigint := 0;
    v_contador_duracion_grupo_medidas   bigint := 0;
    v_contador_tiempo_exceso_total      bigint := 0;
    v_t_paros_rutinarios                bigint := 0;

    -- OBJETIVOS
    v_velocidad_objetivo_tiempo_total   bigint := 0;
    v_velocidad_limite_tiempo_total     bigint := 0;
    v_ratio_velocidad_objetivo_tt       double precision := 0;
    v_calidad_objetivo_tiempo_total     bigint := 0;
    v_dp_objetivo_tiempo_total          double precision := 0;
    v_do_objetivo_tiempo_total          double precision := 0;
    v_ep_objetivo_tiempo_total          double precision := 0;
    v_eo_objetivo_tiempo_total          double precision := 0;

    -- NOTIFICACIONES
    v_contador_notificaciones           int := 0;

    -- CURSOR
    mycur CURSOR FOR
        SELECT m.tipomedida,
               m.valormedida,
               m.duracion,
               m.justificada,
               cp.ratioconteoprincipal,
               cp.ratioprincipaleficiencia,
               c.unidadcantidaddesechada_fk,
               cp.ratioprincipaldesechada,
               cp.vteoria   AS velocidadteorica,
               cp.vlimite   AS velocidadlimite,
               cp.vobjetivo AS velocidadobjetivo,
               cp.calidadobjetivo,
               cp.disponibilidad,
               cp.doobjetivo,
               c.vbleestadosesproductiva,
               c.frecestadoopcmin,
               c.tipotiempoeficiencia,
               t.estadotipo,
               t.estado,
               m.finicio,
               m.ffin,
               t.tmaximo
        FROM medida m
                 INNER JOIN centroproducto cp ON m.centroproducto_fk = cp.id
                 INNER JOIN centro c ON cp.centro_fk = c.id
                 LEFT OUTER JOIN (SELECT ce.id AS ceid,
                                         et.id AS estadotipo,
                                         e.id  AS estado,
                                         ce.tmaximo
                                  FROM centroestado ce
                                           JOIN estado e ON ce.estado_fk = e.id
                                           JOIN estadotipo et ON e.tipo_fk = et.id) t ON m.centroestado_fk = t.ceid
        WHERE c.id = pidcentro
          AND m.ffin >= pfechainicio
          AND m.ffin < pfechafin
        ORDER BY ffin ASC;

BEGIN
    OPEN mycur;

    <<my_loop>>
    LOOP
        FETCH mycur INTO
            v_tipomedida,
            v_valormedida,
            v_duracion,
            v_justificada,
            v_ratioconteoprincipal,
            v_ratioprincipaleficiencia,
            v_unidadcantidaddesechada,
            v_ratioprincipaldesechada,
            v_velocidadteorica,
            v_velocidadlimite,
            v_velocidadobjetivo,
            v_calidadobjetivo,
            v_disponibilidad,
            v_doobjetivo,
            v_vbleestadosesproductiva,
            v_frecestadoopcmin,
            v_tipotiempoeficiencia,
            v_estadotipo,
            v_estado,
            v_fechainicio,
            v_fechafin,
            v_tiempomaximo;

        EXIT my_loop WHEN NOT FOUND;

        IF v_tipomedida = 'produccion' THEN

            v_cantidad_total_producida := v_cantidad_total_producida + v_valormedida;
            v_cantidad_total_conforme  := v_cantidad_total_conforme + v_valormedida;

            IF v_valormedida IS NOT NULL AND v_velocidadteorica IS NOT NULL THEN
                IF v_vbleestadosesproductiva AND v_ratioprincipaleficiencia IS NOT NULL AND v_ratioprincipaleficiencia > 0 THEN
                    v_t_efectivo_neto := v_t_efectivo_neto + (v_valormedida / v_velocidadteorica) * v_ratioprincipaleficiencia;
                ELSE
                    v_t_efectivo_neto := v_t_efectivo_neto + (v_valormedida / v_velocidadteorica);
                END IF;

                IF v_vbleestadosesproductiva THEN
                    IF v_duracion > 0 THEN
                        v_velocidad_instantanea := v_valormedida / v_duracion;
                        IF v_velocidad_instantanea > v_velocidad_maxima THEN
                            v_velocidad_maxima := v_velocidad_instantanea;
                        END IF;
                    END IF;
                END IF;
            END IF;

        ELSIF v_tipomedida = 'cantidadDesechada' THEN

            v_cantidad_total_desechada := v_cantidad_total_desechada + v_valormedida;

            IF v_valormedida IS NOT NULL AND v_velocidadteorica IS NOT NULL THEN
                IF v_vbleestadosesproductiva AND v_ratioprincipaleficiencia IS NOT NULL AND v_ratioprincipaleficiencia > 0 THEN
                    v_t_perdida_calidad := v_t_perdida_calidad + (v_valormedida / v_velocidadteorica) * v_ratioprincipaleficiencia;
                ELSE
                    v_t_perdida_calidad := v_t_perdida_calidad + (v_valormedida / v_velocidadteorica);
                END IF;
            END IF;

        ELSIF v_tipomedida = 'estados' THEN

            IF v_duracion > 0 THEN

                IF v_estadotipo = 4 AND NOT v_justificada THEN
                    v_contador_notificaciones := v_contador_notificaciones + 1;
                END IF;

                IF v_disponibilidad IS NOT NULL THEN
                    v_dp_objetivo_tiempo_total := v_dp_objetivo_tiempo_total + v_duracion * v_disponibilidad;
                END IF;

                IF v_doobjetivo IS NOT NULL THEN
                    v_do_objetivo_tiempo_total := v_do_objetivo_tiempo_total + v_doobjetivo * v_duracion;
                END IF;

                IF v_disponibilidad IS NOT NULL AND v_velocidadobjetivo IS NOT NULL AND
                   v_velocidadteorica IS NOT NULL AND v_velocidadteorica > 0 THEN
                    v_ep_objetivo_tiempo_total := v_ep_objetivo_tiempo_total +
                                                 (v_disponibilidad * 0.01 * (v_velocidadobjetivo / v_velocidadteorica) * v_duracion) *
                                                 v_calidadobjetivo * 0.01;
                END IF;

                IF v_velocidadteorica IS NOT NULL AND v_doobjetivo IS NOT NULL AND v_velocidadobjetivo IS NOT NULL THEN
                    v_eo_objetivo_tiempo_total := v_eo_objetivo_tiempo_total +
                                                 ((v_doobjetivo * 0.01) * v_velocidadobjetivo) /
                                                 (v_velocidadteorica * v_duracion) * v_calidadobjetivo * 0.01;
                END IF;

                IF v_velocidadlimite IS NOT NULL THEN
                    v_velocidad_limite_tiempo_total := v_velocidad_limite_tiempo_total + (v_velocidadlimite * v_duracion)::bigint;
                END IF;

                IF v_velocidadobjetivo IS NOT NULL AND v_velocidadteorica IS NOT NULL THEN
                    v_ratio_velocidad_objetivo_tt := v_ratio_velocidad_objetivo_tt +
                                                    (v_velocidadobjetivo / v_velocidadteorica) * v_duracion;
                END IF;

                IF v_calidadobjetivo IS NOT NULL THEN
                    v_calidad_objetivo_tiempo_total := v_calidad_objetivo_tiempo_total + v_calidadobjetivo * v_duracion;
                END IF;

                IF v_estadotipo = 3 THEN
                    IF v_fechainicio <> v_fecha_fin_anterior OR v_estado <> v_estado_anterior THEN
                        v_contador_duracion_grupo_medidas := 0;
                    END IF;

                    IF v_contador_duracion_grupo_medidas + v_duracion <= v_tiempomaximo THEN
                        v_contador_duracion_grupo_medidas := v_contador_duracion_grupo_medidas + v_duracion;
                        v_t_paros_rutinarios := v_t_paros_rutinarios + v_duracion;
                    ELSE
                        IF v_tiempomaximo > 0 THEN
                            v_contador_tiempo_exceso_total := v_contador_tiempo_exceso_total + v_duracion;
                        END IF;
                    END IF;

                    v_fecha_fin_anterior := v_fechafin;
                    v_estado_anterior    := v_estado;
                END IF;

                v_t_total := v_t_total + v_duracion;

                IF v_estadotipo = 4 AND v_duracion > 0 THEN
                    v_t_fallo := v_t_fallo + v_duracion;
                END IF;

                IF v_estadotipo = 2 AND v_duracion > 0 THEN

                    IF v_velocidadobjetivo IS NOT NULL THEN
                        v_velocidad_objetivo_tiempo_total := v_velocidad_objetivo_tiempo_total + (v_velocidadobjetivo * v_duracion)::bigint;
                    END IF;

                    IF v_estado = 3 AND v_duracion > 0 THEN
                        v_t_velocidad_reducida := v_t_velocidad_reducida + v_duracion;
                    ELSIF v_estado = 2 AND v_duracion > 0 THEN
                        v_t_produccion := v_t_produccion + v_duracion;
                    END IF;

                    IF v_vbleestadosesproductiva THEN
                        IF v_duracion > 0 THEN
                            v_velocidad_instantanea := v_valormedida / v_duracion;
                            IF v_velocidad_instantanea > v_velocidad_maxima THEN
                                v_velocidad_maxima := v_velocidad_instantanea;
                            END IF;
                        END IF;
                    ELSE
                        v_tiempo_produccion_instantaneo := v_tiempo_produccion_instantaneo + v_duracion;
                        IF v_tiempo_produccion_instantaneo > v_frecestadoopcmin THEN
                            v_velocidad_instantanea := v_cantidad_total_producida / v_tiempo_produccion_instantaneo;
                            IF v_velocidad_instantanea > v_velocidad_maxima THEN
                                v_velocidad_maxima := v_velocidad_instantanea;
                            END IF;
                        END IF;
                    END IF;

                END IF;

            END IF;

        END IF;

    END LOOP my_loop;

    CLOSE mycur;

    -- CALCULOS FINALES
    v_cantidad_velocidad_real  := v_cantidad_total_producida;
    v_cantidad_total_conforme  := v_cantidad_total_producida - v_cantidad_total_desechada;
    v_t_perdida_velocidad      := v_t_velocidad_reducida - v_t_paros_rutinarios;
    v_t_operacional            := (v_t_efectivo_neto + v_t_velocidad_reducida + v_t_paros_rutinarios)::bigint;
    v_t_efectivo               := v_t_efectivo_neto - v_t_perdida_calidad;

    IF v_vbleestadosesproductiva THEN
        v_cantidad_velocidad_real := v_cantidad_velocidad_real * v_ratioprincipaleficiencia;
    END IF;

    IF v_tipotiempoeficiencia = 'horas' THEN
        v_t_efectivo_neto       := v_t_efectivo_neto * 60;
        v_t_efectivo            := v_t_efectivo * 60;
        v_velocidad_instantanea := v_velocidad_instantanea * 60;
        v_velocidad_maxima      := v_velocidad_maxima * 60;
    END IF;

    -- RETURN
RETURN QUERY SELECT
    COALESCE(v_t_produccion, 0)::numeric,
    COALESCE(v_t_velocidad_reducida, 0)::numeric,
    COALESCE(v_t_fallo, 0)::numeric,
    COALESCE(v_t_total, 0)::numeric,
    COALESCE(v_t_efectivo, 0)::double precision,
    COALESCE(v_t_paros_rutinarios, 0)::numeric,
    COALESCE(v_contador_tiempo_exceso_total, 0)::numeric,
    COALESCE(v_velocidad_maxima, 0)::double precision,
    COALESCE(v_velocidad_instantanea, 0)::double precision,
    COALESCE(v_velocidad_objetivo_tiempo_total, 0)::numeric,
    COALESCE(v_velocidad_limite_tiempo_total, 0)::numeric,
    COALESCE(v_velocidadobjetivo, 0)::numeric,
    COALESCE(v_cantidad_velocidad_real, 0)::double precision,
    COALESCE(v_ratio_velocidad_objetivo_tt, 0)::double precision,
    COALESCE(v_calidad_objetivo_tiempo_total, 0)::numeric,
    COALESCE(v_dp_objetivo_tiempo_total, 0)::double precision,
    COALESCE(v_do_objetivo_tiempo_total, 0)::double precision,
    COALESCE(v_ep_objetivo_tiempo_total, 0)::double precision,
    COALESCE(v_eo_objetivo_tiempo_total, 0)::double precision,
    COALESCE(v_cantidad_total_producida, 0)::double precision,
    COALESCE(v_cantidad_total_conforme, 0)::double precision,
    COALESCE(v_cantidad_total_desechada, 0)::double precision,
    COALESCE(v_contador_notificaciones, 0)::integer;

END;
$$;

alter function calculareficiencia(timestamp, timestamp, bigint) owner to postgres;

create function calcularfecha(pturno bigint, pfecha timestamp without time zone, pfrecmuestreo bigint) returns timestamp without time zone
    stable
    language plpgsql
as
$$
DECLARE
    FECHA TIMESTAMP;
    HORAINICIO_TURNO TIME;
BEGIN
    FECHA := pFecha;

    SELECT t.horaInicio
    INTO HORAINICIO_TURNO
    FROM turno t
    WHERE t.id = pTurno
    LIMIT 1;

    IF FOUND THEN
        IF TO_CHAR(HORAINICIO_TURNO, 'HH24:MI') = TO_CHAR(FECHA, 'HH24:MI') THEN
            FECHA := FECHA + (pFrecMuestreo || ' minutes')::INTERVAL;
        END IF;
    END IF;

    RETURN FECHA;
END;
$$;

alter function calcularfecha(bigint, timestamp, bigint) owner to postgres;

create function calcularfechafinregla(pfecha timestamp without time zone) returns timestamp without time zone
    stable
    language plpgsql
as
$$
DECLARE
    fechaFin TIMESTAMP;
BEGIN
    fechaFin := pFecha;

    SELECT
        CASE
            WHEN reglas.asignaranterior THEN reglas.horaposterior
            WHEN reglas.asignarposterior THEN reglas.horaanterior
            ELSE pFecha
        END
    INTO fechaFin
    FROM (
        SELECT
            hora,
            (DATE_TRUNC('day', pFecha) + hora - (offsetpreviomin || ' minutes')::INTERVAL) AS horaanterior,
            (DATE_TRUNC('day', pFecha) + hora + (offsetposteriormin || ' minutes')::INTERVAL) AS horaposterior,
            offsetpreviomin,
            offsetposteriormin,
            NOT e.tiempoproductivo
                AND
            TO_CHAR(pFecha, 'HH24:MI:SS')::TIME
                BETWEEN
                (hora::TIME - (offsetpreviomin || ' minutes')::INTERVAL)
                AND
                (hora::TIME + (offsetposteriormin || ' minutes')::INTERVAL) AS check_date,
            asignaranterior,
            asignarposterior
        FROM presenciareglaproduccion
        INNER JOIN estadooperario e ON estadooperario_fk = e.id
    ) AS reglas
    WHERE reglas.check_date = TRUE
    LIMIT 1;

    RETURN fechaFin;
END;
$$;

alter function calcularfechafinregla(timestamp) owner to postgres;

create function calcularfechainicioregla(pfecha timestamp without time zone) returns timestamp without time zone
    stable
    language plpgsql
as
$$
DECLARE
    fechaInicio TIMESTAMP;
BEGIN
    fechaInicio := pFecha;

    SELECT
        CASE
            WHEN reglas.asignarposterior THEN reglas.horaprevia
            WHEN reglas.asignaranterior THEN reglas.horaposterior
            ELSE pFecha
        END
    INTO fechaInicio
    FROM (
        SELECT
            hora,
            (DATE_TRUNC('day', pFecha) + hora - (offsetpreviomin || ' minutes')::INTERVAL) AS horaprevia,
            (DATE_TRUNC('day', pFecha) + hora + (offsetposteriormin || ' minutes')::INTERVAL) AS horaposterior,
            offsetpreviomin,
            offsetposteriormin,
            NOT e.tiempoproductivo
                AND
            TO_CHAR(pFecha, 'HH24:MI:SS')::TIME
                BETWEEN
                (hora::TIME - (offsetpreviomin || ' minutes')::INTERVAL)
                AND
                (hora::TIME + (offsetposteriormin || ' minutes')::INTERVAL) AS check_date,
            asignaranterior,
            asignarposterior
        FROM presenciareglaproduccion
        INNER JOIN estadooperario e ON estadooperario_fk = e.id
    ) AS reglas
    WHERE reglas.check_date = TRUE
    LIMIT 1;

    RETURN fechaInicio;
END;
$$;

alter function calcularfechainicioregla(timestamp) owner to postgres;

create function getgrupomedidahist(medidaid bigint) returns double precision
    language plpgsql
as
$$
DECLARE
    grupoMedida bigint;
BEGIN
    SELECT grupo INTO grupoMedida
    FROM (
        SELECT
            id,
            CASE
                WHEN estado_fk = LAG(estado_fk) OVER (ORDER BY ffin ASC)
                THEN FIRST_VALUE(id) OVER (
                    PARTITION BY grp ORDER BY ffin ASC
                )
                ELSE id
            END AS grupo
        FROM (
            SELECT
                id,
                estado_fk,
                ffin,
                SUM(CASE WHEN estado_fk != LAG(estado_fk, 1, estado_fk) OVER (ORDER BY ffin ASC) THEN 1 ELSE 0 END)
                    OVER (ORDER BY ffin ASC) AS grp
            FROM medidahist
            WHERE centro_fk = (SELECT centro_fk FROM medidahist WHERE id = medidaId)
        ) t
    ) t2
    WHERE id = medidaId;

    RETURN grupoMedida;
END;
$$;

alter function getgrupomedidahist(bigint) owner to postgres;

create function getratioprincipaleficienciacentro(vbleestadosesproductiva boolean, ratioprincipaleficiencia double precision) returns double precision
    stable
    language plpgsql
as
$$
DECLARE
    ratio DOUBLE PRECISION := 1;
BEGIN
    ratio := CASE
        WHEN vbleEstadosEsProductiva THEN ratioPrincipalEficiencia
        ELSE 1
    END;

    RETURN ratio;
END;
$$;

alter function getratioprincipaleficienciacentro(boolean, double precision) owner to postgres;

create function getratiotiempoeficiencia(tipotiempo character varying) returns integer
    stable
    language plpgsql
as
$$
DECLARE
    ratio INTEGER := 1;
BEGIN
    ratio := CASE
        WHEN tipotiempo = 'horas' THEN 60
        WHEN tipotiempo = 'minutos' THEN 1
        ELSE 1  -- Valor por defecto si no coincide
    END;

    RETURN ratio;
END;
$$;

alter function getratiotiempoeficiencia(varchar) owner to postgres;

create function tiempotrabajo(fechainicio timestamp without time zone, fechafin timestamp without time zone, centro bigint) returns bigint
    language plpgsql
as
$$
DECLARE
    tiempoTrabajoTotal bigint;
BEGIN
    SELECT COALESCE(sum(
        CASE
            WHEN mp.tiempoproductivo THEN
                EXTRACT(EPOCH FROM (
                    LEAST(fechaFin, mp.ffin) -
                    GREATEST(fechaInicio, mp.finicio)
                )) / 60.0 * 0.01 * mp.intensidad
            ELSE 0
        END
    ), 0)
    INTO tiempoTrabajoTotal
    FROM (
        SELECT
            pmc.intensidad,
            cpmc.id                                  AS centroFk,
            COALESCE(cpmc.centropadre_fk, cpmc.id)   AS centroPadreFk,
            pm.fechainicio                            AS finicio,
            pm.fechafin                               AS ffin,
            pm.tiempoproductivo
        FROM productividadmedidahist pm
        JOIN productividadmedidacentrohist pmc ON pm.id = pmc.medida_fk
        JOIN centro cpmc ON pmc.centro_fk = cpmc.id
    ) mp
    WHERE mp.centropadrefk = centro
      AND mp.finicio < fechaFin
      AND mp.ffin > fechaInicio;

    RETURN tiempoTrabajoTotal;
END;
$$;

alter function tiempotrabajo(timestamp, timestamp, bigint) owner to postgres;

create function borrar_f_cal_meter() returns void
    language plpgsql
as
$$
    DECLARE
        cof numeric;
        params jsonb;
        volume numeric;
        valformula numeric;
        -- borrar las siguientes variables
        vnodeid int:=106;
        vtime timestamp:=now();
        vvalue numeric:=137086;
        vparameters jsonb;

BEGIN
    -- verification if the datanode belongs to the frig_total_meter_vessel
    PERFORM 1
    FROM equipmentpropertymeter epm
    -- colocar NEW.nodeid en vez de vnodeid
    WHERE epm.datanodeid = vnodeid
    AND epm.equipmentclasspropertyid =59;
    IF FOUND THEN
        --Getting all the parameters needed for the calculation, properties, previous meter data and verificarion of the properties
        params=f_cal_param_meter_vessel(vnodeid);
        IF params->>'resultado'='nok' THEN
            -- pending to register de information in table ej. calculated value
            insert into calculated_value (time,datanodeid,value,parameters)
            values(vtime,vnodeid,vvalue,params);
            --RETURN NULL;
        end if;
        -- sacamos cof el coeficiente del datanode aunque siempre guardaremos el valor en absoluto
        select coefficient into cof
        from equipmentpropertymeter epm
        where epm.datanodeid = vnodeid and epm.equipmentclasspropertyid =59;
        volume=vvalue;
        valformula=f_cal_dif_enthalpy_vessel(
        params->>'fluid',
        (params->>'t_liq_inlet')::numeric,
        (params->> 'p_liq_inlet'):: numeric,
        (params->>'state_liq')::int,
        (params->>'t_liq_vessel')::numeric);
        vvalue=(params->>'frig_total_meter_vessel')::numeric+
                   (vvalue-(params->>'volume')::numeric)*cof*valformula;
         vparameters=params || jsonb_build_object('volume',volume,'valformula',valformula);
          insert into calculated_value (time,datanodeid,value,parameters)
           values(vtime,134,vvalue,vparameters);
    END IF;
    --RETURN NEW;
END;
$$;

alter function borrar_f_cal_meter() owner to postgres;

create function f_cal_dif_enthalpy_vessel(vfluid character varying, t_liquid_inlet numeric, p_liquid_input numeric, state_liq_vessel integer, t_liq_vessel numeric) returns numeric
    language plpgsql
as
$$

-- f_cal_dif_enthalpy_vessel(({{fluid}},{{t_liquid_inlet}},{{p_liq_inlet_sep}},{{state_liq_vessel}},{{t_liq_vessel}})
        DECLARE

        h_vapor_saturado numeric;
        h_liquido numeric;
        dif_entalpia numeric;
        rec_a record;
        rec_b record;
        l_density numeric;
        BEGIN

       -- Calculemos la entalpia de saturación del vapor dentro del separador. Al tener la temperatura del liquido aseguramos que medimos en estado saturado
        -- RAISE NOTICE 'temperatura  del liquido en el separador es:  %',t_liq_vessel ;
        SELECT * into rec_a FROM property_refrigerant_fluid_saturated_new ORDER_BY WHERE fluid=vfluid ORDER BY ABS(temperature_c-t_liq_vessel) LIMIT 1;
         --RAISE NOTICE 'temperatura  VAPOR SATURADO aproximada  ES % y su entalpia es   %  ',rec_a.temperature_c,rec_a.v_enthapy;
        h_vapor_saturado:=rec_a.v_enthapy;
        IF state_liq_vessel=1 THEN
        --    RAISE NOTICE 'presion del liquido a la entrada entrada es %',p_liquid_input ;
            SELECT * into rec_a FROM property_refrigerant_fluid_saturated_new WHERE fluid=vfluid ORDER BY ABS(pressure_bar-p_liquid_input ) LIMIT 1 ;
        --    RAISE NOTICE 'presion aproximada de entrada de liquido es %, su temperatura equivalente es %, entalpia liquido entrada es % y densidad liquido es %',rec_a.pressure_bar,rec_a.temperature_c,rec_a.l_enthalpy,rec_a.l_density;
            -- enthalpy en KJ/KG
            h_liquido:=rec_a.l_enthalpy;
            -- l_density del liquido en kg/m3
            l_density=rec_a.l_density;
        ELSE
          --RAISE NOTICE 'presion del liquido a la entrada entrada es % y la temperatura de entrada es % ',p_liquid_input,t_liquid_inlet ;
            SELECT * into rec_a FROM property_refrigerant_fluid_not_saturated WHERE fluid=vfluid ORDER BY ABS(pressure_bar-p_liquid_input ) LIMIT 1 ;
         -- RAISE NOTICE 'presion más cercana encontrada en la tabla es %',rec_a.pressure_bar ;
            SELECT * into rec_b FROM property_refrigerant_fluid_not_saturated WHERE fluid=vfluid and pressure_bar=rec_a.pressure_bar ORDER BY ABS(temperature_c-t_liquid_inlet) LIMIT 1;
        -- RAISE NOTICE 'temperatura más cercana encontrada en la tabla es %  ',rec_b.temperature_c ;
            h_liquido=rec_b.enthalpy;
            l_density=rec_b.density;
         -- RAISE NOTICE 'La entalpia del liquido calculada es  % siendo la densidad de %',rec_b.enthalpy,rec_b.density ;
        END IF;
        dif_entalpia=(h_vapor_saturado-h_liquido);
       -- RAISE NOTICE 'LA diferencia de entalpia en KJ/KG es %',dif_entalpia;
      --  RAISE NOTICE 'LA diferencia de entalpia en KWh/m3 es %',dif_entalpia*l_density/3600;
        RETURN dif_entalpia*l_density/3600;
        -- return dif_entalpia*l_density/3600;
        -- devuelve la entalpia por kwh/m3 de liquido ya que el contador

        END; $$;

alter function f_cal_dif_enthalpy_vessel(varchar, numeric, numeric, integer, numeric) owner to postgres;

create function f_cal_meter() returns trigger
    language plpgsql
as
$$
    DECLARE
        cof numeric;
        params jsonb;
        volume numeric;
        valformula numeric;
BEGIN
    -- verification if the datanode
    PERFORM 1
    FROM equipmentpropertymeter epm
    WHERE epm.datanodeid = NEW.nodeid
    AND epm.equipmentclasspropertyid =59;
    IF FOUND THEN
        RETURN NULL;
    END IF;
    -- Retorna el registro modificado (o no modificado) para ser insertado
    RETURN NEW;
END;
$$;

alter function f_cal_meter() owner to postgres;

create function f_cal_param_meter_vessel(datanode integer) returns jsonb
    language plpgsql
as
$$
    declare
        trigger_node_id int:=datanode;
        resultado jsonb;

    BEGIN
-- La lógica es primero sacamos con tepm el equipo y la clase de equipo correspondiente al nodo trigger.
-- despues con una subconsulta compuesta por una cte nodes sacamos las propiedades relacionadas con el equipo y sus valores por defecto.
-- finalmente uniendola a measurement value sacamos los ultimos valores de las propiedades dinamicas.
-- metemos esas propiedades en un json
-- que finalmente es introducido en la formula de entalpias.

-- tepm: calculate de equipment id and the equipmentclass for the trigger datanode.
-- is not necessary to filter by the property=5
-- tepm saca  el equipment id y equipmentclassid al que pertenece el datanode
with tepm as (

    select trigger.datanodeid,
           trigger.equipmentid,
           e.equipmentclassid
    from equipmentpropertymeter trigger
    inner join equipment e on e.id=trigger.equipmentid
    where trigger.datanodeid = trigger_node_id
), lectura_datos_formula as (
-- lectura_datos_formulas, saca por un lado un jbson con todas las propiedades y sus valores leidas pertenecientes la las
-- propiedades que son necesarias pra hacer los calculos.

        select

                    -- verifico los datos de las variables leidas para asegurannos que son validos para entrar en la formula,
            -- si no son validos les asigno nok
            case when ((vals->>'t_liq_vessel')::numeric>-60  and (vals->>'t_liq_vessel')::numeric<=40)
            then 'ok' else 'nok' end as st_temp_vessel,
            case when ((static_vals->>'state_liq')::integer=1 and (vals->>'p_liq_inlet')::numeric>=0.2 and (vals->>'p_liq_inlet')::numeric<=15)
            or ((static_vals->>'state_liq')::integer=0 and (vals->>'p_liq_inlet')::numeric>=8 and (vals->>'p_liq_inlet')::numeric<=15)
            then 'ok' else 'nok' end as st_p_liq_inlet,
            case when ((static_vals->>'state_liq')::integer=0 and (vals->>'t_liq_inlet')::numeric>=-10)
            then 'ok' else 'nok' end as st_t_liq_inlet,
            case when ((vals->>'frig_total_meter_vessel'))::numeric>=0
            then 'ok' else 'nok' end as st_frig_meter,
-- construye un json_build a traves de otros dos json que son devueltos por la consulta enthalpy values
            jsonb_build_object(
                    'fluid', (enthalpy_values.static_vals ->> 'fluid')::character varying,
                    't_liq_inlet', (vals ->> 't_liq_inlet')::numeric,
                    'p_liq_inlet', (vals ->> 'p_liq_inlet')::numeric,
                    'state_liq', (static_vals ->> 'state_liq')::integer,
                    't_liq_vessel', (vals ->> 't_liq_vessel')::numeric,
                    'frig_total_meter_vessel',(vals ->> 'frig_total_meter_vessel')::numeric,
                    'volume',volume_ant
                -- hay que ver si podemos poner aquí el coeficiente calculado, cero si ha habido error
                ) as parameters

     from

         (
             -- only one record, the trigger node and equipment with two json, one for default values and other for the last values.
             select max(volume_ant) volume_ant,
-- jsonb_object_agg permite construir un json a partir de los resultados de una consulta con varias filas asignando una columana a lakey y otra al value
                    jsonb_object_agg(property_code, coalesce(last_value::numeric, default_value::numeric)) as vals,
                    jsonb_object_agg(property_code, default_value::character varying)                      as static_vals
             from (
                      -- nodes da la relacion de propiedades de la clase de equipo al que pertenece el equipo, con su property_id, nodo, coef, const y el valor de las propiedades estaticas.
                      WITH nodes as (select -- select the ids of the datanodes and the codes of the properties
                                            tepm.equipmentid              as equipment_id,
                                            tepm.datanodeid               as trigger_node,
                                            ecp.id                        as property_id,
                                            ecp.code                      as property_code,
                                            epm.datanodeid                as property_node,
                                            epm.coefficient               as coefficient,
                                            epm.constant                  as constant,
                                            -- coalesce busca el valor en equipment property y si no lo encuentra toma por defecto el de propertyclass
                                            coalesce(ep.value, ecp.value) as default_value
                                     from tepm
-- inner join with all the classes of the equipment, we can later filter by class id if we want
                                              inner join equipmentclassproperty ecp on ecp.id in
                                                                                       (with recursive parent_equipment_class
                                                                                                           as (select ec.id, ec.code, ec.parentid
                                                                                                               from equipmentclass ec
                                                                                                               where ec.id = tepm.equipmentclassid
                                                                                                               union
                                                                                                               select ec.id, ec.code, ec.parentid
                                                                                                               from equipmentclass ec
                                                                                                                        inner join parent_equipment_class pec on ec.id = pec.parentid)
                                                                                        select ecp.id
                                                                                        from equipmentclassproperty ecp
                                                                                                 inner join parent_equipment_class pec on pec.id = ecp.equipmentclassid
                                                                                        where ecp.id in (36, 37, 38, 39, 7,59))
                                              left join equipmentpropertymeter epm
                                                        on (tepm.equipmentid = epm.equipmentid and
                                                            epm.equipmentclasspropertyid = ecp.id)
                                         -- inner join with equipment value to get the default value of the equipment if it´s different from the default
                                              left join equipmentproperty ep
                                                        on (tepm.equipmentid = ep.equipmentid and
                                                            ep.equipmentclasspropertyid =
                                                            ecp.id)) -- la consulta lastvalues coge los nodos de nodes tanto estaticos como dinamicos y saca los ultimos valores measurement values ys calculados así como el valor de las propiedades estáticas.
                      select
                             nodes.property_code,
                             nodes.default_value as default_value,
                             case
                                 when nodes.property_id in (37, 38, 39,59) then coalesce(nodes.coefficient, 1) *
                                                                             coalesce(last(value, time), nodes.default_value::numeric) +
                                                                             coalesce(nodes.constant, 0)
                                 else 0 end      as last_value,
                             case when nodes.property_id=59 then last(m.parameters->>'volume',time)::numeric else 0 end as volume_ant

                      from nodes
                               left join measurement_value m
                                        --excluyo el intervalo de tiempo porque si no puede haber momentos que no entre dentro de ese intervalo
                                         on (m.nodeid = nodes.property_node) --and m.time <= trigger_timestamp and m.time > trigger_timestamp - interval '1d')
                      group by nodes.property_id, nodes.property_code,
                               default_value, nodes.constant,
                               nodes.coefficient) as last_values
                    ) as enthalpy_values
     group by volume_ant, enthalpy_values.vals, enthalpy_values.static_vals)
select parameters || jsonb_build_object('resultado',
        CASE
            WHEN st_temp_vessel='ok' AND st_p_liq_inlet='ok' AND st_t_liq_inlet='ok' AND st_frig_meter='ok'
            THEN 'ok'
            ELSE 'nok'
        END) as parameters
into resultado from lectura_datos_formula;
RETURN resultado;

END; $$;

alter function f_cal_param_meter_vessel(integer) owner to postgres;

create function f_jerar_equip_medida_energia(id_equipment integer, propertyclass integer)
    returns TABLE(id_equi integer, code_equip character varying, desc_equip character varying, nodeid integer)
    language plpgsql
as
$$
BEGIN
RETURN QUERY
WITH RECURSIVE jerarquía_equipo_energías AS (
    SELECT id AS id_equi,
           code AS code_equip,
           (description ->> 'en')::varchar AS desc_equip
    FROM equipment
    WHERE id = id_equipment

    UNION

    SELECT e.id AS id_equi,
           e.code AS code_equip,
           (e.description ->> 'en')::varchar AS desc_equip
    FROM equipment e
    INNER JOIN jerarquía_equipo_energías c ON c.id_equi = e.parentid
    WHERE NOT EXISTS (
        SELECT 1
        FROM equipmentpropertymeter epm
        WHERE c.id_equi = epm.equipmentid AND epm.equipmentclasspropertyid = propertyclass
    )
)
-- Una vez tiene los primeros equipos hijos que desciendden del equipo proporcionado en cada una de sus ramas y que tienen al menos una propiedad proporcionada
-- saca los nodos de las propiedad-equipos relacionados
SELECT j.id_equi, j.code_equip, j.desc_equip, epm.datanodeid as nodeid
FROM jerarquía_equipo_energías j
INNER JOIN equipmentpropertymeter epm ON j.id_equi = epm.equipmentid AND epm.equipmentclasspropertyid = propertyclass;
END;
$$;

alter function f_jerar_equip_medida_energia(integer, integer) owner to postgres;

create function process_new_volume() returns trigger
    language plpgsql
as
$$
DECLARE
    calculated_formula record;

BEGIN


SELECT INTO calculated_formula * from calc_enthalpy_function_value(NEW.nodeid, NEW.time);

--RAISE NOTICE 'calculated_measurement: %', calculated_formula;

if calculated_formula.enthalpy_formula is not null then
    insert into calculated_value (time, value, DataNodeID, parameters) values (NEW.time, calculated_formula.enthalpy_formula, calculated_formula.r_node_id, calculated_formula.r_vals);
end if;
RETURN NULL;
END;
$$;

alter function process_new_volume() owner to postgres;

create function total_consumo_bucket(bucket interval, cod_equipo integer, propiedad integer, fecha_in timestamp without time zone, fecha_fin timestamp without time zone)
    returns TABLE(time_data timestamp with time zone, consumo numeric, des_equipo character varying)
    language plpgsql
as
$$
    BEGIN
    RETURN QUERY
    Select time_bucket(bucket, time) as mins, sum(increment)::numeric as consumo,desc_equipo::varchar
    from (
        with recursive cte_relacion_hijos(id,code,desc_equipo,cod_parent) as (
            select id,code,description -> 'en' ,parentid
            from equipment
            where id=cod_equipo
            UNION
            select e.id,e.code,e.description -> 'en',e.parentid
            from equipment e
            inner join cte_relacion_hijos c on c.id=e.parentid) ,
        --cnt nos saca los deltas de los contadores asociados a la propiedad de entrada
        cnt as (SELECT time, value - lag(value) over node_window as increment
            FROM measurement_value mv
            inner join equipmentpropertymeter as epm on mv.nodeid = epm.datanodeid
            inner join cte_relacion_hijos eq on epm.equipmentid = eq.id
            where epm.equipmentclasspropertyid = propiedad and time>=fecha_in and time<=fecha_fin
             -- pondremos la propiedad a sumar y la fecha a seleccionar
            window node_window as (partition by nodeid order by time)
            )
            select time,increment,desc_equipo from cnt cross join (select code from equipment where id=cod_equipo) as desc_equipo
            ) time
        group by mins,desc_equipo
        order by mins;
END $$;

alter function total_consumo_bucket(interval, integer, integer, timestamp, timestamp) owner to postgres;

create procedure actualizarmedidasorden(IN codigoorden character varying, IN fechatopeinicio timestamp without time zone, IN fechatopefin timestamp without time zone)
    language plpgsql
as
$$
BEGIN
    -- ============================================
    -- UPDATE 1: medidahist
    -- ============================================
UPDATE medidahist m
SET
    duracion = EXTRACT(EPOCH FROM (m.ffin - m.finicio)) / 60,
    tproduccion = CASE WHEN m.estadotipo_fk = 2 THEN EXTRACT(EPOCH FROM (m.ffin - m.finicio)) / 60 ELSE 0 END,
    tfallo = CASE WHEN m.estadotipo_fk = 4 THEN EXTRACT(EPOCH FROM (m.ffin - m.finicio)) / 60 ELSE 0 END,
    tparorutinario = CASE WHEN m.estadotipo_fk = 3 THEN EXTRACT(EPOCH FROM (m.ffin - m.finicio)) / 60 ELSE 0 END,
    tnoplanificado = CASE WHEN m.estadotipo_fk = 5 THEN EXTRACT(EPOCH FROM (m.ffin - m.finicio)) / 60 ELSE 0 END,
    toperacional = CASE WHEN m.estadotipo_fk <> 5 THEN EXTRACT(EPOCH FROM (m.ffin - m.finicio)) / 60 ELSE 0 END,
    tproductivo = CASE
                      WHEN m.estadotipo_fk = 3 AND m.duracion > m.tmaximo THEN m.duracion - m.tmaximo
                      ELSE CASE WHEN m.estadotipo_fk <> 5 THEN EXTRACT(EPOCH FROM (m.ffin - m.finicio)) / 60 ELSE 0 END
        END,

    ratioconteoprincipal = cp.ratioconteoprincipal,
    ratioprincipalsecundaria = cp.ratioprincipalsecundaria,
    ratioprincipaleficiencia = cp.ratioprincipaleficiencia,
    tefectivo = getRatioTiempoEficiencia(m.tipotiempoeficiencia) * COALESCE((m.cantidad - m.cantidaddesechada) / NULLIF(cp.vTeoria, 0), 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia),
    tobjetivo = getRatioTiempoEficiencia(m.tipotiempoeficiencia) * COALESCE(m.cantidad / NULLIF(cp.vObjetivo, 0), 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia),
    vobjetivo = cp.vObjetivo,
    vteoria = cp.vTeoria,
    rvelocidad = COALESCE((m.cantidad / NULLIF(m.tproduccion, 0)) / NULLIF(cp.vTeoria, 0), 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia),
    rvelocidadobj = cp.vObjetivo / NULLIF(cp.vTeoria, 0),
    dpobjetivo = cp.disponibilidad / 100.0,
    doobjetivo = cp.doobjetivo / 100.0,
    epobjetivo = getEficienciaObjetivo(cp.disponibilidad / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0),
    ep = getRatioTiempoEficiencia(m.tipotiempoeficiencia) * COALESCE((((m.cantidad - m.cantidaddesechada) / NULLIF(m.tproduccion, 0)) / NULLIF(cp.vTeoria, 0)) * m.dp * m.calidadreal, 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia),
    eoobjetivo = getEficienciaObjetivo(cp.doobjetivo / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0),
    eo = getRatioTiempoEficiencia(m.tipotiempoeficiencia) * COALESCE((((m.cantidad - m.cantidaddesechada) / NULLIF(m.tproduccion, 0)) / NULLIF(cp.vTeoria, 0)) * m.dop * m.calidadreal, 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia),
    cantidadobjep = m.tproductivo * cp.vteoria * getEficienciaObjetivo(cp.disponibilidad / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0) / NULLIF(getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia), 0) * getRatioTiempoEficiencia(m.tipotiempoeficiencia),
    cantidadobjeo = m.toperacional * cp.vteoria * getEficienciaObjetivo(cp.doobjetivo / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0) / NULLIF(getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia), 0) * getRatioTiempoEficiencia(m.tipotiempoeficiencia),
    cantidadretrasoep = m.tproductivo * cp.vteoria * getEficienciaObjetivo(cp.disponibilidad / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0) / NULLIF(getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia), 0) * getRatioTiempoEficiencia(m.tipotiempoeficiencia) - m.cantidad,
    cantidadretrasoeo = m.toperacional * cp.vteoria * getEficienciaObjetivo(cp.doobjetivo / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0) / NULLIF(getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia), 0) * getRatioTiempoEficiencia(m.tipotiempoeficiencia) - m.cantidad,
    tOperacionalObj = COALESCE(getRatioTiempoEficiencia(m.tipotiempoeficiencia) * COALESCE((m.cantidad - m.cantidaddesechada) / NULLIF(cp.vTeoria, 0), 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia) / NULLIF(getEficienciaObjetivo(cp.doobjetivo / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0), 0), 0),
    tproductivoobj = COALESCE(getRatioTiempoEficiencia(m.tipotiempoeficiencia) * COALESCE((m.cantidad - m.cantidaddesechada) / NULLIF(cp.vTeoria, 0), 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia) / NULLIF(getEficienciaObjetivo(cp.disponibilidad / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0), 0), 0),
    duracionretrasoeo = m.toperacional - COALESCE(getRatioTiempoEficiencia(m.tipotiempoeficiencia) * COALESCE((m.cantidad - m.cantidaddesechada) / NULLIF(cp.vTeoria, 0), 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia) / NULLIF(getEficienciaObjetivo(cp.doobjetivo / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0), 0), 0),
    duracionretrasoep = m.tproductivo - COALESCE(getRatioTiempoEficiencia(m.tipotiempoeficiencia) * COALESCE((m.cantidad - m.cantidaddesechada) / NULLIF(cp.vTeoria, 0), 0) * getRatioPrincipalEficienciaCentro(c.vbleestadosesproductiva, cp.ratioprincipaleficiencia) / NULLIF(getEficienciaObjetivo(cp.disponibilidad / 100.0, cp.vObjetivo / NULLIF(cp.vTeoria, 0), cp.calidadobjetivo / 100.0), 0), 0),
    calidadobjetivo = cp.calidadobjetivo / 100.0,
    prodestandar = cp.prodestandar
    FROM centroorden co
INNER JOIN centroproducto cp ON co.centroProducto_fk = cp.id
    INNER JOIN centro c ON cp.centro_fk = c.id
WHERE m.centroorden_fk = co.id
  AND co.codigo LIKE codigoOrden
  AND m.finicio >= fechatopeinicio
  AND m.ffin <= fechatopefin;

-- ============================================
-- UPDATE 2: medidasubcentrohist
-- ============================================
UPDATE medidasubcentrohist
SET
    duracion = EXTRACT(EPOCH FROM (ffin - finicio)) / 60,
    tproduccion = CASE WHEN estadotipo_fk = 2 THEN EXTRACT(EPOCH FROM (ffin - finicio)) / 60 ELSE 0 END,
    tfallo = CASE WHEN estadotipo_fk = 4 THEN EXTRACT(EPOCH FROM (ffin - finicio)) / 60 ELSE 0 END,
    tparorutinario = CASE WHEN estadotipo_fk = 3 THEN EXTRACT(EPOCH FROM (ffin - finicio)) / 60 ELSE 0 END,
    tnoplanificado = CASE WHEN estadotipo_fk = 5 THEN EXTRACT(EPOCH FROM (ffin - finicio)) / 60 ELSE 0 END,
    toperacional = CASE WHEN estadotipo_fk <> 5 THEN EXTRACT(EPOCH FROM (ffin - finicio)) / 60 ELSE 0 END,
    tproductivo = CASE
                      WHEN estadotipo_fk = 3 AND duracion > tmaximo THEN duracion - tmaximo
                      ELSE CASE WHEN estadotipo_fk <> 5 THEN EXTRACT(EPOCH FROM (ffin - finicio)) / 60 ELSE 0 END
        END
WHERE orden LIKE codigoOrden
  AND finicio >= fechatopeinicio
  AND ffin <= fechatopefin;

END;
$$;

alter procedure actualizarmedidasorden(varchar, timestamp, timestamp) owner to postgres;

create function geteficienciaobjetivo(dobjetivo double precision, robjetivo double precision, cobjetivo double precision) returns double precision
    stable
    language plpgsql
as
$$
DECLARE
scrap_auto DOUBLE PRECISION;
    eObjetivo DOUBLE PRECISION;
BEGIN
    scrap_auto := 0;
    eObjetivo := 0;

SELECT COALESCE(is_scrap_auto::int * scrap_objective, 0)
INTO scrap_auto
FROM app_config
         LIMIT 1;

IF scrap_auto = 0 THEN
        eObjetivo := dObjetivo * rObjetivo * cObjetivo;
ELSE
        eObjetivo := dObjetivo * rObjetivo * scrap_auto;
END IF;

RETURN eObjetivo;
END;
$$;

alter function geteficienciaobjetivo(double precision, double precision, double precision) owner to postgres;

create function sp_getvbaseindicadoresmag(p_fechainicio timestamp without time zone, p_fechafin timestamp without time zone, p_centro integer)
    returns TABLE(centroid bigint, plantaid bigint, plantanombre character varying, areaid bigint, areanombre character varying, seccionid bigint, seccionnombre character varying, centronombre character varying, centroconectado boolean, centrotipo character varying, centrotipoid bigint, descripcionestados text, centrogestionmanualestados boolean, centrotipocapturaestado character varying, centrotipocapturaproduccion character varying, centroactivo boolean, centrocentropadreid bigint, variableestadosesproductiva boolean, unidadeficiencianombre character varying, estadoactualid bigint, estadoactualnombre character varying, estadotipoid bigint, estadotiponombre character varying, centroordenid bigint, cantidadproducida double precision, unidadprincipalid bigint, unidadprincipalnombre character varying, unidadauxiliarid bigint, unidadauxiliarnombre character varying, unidadsecundariaid bigint, unidadsecundarianombre character varying, tiempoproduccion numeric, tvelocidadreducida numeric, tnoplanificado numeric, tfallo numeric, tnoplanificadoconocupacion numeric, tnooperativo numeric, tiempototal numeric, tefectivo double precision, tparorutinario numeric, texceso numeric, tproductivo numeric, calidadobjetivo double precision, calidadreal double precision, doobjetivo double precision, oeeobjetivo double precision, cantidadtotalproducida double precision, cantidadtotalproducidaauxiliar double precision, cantidadtotalconforme double precision, cantidadtotalconformeuauxiliar double precision, cantidadtotaldesechada double precision, cantidadtotaldesechadaauxiliar double precision, perdidacalidad double precision, contadornotificaciones integer, tipotiempoeficiencia character varying, velocidadobjetivo double precision, velocidadobjetivoauxiliar double precision, unidadeficienciaid bigint, unidadeficiencia character varying, indicadorproductividad double precision, epreal double precision, epobjetivo double precision, disponibilidadproductiva numeric, dpobjetivo double precision, ratiovelocidadreal double precision, ratiovelocidadobjetivo double precision, velocidadreal double precision, velocidadrealuauxiliar double precision, duraciontotal numeric, cantidadobjetivoepunidadprincipal double precision, difep double precision, difdp double precision, difcalidad double precision, oeereal double precision, difoee double precision, difratiovelocidad double precision, difproductividad double precision, unidadproductividadtiempo text, unidadproductividadnombre text, disponibilidadoperacional numeric, difdoee double precision, cantidadobjetivooeunidadprincipal double precision, cantidadobjetivooeunidadauxiliar double precision, tproductividadhreal numeric, tproductividadhobjetivo double precision, difcantidadep double precision, difcantidadoe double precision, difcantidadepuauxiliar double precision, difcantidadoeuauxiliar double precision, cantidadrealunidadsecundaria double precision, difcantidadepunidadsecundaria double precision, tiempoproductivo numeric, tiempooperacional numeric, cantidadrealunidadprincipal double precision, tiemponoplanificado numeric, tiempoestandarproductividad double precision, tiemporealproductividad numeric, ratioproductividadestandar double precision, ratioproductividadreal double precision, diferenciavelocidad double precision, diferenciahorasproductividad double precision, centrotipotiempoeficiencia text, nsecuencia integer)
    language plpgsql
as
$$
    #variable_conflict use_column  -- ESTA ES LA LÍNEA CLAVE
BEGIN
RETURN QUERY
    WITH medidasbaseinicio AS (
        SELECT
            MIN(m.finicio)     AS finicio,
            MAX(m.ffin)        AS ffin,
            MIN(m.id)          AS id,
            m.centroorden_fk,
            m.centroestado_fk,
            m.grupo,
            m.turno_fk,
            m.operarioresponsable_fk,
            centroproducto_fk,
            SUM(m.valormedida) AS valormedida
        FROM vmedida m
        WHERE m.tipomedida = 'estados'
          AND m.finicio < p_fechafin
          AND m.ffin > p_fechainicio
          AND m.centro_fk = p_centro
        GROUP BY
            m.centroorden_fk,
            m.centroestado_fk,
            m.grupo,
            m.turno_fk,
            m.operarioresponsable_fk,
            centroproducto_fk
    ) ,
    medidasbase AS (
        SELECT
            GREATEST(finicio, p_fechainicio) AS finicio,
            LEAST(ffin, p_fechafin) AS ffin,
            id,
            centroorden_fk,
            centroestado_fk,
            grupo,
            turno_fk,
            operarioresponsable_fk,
            centroproducto_fk,
            valormedida,
            EXTRACT(EPOCH FROM (LEAST(ffin, p_fechafin) - GREATEST(finicio, p_fechainicio))) / 60 AS duracion
        FROM medidasbaseinicio
    ),-- medidasbase ya está definida arriba, continuamos con m
m AS (
    SELECT
        m.id AS medidaid,
        m.finicio AS medidafechainicio,
        m.ffin AS medidafechafin,
        DATE_TRUNC('day', m.finicio) AS medidafechajornada,
        m.valormedida,
        m.duracion AS medidaduracion,  -- Ya lo tienes en medidasbase
        cp.centro_fk AS centroid,
        cp.producto_fk AS productoid,
        co.codigo AS centroordencodigo,
        co.id AS centroordenid,
        m.turno_fk AS turnoid,
        m.operarioresponsable_fk AS operarioresponsableid,
        GREATEST(0, COALESCE(m.duracion - NULLIF(ce.tmaximo, 0), 0)) AS tparoexceso,
        -- Subconsultas de producción combinadas
        COALESCE(prod.cantidad,0) AS medidacantidad,
        COALESCE(prod.desechada,0) AS medidacantidaddesechada,
        -- Subconsultas de consumo combinadas
        COALESCE(cons.consumo,0) AS medidaconsumo,
        COALESCE(cons.consumodesechado,0) AS medidaconsumodesechada,
        -- Resto de campos...
        COALESCE(pm_agg.tiempoproductivo, 0) AS tiemporealproductividadminutos,
        cp.ratioconteoprincipal,
        cp.ratioprincipalsecundaria,
        cp.ratioprincipalauxiliar,
        cp.vteoria,
        cp.vobjetivo,
        c.tipotiempoeficiencia,
        c.vbleestadosesproductiva,
        cp.ratioprincipaleficiencia,
        c.unidadprincipal_fk AS unidadprincipalid,
        c.unidadsecundaria_fk AS unidadsecundariaid,
        CASE
            WHEN c.tipounidadproductividad = 'principal'
            THEN c.unidadprincipal_fk
            ELSE c.unidadsecundaria_fk
        END AS unidadproductividadid,
        c.unidadeficiencia_fk AS unidadeficienciaid,
        c.unidadauxiliar_fk AS unidadauxiliarid,
        c.tipotiempoeficiencia AS centrotipotiempoeficiencia,
        c.tipounidadproductividad,
        c.tipotiempoproductividad,
        cp.prodestandar AS productividadestandar,
        e.id AS estadoid,
        e.nombre AS estadonombre,
        et.id AS estadotipoid,
        et.nombre AS estadotiponombre,
        cp.vobjetivo / NULLIF(cp.vteoria, 0) AS ratiovelocidadobjetivo,
        COALESCE(NULLIF(cp.disponibilidad, 0) * 0.01, 1) AS disponibilidadprodobjetivo,
        COALESCE(NULLIF(cp.doobjetivo, 0) * 0.01, 1) AS disponibilidadoperacionalobjetivo,
        COALESCE(NULLIF(cp.calidadobjetivo, 0) * 0.01, 1) AS calidadobjetivo,
        CASE
            WHEN et.id = 2 THEN COALESCE(alarma_agg.duracion, 0)
            ELSE 0
        END AS tmicroparojustificado
    FROM medidasbase m
    LEFT JOIN centroorden co ON m.centroorden_fk = co.id
    LEFT JOIN centroproducto cp ON co.centroproducto_fk = cp.id
    LEFT JOIN centro c ON cp.centro_fk = c.id
    LEFT JOIN centroestado ce ON m.centroestado_fk = ce.id
    LEFT JOIN estado e ON ce.estado_fk = e.id
    LEFT JOIN estadotipo et ON e.tipo_fk = et.id
    -- Agregación de producción
    LEFT JOIN LATERAL (
        SELECT
            SUM(CASE WHEN mp.tipomedida = 'produccion' THEN mp.valormedida ELSE 0 END) AS cantidad,
            SUM(CASE WHEN mp.tipomedida = 'cantidadDesechada' THEN mp.valormedida ELSE 0 END) AS desechada
        FROM medida mp
        WHERE mp.tipomedida IN ('produccion', 'cantidadDesechada')
          AND mp.centroorden_fk = m.centroorden_fk
          AND m.finicio < mp.ffin
          AND m.ffin >= mp.ffin
    ) prod ON true
    -- Agregación de consumo
    LEFT JOIN LATERAL (
        SELECT
            SUM(CASE WHEN mp.tipooperacion = 'PRODUCCION' THEN mp.valorconsumo ELSE 0 END) AS consumo,
            SUM(CASE WHEN mp.tipooperacion = 'CANTIDADDESECHADA' THEN mp.valorconsumo ELSE 0 END) AS consumodesechado
        FROM consumo mp
        WHERE mp.tipooperacion IN ('PRODUCCION', 'CANTIDADDESECHADA')
          AND mp.centroorden_fk = m.centroorden_fk
          AND m.finicio < mp.fecha
          AND m.ffin >= mp.fecha
    ) cons ON true
    -- Agregación de productividad
    LEFT JOIN LATERAL (
        SELECT SUM(
            EXTRACT(EPOCH FROM (
                LEAST(COALESCE(m.ffin, NOW()), COALESCE(pm.fechafin, NOW())) -
                GREATEST(m.finicio, pm.fechainicio)
            )) * pmc.intensidad / 100 / 60
        ) AS tiempoproductivo
        FROM productividadmedida pm
        INNER JOIN estadooperario eo ON eo.id = pm.estado_fk AND eo.tiempoproductivo = TRUE
        INNER JOIN productividadmedidacentro pmc ON pmc.medida_fk = pm.id AND pmc.centro_fk = c.id
        WHERE pm.fechafin > m.finicio
          AND COALESCE(m.ffin, NOW()) > pm.fechainicio
          AND m.finicio < COALESCE(pm.fechafin, NOW())
    ) pm_agg ON true
    -- Agregación de alarmas
    LEFT JOIN LATERAL (
        SELECT SUM(
            EXTRACT(EPOCH FROM (
                LEAST(ca.fechafin, m.ffin) - GREATEST(ca.fechainicio, m.finicio)
            )) / 60
        ) AS duracion
        FROM centroalarma ca
        WHERE ca.centro_fk = c.id
          AND ca.fechainicio <= m.ffin
          AND ca.fechafin >= m.finicio
    ) alarma_agg ON et.id = 2
),
        medidasbaseiniciohist AS (
    SELECT
        m.finicio AS fechainicio,
        m.ffin AS fechafin,
        m.id,
        m.centroorden_fk,
        m.estado_fk,
        m.grupo,
        m.turno_fk,
        m.operarioresponsable_fk,
        m.cantidad AS valormedida,
        m.centro_fk,
        m.producto_fk,
        m.ratioconteoprincipal,
        m.ratioprincipalsecundaria,
        m.ratioprincipalauxiliar,
        m.vteoria,
        m.vobjetivo,
        m.prodestandar,
        m.ratioprincipaleficiencia,
        m.calidadobjetivo,
        m.dpobjetivo,
        m.doobjetivo
    FROM medidahist m
    WHERE m.finicio < p_fechafin
      AND m.ffin > p_fechainicio
      AND m.centro_fk = p_centro
),
        -- Preparación de las medidas históricas
medidasbasehist AS (
    SELECT
        medidasbaseiniciohist.*,
        GREATEST(fechainicio, p_fechainicio) AS finicio,
        LEAST(fechafin, p_fechafin) AS ffin,
        EXTRACT(EPOCH FROM (
            LEAST(fechafin, p_fechafin) -
            GREATEST(fechainicio, p_fechainicio)
        )) / 60 AS duracion
    FROM medidasbaseiniciohist
),

mhist AS (
    SELECT
        m.id AS medidaid,
        m.finicio AS medidafechainicio,
        m.ffin AS medidafechafin,
        DATE_TRUNC('day', m.finicio) AS medidafechajornada,
        m.valormedida,
        EXTRACT(EPOCH FROM (m.ffin - m.finicio)) / 60 AS medidaduracion,
        m.centro_fk AS centroid,
        m.producto_fk AS productoid,
        co.codigo AS centroordencodigo,
        co.id AS centroordenid,
        m.turno_fk AS turnoid,
        m.operarioresponsable_fk AS operarioresponsableid,
        GREATEST(0, COALESCE(m.duracion - NULLIF(ce.tmaximo, 0), 0)) AS tparoexceso,

        -- Agregación de producción y desechada
        COALESCE(prod.cantidad, 0) AS medidacantidad,
        COALESCE(prod.desechada, 0) AS medidacantidaddesechada,

        -- Agregación de consumo
        COALESCE(cons.consumo, 0) AS medidaconsumo,
        COALESCE(cons.consumodesechado, 0) AS medidaconsumodesechada,

        -- Tiempo real de productividad
        COALESCE(pm_agg.tiempoproductivo, 0) AS tiemporealproductividadminutos,

        m.ratioconteoprincipal,
        m.ratioprincipalsecundaria,
        m.ratioprincipalauxiliar,
        m.vteoria,
        m.vobjetivo,
        c.tipotiempoeficiencia,
        c.vbleestadosesproductiva,
        m.ratioprincipaleficiencia,
        c.unidadprincipal_fk AS unidadprincipalid,
        c.unidadsecundaria_fk AS unidadsecundariaid,
        CASE
            WHEN c.tipounidadproductividad = 'principal'
            THEN c.unidadprincipal_fk
            ELSE c.unidadsecundaria_fk
        END AS unidadproductividadid,
        c.unidadeficiencia_fk AS unidadeficienciaid,
        c.unidadauxiliar_fk AS unidadauxiliarid,
        c.tipotiempoeficiencia AS centrotipotiempoeficiencia,
        c.tipounidadproductividad,
        c.tipotiempoproductividad,
        m.prodestandar AS productividadestandar,
        e.id AS estadoid,
        e.nombre AS estadonombre,
        et.id AS estadotipoid,
        et.nombre AS estadotiponombre,
        m.vobjetivo / NULLIF(m.vteoria, 0) AS ratiovelocidadobjetivo,
        COALESCE(NULLIF(m.dpobjetivo, 0), 1) AS disponibilidadprodobjetivo,
        COALESCE(NULLIF(m.doobjetivo, 0), 1) AS disponibilidadoperacionalobjetivo,
        COALESCE(NULLIF(m.calidadobjetivo, 0), 1) AS calidadobjetivo,

        -- Microparos justificados
        CASE
            WHEN et.id = 2 THEN COALESCE(alarma_agg.duracion, 0)
            ELSE 0
        END AS tmicroparojustificado

    FROM medidasbasehist m
    LEFT JOIN centroorden co ON m.centroorden_fk = co.id
    LEFT JOIN centro c ON m.centro_fk = c.id
    LEFT JOIN estado e ON m.estado_fk = e.id
    LEFT JOIN centroestado ce ON e.id = ce.estado_fk AND c.id = ce.centro_fk
    LEFT JOIN estadotipo et ON e.tipo_fk = et.id

    -- Agregación de producción y desechada
    LEFT JOIN LATERAL (
        SELECT
            SUM(CASE WHEN mp.tipomedida = 'produccion' THEN mp.valormedida ELSE 0 END) AS cantidad,
            SUM(CASE WHEN mp.tipomedida = 'cantidadDesechada' THEN mp.valormedida ELSE 0 END) AS desechada
        FROM (
            SELECT valormedida, tipomedida, centroorden_fk, ffin
            FROM medidaproduccionhist
            WHERE tipomedida = 'produccion'
            UNION ALL
            SELECT valormedida, tipomedida, centroorden_fk, ffin
            FROM medidadesechadahist
            WHERE tipomedida = 'cantidadDesechada'
        ) mp
        WHERE mp.centroorden_fk = m.centroorden_fk
          AND m.finicio < mp.ffin
          AND m.ffin >= mp.ffin
    ) prod ON true

    -- Agregación de consumo
    LEFT JOIN LATERAL (
        SELECT
            SUM(CASE WHEN mp.tipooperacion = 'PRODUCCION' THEN mp.valorconsumo ELSE 0 END) AS consumo,
            SUM(CASE WHEN mp.tipooperacion = 'CANTIDADDESECHADA' THEN mp.valorconsumo ELSE 0 END) AS consumodesechado
        FROM consumohist mp
        WHERE mp.tipooperacion IN ('PRODUCCION', 'CANTIDADDESECHADA')
          AND mp.centroorden_fk = m.centroorden_fk
          AND m.finicio < mp.fechainicio
          AND m.ffin >= mp.fechainicio
    ) cons ON true

    -- Agregación de productividad
    LEFT JOIN LATERAL (
        SELECT SUM(
            EXTRACT(EPOCH FROM (
                LEAST(COALESCE(m.ffin, NOW()), COALESCE(pm.fechafin, NOW())) -
                GREATEST(m.finicio, pm.fechainicio)
            )) * pmc.intensidad / 100 / 60
        ) AS tiempoproductivo
        FROM productividadmedidahist pm
        INNER JOIN estadooperario eo ON eo.id = pm.estado_fk AND eo.tiempoproductivo = TRUE
        INNER JOIN productividadmedidacentrohist pmc ON pmc.medida_fk = pm.id AND pmc.centro_fk = c.id
        WHERE pm.fechafin > m.finicio
          AND COALESCE(m.ffin, NOW()) > pm.fechainicio
          AND m.finicio < COALESCE(pm.fechafin, NOW())
    ) pm_agg ON true

    -- Agregación de alarmas (solo si es microparo)
    LEFT JOIN LATERAL (
        SELECT SUM(
            EXTRACT(EPOCH FROM (
                LEAST(ca.fechafin, m.ffin) - GREATEST(ca.fechainicio, m.finicio)
            )) / 60
        ) AS duracion
        FROM centroalarmahist ca
        WHERE ca.centro_fk = c.id
          AND ca.fechainicio <= m.ffin
          AND ca.fechafin >= m.finicio
    ) alarma_agg ON et.id = 2
),
    unionmedidas as (
    select mhist.* from mhist
    union all
    select m.* from m
) ,
t as (
    select m.*,
           (medidacantidad + medidaconsumo) as qtotalup,
           (medidacantidad + medidaconsumo) * ratioprincipalsecundaria as qtotalus,
           (medidacantidad + medidaconsumo) * ratioprincipaleficiencia as qtotaluv,
           (medidacantidaddesechada + medidaconsumodesechada) as qscrapup,
           (medidacantidaddesechada + medidaconsumodesechada) * ratioprincipalsecundaria as qscrapus,
           (medidacantidaddesechada + medidaconsumodesechada) * ratioprincipaleficiencia as qscrapuv,
           case when estadotipoid = 2 then medidaduracion else 0 end as tproduccion,
           case when estadotipoid = 2 and estadoid = 3 then medidaduracion else 0 end as tvelocidadreducida,
           case when estadotipoid = 3 then medidaduracion else 0 end as tparoprogramado,
           case when estadotipoid = 4 then medidaduracion else 0 end as tfallo,
           case when estadotipoid = 5 or estadotipoid = 6 then medidaduracion else 0 end as tnoplanificado,
           case when estadotipoid = 6 then medidaduracion else 0 end as tnooperativo,
           case when estadoid = 9 then medidaduracion else 0 end as tnoplanificadoconocupacion,
           case when estadotipoid in (2,3,4) then medidaduracion else 0 end as toperacional,
           medidaduracion as ttotal,
           case
               when estadotipoid = 2 then medidaduracion
               when estadotipoid = 3 and tparoexceso > 0 then tparoexceso
               when estadotipoid = 4 then medidaduracion
               else 0
           end as tproductividadhreal,
           ((case
                 when tipotiempoeficiencia = 'horas' then (60 * medidacantidad) / nullif(vobjetivo, 0)
                 else medidacantidad / nullif(vobjetivo, 0)
             end) * case when vbleestadosesproductiva then ratioprincipaleficiencia else 1 end) as medidatiempoobjetivo,
           case when unidadprincipalid = unidadproductividadid then 1 else ratioprincipalsecundaria end as ratioprincipalproductividad,
           (vobjetivo / nullif(vteoria, 0)) as pcvobjetivo,
           (ratiovelocidadobjetivo * disponibilidadprodobjetivo * calidadobjetivo) as eficienciaprodobjetivo,
           (disponibilidadprodobjetivo * ratiovelocidadobjetivo * disponibilidadoperacionalobjetivo * calidadobjetivo) as eficienciaoperobjetivo
    from unionmedidas m
) ,
r as (
    select *,
           (tproductividadhreal * vteoria / case when tipotiempoeficiencia = 'horas' then 60 else 1 end * eficienciaprodobjetivo) as cantidadobjetivoep,
           ((qtotalup - qscrapup) * ratioprincipalproductividad) as tproductividadhobjetivo,
           (tproduccion - tvelocidadreducida) as tprodvelocorrecta,
           case
               when tipotiempoeficiencia = 'minutos' then coalesce(qtotaluv / nullif(vteoria, 0), 0)
               when tipotiempoeficiencia = 'horas' then coalesce(qtotaluv / nullif(vteoria, 0) * 60, 0)
           end as tnetoreal,
           case
               when tipotiempoeficiencia = 'minutos' then coalesce(qtotaluv / nullif(vobjetivo, 0), 0)
               when tipotiempoeficiencia = 'horas' then coalesce(qtotaluv / nullif(vobjetivo, 0) * 60, 0)
           end as tnetoobjetivo,
           case
               when tipotiempoeficiencia = 'minutos' then coalesce(qscrapuv / nullif(vteoria, 0), 0)
               when tipotiempoeficiencia = 'horas' then coalesce(qscrapuv / nullif(vteoria, 0) * 60, 0)
           end as tnocalidad,
           (toperacional - tparoprogramado) as tproductivo,
           (tfallo + tparoprogramado) as ttotalparada,
           (tfallo + tparoexceso) as tparonoprogramado,
           (qtotalup - qscrapup) as qrealup,
           (qtotalus - qscrapus) as qrealus,
           (qtotaluv - qscrapuv) as qrealuv,
           (((toperacional * disponibilidadoperacionalobjetivo) * disponibilidadprodobjetivo) * pcvobjetivo * calidadobjetivo) as tefectivoobjetivooperacional,
           case
               when tipounidadproductividad = 'principal' then (qtotalup - qscrapup) * productividadestandar
               else (qtotalus - qscrapus) * productividadestandar
           end as tiempoestandarproductividad,
           case
               when tipotiempoproductividad = 'minutos' then tiemporealproductividadminutos
               else tiemporealproductividadminutos / 60
           end as tiemporealproductividad
    from t
),
s as (
    select r.*,
           (cantidadobjetivoep - qtotalup) as cantidadretrasoep,
           (tproductividadhobjetivo - tproductividadhreal) as tdiferenciahproductividad,
           (tnetoobjetivo * calidadobjetivo) as tefectivoobjetivo,
           (((tproductivo * disponibilidadprodobjetivo) * pcvobjetivo) * calidadobjetivo) as tefectivoobjetivoproductivo,
           tnetoobjetivo as tproduccionobjetivo,
           (tproduccion - tnetoreal) as ttotalmicroparos,
           ((tproduccion - tnetoreal) - tmicroparojustificado) as tmicroparonojustificado,
           (tnetoreal - tnocalidad) as tefectivo
    from r
),vbim as (
    select s.*,
           (tproduccionobjetivo / nullif(disponibilidadprodobjetivo, 0)) as tproductivoobjetivo,
           (tproduccionobjetivo / nullif(disponibilidadprodobjetivo, 0)) as toperacionalobjetivo,
           case
               when centrotipotiempoeficiencia = 'minutos' then tefectivoobjetivoproductivo * vteoria
               else tefectivoobjetivoproductivo * vteoria / 60
           end as qobjetivoproductivauv,
           case
               when centrotipotiempoeficiencia = 'minutos' then tefectivoobjetivooperacional * vteoria
               else tefectivoobjetivooperacional * vteoria / 60
           end as qobjetivooperacionaluv,
           (disponibilidadoperacionalobjetivo * disponibilidadprodobjetivo) as disponibilidadtotalobjetivo,
           case
               when centrotipotiempoeficiencia = 'minutos' then tefectivoobjetivoproductivo * vteoria
               else tefectivoobjetivoproductivo * vteoria / 60
           end / nullif(ratioprincipaleficiencia, 0) as qobjetivoproductivaup,
           case
               when centrotipotiempoeficiencia = 'minutos' then tefectivoobjetivooperacional * vteoria
               else tefectivoobjetivooperacional * vteoria / 60
           end / nullif(ratioprincipaleficiencia, 0) as qobjetivooperacionalup,
           up.nombre as unidadprincipalnombre,
           us.nombre as unidadsecundarianombre,
           uv.nombre as unidadvelocidadnombre,
           uprod.nombre as unidadproductividadnombre,
           ua.nombre as unidadauxiliarnombre,
           uv.id as unidadvelocidadid
    from s
        left join unidad up on up.id = s.unidadprincipalid
        left join unidad us on us.id = s.unidadsecundariaid
        left join unidad uv on uv.id = s.unidadeficienciaid
        left join unidad uprod on uprod.id = s.unidadproductividadid
        left join unidad ua on ua.id = s.unidadauxiliarid
),resultadovistaindicadores as (
    select vbim.medidafechainicio,
           vbim.medidafechafin,
           vbim.centroid,
           vbim.centroordenid,
           vbim.centroordencodigo,
           vbim.unidadprincipalid,
           vbim.unidadprincipalnombre,
           vbim.unidadsecundariaid,
           vbim.unidadsecundarianombre,
           vbim.unidadvelocidadid,
           vbim.unidadvelocidadnombre,
           vbim.unidadproductividadid,
           vbim.unidadproductividadnombre,
           vbim.tipotiempoproductividad,
           vbim.centrotipotiempoeficiencia,
           vbim.qrealup,
           vbim.qrealus,
           vbim.qrealuv,
           vbim.qscrapup,
           vbim.qscrapus,
           vbim.qscrapuv,
           vbim.qtotalup,
           vbim.qtotalus,
           vbim.qtotaluv,
           vbim.tmicroparojustificado,
           vbim.tparonoprogramado,
           vbim.tparoexceso,
           vbim.tfallo,
           vbim.tparoprogramado,
           vbim.ttotalparada,
           vbim.tnoplanificado,
           vbim.tproduccion,
           vbim.ttotal,
           vbim.tnetoreal,
           vbim.ttotalmicroparos,
           vbim.tmicroparonojustificado,
           vbim.tefectivo,
           vbim.tproductivoobjetivo,
           vbim.tproduccionobjetivo,
           vbim.tnetoobjetivo,
           vbim.tefectivoobjetivo,
           vbim.tefectivoobjetivooperacional,
           vbim.tefectivoobjetivoproductivo,
           vbim.tproductividadhobjetivo,
           vbim.tproductividadhreal,
           vbim.qobjetivooperacionalup,
           vbim.qobjetivoproductivaup,
           vbim.tvelocidadreducida,
           vbim.toperacional,
           vbim.tproductivo,
           vbim.productoid,
           vbim.turnoid,
           vbim.operarioresponsableid,
           vbim.productividadestandar,
           vbim.medidafechajornada,
           vbim.toperacionalobjetivo,
           vbim.ratioprincipaleficiencia,
           vbim.ratioprincipalsecundaria,
           vbim.estadoid,
           vbim.estadotipoid,
           vbim.estadonombre,
           vbim.estadotiponombre,
           vbim.tnooperativo,
           vbim.tnoplanificadoconocupacion,
           vbim.unidadauxiliarid,
           vbim.unidadauxiliarnombre,
           vbim.ratioprincipalauxiliar,
           vbim.tiemporealproductividadminutos,
           vbim.tiempoestandarproductividad,
           vbim.tiemporealproductividad
    from vbim
)
select c1.id                                                                                as centroid,
       coalesce(pl.id, 0)                                                                   as plantaid,
       coalesce(pl.nombre, '')                                                              as plantanombre,
       coalesce(a.id, 0)                                                                    as areaid,
       coalesce(a.nombre, '')                                                               as areanombre,
       coalesce(s.id, 0)                                                                    as seccionid,
       coalesce(s.nombre, '')                                                               as seccionnombre,
       coalesce(c1.nombre, '')                                                              as centronombre,
       coalesce(c1.conectado, false)                                                        as centroconectado,
       coalesce(c1.tipo, '')                                                                as centrotipo,
       coalesce(c1.tipo_fk, 0)                                                              as centrotipoid,
       coalesce(i.descripcionestados, '')                                                   as descripcionestados,
       coalesce(c1.gestionmanualestados, false)                                             as centrogestionmanualestados,
       coalesce(c1.tipocapturaestado, '')                                                   as centrotipocapturaestado,
       coalesce(c1.tipocapturaproduccion, '')                                               as centrotipocapturaproduccion,
       coalesce(c1.activo, false)                                                           as centroactivo,
       c1.centropadre_fk                                                                    as centrocentropadreid,
       coalesce(c1.vbleestadosesproductiva, false)                                          as variableestadosesproductiva,
       coalesce(u3.nombre, '')                                                              as unidadeficiencianombre,
       coalesce(est.id, 5)                                                                  as estadoactualid,
       coalesce(est.nombre, 'SIN ESTADO')                                                   as estadoactualnombre,
       coalesce(et_tipo.id, 5)                                                              as estadotipoid,
       coalesce(et_tipo.nombre, 'NO PLANIFICADO')                                           as estadotiponombre,
       coalesce(c1.centroordenactual_fk, 0)                                                 as centroordenid,
       coalesce(i.qrealup, 0)                                                               as cantidadproducida,
       u1.id                                                                                as unidadprincipalid,
       coalesce(u1.nombre, '')                                                              as unidadprincipalnombre,
       u4.id                                                                                as unidadauxiliarid,
       coalesce(u4.nombre, '')                                                              as unidadauxiliarnombre,
       u2.id                                                                                as unidadsecundariaid,
       coalesce(u2.nombre, '')                                                              as unidadsecundarianombre,
       coalesce(i.tproduccion, 0)                                                           as tiempoproduccion,
       coalesce(i.tvelocidadreducida, 0)                                                    as tvelocidadreducida,
       coalesce(i.tnoplanificado, 0)                                                        as tnoplanificado,
       coalesce(i.tfallo, 0)                                                                as tfallo,
       coalesce(i.tnoplanificadoconocupacion, 0)                                            as tnoplanificadoconocupacion,
       coalesce(i.tnooperativo, 0)                                                          as tnooperativo,
       coalesce(i.ttotal, 0)                                                                as tiempototal,
       coalesce(i.tefectivo, 0)                                                             as tefectivo,
       coalesce(i.tparoprogramado, 0)                                                       as tparorutinario,
       coalesce(i.tparoexceso, 0)                                                           as texceso,
       coalesce(i.tproductivo, 0)                                                           as tproductivo,
       coalesce(i.pcqobjetivo, 0)                                                           as calidadobjetivo,
       coalesce(i.pcqreal, 0)                                                               as calidadreal,
       coalesce(i.pcdisponibilidadtotalobjetivo, 0)                                         as doobjetivo,
       coalesce(i.oeeobjetivo, 0)                                                           as oeeobjetivo,
       coalesce(i.qtotalup, 0)                                                              as cantidadtotalproducida,
       coalesce(i.qtotalua, 0)                                                              as cantidadtotalproducidaauxiliar,
       coalesce(i.qrealup, 0)                                                               as cantidadtotalconforme,
       coalesce(i.qrealua, 0)                                                               as cantidadtotalconformeuauxiliar,
       coalesce(i.qscrapup, 0)                                                              as cantidadtotaldesechada,
       coalesce(i.qscrapua, 0)                                                              as cantidadtotaldesechadaauxiliar,
       coalesce((i.pcqreal - i.pcqobjetivo) * 100, 0)                                       as perdidacalidad,
       0                                                                                    as contadornotificaciones,
       coalesce(c1.tipotiempoeficiencia, '')                                                as tipotiempoeficiencia,
       coalesce(i.vobj, 0)                                                                  as velocidadobjetivo,
       coalesce(i.vobjuaux, 0)                                                              as velocidadobjetivoauxiliar,
       u3.id                                                                                as unidadeficienciaid,
       coalesce(u3.nombre, '')                                                              as unidadeficiencia,
       case
           when i.unidadproductividadid = i.unidadprincipalid then coalesce(i.tiemporealproductividad / nullif(i.qrealup, 0), 0)
           when i.unidadproductividadid = i.unidadsecundariaid then coalesce(i.tiemporealproductividad / nullif(i.qrealus, 0), 0)
           else coalesce(i.tiemporealproductividad / nullif(i.qrealuv, 0), 0)
           end                                                                                  as indicadorproductividad,
       coalesce(i.pcope, 0)                                                                 as epreal,
       coalesce(i.opeobjetivo, 0)                                                           as epobjetivo,
       coalesce(i.pcdisponibilidadproductiva, 0)                                            as disponibilidadproductiva,
       coalesce(i.pcdisponibilidadproductivaobjetivo, 0)                                    as dpobjetivo,
       coalesce(i.pcvreal, 0)                                                               as ratiovelocidadreal,
       coalesce(i.pcvobj, 0)                                                                as ratiovelocidadobjetivo,
       coalesce(i.vreal, 0)                                                                 as velocidadreal,
       coalesce(i.vrealuaux, 0)                                                             as velocidadrealuauxiliar,
       coalesce(i.ttotal, 0)                                                                as duraciontotal,
       coalesce(i.qrealupobjetivoproductiva, 0)                                             as cantidadobjetivoepunidadprincipal,
       coalesce((i.pcope - i.opeobjetivo) * 100, 0)                                         as difep,
       coalesce((i.pcdisponibilidadproductiva - i.pcdisponibilidadproductivaobjetivo) * 100, 0) as difdp,
       coalesce((i.pcqreal - i.pcqobjetivo) * 100, 0)                                       as difcalidad,
       coalesce(i.pcoee, 0)                                                                 as oeereal,
       coalesce((i.pcoee - i.oeeobjetivo) * 100, 0)                                         as difoee,
       coalesce((i.pcvreal - i.pcvobj) * 100, 0)                                            as difratiovelocidad,
       coalesce(i.tiemporealproductividad - i.tproductividadhobjetivo, 0)                   as difproductividad,
       coalesce(i.unidadproductividadtiempo, '')                                             as unidadproductividadtiempo,
       coalesce(i.unidadproductividadnombre, '')                                            as unidadproductividadnombre,
       coalesce(i.pcdisponibilidadtotal, 0)                                                 as disponibilidadoperacional,
       coalesce((i.pcdisponibilidadtotal - i.pcdisponibilidadtotalobjetivo) * 100, 0)       as difdoee,
       coalesce(i.qrealupobjetivooperacional, 0)                                            as cantidadobjetivooeunidadprincipal,
       coalesce(i.qrealuaobjetivooperacional, 0)                                            as cantidadobjetivooeunidadauxiliar,
       coalesce(i.tiemporealproductividad, 0)                                               as tproductividadhreal,
       coalesce(i.tproductividadhobjetivo, 0)                                               as tproductividadhobjetivo,
       coalesce(i.qrealup - i.qrealupobjetivoproductiva, 0)                                 as difcantidadep,
       coalesce(i.qrealup - i.qrealupobjetivooperacional, 0)                                as difcantidadoe,
       coalesce(i.qrealua - i.qrealuaobjetivoproductiva, 0)                                 as difcantidadepuauxiliar,
       coalesce(i.qrealua - i.qrealuaobjetivooperacional, 0)                                as difcantidadoeuauxiliar,
       coalesce(i.qrealus, 0)                                                               as cantidadrealunidadsecundaria,
       coalesce(i.qrealus - i.qrealupobjetivoproductiva, 0)                                 as difcantidadepunidadsecundaria,
       coalesce(i.tproductivo, 0)                                                           as tiempoproductivo,
       coalesce(i.toperacional, 0)                                                          as tiempooperacional,
       coalesce(i.qrealup, 0)                                                               as cantidadrealunidadprincipal,
       coalesce(i.tnoplanificado, 0)                                                        as tiemponoplanificado,
       coalesce(i.tiempoestandarproductividad, 0)                                           as tiempoestandarproductividad,
       coalesce(i.tiemporealproductividad, 0)                                               as tiemporealproductividad,
       coalesce(i.ratioproductividadestandar, 0)                                            as ratioproductividadestandar,
       coalesce(i.ratioproductividadreal, 0)                                                as ratioproductividadreal,
       coalesce(i.vreal - i.vobj, 0)                                                        as diferenciavelocidad,
       coalesce(i.diferenciahorasproductividad, 0)                                          as diferenciahorasproductividad,
       coalesce(i.centrotipotiempoeficiencia, '')                                            as centrotipotiempoeficiencia,
       c1.nsecuencia                                                                        as nsecuencia
from centro c1
         left join (
    with datosbase as (
        select min(vbi.medidafechainicio)                                                   as fechainicio,
               max(vbi.medidafechafin)                                                      as fechafin,
               vbi.centroid,
               c.nombre                                                                     as centronombre,
               vbi.productoid,
               p.nombre                                                                     as productonombre,
               (select string_agg(
                               concat(
                                       sub.estadotiponombre, ' ',
                                       sub.estadonombre, ' ',
                                       round(sub.total_minutos), 'min '
                               ),
                               '|' order by sub.estadotiponombre, sub.estadonombre
                       )
                from (
                         select vbi2.estadotiponombre,
                                vbi2.estadonombre,
                                sum(vbi2.ttotal) as total_minutos
                         from resultadovistaindicadores vbi2
                         where vbi2.estadotipoid in (3,4,5,6)
                           and vbi2.centroid = vbi.centroid
                           and vbi2.productoid = vbi.productoid
                         group by vbi2.estadotiponombre, vbi2.estadonombre
                     ) as sub
               )                                                                            as descripcionestados,
               sum(vbi.qobjetivooperacionalup)                                              as qobjetivooperacionalup,
               sum(vbi.qobjetivooperacionalup * vbi.ratioprincipalauxiliar)                as qobjetivooperacionalua,
               sum(vbi.qobjetivoproductivaup)                                               as qobjetivoproductivaup,
               sum(vbi.qobjetivoproductivaup * cp.ratioprincipalauxiliar)                  as qobjetivoproductivaua,
               max(vbi.productividadestandar)                                               as productividadestandar,
               max(vbi.tipotiempoproductividad)                                             as unidadproductividadtiempo,
               max(vbi.unidadprincipalid)                                                   as unidadprincipalid,
               max(vbi.unidadprincipalnombre)                                               as unidadprincipalnombre,
               max(vbi.unidadsecundariaid)                                                  as unidadsecundariaid,
               max(vbi.unidadsecundarianombre)                                              as unidadsecundarianombre,
               max(vbi.unidadvelocidadid)                                                   as unidadvelocidadid,
               max(vbi.unidadvelocidadnombre)                                               as unidadvelocidadnombre,
               max(vbi.unidadproductividadid)                                               as unidadproductividadid,
               max(vbi.unidadproductividadnombre)                                           as unidadproductividadnombre,
               max(vbi.unidadauxiliarid)                                                    as unidadauxiliarid,
               max(vbi.unidadauxiliarnombre)                                                as unidadauxiliarnombre,
               max(vbi.centrotipotiempoeficiencia)                                          as centrotipotiempoeficiencia,
               sum(vbi.qrealup)                                                             as qrealup,
               sum(vbi.qrealus)                                                             as qrealus,
               sum(vbi.qrealuv)                                                             as qrealuv,
               sum(vbi.qrealup * cp.ratioprincipalauxiliar)                                as qrealua,
               sum(vbi.qscrapup)                                                            as qscrapup,
               sum(vbi.qscrapup * cp.ratioprincipalauxiliar)                               as qscrapua,
               sum(vbi.qscrapus)                                                            as qscrapus,
               sum(vbi.qscrapuv)                                                            as qscrapuv,
               sum(vbi.qtotalup)                                                            as qtotalup,
               sum(vbi.qtotalup * vbi.ratioprincipalauxiliar)                              as qtotalua,
               sum(vbi.qtotalus)                                                            as qtotalus,
               sum(vbi.qtotaluv)                                                            as qtotaluv,
               sum(coalesce(vbi.tmicroparojustificado, 0))                                  as tmicroparojustificado,
               sum(vbi.tparonoprogramado)                                                   as tparonoprogramado,
               sum(vbi.tparoexceso)                                                         as tparoexceso,
               sum(vbi.tfallo)                                                              as tfallo,
               sum(vbi.tparoprogramado)                                                     as tparoprogramado,
               sum(vbi.ttotalparada)                                                        as ttotalparada,
               sum(vbi.tnoplanificado)                                                      as tnoplanificado,
               sum(vbi.tnoplanificadoconocupacion)                                          as tnoplanificadoconocupacion,
               sum(vbi.tnooperativo)                                                        as tnooperativo,
               sum(vbi.tproduccion)                                                         as tproduccion,
               sum(vbi.tvelocidadreducida)                                                  as tvelocidadreducida,
               sum(vbi.toperacional)                                                        as toperacional,
               sum(vbi.tproductivo)                                                         as tproductivo,
               sum(vbi.ttotal)                                                              as ttotal,
               sum(vbi.tnetoreal)                                                           as tnetoreal,
               sum(vbi.ttotalmicroparos)                                                    as ttotalmicroparos,
               greatest(sum(coalesce(vbi.tmicroparonojustificado, 0)), 0)                   as tmicroparonojustificado,
               sum(vbi.tefectivo)                                                           as tefectivo,
               sum(vbi.tproductivoobjetivo)                                                 as tproductivoobjetivo,
               sum(vbi.tproduccionobjetivo)                                                 as tproduccionobjetivo,
               sum(vbi.tnetoobjetivo)                                                       as tnetoobjetivo,
               sum(vbi.tefectivoobjetivo)                                                   as tefectivoobjetivo,
               sum(vbi.toperacionalobjetivo)                                                as toperacionalobjetivo,
               sum(vbi.tefectivoobjetivooperacional)                                        as tefectivoobjetivooperacional,
               sum(vbi.tefectivoobjetivoproductivo)                                         as tefectivoobjetivoproductivo,
               sum(vbi.tproductividadhobjetivo)                                             as tproductividadhobjetivo,
               sum(vbi.tproductividadhreal)                                                 as tproductividadhreal,
               sum(vbi.tiemporealproductividadminutos)                                      as tiemporealproductividadminutos,
               sum(vbi.tiempoestandarproductividad)                                         as tiempoestandarproductividad
        from resultadovistaindicadores vbi
                 left join centro c on vbi.centroid = c.id
                 left join producto p on vbi.productoid = p.id
                 left join turno t on vbi.turnoid = t.id
                 left join unidad up on vbi.unidadprincipalid = up.id
                 left join unidad us on vbi.unidadsecundariaid = us.id
                 left join unidad uprod on vbi.unidadproductividadid = uprod.id
                 left join centroorden co on vbi.centroordenid = co.id
                 left join centroproducto cp on co.centroproducto_fk = cp.id
        group by vbi.centroid, c.nombre, vbi.productoid, p.nombre, cp.id
    ),
         calculos as (
             select centroid,
                    centronombre,
                    unidadproductividadtiempo,
                    unidadprincipalid,
                    unidadprincipalnombre,
                    unidadsecundariaid,
                    unidadsecundarianombre,
                    unidadvelocidadid,
                    unidadvelocidadnombre,
                    unidadproductividadid,
                    unidadproductividadnombre,
                    unidadauxiliarid,
                    unidadauxiliarnombre,
                    centrotipotiempoeficiencia,
                    max(descripcionestados)                                                      as descripcionestados,
                    sum(db.qobjetivooperacionalup)                                               as qobjetivooperacionalup,
                    sum(db.qobjetivooperacionalua)                                               as qobjetivooperacionalua,
                    sum(db.qobjetivoproductivaup)                                                as qobjetivoproductivaup,
                    sum(db.qobjetivoproductivaua)                                                as qobjetivoproductivaua,
                    sum(db.qrealup)                                                              as qrealup,
                    sum(db.qrealua)                                                              as qrealua,
                    sum(db.qrealus)                                                              as qrealus,
                    sum(db.qrealuv)                                                              as qrealuv,
                    sum(db.qscrapup)                                                             as qscrapup,
                    sum(db.qscrapua)                                                             as qscrapua,
                    sum(db.qscrapus)                                                             as qscrapus,
                    sum(db.qscrapuv)                                                             as qscrapuv,
                    sum(db.qtotalup)                                                             as qtotalup,
                    sum(db.qtotalua)                                                             as qtotalua,
                    sum(db.qtotalus)                                                             as qtotalus,
                    sum(db.qtotaluv)                                                             as qtotaluv,
                    sum(coalesce(db.tmicroparojustificado, 0))                                   as tmicroparojustificado,
                    sum(db.tparonoprogramado)                                                    as tparonoprogramado,
                    sum(db.tparoexceso)                                                          as tparoexceso,
                    sum(db.tfallo)                                                               as tfallo,
                    sum(db.tparoprogramado)                                                      as tparoprogramado,
                    sum(db.ttotalparada)                                                         as ttotalparada,
                    sum(db.tnoplanificado)                                                       as tnoplanificado,
                    sum(db.tnoplanificadoconocupacion)                                           as tnoplanificadoconocupacion,
                    sum(db.tnooperativo)                                                         as tnooperativo,
                    sum(db.tproduccion)                                                          as tproduccion,
                    sum(db.tvelocidadreducida)                                                   as tvelocidadreducida,
                    sum(db.toperacional)                                                         as toperacional,
                    sum(db.tproductivo)                                                          as tproductivo,
                    sum(db.ttotal)                                                               as ttotal,
                    sum(db.tnetoreal)                                                            as tnetoreal,
                    sum(db.ttotalmicroparos)                                                     as ttotalmicroparos,
                    sum(db.tmicroparonojustificado)                                              as tmicroparonojustificado,
                    sum(db.tefectivo)                                                            as tefectivo,
                    sum(db.tproductivoobjetivo)                                                  as tproductivoobjetivo,
                    sum(db.tproduccionobjetivo)                                                  as tproduccionobjetivo,
                    sum(db.tnetoobjetivo)                                                        as tnetoobjetivo,
                    sum(db.tefectivoobjetivo)                                                    as tefectivoobjetivo,
                    sum(db.tefectivoobjetivooperacional)                                         as tefectivoobjetivooperacional,
                    sum(db.tefectivoobjetivoproductivo)                                          as tefectivoobjetivoproductivo,
                    sum(db.tproductividadhobjetivo)                                              as tproductividadhobjetivo,
                    sum(db.tproductividadhreal)                                                  as tiemporealproductividad,
                    coalesce(sum(db.tiemporealproductividadminutos), 0)                          as tiemporealproductividadminutos,
                    coalesce(sum(db.tnetoreal) / nullif(sum(db.tproduccion), 0), 0)              as pcvreal,
                    sum(db.tnetoreal - db.tefectivo)                                             as tnocalidad,
                    coalesce(sum(db.tefectivo) / nullif(sum(db.tnetoobjetivo), 0), 0)            as pcvobj,
                    coalesce(
                            sum(db.tnetoreal) / nullif(sum(db.tproduccion), 0) *
                            sum(db.qtotaluv) / nullif(sum(case when db.centrotipotiempoeficiencia = 'minutos' then db.tnetoreal else db.tnetoreal / 60 end), 0),
                            0
                    )                                                                            as vreal,
                    coalesce(
                            sum(db.tnetoreal) / nullif(sum(db.tproduccion), 0) *
                            sum(db.qtotalua) / nullif(sum(case when db.centrotipotiempoeficiencia = 'minutos' then db.tnetoreal else db.tnetoreal / 60 end), 0),
                            0
                    )                                                                            as vrealuaux,
                    coalesce(
                            sum(db.qtotaluv) / nullif(sum(case when db.centrotipotiempoeficiencia = 'minutos' then db.tproduccionobjetivo else db.tproduccionobjetivo / 60 end), 0),
                            0
                    )                                                                            as vobj,
                    coalesce(
                            sum(db.qtotalua) / nullif(sum(case when db.centrotipotiempoeficiencia = 'minutos' then db.tproduccionobjetivo else db.tproduccionobjetivo / 60 end), 0),
                            0
                    )                                                                            as vobjuaux,
                    sum(db.qobjetivooperacionalup)                                               as qrealupobjetivooperacional,
                    sum(db.qobjetivoproductivaup)                                                as qrealupobjetivoproductiva,
                    sum(db.qobjetivooperacionalua)                                               as qrealuaobjetivooperacional,
                    sum(db.qobjetivoproductivaua)                                                as qrealuaobjetivoproductiva,
                    coalesce(sum(db.qtotaluv) / nullif(sum(db.tnetoreal), 0), 0)                 as vteorica,
                    coalesce(sum(db.tproduccion) / nullif(sum(db.toperacional), 0), 0)           as pcdisponibilidadtotal,
                    coalesce(
                            sum(db.tproduccionobjetivo) / nullif(sum(db.toperacionalobjetivo), 0),
                            0
                    )                                                                            as pcdisponibilidadtotalobjetivo,
                    coalesce(sum(db.tproductivo) / nullif(sum(db.toperacional), 0), 0)           as pcdisponibilidadoperacional,
                    coalesce(
                            sum(db.tproductivoobjetivo) / nullif(sum(db.toperacionalobjetivo), 0),
                            0
                    )                                                                            as pcdisponibilidadoperacionalobjetivo,
                    coalesce(sum(db.tproduccion) / nullif(sum(db.tproductivo), 0), 0)            as pcdisponibilidadproductiva,
                    coalesce(
                            sum(db.tproduccionobjetivo) / nullif(sum(db.tproductivoobjetivo), 0),
                            0
                    )                                                                            as pcdisponibilidadproductivaobjetivo,
                    coalesce(sum(db.tefectivo) / nullif(sum(db.tnetoreal), 0), 0)                as pcqreal,
                    coalesce(sum(db.tefectivoobjetivo) / nullif(sum(db.tnetoobjetivo), 0), 0)    as pcqobjetivo,
                    coalesce(
                            sum(db.tproduccionobjetivo) / nullif(sum(case when db.unidadproductividadid = db.unidadprincipalid then db.qtotalup else db.qtotalus end), 0),
                            0
                    )                                                                            as productividadobjetivo,
                    coalesce(
                            sum(db.tproduccion) / nullif(sum(case when db.unidadproductividadid = db.unidadprincipalid then db.qtotalup else db.qtotalus end), 0),
                            0
                    )                                                                            as productividadreal,
                    coalesce(sum(db.tefectivo) / nullif(sum(db.toperacional), 0), 0)             as pcoee,
                    coalesce(sum(db.tefectivo) / nullif(sum(db.tproductivo), 0), 0)              as pcope,
                    coalesce(
                            sum(db.tefectivoobjetivooperacional) / nullif(sum(db.toperacional), 0),
                            0
                    )                                                                            as oeeobjetivo,
                    coalesce(
                            sum(db.tefectivoobjetivoproductivo) / nullif(sum(db.tproductivo), 0),
                            0
                    )                                                                            as opeobjetivo,
                    coalesce(sum(db.tefectivo) / nullif(sum(db.ttotal), 0), 0)                   as teep,
                    coalesce(sum(db.tiempoestandarproductividad), 0)                             as tiempoestandarproductividad
             from datosbase db
             group by db.centroid,
                      db.centronombre,
                      db.unidadproductividadtiempo,
                      db.unidadprincipalid,
                      db.unidadprincipalnombre,
                      db.unidadsecundariaid,
                      db.unidadsecundarianombre,
                      db.unidadvelocidadid,
                      db.unidadvelocidadnombre,
                      db.unidadproductividadid,
                      db.unidadproductividadnombre,
                      db.unidadauxiliarid,
                      db.unidadauxiliarnombre,
                      db.centrotipotiempoeficiencia
         )
    select f.*,
           f.tiempoestandarproductividad - f.tiemporealproductividad                        as diferenciahorasproductividad,
           case
               when f.qrealup > 0 then
                   case
                       when f.unidadproductividadnombre = f.unidadprincipalnombre then f.tiemporealproductividad / f.qrealup
                       when f.unidadproductividadnombre = f.unidadsecundarianombre then f.tiemporealproductividad / f.qrealus
                       end
               else 0
               end                                                                              as ratioproductividadreal,
           case
               when f.qrealup > 0 then
                   case
                       when f.unidadproductividadnombre = f.unidadprincipalnombre then f.tiempoestandarproductividad / f.qrealup
                       when f.unidadproductividadnombre = f.unidadsecundarianombre then f.tiempoestandarproductividad / f.qrealus
                       end
               else 0
               end                                                                              as ratioproductividadestandar
    from calculos f
) i on i.centroid = c1.id
         left join seccion s on s.id = c1.seccion_fk
         left join area a on s.area_fk = a.id
         left join planta pl on a.planta_fk = pl.id
         left join unidad u1 on c1.unidadprincipal_fk = u1.id
         left join unidad u2 on c1.unidadsecundaria_fk = u2.id
         left join unidad u3 on c1.unidadeficiencia_fk = u3.id
         left join unidad u4 on c1.unidadauxiliar_fk = u4.id
         left join estado est on est.id = c1.estadoactual_fk
         left join estadotipo et_tipo on et_tipo.id = est.tipo_fk
where c1.id = p_centro;
END;
$$;

alter function sp_getvbaseindicadoresmag(timestamp, timestamp, integer) owner to postgres;

create function calcularindicadores(fechainicio timestamp without time zone, fechafin timestamp without time zone, turno bigint, idusuario bigint)
    returns TABLE(plantaid bigint, planta character varying, areaid bigint, area character varying, seccionid bigint, seccion character varying, id bigint, nombre character varying, terminal bigint, conectado boolean, tipotiempoeficiencia character varying, vbleestadosesproductiva boolean, ratioconteoprincipal numeric, ratioprincipaldesechada numeric, ratioprincipaleficiencia numeric, ratioprincipalsecundaria numeric, estadoactual character varying, duracionmaxima numeric, estado bigint, estadotipo bigint, duraciongrupomedidas numeric, ordenactual character varying, codigoproducto character varying, nombreproducto character varying, centroproducto bigint, cantidadproducida numeric, cantidad numeric, unidad character varying, unidadsecundaria character varying, ccpendientes bigint, ratiounidadprincipalunidadproductividad numeric, totalttiempotrabajorreal numeric, productividadestandartiempo numeric, totalttiempotrabajoestandar numeric, prodestandar numeric, productividadestandarminutos numeric, cantidadordenturno numeric)
    language plpgsql
as
$$
BEGIN
RETURN QUERY

SELECT
    p.id                                                                            AS plantaid,
    p.nombre                                                                        AS planta,
    a.id                                                                            AS areaid,
    a.nombre                                                                        AS area,
    s.id                                                                            AS seccionid,
    s.nombre                                                                        AS seccion,
    c.id,
    c.nombre,
    ct.terminal_fk                                                                  AS terminal,
    c.conectado,
    c.tipotiempoeficiencia,
    c.vbleestadosesproductiva,
    cp.ratioconteoprincipal::numeric,
    cp.ratioprincipaldesechada::numeric,
    cp.ratioprincipaleficiencia::numeric,
    cp.ratioprincipalsecundaria::numeric,
    eactual.nombre                                                                  AS estadoactual,
    ce.tmaximo::numeric                                                             AS duracionmaxima,
    eactual.id                                                                      AS estado,
    eactual.tipo_fk                                                                 AS estadotipo,
    COALESCE(grupomedidas.duracion, 0)::numeric                                     AS duraciongrupomedidas,
    co.codigo                                                                       AS ordenactual,
    pr.codigo                                                                       AS codigoproducto,
    pr.nombre                                                                       AS nombreproducto,
    cp.id                                                                           AS centroproducto,
    co.cantidadproducida::numeric,
    co.cantidad::numeric,
    uprincipal.nombre                                                               AS unidad,
    usecundaria.nombre                                                              AS unidadsecundaria,
    COALESCE(cc.ccpendientes, 0)                                                    AS ccpendientes,
    CASE WHEN c.tipounidadproductividad <> 'secundaria'
             THEN 1.0
         ELSE cp.ratioprincipalsecundaria
        END::numeric                                                                   AS ratiounidadprincipalunidadproductividad,
    COALESCE(productividad.totalttiempotrabajorreal, 0)::numeric,
    SUM((COALESCE(cp.prodestandar, 0) * 60) * COALESCE(medidaestados.duracion, 0))::numeric AS productividadestandartiempo,
    (COALESCE(medidaproduccion.totalttiempotrabajoestandar, 0) -
     COALESCE(medidaproducciondesechada.totalttiempotrabajoestandar, 0))::numeric   AS totalttiempotrabajoestandar,
    cp.prodestandar::numeric,
    (cp.prodestandar * 60)::numeric                                                 AS productividadestandarminutos,
    COALESCE(ordenturno.cantidadordenturno, 0)::numeric                             AS cantidadordenturno

FROM centro c
         LEFT JOIN usuarioseccion us ON us.usuario_fk = idusuario
         LEFT JOIN seccion s ON c.seccion_fk = s.id
         LEFT JOIN area a ON s.area_fk = a.id
         LEFT JOIN planta p ON a.planta_fk = p.id
         LEFT JOIN centroorden co ON co.codigo = c.ordenactual
         LEFT JOIN centroproducto cp ON cp.id = co.centroproducto_fk
         LEFT JOIN producto pr ON pr.id = cp.producto_fk
         LEFT JOIN centroterminal ct ON ct.centro_fk = c.id

         LEFT JOIN (SELECT m.*
                    FROM medida m
                             JOIN (SELECT MAX(m1.ffin) AS fmax, m1.centroproducto_fk
                                   FROM medida m1
                                   WHERE m1.tipomedida = 'estados'
                                   GROUP BY m1.centroproducto_fk) maux
                                  ON m.tipomedida = 'estados'
                                      AND m.ffin = maux.fmax
                                      AND maux.centroproducto_fk = m.centroproducto_fk
                    ORDER BY ffin DESC, finicio DESC, id ASC) ultimamedidaestados
                   ON ultimamedidaestados.centroproducto_fk = cp.id

         LEFT JOIN (SELECT SUM(m.duracion) AS duracion, m.grupo, m.centroproducto_fk
                    FROM medida m
                    WHERE m.tipomedida = 'estados'
                      AND m.finicio >= fechainicio
                      AND m.finicio < fechafin
                    GROUP BY m.centroproducto_fk, m.grupo) grupomedidas
                   ON grupomedidas.grupo = ultimamedidaestados.grupo
                       AND grupomedidas.centroproducto_fk = cp.id

         LEFT JOIN unidad uprincipal ON uprincipal.id = c.unidadprincipal_fk
         LEFT JOIN unidad usecundaria ON usecundaria.id = c.unidadsecundaria_fk
         LEFT JOIN estado eactual ON c.estadoactual_fk = eactual.id
         LEFT JOIN centroestado ce ON ce.centro_fk = c.id AND ce.estado_fk = c.estadoactual_fk

         LEFT JOIN (SELECT COUNT(*) AS ccpendientes, cc.centro_fk
                    FROM calidadcontrol cc
                    WHERE cc.fechalanzamiento >= fechainicio
                      AND cc.estado = 0
                    GROUP BY cc.centro_fk) cc ON cc.centro_fk = c.id

         LEFT JOIN (SELECT
                        CASE WHEN c.tipounidadproductividad = 'secundaria'
                                 THEN SUM(COALESCE(mproduccion.valormedida, 0) * centroprod.ratioconteoprincipal *
                                          centroprod.ratioprincipalsecundaria * centroprod.prodestandar)
                             ELSE SUM(COALESCE(mproduccion.valormedida, 0) * centroprod.ratioconteoprincipal *
                                      centroprod.prodestandar)
                            END                AS totalttiempotrabajoestandar,
                        c.id               AS centroid,
                        MIN(mproduccion.ffin) AS ffin
                    FROM medida mproduccion
                             JOIN centroproducto centroprod ON centroprod.id = mproduccion.centroproducto_fk
                             JOIN centro c ON centroprod.centro_fk = c.id
                    WHERE mproduccion.tipomedida = 'produccion'
                      AND mproduccion.finicio >= fechainicio
                      AND mproduccion.finicio < fechafin
                    GROUP BY c.id, c.tipounidadproductividad) medidaproduccion
                   ON medidaproduccion.centroid = c.id

         LEFT JOIN (SELECT
                        CASE WHEN c.tipounidadproductividad = 'secundaria'
                                 THEN SUM(COALESCE(mproduccion.valormedida, 0) * centroprod.ratioconteoprincipal *
                                          centroprod.ratioprincipalsecundaria * centroprod.prodestandar)
                             ELSE SUM(COALESCE(mproduccion.valormedida, 0) * centroprod.ratioconteoprincipal *
                                      centroprod.prodestandar)
                            END                AS totalttiempotrabajoestandar,
                        c.id               AS centroid,
                        MIN(mproduccion.ffin) AS ffin
                    FROM medida mproduccion
                             JOIN centroproducto centroprod ON centroprod.id = mproduccion.centroproducto_fk
                             JOIN centro c ON centroprod.centro_fk = c.id
                    WHERE mproduccion.tipomedida = 'cantidaddesechada'
                      AND mproduccion.finicio BETWEEN fechainicio AND fechafin
                    GROUP BY c.id, c.tipounidadproductividad) medidaproducciondesechada
                   ON medidaproducciondesechada.centroid = c.id

         LEFT JOIN (SELECT c.id AS centroid, SUM(duracion) AS duracion
                    FROM medida medidaestados
                             JOIN centroproducto centroprod ON centroprod.id = medidaestados.centroproducto_fk
                             JOIN centro c ON centroprod.centro_fk = c.id
                    WHERE medidaestados.tipomedida = 'estados'
                      AND duracion > 0
                      AND medidaestados.finicio BETWEEN fechainicio AND fechafin
                    GROUP BY c.id) medidaestados ON medidaestados.centroid = c.id

         LEFT JOIN productividadmedidacentro pmc ON pmc.centro_fk = c.id
         LEFT JOIN productividadmedida pm ON pmc.medida_fk = pm.id
         LEFT JOIN estadooperario eo ON eo.id = pm.estado_fk

         LEFT JOIN (SELECT c.id AS centroid, e.id AS estadoid, e.tipo_fk AS tipo
                    FROM centroestado ce
                             LEFT JOIN estado e ON ce.estado_fk = e.id
                             LEFT JOIN centro c ON ce.centro_fk = c.id
                    WHERE e.tipo_fk = 2
                    GROUP BY c.id, e.id, e.tipo_fk) centroestado ON centroestado.centroid = c.id

         LEFT JOIN (SELECT prod.centroid,
                           prod.turnoid,
                           SUM(prod.tiempototalasignacion) AS totalttiempotrabajorreal
                    FROM (SELECT pmc.centro_fk                                                            AS centroid,
                                 pm.turno_fk                                                              AS turnoid,
                                 pm.operario_fk                                                           AS operarioid,
                                 pm.fechainicio                                                           AS fechainicio,
                                 COALESCE(CASE WHEN eo.tiempoproductivo THEN pmc.intensidad * 0.01 ELSE 0 END, 0) *
                                 COALESCE(CASE WHEN pm.cerrada
                                                   THEN pm.duracion
                                               ELSE EXTRACT(EPOCH FROM (LEAST(calcularindicadores.fechafin, NOW()) - pm.fechainicio)) / 60
                                              END, 0)                                                         AS tiempototalasignacion
                          FROM productividadmedidacentro pmc
                                   JOIN productividadmedida pm ON pm.id = pmc.medida_fk
                                   JOIN estadooperario eo ON eo.id = pm.estado_fk
                          WHERE pm.fechainicio >= calcularindicadores.fechainicio) prod
                    GROUP BY prod.centroid, prod.turnoid) productividad
                   ON productividad.centroid = c.id AND productividad.turnoid = turno
         LEFT JOIN (SELECT SUM(m.valormedida) AS cantidadordenturno,
                           m.centroorden_fk
                    FROM medida m
                    WHERE m.tipomedida = 'produccion'
                      AND m.turno_fk = calcularindicadores.turno
                      AND m.finicio < calcularindicadores.fechafin
                      AND m.ffin > calcularindicadores.fechainicio
                    GROUP BY m.centroorden_fk) ordenturno ON ordenturno.centroorden_fk = co.id
WHERE c.activo = true
  AND c.centropadre_fk IS NULL
  AND s.id = us.seccion_fk

GROUP BY c.nsecuencia, c.id, p.id, p.nombre, a.id, a.nombre, s.id, s.nombre,
         ct.terminal_fk, c.conectado, c.tipotiempoeficiencia, c.vbleestadosesproductiva,
         cp.ratioconteoprincipal, cp.ratioprincipaldesechada, cp.ratioprincipaleficiencia,
         cp.ratioprincipalsecundaria, eactual.nombre, ce.tmaximo, eactual.id, eactual.tipo_fk,
         grupomedidas.duracion, co.codigo, pr.codigo, pr.nombre, cp.id,
         co.cantidadproducida, co.cantidad, uprincipal.nombre, usecundaria.nombre,
         cc.ccpendientes, c.tipounidadproductividad, cp.prodestandar,
         productividad.totalttiempotrabajorreal, medidaproduccion.totalttiempotrabajoestandar,
         medidaproducciondesechada.totalttiempotrabajoestandar, medidaestados.duracion,
         medidaproduccion.ffin, medidaproducciondesechada.ffin, ordenturno.cantidadordenturno

ORDER BY p.id, a.id, s.id, c.nsecuencia, c.id, medidaproduccion.ffin, medidaproducciondesechada.ffin DESC;

END;
$$;

alter function calcularindicadores(timestamp, timestamp, bigint, bigint) owner to postgres;

create aggregate first(anyelement, "any") (
    sfunc = _timescaledb_functions.first_sfunc,
    stype = internal,
    finalfunc = _timescaledb_functions.bookend_finalfunc,
    finalfunc_extra,
    combinefunc = _timescaledb_functions.first_combinefunc,
    serialfunc = _timescaledb_functions.bookend_serializefunc,
    deserialfunc = _timescaledb_functions.bookend_deserializefunc,
    parallel = safe
    );

alter aggregate first(anyelement, "any") owner to postgres;

create aggregate last(anyelement, "any") (
    sfunc = _timescaledb_functions.last_sfunc,
    stype = internal,
    finalfunc = _timescaledb_functions.bookend_finalfunc,
    finalfunc_extra,
    combinefunc = _timescaledb_functions.last_combinefunc,
    serialfunc = _timescaledb_functions.bookend_serializefunc,
    deserialfunc = _timescaledb_functions.bookend_deserializefunc,
    parallel = safe
    );

alter aggregate last(anyelement, "any") owner to postgres;

create aggregate histogram(double precision, double precision, double precision, integer) (
    sfunc = _timescaledb_functions.hist_sfunc,
    stype = internal,
    finalfunc = _timescaledb_functions.hist_finalfunc,
    finalfunc_extra,
    combinefunc = _timescaledb_functions.hist_combinefunc,
    serialfunc = _timescaledb_functions.hist_serializefunc,
    deserialfunc = _timescaledb_functions.hist_deserializefunc,
    parallel = safe
    );

alter aggregate histogram(double precision, double precision, double precision, integer) owner to postgres;


