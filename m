Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04257CD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 15:25:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22221.1781796298563648757
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 08:24:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=CwbkCLDv;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Q4ldERdO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFGUL12094570
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rKQvUT9vFIuDCFopmgDKExte
	4zxqZpMDW7C1Nq6d4+M=; b=CwbkCLDvGUzwDMUDWm1lCUSdH9Ni1n37emd6WRHb
	wK6bhE5897qdK5TEM2+5HIIQgJLLESyB/XxMzEDestCMuP2b8H2ARTusP3hJE1BE
	WtC6u2hxzlMRHLidPCFAKcK8nygG+O5RbmLbt1rHWc//Xb92lxScW1NWMgwl2Kjo
	L4B57HQjabavOJ44suWd4lWy2KQiWny1ASoXy/TOlKBvTY+UsgVMTidnpQUvBTL5
	L4/fbqoLiqQlauMRPlmqsXrwoklHENq/5XEsm8kAdAD5Qzw2BsPC2fHEbLHT8auE
	NK9qd2Jc4MS++2gDwsLTmGF8Oz3O5kVEqbmoelgB7P4vCg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a40rj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:24:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8cceb5a9686so29110266d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 08:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781796296; cv=none;
        d=google.com; s=arc-20240605;
        b=Ix0NTgg6DAPrqB6qyOQv3CAs4kMZCtYFIgAZ1sNVCZ5taI5zEJRHrrwS0o8gjvWxur
         TbLmcTwsa+1REy8llcRfFPiUmaH/SiuswE0TJ1JG3o8A8a/fDh1aczm6j9Q3DCyTTz6q
         VUdvxAH04mwtnBGmJrsQJe1Qq4IAFizH3ycvC9EODusxowswwFSQRIuM5GJyfxA849SC
         rgWRsIw6Twmd3mx5ugtzshA5dr02/xr9SblGT2HFmg9TOO3gT87va+RO9gfdGfPhF9JL
         v/XwsBOtL9NC8HhQABs2AQf8xtWkr7eTWJhHeXm46s0E3z1Iu0592dn76Fay+IlubUD8
         UXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rKQvUT9vFIuDCFopmgDKExte4zxqZpMDW7C1Nq6d4+M=;
        fh=zxgxdXi5ZYqu52obbj2c4rCG513/R/jegBbZCN/+NgA=;
        b=N9ZNQDP2RO3kzoDOt7OceUXzUc3cs5I21+xi9OzyPKy6pVTd5YsTAsHbUW/4W8UdVr
         gsgSrQ1u7oZbWCTwuCPYywnOom1UTZs9Io2ORMpm1Jb/co6die4wjP6sigzFBUJ0Uqxz
         WKv8JDWI9pgi1x6rYwinnGL6hW8CYVmzwCfVjEatypvNKC/M6MqIc7uYCv6jdko7NgBT
         z/LhKQbBVQ0grkHZKa6RJFho5RA9ptaL3buLEXfQnbQwGoq6DK5XiQmLaenozpSixOmn
         NealdBuETX5kV9wYzGbj0E0VjEFCk77FuV4nx89oubMLp5oxySFKTZo8/Y/XAsXBhg4R
         jWqw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781796296; x=1782401096; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKQvUT9vFIuDCFopmgDKExte4zxqZpMDW7C1Nq6d4+M=;
        b=Q4ldERdOe/S4mc+20q1gmxg+aHb+hHZMZ9ph8egwq2TIPVifxjh/TXQmj8w1TdSCNj
         /EN/VgupPYIjWMX3av1c4oaNGiIEZkW2QJ6sZvdHydmHX7P8qINf5cTYaOKIxC3zD1Ea
         gIHiCqzpYHIB1UjwZvNLJrqrmMPfZ4vQl3Ig//arGvWYqmSHXgN+y6UiZS3qRIMkyCvA
         DofrsjY+KkG/z5shs4iLJXYWVGH9uxnF4SBECkGgX19KQ6G+qH4Gcp8/UzX+lPoM4WIz
         2WHzhNU59XKn6trpM5KdEALU7CG2HhMcJDXcpKvKWxMRcK97Hl96akYteGXXeu7QctsG
         a+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796296; x=1782401096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKQvUT9vFIuDCFopmgDKExte4zxqZpMDW7C1Nq6d4+M=;
        b=PT+o5ggaj1f4IbTCWmaiiViD7J7WST70e5gRunKYPFYhNhtPAekpn+K8Z/92AU1B+B
         VpPHiggV+IO2bZd4eoyw3iL6wjfdOrIt4RKQc2SjPl3/MyGLwr77eu5jyOlzuyfRtqQd
         kefdBqqXL7Fk7ZrPXtufbS8Nq06M4/7/yIiU0+TpSeRS3ww6BLj6SxiwKUQcFucUFsOc
         qo2MnuyjQgmpreX1IqSRz15fMZIJY3SIy8VRD/9LJTTjuKTGeLV7bTbGVySV2HYMqNTh
         atpkO92hYTNJdQwdp59fMInC2o8cFzEn8vgGqUNO6QMcL9D9r6hp+q8ujMwpniHFRYrg
         cNqQ==
