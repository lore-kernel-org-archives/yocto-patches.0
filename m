Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFDD5E14A
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 12:50:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21641.1765889450897064561
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 04:50:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=HGxLGB/r;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Urzdb4hJ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGBvDkF2810486
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 12:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+gfet/EqfiUfAJvEcNQCm6JwzOUSWNDej4fOIy38vgA=; b=HGxLGB/r1fMSxeTn
	L4/k4BaIMUQW6klsovUybrTWfNt5fUzNll1jSD6ycqz1FurpETQMIbzkfX+Y2+VG
	Zpw0zEjuvMv/ADatBZxaI5gcBuCQm+U/nd01TIriqc8DyxYT3QHUZDyUOOdzs/mV
	cHNV6wngG3Nyt3yOiT+blF0XcHu1YMQrnv+zvBxMoDW5uIsNJHqdXSYGaHW6A2Q7
	iSwKp68pmm5rvIrOoxQfphl8bysZS7x4+rCwbGEjkLPSa6zteg/z7+PoLl+X2qLC
	BAZx3k+GPvByKH7MD9PGLL220qitKLZqIMgY7tdGTNZ7jciwgucUjhyOp8nSU8Yl
	GE19yw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b32gasdce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 12:50:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee0c1c57bcso167159061cf.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 04:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765889449; x=1766494249; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gfet/EqfiUfAJvEcNQCm6JwzOUSWNDej4fOIy38vgA=;
        b=Urzdb4hJUz8b8GFliSZ/Kuove0MvSJ2Er0jvLKjWEW1Cp39i5ZtCXKmp5ztUcRmDTP
         jhqNYyGeAVqhydtCJutQOGhlUX5CsUqCqK3MumFJ8YrZL2KwbeOQMI0b9If08k9q1KNv
         8p6BOPz2zHqQCq/k5ftMnJrMA1zxC8tmNlxFhZyEuiXfAU11F50IRgrOzhoyPIZfio7P
         YVzi1RDJtoNXKD3HZ3aMayRhdzNu3XvTMdE9dAEmB9fYgFmSB0GO1zSCWXLhkwaHHoMp
         IsaoZaYokYfpJeuPJ+PCQVSIEsuKThc2Ikgn63cAoOtMbwQEYqKELb5/ilG43gdgvlcw
         Kx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889449; x=1766494249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gfet/EqfiUfAJvEcNQCm6JwzOUSWNDej4fOIy38vgA=;
        b=i0TjjQkpH7ZyRManoW9MaqxopKYzaonGR99bZet0Olb0jNaOqG/TJCpCKzXFKdKSNl
         P55pHvHY+05T+POnS8kwSfRIxMqTkS7JCHSqt+T5zd79uRrTkT6UjlwnCifoT+cDH8iR
         4Od7EFyovdIcy3xR2F0Iaqk60m/jVr8MI2Rsd/j7Q2pTsIhWGDVoPRvyXoNn6m7GkGRt
         fnrU5f75E8uvOJvcUCL8bYJyggpC6twa/ZBc1pIqmo/8yRdhE2ckuE1QSPZi8Udhi9DP
         GfBsXZ0fo7g9E3A9f1TpSr6OtFzkF3wN7E0NNIKXilHRa2pOfKeFOBjrXegafVornhH+
         0ahg==
X-Gm-Message-State: AOJu0Yy1ZKMJgX208ijOcJRXq7LHNON8RGB09Dk7IsXBPNZe6i6d+igc
	/h9XoWbcqohP22k/mserb3WPBdwMlZgrHqwkOvb3P8AvGirO+dkP6eBX1UzxwpDvyOavIOtrfgH
	SXNsai6bDKpp9merALbygnPUOXWfz+Pk3QDrih772r9KtVehYVHSOosy7xPJHpz+iqv1Lu0b4fg
	31MPpAdXWB5ZVToUq6foQqeE5+DwhbsuXp/jaaJ3ggoFRCDq8HbKh7iOEslDCpl3I=
