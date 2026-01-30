Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67694D73EAF
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 01:26:06 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.871.1769736363118032266
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 17:26:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=d+1b+yrN;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=IN4qwEtR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TMtmu8325937
	for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 01:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rndbLWod0kmyN6uw1rpofhksVBoPa3JQfOQKMzfxaS0=; b=d+1b+yrN2f7v27SD
	tXXerSL/vfgF7pP8iDdPElnWHfi47vZjw2cuMLDPKnwwGB1KCqis+TmMch9GiSAa
	bbVtQJp2+5/3gMbeh5y4sStmI7L+yqG1nrONmZLsmZG7GsT9tCh7ByFVfT+6hFDN
	JMPYYVhoxCEoNja7tQ02k71DsHXb1Vx61in9VFTJ6KsyyWW5ZwoeejM34Nn5Oa/Z
	vU2yOmtp77mxDaIdVa/QNvmfqfVFH4ciNWrOL3Gzk+NBqdoHQduledxPAZnwHoFg
	gYqV/cYDbqqJ+SZ3IHWk43hGgzu1GapfoGYba9HnCVlW24y60lJmkU9cdxKMW5H7
	lyolKQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gs7ra3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 01:26:02 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8946f1b8691so41419516d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 17:26:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769736361; cv=none;
        d=google.com; s=arc-20240605;
        b=KJJMOaty2xvbXrp4OsTGyXfvhzmy0wyQ6kOy7CqszZKJ4bYXsakMWHxZFbSyusjdRh
         xt/zr4TvCzMt7y/eXl5uauhQy7sMgLayLiRzhC+5jb/Zp7E6djYH+u0Fp6+Fs0X48gQt
         z7IcS7SGdaonF+RypC3CY92xQD7Qouq5SVdRyks0asYqzorzLraEZzJKFwUf5cnEJhDH
         nICOUqZQ9O7IbAZL140d3HvPOQjrf32Aka3lLthXQKEJwGuI1msxuGdyZv9TtaHqhYju
         xiAj/laPRYfmdXUy5XZPsYfGfQRfDv8RWK/pBoU0lxtxIbjtKz+e0gwRcMqWo9ehSXH9
         TvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rndbLWod0kmyN6uw1rpofhksVBoPa3JQfOQKMzfxaS0=;
        fh=d27dypai4idq2DsS1C9ZIb4wMyRynf3jVKn8yAUIzkM=;
        b=dIA7sNv16+nBGs0InAA+1D4BtrKCY6dRiWx/HFCYq9MvgHspS2REchtshBIpI0oJje
         U1Hr865D/nuA6DSD2YErWfCbZ7av85WKQVZ7af2OhVdivk15vHE8WOXELllITELzkC2m
         y9/07h82cypJWvy5CamZdRVfzmUcVVJlMxR/7EA9kRR/n+fryyx7sf5tfANsNwY1JSR1
         PsKqrJNH1SD/GShzRnoiKpmX3mlPQ3N8/oVH+qsPraqSO8YGN0Y1MAwJR83LXBmNhrVR
         +JBZFpuSPSdx+ISwDUZWuHB4Tp8+ipWOmC41mHVn7pHOZE7NK4mLCLLuAs7xSuQtw5dk
         HKEw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769736361; x=1770341161; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rndbLWod0kmyN6uw1rpofhksVBoPa3JQfOQKMzfxaS0=;
        b=IN4qwEtRiwBrPd5uxpTPFbr1b/mI+u/+6veRiiK+AeqlLORwedGOxN8cK+awLbuuBv
         jpfS8xIwN+Rp6plpbMXEIFkOCj1dDhJCaSVqgws4BJ6Nezfa5KvNB9U4iQe/2qExfSO4
         VWueXPngzHz+LREULkkdG7CxhrxdAzwCreyvPinmoxv6pjF9/kU5THiM2nQr4S52o7J6
         8o8oQ6F6c/J4rEQWOiafVE2ERvaigC3VcgEsDtmz5rCiZkUyVjnvxF6rTXUXMo1K6aiU
         U0FrxbmjVOGwjiEIHGH0Dqpp9NLWseF+Ug0JjsHpia0jUYvWyGpLb4rUNeFhZKAMFzf2
         Rm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769736361; x=1770341161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rndbLWod0kmyN6uw1rpofhksVBoPa3JQfOQKMzfxaS0=;
        b=mVXaf9N6d7D4Szx/M2Eh8mmCw3Qe6FmtAqtt0KOMITWdzclVa/0mXTBmf1amX3kGFV
         PTbBb+Op8peMvAibsA7g1V7yjxNTtoSJw2y5MRWfMekzV8BSVeK+uL1oyEC/jOEmyJH9
         v+TGJQt9QCUrG2nntfsq6d7iVWckqdw92WWkMkeDz442k1TWLMLGisuajY2UoqxUFNOm
         aTlgVR0ubTFdMCkt6M2KzZ44/3SNF7wlRrCmBTBN6PieZVK7bwItMD68WSz5+wnWcfBk
         f+cNuGcofGI1dnEnf95JsuSmaTmZQxx3/XPTxxWL7Pg5qMEFSkbwdYmXyrUBs4ahH+mZ
         qt6g==