X-Gm-Message-State: AOJu0Ywdod7GADPgkTkBXg/U9hnDGhifLNHhdbgCfhEprtCeEpD13/mv
	iaVF+r+wi8KaNJ/+Nm9EDV1VGlHljfhNzDOHTZQ+Fac8hQvqViUdsMVfAUsDT6BFG8Ky8IC1+Vc
	kp9gWDdrBNAJ3Qg0g0qIdJZpJ6rY5eg94b2XZq7oSMHbw0801gV661TlhsccqgK1bt2AW6Qh67L
	8yZm20RCfm/gTBlAVIqlIVWdONcS6liOgMS64KgsYN/NhZO4OSllX+
X-Gm-Gg: AfdE7cmenOKEM1FiBkMjG0kp/yAO4LMD3RQVN0ce3dOaKePNBA583syVpfY5UmkO8nR
	oXA8RXXtL422CK/re/mOrFj5feRJtmtPt4pYlz8fb4YIk56+M3Pn9lJ8ba0kg3YOAJR5zZTfLuh
	DxasV86FVWV/1ijf5TjiOOxCoXIPw5SbasSFvIjJwbMr992ngU7/91QdZwGUkuYh2e7yzmKg==
X-Received: by 2002:ad4:5ae9:0:b0:8d5:517:12e4 with SMTP id 6a1803df08f44-8dcdf64ad30mr53296566d6.6.1781796295987;
        Thu, 18 Jun 2026 08:24:55 -0700 (PDT)
X-Received: by 2002:ad4:5ae9:0:b0:8d5:517:12e4 with SMTP id
 6a1803df08f44-8dcdf64ad30mr53296156d6.6.1781796295442; Thu, 18 Jun 2026
 08:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
In-Reply-To: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:24:43 +0100
X-Gm-Features: AVVi8CcqDEPWXJR3HTKYgRSB-NXY9wOLuhMFZ-zDZJM7GPH0ZoPwJ8xzZl4bWVE
Message-ID: <CADWMC-YPvr42kCsZVjW1yDV3YDETCZV+ywcXfRMvSN3-fT=_8w@mail.gmail.com>
Subject: Re: [meta-lts-mixins][wrynose/linux-firmware][PATCH 0/3] layer: make
 it Yocto Project compliant
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: yocto-patches@lists.yoctoproject.org,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="00000000000040aaf2065488c77c"
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a340dc9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ArRGne8e9FqFoecyWsoA:9 a=QEXdDO2ut3YA:10 a=gsB7tEvTAAAA:8
 a=scQ1tZ8K3Qz-R2o8zwcA:9 a=F48yyDyeIPJO6px4:21 a=lqcHg5cX4UMA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=IXsN1-T0KV0ZAiTuZHq4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0MyBTYWx0ZWRfX+/c3c2zEO5i1
 mtNC1gk7ItD9HjSAgGGKmhRvc3dSQB0fzJtPBSXWIFaubxU0+aqDLfPVAVHTRooLPK76Ly90mYc
 /aAbyRvgnxwetEBPHO2kqqafMXRuhLU=
X-Proofpoint-GUID: yyl2oufn9yt5SKM4O-RgbIDItl4wBGvt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0MyBTYWx0ZWRfX9QaLC3C4K6iz
 +nz1ywScrjbnLoYZ6RRyH93jBF+DVQN/g5bap5HelvGC4mhMsB9ixkZJIR3uMWoFU/VkyDzTUye
 78dq/5XD7PWBREESrlljHcgPgalvFUZ/0ARJEIdeIQil1qg7f8j1pBk+s4mp1Li6BKYxS3blazI
 4X6RuxrMKKkGgyMAw/Hsiz8yiZUlnN6EQaRyn+IOTa6JvSmDHXVQ4sNdRh2sBh1plBS92eV2lI4
 Gc8p9DrdvocfIIFTolG3NXhEk6L7h+SNPqRqVq5XLYNwSsYtfjMuqzmhxcTnw0t4l5dDd9F4gTL
 DrkX7ibMQ0dZ8R6dVjSnvQF2PIJSjnrJBUu1TdM1S5fFBTLh0SEozgBoHIdk2+m3zEIYvSltLqh
 BYkrBQpvcAW8+xu/VPRa/Xhczo9+G+9NQ0rpdRS+849eCIcoHjxynYqAoUo60ybjl5MALoMTfx8
 QNyoQECBNDKqAeOsX7w==