X-Gm-Gg: AY/fxX5EagwbnVc6TBCa4h0dZcjMZnzmDpZaQKU3MfSL+sJqzDa4jE+CzSR46KqHjkP
	NUaZ2jSL3fWxyTBRF8UU+AAUdz3zY84ChNJ20FK02MOJ2/xKm7bM9q1Bb7/1zXE+xK3rEnhu/YK
	/O9UfOp3Q3A/JuRUbcbnncARhSbDqpRRxVvgs/dRygDQa1WK2z2S1ZJRAvxc6i58nV
X-Received: by 2002:a05:622a:8c8:b0:4ee:19f2:9f1b with SMTP id d75a77b69052e-4f1d04fe751mr192867531cf.37.1765889449359;
        Tue, 16 Dec 2025 04:50:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD07XUkcTBJa0SsqynsfMDYnjRsTcfJTEBngC9Tu75iq/xfD7rQIsHu6M4ygZy7RFNjvfNpuG/G92szrZK0cQ=
X-Received: by 2002:a05:6214:3f8d:b0:88a:4ab2:5f52 with SMTP id
 6a1803df08f44-88a4ab26055mr15967256d6.51.1765889112147; Tue, 16 Dec 2025
 04:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20251210024150.379272-1-anuj.mittal@oss.qualcomm.com> <a59d61cd0637cbc09b44cdaf2044b15ca550ad3d.camel@pbarker.dev>
In-Reply-To: <a59d61cd0637cbc09b44cdaf2044b15ca550ad3d.camel@pbarker.dev>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 20:45:00 +0800
X-Gm-Features: AQt7F2ovrav2Fnf4LNiMQsBR4DI5urBX7CEAZg0BOVEgxHVp37nYEkXZ4KQCSTE
Message-ID: <CA+s=J=yfW49FP_M+98-D2f6RV7bEob-0ScqNXXr26ZgDiOOBnQ@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] config.py: add
 meta-qcom to layers to be built
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org, nicolas.dechesne@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Vcb6/Vp9 c=1 sm=1 tr=0 ts=694155aa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=foCVyA4svL5jPZxvdroA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 2ZGL0cJygvYdLROppAfWkaZQIukXEI5g
X-Proofpoint-ORIG-GUID: 2ZGL0cJygvYdLROppAfWkaZQIukXEI5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwOSBTYWx0ZWRfX2TM8Gr4LeFGC
 iaOGuWgjd+5zsyyBOeiCKDTBnFAramDSvb/IsvIsleZmzIGXDqxPGtVCBYuNX2ePJvidQPXmJU4
 5PNsebp1w1ijmZUAeZkCaC9NMIfBqfM4lPhECu/fqyvz/QVHAaytIZA7DCDvjJ01Q15wCuH3BDj
 fo20OoyhAQEM6PY6V0GIl8SN4IutJAhZwxzNrUyONYlcqfvmgFWM4dUCMorCVH5ILQtzGMVhNrR
 1gmfa1g4YQhsC697hTNFj16dMpFgcGFMBu25qCCmnHYxDgWLeW2HuoNKWzNBlmjmyOGBGk01iUx
 /0k439Wt7GBZRHtUI6O8ydpwVuoFwm2rnuzQkBTdX42qA1+tvCnxptTWmB0XkoNku2v/RFKcV7W
 xBWtvv7by31eHP5WaitpwWUTeqVzsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160109
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 12:50:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2802

On Tue, Dec 16, 2025 at 6:35=E2=80=AFPM Paul Barker <paul@pbarker.dev> wrot=
e:
> This patch was discussed in the TSC call yesterday. We need to make this
> change in two stages:
>
> 1) Add meta-qcom as an individually triggered build.
>
> 2) Once this is confirmed working, add it to the a-full build set with a
>    follow up patch.
>
> Could you re-send just the changes for (1)? So, no changes to
> buildertorepos["a-full"] or trigger_builders_wait_full yet.
>

Thank you, I've sent v2 with these changes.

Thanks,

Anuj

