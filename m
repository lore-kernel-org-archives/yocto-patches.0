Return-Path: <dmitry.baryshkov@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA6BCD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 19:21:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3080.1781724085727248604
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jun 2026 12:21:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=nAd39NQL;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=dicaoyMX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HIePhi3588747
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FI1kKjyiULhvHKY3l8Kb0k
	w3/WyqHnKdR3dS8VxElic=; b=nAd39NQLhV4OerXvulD0btkm84C2remtz7ueIN
	ohmOBuYh57aBED8ouoFiqA5YJ432AALwmBItulXbbiJIHZTmWFXXPBriXmPbBdKO
	hXwaPYkEV0iyBlQEa9weA3WjmoaFvmdactd760C8tCF1PnDunfbGz6gP31Gwa0cs
	b/IbfZNCRP+xo/8olY/gUjmDVdjno1O67HmlaofcR68m6mITCba9xafI0SuL8owC
	zBg9q/2cBlCk7C8tqp23/91ZpYvtXLXkg6l4CQQ68FpJ8xTAAxl7Dn6ifG/vkw2+
	5SfIXzLRE13EOknwdkxg/ZJARY4Y6z4ONvWWFFUmWQZNQzGQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kg4r5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:24 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfd2462acbso187542137.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781724084; x=1782328884; darn=lists.yoctoproject.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FI1kKjyiULhvHKY3l8Kb0kw3/WyqHnKdR3dS8VxElic=;
        b=dicaoyMXn4NalTQcb0YPqYrGSIj8q9/17TYhkyzMYLsqrIt5Y7DEwNxLaisiZlm7FX
         NsfqTngTZ3RMF1CyAoznu/Zm/zIzqwSco6nWb74kXQjDDC0AwALC28LCq+OgCWHp4c2u
         ceZt5fIhdd2vC/kjpVsfNIEkt95PF8j0iRL6Hr8I3FnLJ1aWRG8xPAc1DEETemuBRx0s
         8uBOIG5KgelCsHDobbkhAU1QbJOhSLNNP5N/EtRBx2p7Qf/Mdqpi0M/GKXpAtaVT9nKj
         hVuoQ2scAFAYhEZkM5he4K7UQ+ktIQX9IrhfcWmLFrsSbV72t1aQKM0xMDcqLMz3kn6P
         J+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724084; x=1782328884;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI1kKjyiULhvHKY3l8Kb0kw3/WyqHnKdR3dS8VxElic=;
        b=jo+mP+SyC3iB0BdzqERPeaT0HeSjiexK+YifyQhmmKYzsePpCM4wj7nMs97le1GSD+
         r5EI8IPiTCKiimH2mfl6S8oCRzdoyKRgJJ5qPXDMue25rwAaKeJyksLhdsSxxj7IRh2o
         C7h0n7u6XVyQB6RitxFL5O9BSLdMldEm3vHkAq1uEDUdHBI0EjEc6XDwhXZOsdOVe9CX
         BCJAnV7Pb0zCx23Cx+uYOYdIBdNytnLOxtyEbdDnEsqGaTZTxVi3sPpJJgYtVlwb+Gfl
         4ZMXeVW/llTEPcPOkwkjVsFkFbY1gpWDLiL0LuKkyUlViA4a2cfVdRUv/3B3vACmo2rd
         in6g==
X-Gm-Message-State: AOJu0YwaBIgXMepbGmvNaIllai4XDMJ/3uPm5MYRaLLiIiM8qWjGCcJW
	N2yEKtqkQlfQ0+buA3tmpM98O0HH3HO8CRdXIQrGvSr7vszjonhGop0/qIdw22p3xVHGKtXR9wd
	HmrXo1J8OOJCH71buW55AP2Adm01eZNQm5u0DxJLeWKDQ5AaYw8Y/C0fRmdjiNKzLMESjk1rp7s
	lny2HYOTI8PA==
