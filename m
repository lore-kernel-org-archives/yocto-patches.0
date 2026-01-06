Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6299C47BE0
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:35:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.87297.1767695719727129895
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Jan 2026 02:35:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=HJ+Yp9Ul;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=RZyWYatF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6066tXv83295997
	for <yocto-patches@lists.yoctoproject.org>; Tue, 6 Jan 2026 10:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7t6v47LnI7OxQy9keHMDeaCQBCt0ft012ztrgPObOHI=; b=HJ+Yp9UlMK2LaGHP
	XAaamkscV4rUsBLo+qUsMbW2/FwxZ+Mhkz+V3rbFAYlUtmL7d/yVj1I2/jGcdFiM
	dV373FfH9p3M7WRypN/50USPJ+1Ipe2A05aijwfGFP4BppHEVOWFwgAQfc1GY8Vc
	65ox3CfdUnC7CPieU83PSquKUN8sa/wni5M3acjLH2AzSHB1IU/4KUeTKTyXbIol
	ayVuSCBXxTXRl0544hQMgASiSWnV+/wQAkCJ+Ny4yUin+/Blo9gKnUjz3ozQAKv9
	WHx0/b9Gkf3hogd4njhYqifJcoYODCNvFMNXLtCNkB3L5Cm7mcN8QLieNWFDu8u/
	ZhO+UQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgwj00nf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 10:35:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edad69b4e8so17790081cf.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 02:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767695718; x=1768300518; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7t6v47LnI7OxQy9keHMDeaCQBCt0ft012ztrgPObOHI=;
        b=RZyWYatFYtl8jB/HgdMzaKJxWmUE4eUk4FlbAoZS0aZjBga0W0tEp0/TYA/piJ6kVq
         cwzIr+5J+sLWzMV7DWwwDbpJGtw8ynfJrZgYu2eNuyAW4ZunD3hcXiozykcSxWUAj5Kc
         K52DasXUarQRhZu27ZFlY5MCTq2KOxhwzY2QMBV12rwA5QuXreMaVim3s6eO4Fa5ctG6
         FnDG5Em8mTrc1I1qly4/fMznLJSt+JOmxnUdmv/K70nqf7Cj3F/R+e+8kmBFXjLHHOcF
         /3zbP6Gs9Y2J7hJ1/BrKKKHYRPPU3ancRzSnZvwfvRF6YBNoPsJLZPwIQ2ZfQYpmmJrU
         1ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767695718; x=1768300518;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7t6v47LnI7OxQy9keHMDeaCQBCt0ft012ztrgPObOHI=;
        b=sKk75cYQlziOr4v18MjSK5wIhZA4TnbpygSnBVP6KvaaWROwx1uWYhnXHNVx6T80bP
         wx3c2rZVWFWX9RX6N0nBdZ6iPoAl8PCrczabHoParjzN9WXo9NR8Eq3qN34wRFgoJPsg
         CKnn0hZzr50f9pd+qYU7xhSTQLzRdvU8tNuzvQikKEAIUkptmUnefxSYNVAA5wQwsAlT
         kRd/wgN2pjMnmu/wtuT5Y2Sb845R2LCaha6bb2yIPlPaBzldD4eATDrTGOpBHVxJvlvw
         yOsffpN/uP2/84of5Zcz2lRv/+kG3k+pdzsEpbrnOlaPZ+ZRYNb+8Ldgqgx3etq5FGCi
         T+vw==
X-Gm-Message-State: AOJu0YwUzy+QxCKGLPdcCBdN0Xboro2hmbnnZ40y9V2cKJrBoBaUoX15
	2w6KZUfMmW0283+/u/bqFSDyZ1H2uIEV31p7IWA+odS45gXAmRmS9cQxi0FFAhNo+cRZ+KM1j2q
	phKd01SwTVAUSxSuUY+s5uGU5ui58Nnb5PikvIG3NSxe/BR4VOiplcV4nPoPQpaco1UFzet2ejm
	M3inq7YQOkN5qgJwKIQ158H64V61H2MAXPmuf5Vas7XKS0KVsuj24N7wAIBx+6QCA=
X-Gm-Gg: AY/fxX5w4b+zl0DmntqjvGH4R3Rc5yD8N5ck6e9xbbdaq+VIWkWUZ/Lptfmh9UxFQYY
	1fFc8MW2uWdbUOpBwXJFfPeJfQmhKeZY8kSK1XdiUcq0MrR2Tj+GVzaol+rhHfrHlxpQ7gHduHx
	kmizfODPyU4AXWO97+/qk5+xCPWCoAeZQz4urO50HoJENUZDoDsOFBrdfzngBsH6iU
