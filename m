Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4CAD6406D
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 02:27:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4705.1765938458267216874
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 18:27:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Es/ZQmTO;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=UVurzfO/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGMQmb2990393
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 02:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g+QmAKRwDY6Jr+m3lkpWLyDLBS7FxhixJgWfRk+bQXc=; b=Es/ZQmTOep0h5S9E
	99ecqHcFQjznfJpBdO6tU+deZYFvNtAJ1dyKRt4ydZ5vK6lylEeMTuyn6PIwNgm9
	74mPbtBBNtYUGgmwcbfCco7IBurjtnWiiEuEcHnpWtcUgWpUUNBBHymuU2+UaIHX
	rlh+XnjslSX4erBpV4pybbsghVUBRqW4O1LhkPJvSHoRaTg9TJ9BiyMen0xm8wBe
	HncoqfGM+CNE+UwXw/8I+3hgSeIpoBREXa8ImnMxpxT7nRxPrKlF7ProPMqfrK93
	yAg6mOFmCcnG5KGufPrjm++yUvogIYrwWFybBeltxWCbGEKXD1RkVWBaTQwfHXRb
	XrXGjg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fefgmsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 02:27:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b234bae2a7so1169779085a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 18:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765938456; x=1766543256; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+QmAKRwDY6Jr+m3lkpWLyDLBS7FxhixJgWfRk+bQXc=;
        b=UVurzfO/zmN5ZsKahrwR4v/ArEEkjuZSemL+tXIQBQy3HaHdMtAJ/HBUFakZG9qie6
         Bcv0nsQ+ZJYm3+isjQw9yDTx6xgxeedMJMk9fozvS1PXMa1wZg7vIDeEvW3XhqgGoFbm
         DMSjLAL/j2rhWymSNz6iapHd6sEA0i/lnBcD+CTA9t99fmW4d0dctLvDVGAKavuQJhDV
         SqA/ETOXlM8MuAXY9nRp/ydGm2qk7YBxgHckTnG2f/SpxbErCZfSmRCTSxvFr4j2/kl5
         zq5fdbTr2e8Kgz6F35qyfqeizW5psFFEgHZduCM8ToCeCHXQm59/pYReVp8P2bknkeqi
         sCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765938456; x=1766543256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g+QmAKRwDY6Jr+m3lkpWLyDLBS7FxhixJgWfRk+bQXc=;
        b=f6xL3qcpMrfU5B6Nlt02SkHkHVJzVvoluBGY0amKAiFYX+/jHHUHB4tqBJ12CBk1nN
         lT0HmNGsikm+dtP5N1opqEnED2LWOD6TiDdi/UBR/qLg40XLkQkaCxfBVCt4sNpYSp3Z
         a2jlWkVD7PIbJe80eekBzRvt7qm6lRtkrv20BL6ho6Dwe6agp+3XNX5B7CnCgvLnlGYL
         VkuyvkNWeJDLfCElzIV0vPhRtwwLzn75Aa0CUzGPqpkhax6vN0sxeF/vVIFQiqSuFp0L
         lc9mBulv3wUbegXtpiBLpQPtiYlUSoNmk60dmoocFeVlRYswWRYRZsAr2x4MfsvCV4hM
         A72A==
X-Gm-Message-State: AOJu0YxteSB6OGuIRWZyQDwiiCp3h8VpBvMYf4hvNcm09+peNuMbRPOT
	tZTinb0kOeaFLAZl/iRtGY07FRR32KW50Cfq2mC9ncxVde4kNlj32P90NOApSwtV2lLN2+x77+/
	fC0suDybzMW+PjlzPLCEf8mmAf9DGVym+KtyTwKKpB6utnGHwpsM7/u4jrJRG5cL6DtP15uzegD
	9keLaVayyS998elsGPJppkmUvdQ0DFZhFbKPdJuZ5K5MDwDlFbAo6E
X-Gm-Gg: AY/fxX5W5SjX9o8kfnVdnLDKoVrVdXd7kXp9GOOclkNY5LCaYMtyEePFqmoXebhODIF
	mXQUI+kxQ1KK5P/XSuaqj6K4plr3oUvIafb5UspmKfhUZuVasTnIL3ERA+w1Y1KXbiedM4q0+Px
	dQmEo6SLW/0CCUJgIzEUj7gqQJJbRwbNWT0jO4HuvAd57ZQS61gjo+IH2zCko+iCtC
