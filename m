Return-Path: <dmitry.baryshkov@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E229C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 08:32:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33295.1782721963724455315
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jun 2026 01:32:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=T85rrxLs;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=I+kFnt+R;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rTBW2124901
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 08:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Oi9gEcrr+oApWeX7HvfA1JP6
	bKT6mg2AB5TYGx77/fE=; b=T85rrxLsoWgUrnIL+IPxrmNLufDlqLs5fGHUvf3A
	xlg/t0BIhTQ8UbQvqSswn9fLePcShk5XXdnQbM3vzs8HDlE2O20Vo5PxpZFF7xgC
	VwQByGnQ+JR8xnUask819zLIWqdo3YiOYLsXjFlMBeRHRK56pvJWFZbnDWrYcgCj
	rEjzuObdNbAnGOPmcHHpqdnmuCGmcai8gxBQU5jGiqfrJBD/XzrLgOsEodddd/as
	aek9q2RI8oDiWcM7RK7of75SIe95/fVT9uxJ9PYGMyG5JIOY1zTRAXTZcEH5pCe7
	DSORE4Mvs6MWultzrMQyYf58iupfRxvrGS1Jz0DluK7T8A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27335j9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 08:32:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9f0073e20so8206935ad.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 01:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782721961; cv=none;
        d=google.com; s=arc-20260327;
        b=KYuUcYUxIY186ejIDgNDyfqMpPLNoNPtt2O8mJX+7KNojjch2t52g0LNyhTji/vOgl
         HQCs5z0zR5HVm0L6jcZ06Fb7Vd0r65aSfA+BUHGbL0R4lyBx2QLbzahRN8npyx/uXGW+
         /zA/dXdY5ZPvUhTXcCxQ29VrH7kwAacZNUJLJalXLjmA1gKsDeW71vx9GZYln+5TgMEA
         mgokzvMu3Zs1P/aTVpXt0UHkGROHy0F36Cv6CtXTn15aurcwA+pTUB9Ckp1UqD1VuOWR
         OQEiHUsJcKMitgPXUt7Oo0u5ZgIRec9Yu8coGY1vpGKzOV5YKsH9O20ts+i2NLzS2Wir
         4Z1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Oi9gEcrr+oApWeX7HvfA1JP6bKT6mg2AB5TYGx77/fE=;
        fh=0WMgTBIIl9xif80gosCM6ooA3Wc1AiUIUWsV6DbLrIE=;
        b=szaLNW+h+Yt0WYYA3oB8Uke/pQ4v/jNGi5QnFc6PTLKPpBKY2kM5nTKHNsnGhs1lJA
         3ZS9iEcZ+7Z+LKaK8hdWbyFdT9LBoFgUkd+2ooQ+8NAD/VPBBnehS2WCmSGfbxQt4/k0
         V95VdocAi2t4iZWQKRdCmb8O8rYuctkfKCxl3nnVQgPmwtfT3Lf1rKN7tJ3Gvtx9NLPw
         +DTfnA08gH0jOJ+JDni8mFt98zpmH8LxcOCOHfuiWE2UaRa/05Mfrfok7GTK5/KXa++u
         visoy8qf28nykLYfOPewZYu51vZFoUVN043a3EwGAqQkUO5Ar2IbK+d9pJdevVqZ0UVp
         jdag==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782721961; x=1783326761; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi9gEcrr+oApWeX7HvfA1JP6bKT6mg2AB5TYGx77/fE=;
        b=I+kFnt+RfKV/hXFCzkeqevCgsISdr9dq9hwDWXpVF+xlNvqAJX+o+WkXTNl1MYqxRw
         NCGRS3oRcSfKi5KMZnYTeYLbniEce6CMlfsKrX/H9LT6JbLWKpnxy8UIY8rBuQ1emlsJ
         G5PBnEVNB+hBdMa6yGs1LS40dkqe895+KSlbI0CgLg7st5c8rxfrlf9Ef8gtt1OmeLeO
         r5RnIOZcbtkr/iKUirGJoptXepPO8K+tQFN0Av9rbJExR4IhuWBRTK3dW7Mg2VFPxjb2
         7OCyYycMvpBmuGgyb9/OX5ui5oW2EZDpWNQlR74RRCJEUe4+veygbUMUIT5w/BPubCE/
         wLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782721961; x=1783326761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi9gEcrr+oApWeX7HvfA1JP6bKT6mg2AB5TYGx77/fE=;
        b=CE7jPNvxjcOpu7apY3u7UQvdlr9FgeG2e3JyeILd64dcqwzS/DtWuyNi/K/usHjoi/
         N4gCGfF4qe6jr3RoaWm8GTC7ELqpwRrIHhVRpVFMgnTSCTk/jFlZOfFjaqBAM0DMy8Mc
         spQtWeBqmWfBBL9RzrLvoGSadFG8oWfKmn7NDFsvr7NBXL877pXQKng3/OiZvCK8vMbz
         2IMrwgpXN9ZfBjYwEQIkwOcFE+MHV2DtMoxa1auXoP5E2GWYLzxJeyQEVkPnCBQM0JM7
         GVB6vJkw+VX+J73Gqh9KN0pckZurvgfbpTbqY13O8sDP42PVaZxDsQb/AEB+gGor2Ppc
         ovjg==