X-Received: by 2002:ac8:5885:0:b0:4ee:1ec6:aeda with SMTP id d75a77b69052e-4ffa851603cmr27487341cf.34.1767695718090;
        Tue, 06 Jan 2026 02:35:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZCFKI7f/t445KtYOLW4rkmtx3+FF9Ju14Zguc/xVa4itZA+nx1vJg2dy/2FtUg7P1yQ8HY0kPCJ4pCxPsZWA=
X-Received: by 2002:ac8:5885:0:b0:4ee:1ec6:aeda with SMTP id
 d75a77b69052e-4ffa851603cmr27486921cf.34.1767695717314; Tue, 06 Jan 2026
 02:35:17 -0800 (PST)
MIME-Version: 1.0
References: <1881E5408DAD4814.1506149@lists.yoctoproject.org>
In-Reply-To: <1881E5408DAD4814.1506149@lists.yoctoproject.org>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 18:35:06 +0800
X-Gm-Features: AQt7F2od5sexRupxybeC8gQcgngM68zXwAThaFhlQc1yzcP02avjCLPtiRMdDrY
Message-ID: <CA+s=J=ywwXQnYxX+Ly8z0DUWpw6uxVHOLAQ3xaq797LN7YFMAw@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] config.py: include
 meta-qcom in a-full
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA5MSBTYWx0ZWRfX+zTGww3ZAhaX
 c5dRmzioqTimx6e0fATtpWzhTl1JUmBpAkQE42KChUyAXD0Q62qXLuf4woJVVW6p4w+h8mf9ZnJ
 cNXik79FfvKy/NuAmbTaD+/wsxsck9fYvyRn0Iz9o0cTy0f3kgLHa+5/UpygXVcvsGSDpZZy68O
 Ol0BaZiwDIpIkvaIRw6f2GsPjEnBSobT9V5/4EPOgq+8TRezFK46GTmi58vHsphhURdQ+PXLyvW
 C4AML38bSTXaudB3ZMJeCuOhQpcoF9Af/NBaSY1S+5UID2o4u/fxr1EJtgKrdXIDhNhegmegdJt
 pChFVucqU6ryIRb1ENtEfnL9vkcqkPjkgO6KzAYhFF1F5ZzqS/jZ9gyze/lnwQaw8Z62V1OuSnj
 PVWoHZXdaeuq+QFsPH2/yaDPoqF19QZ3FGjy5EdMKrliz8UnMGZ+hOIiGmIRo/4a2qI5DAmlQNn
 CjImyf9TkLVGzUKEOGA==
X-Authority-Analysis: v=2.4 cv=bdBmkePB c=1 sm=1 tr=0 ts=695ce567 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8
 a=Nj9o2uNbzjs7e5cqL_cA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: 5bW2UctAUXSgJj26tey-Aa8ltDwOVthJ
X-Proofpoint-GUID: 5bW2UctAUXSgJj26tey-Aa8ltDwOVthJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060091
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 10:35:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2903

Gentle ping.

I also ran meta-qcom builds on autobuilder to take advantage of
relatively calm last few weeks. All builds passed and build times
ranged between 2-15 minutes.

Thanks,

Anuj

On Wed, Dec 17, 2025 at 12:09=E2=80=AFPM Anuj Mittal via
lists.yoctoproject.org
<anuj.mittal=3Doss.qualcomm.com@lists.yoctoproject.org> wrote:
>
> From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
>
> Now that we've tested meta-qcom build individually, allow it to be
> triggered when using a-full as well.
>
> Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
> ---
>  config.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/config.py b/config.py
> index 50710bc..cdefeae 100644
> --- a/config.py
> +++ b/config.py
> @@ -8,7 +8,7 @@ baserepos =3D ["bitbake", "oecore", "meta-yocto", "yocto-=
docs", "poky"]
>  # Repositories used by each builder
>  buildertorepos =3D {
>      "a-quick": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2"],
> -    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "me=
ta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization"=
, "meta-clang"],
> +    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "me=
ta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization"=
, "meta-clang", "meta-qcom"],
>      "non-gpl3": baserepos + ["meta-gplv2"],
>      "meta-mingw": baserepos + ["meta-mingw"],
>      "meta-oe": baserepos + ["meta-openembedded"],
> @@ -101,7 +101,8 @@ trigger_builders_wait_full =3D trigger_builders_wait_=
shared + [
>      "qemux86-world-alt",
>      "oe-selftest-debian", "oe-selftest-fedora",
>      "qemux86-64-ptest", "qemux86-64-ltp", "qemuarm64-ptest", "qemuarm64-=
ltp",
> -    "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", =
"qemuarmv5",
> +    "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", =
"meta-qcom",
> +    "qemuarmv5",
>      "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc"
>  ]
>
> --
> 2.52.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2807): https://lists.yoctoproject.org/g/yocto-patches=
/message/2807
> Mute This Topic: https://lists.yoctoproject.org/mt/116822178/3616702
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1321632=
3/3616702/1570666242/xyzzy [anuj.mittal@oss.qualcomm.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