X-Proofpoint-ORIG-GUID: yyl2oufn9yt5SKM4O-RgbIDItl4wBGvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180143
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:25:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4243

--00000000000040aaf2065488c77c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged.

Thanks

Jose

On Wed, Jun 17, 2026 at 8:21=E2=80=AFPM Dmitry Baryshkov <
dmitry.baryshkov@oss.qualcomm.com> wrote:

> Fix several issues. With these patches applied:
>
> lumag@umbar:~/Projects/Qcomm/kas/wrynose/build$ yocto-check-layer
> ../meta-lts-mixins/
> INFO: Detected layers:
> INFO: meta-lts-mixins: LayerType.SOFTWARE,
> /home/lumag/Projects/Qcomm/kas/wrynose/meta-lts-mixins
> INFO:
> INFO: Setting up for meta-lts-mixins(LayerType.SOFTWARE),
> /home/lumag/Projects/Qcomm/kas/wrynose/meta-lts-mixins
> INFO: Getting initial bitbake variables ...
> INFO: Getting initial signatures ...
> INFO: Adding layer meta-lts-mixins
> INFO: Starting to analyze: meta-lts-mixins
> INFO: Distro: nodistro
> INFO:
> ----------------------------------------------------------------------
> INFO: setUpClass (bsp.BSPCheckLayer)
> INFO:  ... skipped "BSPCheckLayer: Layer meta-lts-mixins isn't BSP one."
> INFO: test_layerseries_compat
> (common.CommonCheckLayer.test_layerseries_compat)
> INFO:  ... ok
> INFO: test_parse (common.CommonCheckLayer.test_parse)
> INFO:  ... ok
> INFO: test_patches_upstream_status
> (common.CommonCheckLayer.test_patches_upstream_status)
> INFO:  ... ok
> INFO: test_readme (common.CommonCheckLayer.test_readme)
> INFO:  ... ok
> INFO: test_security (common.CommonCheckLayer.test_security)
> INFO:  ... ok
> INFO: test_show_environment (common.CommonCheckLayer.test_show_environmen=
t)
> INFO:  ... ok
> INFO: test_signatures (common.CommonCheckLayer.test_signatures)
> INFO:  ... ok
> INFO: test_world (common.CommonCheckLayer.test_world)
> INFO:  ... ok
> INFO: test_world_inherit_class
> (common.CommonCheckLayer.test_world_inherit_class)
> INFO:  ... ok
> INFO: setUpClass (distro.DistroCheckLayer)
> INFO:  ... skipped "DistroCheckLayer: Layer meta-lts-mixins isn't Distro
> one."
> INFO:
> ----------------------------------------------------------------------
> INFO: Ran 9 tests in 135.726s
> INFO: OK
> INFO:  (skipped=3D2)
> INFO:
> INFO: Summary of results:
> INFO:
> INFO: meta-lts-mixins ... PASS
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Dmitry Baryshkov (3):
>       layer.conf: use the same priority as OE-Core
>       linux-firmware: set DEFAULT_PREFERENCE to "-1"
>       SECURITY.md: describe security policy and pointers
>
>  SECURITY.md                                        | 23
> ++++++++++++++++++++++
>  conf/layer.conf                                    |  3 ++-
>  .../linux-firmware/linux-firmware_20260519.bb      |  3 +++
>  3 files changed, 28 insertions(+), 1 deletion(-)
> ---
> base-commit: 348a9eaaf3991e2329d0cef14dce23fabaef9191
> change-id: 20260617-fix-check-layers-60e6bae2d6fb
>
> Best regards,
> --
> With best wishes
> Dmitry
>
>

