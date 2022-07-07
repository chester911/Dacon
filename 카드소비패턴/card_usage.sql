# 월별, 업종별, 연령대별, 성별 사용 금액, 이용자 수
select a.ym as 년월,
	b.class3 as 업종,
    a.age as 연령대,
    a.gender as 성별,
    a.amt as 사용금액,
    a.usect as 이용자수
from
(select ym,
	upjong_cd,
    age,
    gender,
    sum(amt_corr) as amt,
    sum(usect_corr) as usect
from card.block_sex_age
group by 1, 2, 3, 4
order by 1, 3) as a
	left join card.code as b
		on a.upjong_cd= b.upjong_cd;

# 성별 별 많이 이용한 업종
with gender_rnk as
(select a.ym,
	a.gender,
    b.class3,
    sum(a.usect_corr) as user_cnt,
    rank() over(partition by a.ym, a.gender order by sum(a.usect_corr) desc) as rnk
from card.block_sex_age as a
	left join card.code as b
		on a.upjong_cd= b.upjong_cd
group by 1, 2, 3
order by 1)

select ym as 년월,
	gender as 성별,
    class3 as 업종,
    user_cnt as 이용자수
from gender_rnk
where rnk= 1;

# 월별 시간대별 업종별 소액결제 금액, 소액결제 건수
select a.ym as 년월,
	a.time as 시간대,
    b.class3 as 업종,
    sum(amt_corr) as 소액결제금액,
    sum(micro_pym) as 소액결제건수
from card.block_time as a
	left join card.code as b
		on a.upjong_cd= b.upjong_cd
group by 1, 2, 3
order by 1, 2;

# 월별 시간대별 업종별 사용금액, 이용자 수
select substr(ymd, 1, 6) as 년월,
	time as 시간대,
    class as 업종,
    sum(amt_corr) as 사용금액,
    sum(usect_corr) as 이용자수
from card.agg_time
group by 1, 2, 3
order by 1, 2;

# 시간대별 이용자가 가장 많은 업종?
with usect_rnk as
(select ymd,
	time,
    class,
    sum(usect_corr) as usect,
    rank() over(partition by ymd, time order by sum(usect_corr) desc) as rnk
from card.agg_time
group by 1, 2, 3)

select ymd as 년월,
	time as 시간대, 
    class as 업종,
    usect as 이용자수
from usect_rnk
where rnk= 1;

# 이용자가 가장 많은 시간대 (월별)
with time_rnk as
(select substr(ymd, 1, 6) as ym,
	time,
    class,
    sum(usect_corr) as user_cnt,
    rank() over(partition by substr(ymd, 1, 6), time order by sum(usect_corr) desc) as rnk
from card.agg_time
group by 1, 2, 3)

select ym as 년월,
	time as 시간대,
    class as 업종,
    user_cnt as 이용자수
from time_rnk
where rnk= 1;

# 지역별 업종별 사용 금액, 이용자 수
select substr(ymd, 1, 6) as 년월,
	sido as 시도,
    sgg as `군/구`,
	class as 업종,
    sum(amt_corr) as 사용금액,
    sum(usect_corr) as 이용자수
from card.agg_region
group by 1, 2, 3, 4
order by 1;

# 업종별 이용자 수 1위 지역 (월별)
with monthly_rnk as
(select substr(ymd, 1, 6) as ym,
	class,
    sido,
    sgg,
    sum(usect_corr) as user_cnt,
    rank() over(partition by substr(ymd, 1, 6), class order by sum(usect_corr) desc) as rnk
from card.agg_region
group by 1, 2, 3, 4)

select ym as 년월,
	class as 업종,
    sido as 지역대분류,
    sgg as 지역소분류,
    user_cnt as 이용자수
from monthly_rnk
where rnk= 1;