X-Gm-Gg: AfdE7cnVdODotS7nJmwdDTRTOGr2JMn6fxHS7/Jh1welE+85P3g0asWYVp7v1zMRalZ
	nN1ntWxxb4uLfsVPP33T3CrM/mUYhkPJlrVnU2SLKRZ2qIm4EUj8mG3VUes0MysGDQIAwYvvwkk
	WtBL3aIZc4tRT8e/ug3cFfGS7m6TllBIjRTwSLyG1c0NsU45u3LV928WtEkDrh1WZqofefh6/OI
	gF7lFD/VNgshBSLEYE5/r77tpYgNvvvG2nfHUxLWzW1a9hwzD2RwaYvxlplP+0CnHuqwTe+w4mT
	UQGhtooD+gke9Sj0P9Hw+owqQmQainmn4IF3qJKdMjccLiEdXlakxFsPdKEzG1wMNOfdaOigihL
	H3h7FSvfmKQ+4gmJeBUxKqfo1E2TDO4ZGNwedrR4guZOQwYpXq6jwyuJ/3uTwFoLRu+uMQ8MMOP
	571nSg19t7BPV3/H7ICIcHI0tx
X-Received: by 2002:a05:6102:3f48:b0:633:c6c4:b32c with SMTP id ada2fe7eead31-7246c890bd5mr3678082137.15.1781724083798;
        Wed, 17 Jun 2026 12:21:23 -0700 (PDT)
X-Received: by 2002:a05:6102:3f48:b0:633:c6c4:b32c with SMTP id ada2fe7eead31-7246c890bd5mr3678062137.15.1781724083383;
        Wed, 17 Jun 2026 12:21:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f2fsm4774356e87.11.2026.06.17.12.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:21:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 0/3] layer: make
 it Yocto Project compliant
Date: Wed, 17 Jun 2026 22:21:15 +0300
Message-Id: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvzMmoC/yXMQQ6CQBBE0auYXtsRWIyJVyEshqGQVhhMNwiEc
 HdHXf6k6u1kUIHR7bST4i0mY0yRn08UOh/vYGlSU5EVLnP5lVtZOXQIT+79BjV2GVztUTSurSn
 dXoq0+ZFl9W+b6wfC9HXKAZPnfjIeZJVoVbnoFkfDpZc4r4nXYfGKio7jA4UBZmedAAAA
X-Change-ID: 20260617-fix-check-layers-60e6bae2d6fb
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7/QqUHTLQhAQ+/zLU6D3Jnm7151AfBWzSND6F8q4r8M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqMvOvLVZTpaidCCCQ8tnERs1nJfEyOEIpyUe+k
 PJRvn3Hkj2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCajLzrwAKCRCLPIo+Aiko
 1duICACP2vtoiUOSQSmGCIiQ8TOM62avBcjaBIE88ULYFiicFlhxmRjg+jrt4MjIOYhSB9yo7mu
 rqTNF+dpN52nD9nYpPcqLNkvK+HnLc/UKKGhnW2YQR/sK9+6NjqG/U+vETxZ7rFyu+kKi3qdbYD
 qulP0ijl7wqJMm2Xa4Rsibz6bzIFEupu/Wa57gKePThQCarOAO7+fJ8lWqqNmi9hBxpd8HeMZdK
 hxlT/oPHnwGT3sb1aqLAgOd7d759vUtLgIEi2cTcOQmlVPCi8hNya4VLyQrb+auvm7GfvA4qP10
 /vkd9ivPoPPeh9sZl9umGwHnm0MCQIbjutInFHAXXkiU4Oii
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4NyBTYWx0ZWRfXxNJY8EF/mw0L
 tsiEwog3wD/XjnYduRYFTXk4aPWW/88nPfhXblP4/hIWbLkXD9EZ2JWX+ISGzRAgdaRy7lmqryu
 TX2ohlxuLZzPcXnyGnZ8zTWvMRhCbjRRGsWdsrpWkJwkcew1B0APK+xvPpG5fR3XuMsrq64yE45
 cOdeBGc2U3UJT+cT+eUqXjnUTabyejgJpmtnecM8xB6+6HB8gDC0BHp6Szng+Yr3GqbGR+7tGX5
 3m5/zSGq580xYeg13/WYXgesoW9qRhDYil1qg9THwTSJaPgqAjXtpkWARzL+MHzLqMw+qNpzrip
 ewPNjEM50xuxgUi48xCHcXsN73ClaQJ+7x3rbjn8nc0bcUK64NFJdewgd+8EBu6HPQQVigihr9K
 Sta4wvRS4LsX2kXXgYmDCggzeQ3BTmEjZH5YlQyVPNRGMUA5FSl4lTrvSymuJQijnOOmPz0exWY
 ndfQDe5rBglGEWTApmA==