--00000000000040aaf2065488c77c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Merged.</div><div><br></div>Thanks<div><br></div><div=
>Jose</div><div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 17, 2026 at 8:21=E2=80=AFPM Dmi=
try Baryshkov &lt;<a href=3D"mailto:dmitry.baryshkov@oss.qualcomm.com">dmit=
ry.baryshkov@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Fix several issues. With these patches applied=
:<br>
<br>
lumag@umbar:~/Projects/Qcomm/kas/wrynose/build$ yocto-check-layer ../meta-l=
ts-mixins/<br>
INFO: Detected layers:<br>
INFO: meta-lts-mixins: LayerType.SOFTWARE, /home/lumag/Projects/Qcomm/kas/w=
rynose/meta-lts-mixins<br>
INFO:<br>
INFO: Setting up for meta-lts-mixins(LayerType.SOFTWARE), /home/lumag/Proje=
cts/Qcomm/kas/wrynose/meta-lts-mixins<br>
INFO: Getting initial bitbake variables ...<br>
INFO: Getting initial signatures ...<br>
INFO: Adding layer meta-lts-mixins<br>
INFO: Starting to analyze: meta-lts-mixins<br>
INFO: Distro: nodistro<br>
INFO: ---------------------------------------------------------------------=
-<br>
INFO: setUpClass (bsp.BSPCheckLayer)<br>
INFO:=C2=A0 ... skipped &quot;BSPCheckLayer: Layer meta-lts-mixins isn&#39;=
t BSP one.&quot;<br>
INFO: test_layerseries_compat (common.CommonCheckLayer.test_layerseries_com=
pat)<br>
INFO:=C2=A0 ... ok<br>
INFO: test_parse (common.CommonCheckLayer.test_parse)<br>
INFO:=C2=A0 ... ok<br>
INFO: test_patches_upstream_status (common.CommonCheckLayer.test_patches_up=
stream_status)<br>
INFO:=C2=A0 ... ok<br>
INFO: test_readme (common.CommonCheckLayer.test_readme)<br>
INFO:=C2=A0 ... ok<br>
INFO: test_security (common.CommonCheckLayer.test_security)<br>
INFO:=C2=A0 ... ok<br>
INFO: test_show_environment (common.CommonCheckLayer.test_show_environment)=
<br>
INFO:=C2=A0 ... ok<br>
INFO: test_signatures (common.CommonCheckLayer.test_signatures)<br>
INFO:=C2=A0 ... ok<br>
INFO: test_world (common.CommonCheckLayer.test_world)<br>
INFO:=C2=A0 ... ok<br>
INFO: test_world_inherit_class (common.CommonCheckLayer.test_world_inherit_=
class)<br>
INFO:=C2=A0 ... ok<br>
INFO: setUpClass (distro.DistroCheckLayer)<br>
INFO:=C2=A0 ... skipped &quot;DistroCheckLayer: Layer meta-lts-mixins isn&#=
39;t Distro one.&quot;<br>
INFO: ---------------------------------------------------------------------=
-<br>
INFO: Ran 9 tests in 135.726s<br>
INFO: OK<br>
INFO:=C2=A0 (skipped=3D2)<br>
INFO:<br>
INFO: Summary of results:<br>
INFO:<br>
INFO: meta-lts-mixins ... PASS<br>
<br>
Signed-off-by: Dmitry Baryshkov &lt;<a href=3D"mailto:dmitry.baryshkov@oss.=
qualcomm.com" target=3D"_blank">dmitry.baryshkov@oss.qualcomm.com</a>&gt;<b=
r>
---<br>
Dmitry Baryshkov (3):<br>
=C2=A0 =C2=A0 =C2=A0 layer.conf: use the same priority as OE-Core<br>
=C2=A0 =C2=A0 =C2=A0 linux-firmware: set DEFAULT_PREFERENCE to &quot;-1&quo=
t;<br>
=C2=A0 =C2=A0 =C2=A0 SECURITY.md: describe security policy and pointers<br>
<br>
=C2=A0SECURITY.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 23 ++++++++++++++++++++++<br>
=C2=A0conf/layer.conf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 3 ++-<br>
=C2=A0.../linux-firmware/<a href=3D"http://linux-firmware_20260519.bb" rel=
=3D"noreferrer" target=3D"_blank">linux-firmware_20260519.bb</a>=C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +++<br>
=C2=A03 files changed, 28 insertions(+), 1 deletion(-)<br>
---<br>
base-commit: 348a9eaaf3991e2329d0cef14dce23fabaef9191<br>
change-id: 20260617-fix-check-layers-60e6bae2d6fb<br>
<br>
Best regards,<br>
--=C2=A0 <br>
With best wishes<br>
Dmitry<br>
<br>
</blockquote></div></div></div>

--00000000000040aaf2065488c77c--