X-Gm-Message-State: AOJu0Yy3Rl1dWq9KvDfa9S7IHUbOY4UjAaQW0pntKUsyPTZ5riZw/LKI
	yWOT2k2n9urGhTF2aCEYIGYtIYkBeOrsMvPeYTSwTawNLY6mYVW8zrzauVoh9Ry4+lrQvvm1Iv6
	05HI0Rv+nxTVDSrjY1SsYJ6eghrERkXgOSe2BbnN1R/OC4vudvPrCF25hyzw6CG7fGnKp6emqmE
	0I6hXZ1HfAH3y1GsOYCPHXh1QQ9gqJpQhZU+fUBaUlPulPT+wDeuOcHO9iddXB
X-Gm-Gg: AZuq6aLdwX43YOFSWjDQHevuYGQRve91DdeIG5GmjvHIJXp3zC1uGxL7CCEVsOvITL2
	ikOlqUPonjRimQTL2O4ooteaQZiiAxwG3XBIy//ocR5TQF2344lBVj6FH/pXaDSqwJXUQ5xtI4r
	WdFvj1elBzbm3dtGkuBB55I3fg1gj6DsSgFYbFkwiCebje85WdUC5YxcIEecYDZWOH
X-Received: by 2002:a05:6214:410b:b0:87c:1d9a:d0c8 with SMTP id 6a1803df08f44-894e9fa4c46mr20638866d6.27.1769736361522;
        Thu, 29 Jan 2026 17:26:01 -0800 (PST)
X-Received: by 2002:a05:6214:410b:b0:87c:1d9a:d0c8 with SMTP id
 6a1803df08f44-894e9fa4c46mr20638596d6.27.1769736361160; Thu, 29 Jan 2026
 17:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20260129083517.647116-1-gyenugul@qti.qualcomm.com>
In-Reply-To: <20260129083517.647116-1-gyenugul@qti.qualcomm.com>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 09:25:50 +0800
X-Gm-Features: AZwV_Qj-zBXtyHVMzb5UlbDdcR8hACMPWdbjkMShRtk1CjUDyuz_b5bssxAsMe0
Message-ID: <CA+s=J=wM8nYuauj+jorngshKoaGJc0JtV2Hg7qCyEFObbQeb8Q@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH] pd-mapper: Introduce SELinux domain for pd-mapper
To: yocto-patches@lists.yoctoproject.org
Cc: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAwOCBTYWx0ZWRfX84aoSU43oiGv
 76SGEYbsaBsZinOKajC132oVVij3ZBjZJUf43w1y4lOZyQZtedBXIRbTJDQPFsBTiltNevJtork
 3/SHOZmVvG3ar7vrB/Mbs5h799NgxQxq6LctmVAG4qcffe3oLfTISWanPAZyg/lY5HQvYpR1xr6
 N099LflVP3+IGptCBJPMAGUVMizjtKt6OCswaXryy4cDwwG1+yVAOdMGw8CmOierP+lI/Pbwhsj
 ock2xvNK+/xOTNcaTs2HGfiJizNgyvapmIGuD0CLGGptx8IUS0a+1pRHTbb2oumFiZ3fM2hDq9I
 u77h/rOcHf7tWQyMgdts+V83zsU53H5c7N1uj+oLlIQHqIBXUQz33Fnz+lZ9eQgtKtG8IB+RMdJ
 +al79MzOLjFZUDy5ytjIfLzDyavjrNUSmqujUhYM8XwT/cCesG1//7AHWWNHVCpRCJ9a3GKLzf9
 x25xUuEDg0A60W6Yyyg==
X-Proofpoint-ORIG-GUID: gyveyKQ21xVSHL5iwliujFXKoiDplCpT
X-Proofpoint-GUID: gyveyKQ21xVSHL5iwliujFXKoiDplCpT
X-Authority-Analysis: v=2.4 cv=UPLQ3Sfy c=1 sm=1 tr=0 ts=697c08aa cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8
 a=EUspDBNiAAAA:8 a=LmlsDRhIBYbCkufYxE8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300008
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 01:26:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3146

On Thu, Jan 29, 2026 at 5:35=E2=80=AFPM Ganga Bhavani Yenugula via
lists.yoctoproject.org
<gyenugul=3Dqti.qualcomm.com@lists.yoctoproject.org> wrote:
>
> From: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
>
> Define a dedicated domain (`pd_mapper_t`) to confine pd-mapper service, e=
nsuring
> it operates in a restricted environment isolated from other init processe=
s.
>
> Grant the necessary permissions to resolve AVC denials observed during
> the transition to enforcing mode:
>
>  - Filesystem: Authorize read access to `/sys`.
>  - Socket: Allow creation and basic use of qipcrtr_socket
>
> Signed-off-by: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
>
> Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pu=
ll/1070/changes/c8aef7c55e8768378c6adeda7e8edfaeecb9fa28]
>
> ---
>  policy/modules/services/pd_mapper.fc |  1 +
>  policy/modules/services/pd_mapper.if | 10 ++++++++++
>  policy/modules/services/pd_mapper.te | 15 +++++++++++++++
>  3 files changed, 26 insertions(+)
>  create mode 100644 policy/modules/services/pd_mapper.fc
>  create mode 100644 policy/modules/services/pd_mapper.if
>  create mode 100644 policy/modules/services/pd_mapper.te

This looks like a patch to refpolicy and not meta-selinux.

Thanks,

Anuj