X-Received: by 2002:a05:620a:2989:b0:89f:5f63:68eb with SMTP id af79cd13be357-8bb3aed2fe5mr2024421685a.13.1765938456302;
        Tue, 16 Dec 2025 18:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgS/pCPvVg7R1B5V5mRlhfOCdQa3qcmWG1Y32wZmG0LB2lU54UggOCu6Ii7BMccO4s6PyrRpoY4GkLCzTfB8s=
X-Received: by 2002:a05:620a:2989:b0:89f:5f63:68eb with SMTP id
 af79cd13be357-8bb3aed2fe5mr2024419485a.13.1765938455761; Tue, 16 Dec 2025
 18:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20251216053630.512423-1-ruiqiang.hao@windriver.com>
In-Reply-To: <20251216053630.512423-1-ruiqiang.hao@windriver.com>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 10:27:24 +0800
X-Gm-Features: AQt7F2qYQICXKad_lT-w4kZ3EO2D-eSDVzwkuuUXdT0_0DD-It_rQTWCvnaNCzQ
Message-ID: <CA+s=J=xZTZjJTHcj_SdK93U1U9+u+=RSsRWKzgDiEcX6TiUmag@mail.gmail.com>
Subject: Re: [meta-dpdk][PATCH v2] dpdk: upgrade 23.11.1 -> 25.11.0
To: Ruiqiang Hao <ruiqiang.hao@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDAxOCBTYWx0ZWRfX+BkPkX/1nZZg
 JVctYbn5EjMI3apuG2VDe5R0qhWIfphvvscY/yjY+/6tyCtvfrIjk2Y+qMVUSAC97Dvz/IveKUq
 b4yZVDLn78Vaghvgq9AgdIam7hQQ7CLfzDGjvIQwBVDe9UQ5pId4++0+/oCym9K7XgtEN6not/9
 YHiqakbN6fwcKEmGEjGh0gYU5xO9bp5ZizBRRRA6wpa66tAstmGPeiPKWozE7QYj6dCI6mnGFxG
 dwlWUvFhckJQ//zIHBnVnDzIxVgpDuPcsa+8W+YG7vohUxo+yah4SEuTh3E3AYyxQKyijcjBq8j
 lnlvczOKBTBsz2aWlv4PfCby94wJt4E3lT2O2raYfnZi3xugNKDCQnCXNgRWSOWxvTGvh7EszXV
 oC/2r8YlzAlfGYjhhTh/vELmTLJCYw==
X-Proofpoint-ORIG-GUID: t_A8XzFZ7Cd93C9bMLo2LmJ-mLshqqLc
X-Proofpoint-GUID: t_A8XzFZ7Cd93C9bMLo2LmJ-mLshqqLc
X-Authority-Analysis: v=2.4 cv=R48O2NRX c=1 sm=1 tr=0 ts=69421519 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8rWy6zfcAAAA:8 a=t7CeM3EgAAAA:8
 a=vWwdD01V-RSNx6d4aqYA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170018
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 02:27:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2806

Hi Ruiqiang

On Tue, Dec 16, 2025 at 1:36=E2=80=AFPM Ruiqiang Hao <ruiqiang.hao@windrive=
r.com> wrote:
>
> From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
>
> Upgrade to DPDK 25.11 LTS release.
>
> - Remove patches that are no longer needed in 25.11.0:
>   * 0001-Add-new-tracepoint-function-for-type-time_t.patch
>   * 0001-net-gve-base-fix-build-with-Fedora.patch
>   * 0001-net-ionic-fix-build-with-Fedora.patch
> - Update library path from pmds-24.0 to pmds-26.0
> - Update SRCREV and branch references
>
> Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
> ---
>  ...-tracepoint-function-for-type-time_t.patch | 114 ------------------
>  ...1-net-gve-base-fix-build-with-Fedora.patch |  95 ---------------
>  ...0001-net-ionic-fix-build-with-Fedora.patch |  65 ----------
>  .../dpdk/{dpdk_23.11.1.bb =3D> dpdk_25.11.0.bb} |  12 +-

Please remove the older 22.11 recipe instead which will reach end of
life next month. In case you haven't seen:

https://core.dpdk.org/roadmap/

...

> -BRANCH =3D "23.11"
> -SRCREV =3D "a6ec5765cf83d3d58cbd6d4ed5b92b4a06f8a808"
> +BRANCH =3D "v25.11"
> +SRCREV =3D "ed957165eadbe60a47d5ec223578cdd1c13d0bd9"
> +S =3D "${WORKDIR}/git"
>

This assignment shouldn't be needed.

