Return-Path: <dmitry.baryshkov@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28AECD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 10:31:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16665.1781778704051964267
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 03:31:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=dUMzP2P7;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Fv8vgzvA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8x8Jj722837
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 10:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rGuYWVLyc9c3kKR4o02V6iUow3UqGTDIognZa629rsE=; b=dUMzP2P7OYx9Amtq
	wHJjgJ+9JBknA7Pedtyt8496XxgKjQVTs1dY57+1JthHiuXz0RFQnSfS0G9Gim1G
	r+O+OLV0fa4Q2YBCJ6eSWcXL7fgsvEyuI43XGJKtl1UiQTQ5lj6Ri7QsKWMWXeKO
	L4F82mCAQmyWIHuuDHKfRoQlwWiAO+wyrkj/ODTI+j51F0oyFxy2ooGGndNm58Dm
	BPastJumxhDGvHoSNOInYJKDxHVL7YPxiRBqiC1sNWfYYrVGUF7GYzYybTDZSWA6
	6GAf31TwU63QaKu+NQB5EKZeqO5SWc90nPSs7eSPOPnMxMhS8WKt91NRSb5UdZp2
	86lS9w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn40ahp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 10:31:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso19675945ad.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 03:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781778702; cv=none;
        d=google.com; s=arc-20240605;
        b=cJBnNH8BN7Hy4Jqkg38ZeED3Wery6fjdglgzWd3oLNfTUFUkn5s/OuhJY/tNdPRrwr
         9EyQKMLVFejFWCekZyM2ppc0LXYY/l2uBe+r3hXFGqgk5qgHURgpHNpxFdf5mRsT/jnt
         Vf72BXUZ6FBNCVt0hkL71o0Gy6jTb7vyhd0vlkz+xOkcGKQYyE3Uit7scmj4NMPgrYfT
         hjo5JKvlvX8hTuOboN5C/sgFi01iNXIPzb/nERjImc34pI1NAvKkQEMmk6r13syWGeTE
         hbf477j8gH2jHaht4Zp9JtmCHFcUFMSDHB0yUdjRl1rEWEItzbUg+7NeV6s8F3nHqy2d
         nxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rGuYWVLyc9c3kKR4o02V6iUow3UqGTDIognZa629rsE=;
        fh=lLY5HJalhLS6XP1Wm/shaH8M8Uf3V5MyLV0cg5w9c/g=;
        b=Uc9p+ExXfjicJ9JkSWiyZ6q5nziTu5zsHSZkrqpUzywwOhrRWIkt2A7cm3vjqjOmvl
         tmKDiro4E2F6qdCvC0UZpT5wXypH4cM1kdoXDIys+0P9IijPDR+I3fEH4Hdr0CYE67hX
         uNizSnH1+H4/gq3JWtPjq3TIb/97CJBwZuhHESK3dq40b/M/eD9x7Jht/C80VN+8P5CW
         Imgb4tNcOBI4dyxGs753G90ka+pjl7Fe+sHDtwws8muEgBH8X/wL0on2SRvuGY0ekG/V
         TZDnwKTMNGrq25p+11T0atBkXXooC1gC2EkU6vv5V6dfk8fxFdLqux1L0aEviTQqu/OD
         X3hQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781778702; x=1782383502; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGuYWVLyc9c3kKR4o02V6iUow3UqGTDIognZa629rsE=;
        b=Fv8vgzvA+JpZnxgPxXJuXnM3wEEZTlXkMyydyW5JT/LPF3n+5xmu/097pdnUIpkJ9n
         rPuWoHEq0O3dLOqTX1LH69Lt29xE0vbx57BJOE0j6gS/+IQm/dZim6TEApLmSXALMkYi
         jzYbhP0d4+JloIpSHVHWOyjBL9oqRybBJ8EPRDRwivAmOkdf9/k12GdmpF96LwshGClL
         Dw+mex8nO2g5I02waqagFuucLjhuVsFwa9GJFZq1uNgDCNCw3Wve0iM/fbzgFxicjDy0
         AZ/hhylqbGZGWxpbqbkXpqbsmm7q3yP4DeLboRyvPbgVjCAveam3TSAzyfRpCK9Bfq7Y
         UYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778702; x=1782383502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGuYWVLyc9c3kKR4o02V6iUow3UqGTDIognZa629rsE=;
        b=XCPiFgziPppfCi74Ti5mmO1EYJJCuP45u9JVVegHYYLzQoHIiUagkf2BBM8VxaDxRv
         LwDYyF1Q5PtNIt8EPBBYVl1mXexEfpHnz+4j+CBdUrR8df9diglSh68vmvwzpE5lYtWc
         n61gfdvYplWLwYoSopp90cTcvYqjSWekDXtfpK6TS6upX0GmzA2pKOEGh/saAcayowYO
         dQdLNf4cS0aneqsngHtK8pr/o5/bqd3yl/mUidCT8m8gz962YlI2u6FZCiEwMJYv810B
         SeM1er0eclRh/2Tw47zvqPdwswEHP9Z0s6gn7EU7x3xP0bmTf/f2gUMSERDHeQ9ceTeI
         MJLA==
X-Gm-Message-State: AOJu0Yxu2CE+kQOU+Py206rwZgVkIkQd+qXTEZIQDGoCwPL3XicznWOs
	9JTyd3Sdc9y8lkCiyl2m4/9XazRkJKYdmJB+2RhL8aqFPNhl9ijSEybvGP0gdjRDeZoOAeB4G69
	bueXGIwaQfS5ho6rVWs2BLvnjJtJ7QfKApfuvC/0nWUkgxBHq8AzzlMkerHz3s7z669vBlEGUI9
	LL6dRhD8Of8SH2N4/XWgg+w/oqBH5zVlmLF6msSPYIn7peS8whaBx6
