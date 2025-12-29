Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69750E8FDB1
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 10:32:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41100.1767004350592741691
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Dec 2025 02:32:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=X5P2hev0;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=CtItYI63;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTA8hmW3661000
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Dec 2025 10:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/1cTh443Fhxd/4IrW9AjSKdnxSE/eplKFGwYwcrcnEA=; b=X5P2hev0zidb2EDV
	oKLw6SnHmoz3hrcVOeCKOhaGLCn7t0vDPIYRjs8Is9Nt3Qn1pmmTAbLQkQA8BR6T
	pZYTgeLTKI00NcoVbtLGDIA1AqUowQnV5GyaMKVNbxK49Q0LX6ZNGGcH/37atIsZ
	psYLKn+Qkdf2CmZauvIdoRYxaH6ZMOda6mZhpRLEcAptlrs50tZLTBryoMEYYDLa
	xqlgbz2iNUM69h+oD1tDhWppI2m83BaJNgl/U7I9LzITCEtCvWKDHPT81oDZBTzB
	tTwmtbA4YDEniMUKYM23gx07IxrKGMB4kD6lZELjzk2yZYb7zF5ibABJO5DgJJEI
	pJhPCw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6sg4536-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Dec 2025 10:32:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1dea13d34so216588821cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Dec 2025 02:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767004349; x=1767609149; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1cTh443Fhxd/4IrW9AjSKdnxSE/eplKFGwYwcrcnEA=;
        b=CtItYI63U0DKgmm2HizY1v/AZTS2Pzvn5eiLdkygCY/h1Dl7g6oKqYIlSzrNHzMPOZ
         Gd5xTjpQEMIA882jHn8UA0/BCKVYEhe1Clmt7ofRbjuhDC8qnmACh3hiymtX37p+yzqN
         4EW0HAVeia9GjfXMrSV7ZvVjskLSyZZZTmXoKoJKn0uUAba3PSAN8alYNf8+lMaf7vk5
         tjTAB4lSWKvhTnfqIJVOouY4+pE7XE/EH9QtTF+YqMdX4fBty9RmeMRWCJF5Gv1X0hCp
         kkUxeAoP5hcWQgleH2bCGn0KqZWj6742+qkasP6H8tRRjdE8tCfdGM7sG1S/Zmd1168+
         Snzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767004349; x=1767609149;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1cTh443Fhxd/4IrW9AjSKdnxSE/eplKFGwYwcrcnEA=;
        b=UBR990ug3wqD1rCQHWHj1syZxi4d16KrI547YfOwFv6QMtB4+y429pFIzBH6vI0ii5
         KWStMkkqMXy43A5XsfFloFxmBNt+3eJD4rlNghMxeaIeGjkF5kWztg+tZM5BsumsHB27
         9p172INecLwnqUjdvqpzymR/osRW1+/ahZenf+V+CIZ8bpx9tl6c/V0pg0gQrGOrzxmr
         IKx5lj+A6J52fHYruHOegKYf3kSr+0NMdxKAlu42a4XQnkr7aTuI8xZlw/mKj5Xrg66j
         6B8sEhSvO7wpI/KRmOyiOrHI+wqjEKHjiixAFrHRqZsBHhib7ESHAoJP4VHcN32CcyTY
         3Qfw==
X-Gm-Message-State: AOJu0YxbUw+6an7COBaNDON1baGuQYNghTFORj3iOshCafjOneeYvfEK
	UaT1W+lFMTBP9eDB9hFbXYcmvyXb7RtrfJVdMdXHfBZf+cxCI8S8YggYr7TMJP/Au+6fb8jtWZ6
	DeLCp5KG/xFqaZcociQ0YUDXyZR1K+qFiDX6Zue4AJpVrj6AO1bBGyCMeGndNhY+dt4WRkEVQgT
	hVZVLvjwL9nRlPM9KoJgcjaHWu+4DW18qThPbB9YHYk1cj/33SheL0tqwVhZAZ
X-Gm-Gg: AY/fxX6qdBF3gP3z7WYrMWwnuFDZOwoYrVQj5og2yzKHklUZjXYYO9lmQPvtBovBYY4
	ZQaLTvLucsQ+zi59V4AHiE7stu6lrmjUe1zcBdi7c1SWUlP8IAk9xXRnr3YpHVQv0OJdZiMeZHL
	kA1g0HLKSMK9SFzN4LqEV0DItDY4Bxflqa6u5qcBdjus53fWSTzoDYRV/dnrGmKnv8
