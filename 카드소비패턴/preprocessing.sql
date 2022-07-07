select *
from card.block_sex_age;

alter table card.block_sex_age change upjong upjong_cd text;
alter table card.block_sex_age change `기준년월(YM)` `ym` int;
alter table card.block_sex_age change `고객주소블록코드(BLOCK_CD)` `block` int;
alter table card.block_sex_age change `성별(GEDNER)` `gender` text;
alter table card.block_sex_age change `연령대별(AGE)` `age` text;
alter table card.block_sex_age change `카드이용금액계(AMT_CORR)` `amt_corr` int;
alter table card.block_sex_age change `카드이용건수계(USECT_CORR)` `usect_corr` int;

select *
from card.block_sex_age;

alter table card.block_sex_age change `block` `block_cd` int;

alter table card.code change `업종코드(UPJONG_CD)` `upjong_cd` text;
alter table card.code change `대분류(CLASS1)` `class1` text;
alter table card.code change `중분류(CLASS2)` `class2` text;
alter table card.code change `소분류(CLASS3)` `class3` text;

update card.code set upjong_cd= replace(upjong_cd, 'ss', 'SS');

select *
from card.code;
        
select *
from card.block_time;

alter table card.block_time change `서울시민업종코드(UPJONG_CD)` `upjong_cd` text;
alter table card.block_time change `기준년월(YM)` `ym` int;
alter table card.block_time change `시간대구간(TIME)` `time` text;
alter table card.block_time change `고객주소블록코드(BLOCK_CD)` `block_cd` int;
alter table card.block_time change `카드이용금액계(AMT_CORR)` `amt_corr` int;
alter table card.block_time change `소액결제건수(MICRO_PYM)` `micro_pym` int;

update card.block_time set time= replace(time, '0', '');

select *
from card.block_time;

select *
from card.agg_region;

alter table card.agg_region change `가맹점주소광역시도(SIDO)` sido text;
alter table card.agg_region change `가맹점주소시군구(SGG)` sgg text;
alter table card.agg_region change `업종대분류(UPJONG_CLASS1)` class text;
alter table card.agg_region change `기준일자(YMD)` ymd int;
alter table card.agg_region change `고객주소집계구별(TOT_REG_CD)` tot_reg_cd bigint;
alter table card.agg_region change `카드이용금액계(AMT_CORR)` amt_corr int;
alter table card.agg_region change `카드이용건수계(USECT_CORR)` usect_corr int;

select *
from card.agg_time;

alter table card.agg_time change `업종대분류(UPJONG_CLASS1)` class text;
alter table card.agg_time change `기준일자(YMD)` ymd int;
alter table card.agg_time change `시간대구간(TIME)` `time` int;
alter table card.agg_time change `고객주소집계구별(TOT_REG_CD)` tot_reg_cd bigint;
alter table card.agg_time change `카드이용금액계(AMT_CORR)` amt_corr int;
alter table card.agg_time change `카드이용건수계(USECT_CORR)` usect_corr int;

select *
from card.agg_time;