X-Gm-Gg: AfdE7cmf/jKftx0S7zkzqxJhRN25Ima/Htk6DwHlIzLMQNARMU0ViJ60ZNzZzWT/dLt
	Mi/1ThVeP3Q6blfJ6X4SPXegMgNqERWFqPblzbzP5kn2ME4TZGpLYGUkfeg6I5Q/JIlZ3MTMuFB
	nKZy6rklXxizrdedmz1BZ+/symfYpsgN99XksiDL1ksrup13KikIZwE3N7Ei1D0Banir8+zPEIi
	vUHCF1coWvN29qOgjGLp+/KWaNqpQ==
X-Received: by 2002:a17:903:244c:b0:2c0:c262:b91f with SMTP id d9443c01a7336-2c6bbf8e9efmr88450755ad.8.1781778702332;
        Thu, 18 Jun 2026 03:31:42 -0700 (PDT)
X-Received: by 2002:a17:903:244c:b0:2c0:c262:b91f with SMTP id
 d9443c01a7336-2c6bbf8e9efmr88450335ad.8.1781778701831; Thu, 18 Jun 2026
 03:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
 <20260617-fix-check-layers-v1-2-d1b60c899440@oss.qualcomm.com> <CADWMC-ao_--=gUSFnQnqvpN=yXOR+Cc9XuJOum39DfJrr30ZKA@mail.gmail.com>
In-Reply-To: <CADWMC-ao_--=gUSFnQnqvpN=yXOR+Cc9XuJOum39DfJrr30ZKA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 13:31:29 +0300
X-Gm-Features: AVVi8CcwldaUSwW_26PXtAbLZ_1WS0yN1t2g8xM-mo0l2OUKaKJkA01MUGYbEgE
Message-ID: <CAO9ioeX6kqfTDyks2DVooEuvN8G08N_BkBg=LKR2N0kyF=FTBw@mail.gmail.com>
Subject: Re: [meta-lts-mixins][wrynose/linux-firmware][PATCH 2/3]
 linux-firmware: set DEFAULT_PREFERENCE to "-1"
To: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Cc: yocto-patches@lists.yoctoproject.org,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5NyBTYWx0ZWRfX7FQ+baDPr8Ky
 NAYzEwLjhVTQAqSqceymWMBWVeRzA7kxVdyt0i0p6C/6pGNXztAmACtE7SlFP1T6yCcf2eDVaiM
 50Fi5IkxiF2Slfz5nDA+8rK7XnhbZ2Xx6R+/O4sFdpOuJ/fmCBcG7E0ekq5RfnWcyiMGnT52isF
 xxHh2LQ6B4mb0ezejAgqAElUA9iDjkcp+JPVyqCdJu5fZnE3kCgkbzIXW1nj6ukVGkrCBbSZwKF
 TR66OOM6y+hrrQ70jktcWjR8jEn+ynoWlzvOhQ2nCvzd4mpRPqQE+76IEWxyQttjs3181HSznHZ
 prmsfeJXAZqVIXedHDM/GGKNDIY0TsE4jHYTPIvow27irIyPwJrlE78FHK5i0ROBcMkJkkjmyk6
 dFX385ksx2RbPaFF39GaCpU0Pvinij+HOfclTth1Trjdj+1eBuWH2VLVkNJlAWsEnXLyTA1nH+W
 AhhEHn/g60VvXcXih1g==
X-Proofpoint-ORIG-GUID: 3w8ggkjbJr_yi-T8gEeRUsHdXxPQ2qQW
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a33c90f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=aQvQJF7sLOEGS1KjRxIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 3w8ggkjbJr_yi-T8gEeRUsHdXxPQ2qQW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5NyBTYWx0ZWRfXwSCQIQH+nTH3
 0l13J+hJJIvrtCxY4ncDlW76eVzJd6apc9jKG50+FK1cdIcR5vb2YSTZ420ngAolRxlputPJy+i
 x4186nOCnlRAGUjb3D5HObeitVoUbkE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180097
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 10:31:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4240

On Thu, 18 Jun 2026 at 13:29, Jose Quaresma
<jose.quaresma@oss.qualcomm.com> wrote:
>
> Hi Dmitry,
>
> On Wed, Jun 17, 2026 at 8:21=E2=80=AFPM Dmitry Baryshkov <dmitry.baryshko=
v@oss.qualcomm.com> wrote:
>>
>> In order to make this layer Yocto Project Compatible, the layer should
>> not provide new versions of packages by default. The easiest way to
>> achieve it is to set DEFAULT_PREFERENCE to "-1" for the new versions of
>> the recipes.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>  recipes-kernel/linux-firmware/linux-firmware_20260519.bb | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb b/=
recipes-kernel/linux-firmware/linux-firmware_20260519.bb
>> index 7eb9bf35fbe3..f2cd8737f253 100644
>> --- a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
>> +++ b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
>> @@ -3692,3 +3692,6 @@ INSANE_SKIP:${PN} =3D "already-stripped"
>>
>>  # No need to put firmware into the sysroot
>>  SYSROOT_DIRS_IGNORE +=3D "${firmwaredir}"
>> +
>> +# Don't prefer it by default
>> +DEFAULT_PREFERENCE =3D "-1"
>
>
> With this change this recipe will no longer be used by layer users.
> Until now, to use the provided linux-firmware recipe, all you had to do w=
as add the layer.
>
> I would prefer to continue having something similar where no additional c=
onfiguration
> is needed to use this layer.

This exactly contradicts with the Yocto Project Compatibility
requirements. The layer should not be changing the default
configuration.

--=20
With best wishes
Dmitry