X-Received: by 2002:a05:622a:909:b0:4f3:4edc:5414 with SMTP id d75a77b69052e-4f4abcd2a29mr441420521cf.11.1767004348659;
        Mon, 29 Dec 2025 02:32:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH+C/16IElHxbXo2nLScovaRpMYjW215higpwjzMMtB85MT2ooTpRF3FxdeOR3X2w5lSYxSV2pzy1tZIPxEWA=
X-Received: by 2002:a05:622a:909:b0:4f3:4edc:5414 with SMTP id
 d75a77b69052e-4f4abcd2a29mr441420321cf.11.1767004348152; Mon, 29 Dec 2025
 02:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20251229093946.2776440-1-ruiqiang.hao@windriver.com>
In-Reply-To: <20251229093946.2776440-1-ruiqiang.hao@windriver.com>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 18:32:16 +0800
X-Gm-Features: AQt7F2pbW9CKsxb5qCEDSAxjGLul96W0QtYOUZWclKCJ8xZPjpTvrFxMpPRnFdk
Message-ID: <CA+s=J=wXCW+og+M-kTP3YmCPTEBgfRGH9P9BvYm_mJW4TQWUfw@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH] dpdk: rename recipe to match tag format
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: r_WsXaxZikqfSZcNNDxlkKpb970Lcut6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA5OCBTYWx0ZWRfX9TgstzxZemzO
 7o3pw186rDdcmXxUllh3d/orzBGYdeQuY8OdxzBZCrCG8Eoc3u16KaRbHKkWNwLB1SFwf/MoKHu
 K+ISZk/NS/xcXR9el52zG0kVzPaYXQUvGZ/da6ePBDgB3I6LONYeTAHg6Ik9Fx8NGj71+YqmIA9
 2ORYTLOklhmbj7ro/rOq+c/lxtatRFWmkX7JHA7CKajAdYifqxNJKevu/3/ZjpgnMy0+JaJL3j5
 /wA3cVaZ/xgc86jxq47f42E3wP7DA7JW8mGvIpvreAchRXqw1yLPxtUbChY+fDTKZxs3oGicYHz
 Fy6UaeL6cwSMnEcp6DkvQzEmkRTQPacK4cPppQDj70ITmF9zDp0bCe+65EmKCmM+ndp8y6fhTcU
 vY9krKeVhC9FZ0lOcpr+N+2cxagTjSENj3uQQtHVlEcgZ+L/Kwq/SfrATS87EJWcySiCKRxVw/h
 KxdqBAhv7gk9Tcf5ibQ==
X-Proofpoint-ORIG-GUID: r_WsXaxZikqfSZcNNDxlkKpb970Lcut6
X-Authority-Analysis: v=2.4 cv=Y+L1cxeN c=1 sm=1 tr=0 ts=695258bd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=EUspDBNiAAAA:8 a=tJDQK97-KnoCPbTjO1cA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_03,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290098
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Dec 2025 10:32:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2880

Sorry, not sure how it was missed in my testing. This makes the
version go backwards so please add PE=3D1 as well or remove tag=3D
validation for now and we can add it back later.

Thanks,

Anuj


On Mon, Dec 29, 2025 at 5:40=E2=80=AFPM Ruiqiang Hao via
lists.yoctoproject.org
<Ruiqiang.Hao=3Dwindriver.com@lists.yoctoproject.org> wrote:
>
> From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
>
> Rename dpdk_25.11.0.bb to dpdk_25.11.bb to align with v${PV}
> tag format and prevent fetch failures.
>
> Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
> ---
>  recipes-extended/dpdk/{dpdk_25.11.0.bb =3D> dpdk_25.11.bb} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename recipes-extended/dpdk/{dpdk_25.11.0.bb =3D> dpdk_25.11.bb} (100%)
>
> diff --git a/recipes-extended/dpdk/dpdk_25.11.0.bb b/recipes-extended/dpd=
k/dpdk_25.11.bb
> similarity index 100%
> rename from recipes-extended/dpdk/dpdk_25.11.0.bb
> rename to recipes-extended/dpdk/dpdk_25.11.bb
> --
> 2.46.2
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2879): https://lists.yoctoproject.org/g/yocto-patches=
/message/2879
> Mute This Topic: https://lists.yoctoproject.org/mt/116981995/3616702
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1321632=
3/3616702/1570666242/xyzzy [anuj.mittal@oss.qualcomm.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