X-Proofpoint-GUID: FbqGcWz20uJ4O69N6CSt1ME3RK9C5HJP
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a32f3b4 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=Ii1caJqkCqkA:10
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YBRDztzB1Kn1uOINanoA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: FbqGcWz20uJ4O69N6CSt1ME3RK9C5HJP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4NyBTYWx0ZWRfX84KmUwWubjmv
 Y6KiX6STsrpSUJLIQbTcVFkwDtKuKTV/c0gDxh/Ne9V+SDjGpGI6onri9Fp8L12cZuNcyp0xTCG
 FmtOdNoww58uA3du/zAtsmUqbG5y+u8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170187
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4233

Fix several issues. With these patches applied:

lumag@umbar:~/Projects/Qcomm/kas/wrynose/build$ yocto-check-layer ../meta-lts-mixins/
INFO: Detected layers:
INFO: meta-lts-mixins: LayerType.SOFTWARE, /home/lumag/Projects/Qcomm/kas/wrynose/meta-lts-mixins
INFO:
INFO: Setting up for meta-lts-mixins(LayerType.SOFTWARE), /home/lumag/Projects/Qcomm/kas/wrynose/meta-lts-mixins
INFO: Getting initial bitbake variables ...
INFO: Getting initial signatures ...
INFO: Adding layer meta-lts-mixins
INFO: Starting to analyze: meta-lts-mixins
INFO: Distro: nodistro
INFO: ----------------------------------------------------------------------
INFO: setUpClass (bsp.BSPCheckLayer)
INFO:  ... skipped "BSPCheckLayer: Layer meta-lts-mixins isn't BSP one."
INFO: test_layerseries_compat (common.CommonCheckLayer.test_layerseries_compat)
INFO:  ... ok
INFO: test_parse (common.CommonCheckLayer.test_parse)
INFO:  ... ok
INFO: test_patches_upstream_status (common.CommonCheckLayer.test_patches_upstream_status)
INFO:  ... ok
INFO: test_readme (common.CommonCheckLayer.test_readme)
INFO:  ... ok
INFO: test_security (common.CommonCheckLayer.test_security)
INFO:  ... ok
INFO: test_show_environment (common.CommonCheckLayer.test_show_environment)
INFO:  ... ok
INFO: test_signatures (common.CommonCheckLayer.test_signatures)
INFO:  ... ok
INFO: test_world (common.CommonCheckLayer.test_world)
INFO:  ... ok
INFO: test_world_inherit_class (common.CommonCheckLayer.test_world_inherit_class)
INFO:  ... ok
INFO: setUpClass (distro.DistroCheckLayer)
INFO:  ... skipped "DistroCheckLayer: Layer meta-lts-mixins isn't Distro one."
INFO: ----------------------------------------------------------------------
INFO: Ran 9 tests in 135.726s
INFO: OK
INFO:  (skipped=2)
INFO:
INFO: Summary of results:
INFO:
INFO: meta-lts-mixins ... PASS

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      layer.conf: use the same priority as OE-Core
      linux-firmware: set DEFAULT_PREFERENCE to "-1"
      SECURITY.md: describe security policy and pointers

 SECURITY.md                                        | 23 ++++++++++++++++++++++
 conf/layer.conf                                    |  3 ++-
 .../linux-firmware/linux-firmware_20260519.bb      |  3 +++
 3 files changed, 28 insertions(+), 1 deletion(-)
---
base-commit: 348a9eaaf3991e2329d0cef14dce23fabaef9191
change-id: 20260617-fix-check-layers-60e6bae2d6fb

Best regards,
--  
With best wishes
Dmitry