X-Gm-Message-State: AOJu0Yyly/EYl0EqPGVw4dtuO+hrZr4Vgls8q/+dV9V5gEXlToLO1NDR
	eDT8U9i4IXpfx1k2kRdRLtiKoinD6tjVChzauvx2qv9Wj0YR7UeZH3yy0F3D9SQBpXSb18qCYLo
	qRkTHdKPKRUaanh4Rm9jeNUonwpM/jUXkMjj9kNhPQ7qADZZzJRs4cp9ZrYALtpp8EfGseV0VSm
	oFUCwcAI3Ro29dzSvdTBApZjIsKof8jsO7LvE6xW738/Lby/drXfD6
X-Gm-Gg: AfdE7cm5jr9AZyvDbKircLgJITek6PyjX4dL6UW20vtHkZmJpx4TaELp63jY7BiYVEV
	zvFngxPAZoUvUbXsa70wsWLP3cx8PiYkAGnOWN+CDvoYj0Ii3XFGiYZO3JgYtp6xTlyqFwuId/C
	DppJWJj4sNXFj+9ItyKhz1Rm6CnZxefKPu9awT7vEaQlL/whAEwiE/HTIoYAuqA5tagtImYUnyk
	ab/lfLC36uf5iCIlqDhT9zijfqrsQ==
X-Received: by 2002:a17:902:ce07:b0:2ca:e5c:7fcf with SMTP id d9443c01a7336-2ca0e5c82d1mr13394545ad.3.1782721961359;
        Mon, 29 Jun 2026 01:32:41 -0700 (PDT)
X-Received: by 2002:a17:902:ce07:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2ca0e5c82d1mr13394195ad.3.1782721960888; Mon, 29 Jun 2026
 01:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260629083124.1800-1-jose.quaresma@oss.qualcomm.com>
In-Reply-To: <20260629083124.1800-1-jose.quaresma@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:32:29 +0300
X-Gm-Features: AVVi8CcNcUWKB4zt-_6y94VxCKU_h0GC7oQcM-qwMnwKLafGvM1aWmq6xJHdyLg
Message-ID: <CAO9ioeWgBEPtJPUHDCD5UAtBR39wEwdjiWC6a+MAhxq9zJXyNQ@mail.gmail.com>
Subject: Re: [meta-lts-mixins][wrynose/linux-firmware][PATCH] linux-firmware:
 upgrade 20260519 -> 20260622
To: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Cc: yocto-patches@lists.yoctoproject.org, Vivek Puar <vpuar@qti.qualcomm.com>,
        Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        Ross Burton <ross.burton@arm.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a422daa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=7CQSdrXTAAAA:8
 a=ag1SF4gXAAAA:8 a=7b-f8jZ2baKOIvEbZSMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=d3PnA9EDa4IxuAV0gXij:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: dIgLF5nCocgViCQsDIKg-zK3IuZSNM8S
X-Proofpoint-ORIG-GUID: dIgLF5nCocgViCQsDIKg-zK3IuZSNM8S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX3IFBJ/d+nlpb
 vVkH/FSqjhQSlzmmdNX9H7krjggMb8T3EskCectpLO/DqW0td5d1aerogZGeCX4uVsKsEvhhY8J
 A1xayH5xJT3ZpqBY3sEBz+AMREpb+PrslHW/iRtlAGGK8yhZ+et1Ty4F+JMfN3CUJQXEGIsa27w
 aoc8C346v5vbpu2zrTU94s1HexgnAOfKfhrWL7FaFMYmlgwyW4kvpDmmOWJXd43mcTZ/eP9tncx
 HrHCeBJoyc5MOTnvB4CSMPZGE+PDlWSoPMDv72eDVc9H0VkzT1a7Ap9yCMJLbjEzNdngAePaTdt
 y9Qmt1Xnd9WUCgITkAQwAGt3Xs/xFl9MaywKK6YYMn9nr6V/1/T/AEuRPDy97aeeJucGbAXYOYQ
 MU0YfY8erpqI1KPQE5D3FynFyrbNi/mQqf5uFtepxCD7jf0vJM5OmGk3m9pkwQBULF0RHdqk3zj
 nxskjRa/UI5EyG+8QtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX/aBur27xgxpJ
 K+zEnoYVArpoBCK4tq62tKXCRGjIXw/142NgAL6OAFP25GsDAX6QYsY+92jotDKFVJNTE37yey/
 cjuUOsEjn3bBgvW42XS3wooaoB+1L3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290067
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 08:32:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4319

On Mon, 29 Jun 2026 at 11:31, Jose Quaresma
<jose.quaresma@oss.qualcomm.com> wrote:
>
> From: Vivek Puar <vpuar@qti.qualcomm.com>
>
> Upgrade the firmware package to latest release. Add RCA firmware for
> tas257x, add firmware for NXP IW61x SDIO WiFi device, bluetooth firmware
> for NFA725B (QCA2066), add BCS calibration firmware for QCC2072. Add gpu,
> audio and modem packages for QCOM shikra board.
>
> Firmware licenses and few that are not at the top level (qca/NOTICE.txt,
> qcom/NOTICE.txt, wfx/LICENCE.wf200) are moved to a LICENSES directory as
> per the REUSE specification. Update LIC_FILES_CHKSUM, NO_GENERIC_LICENSE
> and do_install accordingly. Remove REMOVE_UNLICENSED entries for firmware
> files that were deleted upstream.
>
> Signed-off-by: Vivek Puar <vpuar@qti.qualcomm.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
> ---
>  ...20260519.bb => linux-firmware_20260622.bb} | 574 +++++++++---------
>  1 file changed, 286 insertions(+), 288 deletions(-)
>  rename recipes-kernel/linux-firmware/{linux-firmware_20260519.bb => linux-firmware_20260622.bb} (87%)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

