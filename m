Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E631CD4F26
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 15:28:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45111.1781882897567399701
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Jun 2026 08:28:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=fS5gR2gn;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=B5JpeUCM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDCUdU593402
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Jun 2026 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Fr9bP4yKrgn+E9VLuvfmfmlu
	GhI3zEgNYPwc50h39x8=; b=fS5gR2gnS/gbMaHadVVV/n8ftxpFHKxdFRfeeIHV
	sLdytpcKUjjARuBl3N2wC6s0WiF6V0JfNLukGQ7yoLKqOCZfW92qK0jV5ca3wBwd
	96GML1h85pzLM35vic4C3iv8aHBG+I8zMe6jOdZdB7936PXc01AhSvliO/PmVXLp
	ZJxLYJV2aFioVyn1DYIsp7IIiqeBKdf8Owr2mxxRUaYVg3BvQziEUjUeKKuSMPGZ
	eleMFcABajYi1EflwhLjMs0kBUMylKiS23c+02GwidYAc85JammjUuZ2MNkwcrhp
	D49zT1eLWaTKwKcgoKaeJWUIMz49tIlDXUKyKA8arZLe/Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sbsqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Jun 2026 15:28:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9159bc52211so365199285a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Jun 2026 08:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781882895; cv=none;
        d=google.com; s=arc-20240605;
        b=AVqxouGaSXCd9A9I1j7aYYu33t9Cn5Tbsrw77Wg0y//GdDA0eZTqOTBVh5Bi22/8DS
         ZCuO7WnOOkv13UJ6oXSMJ8bApa9F76oacoUhoDJYGYhwXCelQ/3Px4Lowq5gCMvRppZJ
         EWkTWVduyuTHmaGphzDeR2mRoiy4Qfk8VTqcDU2BA+z750nt8oHxB/jG25kVpQSOajiV
         ApcjdIxfKA9UtrG4WdiUNEJaC27fryeC+bHrKig9+HWLJDYzwANPwuNTqftMwVMWWvZI
         XPnYh8qj2+e6Ij00NrmKsFEyTZzFCEHLsSMdFfOPEBIPMJODSNBkQZswxqvPypCoerHN
         dL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=Fr9bP4yKrgn+E9VLuvfmfmluGhI3zEgNYPwc50h39x8=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=N1ZtNx53+vtI6ohgCdvHhtd9Kfbp92omlQQbwGaErWPQqDsGxR+gkxn26zdK9/FxJp
         pahbQrHTVQHyrRNxPZUSErpn/eXHBm23KVh0ITI2DIib/zeTKM7tT+QPJIuhBYPYjuKh
         w6SX3yLonmjIUCbSGIBKBzosINck1woTNLnWnBRapoR1v8VjrKhn5VtJpnrawWEfGmRR
         AVgMPP5vGZ4knhVm58/7QFGgwqppdYGClXGHUPg7X3wruJNo3ztcod5uiytDZKpKmOF2
         A4HX4lTxntqA4dvaL8WgLSEKuLn22nzKkG53m5Yw1HOp3tU2UaaMziHHdHUJA+Yx15aI
         CX7A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781882895; x=1782487695; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fr9bP4yKrgn+E9VLuvfmfmluGhI3zEgNYPwc50h39x8=;
        b=B5JpeUCMuRJsX8Hlu+qt3HzUjGz8aypbGpqupj47GqcnTnJgBZrN1Zd9z8M9QZzov9
         B4TJDrFg8iXhCTL8g/eNRgLN89RphlqfqNQIZJ274j4/WeEVc+ZEDfP9ToqjqJ9oQ3kW
         /T4UDLXbzPbkNS+R+k/6QMya51/wJh3LfobOUxpKIXGpgCKUuMp5aFWP+V2XqvusFKYG
         yIoWFsKyPFZB0VHFmSDPOugWitCQsCY/cQpG4PXmi0vuK5tpYVJqD8tEYMGOFxCOeT3n
         82dApwDRc5RmTdVD7UJiQzwhQBPKC2VuoqXZz/odNfey2wYe/+DFgtQ8cPlAaiHBOane
         oPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882895; x=1782487695;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr9bP4yKrgn+E9VLuvfmfmluGhI3zEgNYPwc50h39x8=;
        b=a80YHT7QZ+cdlEGU1NRVC7TtZidVdEoDcPjaQaklSk1P8D759dI7BV3bn0x5SJ4Ify
         StbMCNPu/ZwDaORdOnqyyFOciPTntUYs8pR5lnk38CH/17MUoe79qZ2ClxAfo5Fg8zc/
         cb7hmUoQ3ZGbkJo4ailzO/g/pSUOfx7eiStUAGMyX+1bV8Dfio8Tyqam6d5MvNhT1GX7
         fmZ7NGduP9Wn+4iCtE3WYkKUPc85vTlqlHbIPN8DwYTwMvr8D4upvMKM5NHZJFqZefYh
         02o5Z26oCe2C12ifKbifjlEiynRGT34e3VUipVCmfoCb34kFPx9rf4PNvs6QLP9LnIN3
         wXyQ==
X-Gm-Message-State: AOJu0Yw/h3yyMbzqX1GaeB/NA6DAWaIu8OKP/vXKh7JJ1rPeYUxBgf1v
	9mZdX1JzFYkOElWK81/gFR0U7HDCF5hHMLBuR36SCl5Hgavlo0q5l88SWES/9sWRo3VYvVHoPil
	y9QmynvPuRAY+hA1HRdR2/SXFxOucwOASPTdOOURybdWoe4hQYCdD8/HA8EOrk0GMlkKinXvnBS
	snCqhyyDUqGwU4QXfN8ij/uROq6pD9hKeaCEarq18QJ6ry+1XYhZ+qB/8aKAkCFOo=
X-Gm-Gg: AfdE7cl5Nwwp0MqkE7DyGefpcsYGWP6y4a59fXoEJJ2Nw+8pMZfGhzga60lgOJ2m0E/
	FAOkytVW8U4E9ieyrO2zXb5yEmdHRp6vcBZTMHEIB5N7ayZqe34jRnpotmuMiCHED+y40n++uSL
	6LdjxgQaIOgL4YLfOnAcUcoaUkTZ9m2W3EWK+ym7HqK419ik5Fup+/egdLRx3dus9gQsE7Zg==
X-Received: by 2002:a05:620a:2914:b0:915:f27f:e711 with SMTP id af79cd13be357-9208ef62cadmr629189485a.19.1781882895341;
        Fri, 19 Jun 2026 08:28:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2914:b0:915:f27f:e711 with SMTP id
 af79cd13be357-9208ef62cadmr629180985a.19.1781882894716; Fri, 19 Jun 2026
 08:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260618160001.3634123-1-jose.quaresma@oss.qualcomm.com> <18BA3836CC54C3CA.777602@lists.yoctoproject.org>
In-Reply-To: <18BA3836CC54C3CA.777602@lists.yoctoproject.org>
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:28:03 +0100
X-Gm-Features: AVVi8Cdw-54OHsMb9f6XciEhDiJ--8lQeTcolfrY5G4202Zef71LJsdtrSqCtpQ
Message-ID: <CADWMC-ZH54PRvLvs9LcYprEa4xWBKn44Oj_zmbzPfHU9eZFm1g@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][wrynose/linux-firmware][PATCH
 3/3] README: add LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000f8a15106549cf0b1"
X-Proofpoint-GUID: GB71uEUb_aVxiIEtIp0_3arhK9lIU5c5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE0NiBTYWx0ZWRfX+gjBEfi1GVf6
 p+tRi+nAgstxe83/jomJnTZ6TuFViAwkYgk7AeBKViXC0lSZhyV330Mvx1ijqY28kruvk7sNDuH
 9FcE1G6XcPXFSzT7usUcL2sFKQqR48d6itbjbt+/9IXR1IHFNtzc0yPoQI+ECbB6O8GFwlz1yEF
 5dkKBSsMJIgRKF8xlWMJx8QcWUQEVYbQSbmPPY3twGpF2ppBAXgNWsB+ck4it8yfZRIbkZ3Hkni
 7oY9xjIVCR6s9uvLaeHdQThURAYJg58q8V5GeuNh4fYrfTjBtroqFE/FfxTw1oTgotli4CIsY9I
 O6BX05IUipqmkaJ+lPdt3PctI909RGZkxDRJlaH44NAL/CBypsw9Yg9Wkpoazhj7Oh+vIX/UhNb
 vhbdxkeiyciAj9fXVxLeMM8ls3G6aA9mt5CoLSB4ov0bXbzyNJ4DxzR7HT5p/jw3xmMQpQvlJ3N
 TRnpVc9SAMOWhbo1Fdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE0NiBTYWx0ZWRfX6Sk/x7stVK8K
 OQqjxrVEclv09fYrHhkeHo2sk5CLlZNjGTFFRrGPeqax/v6EKHyrt6jUGfV0NrQeTjbZU0H5ixj
 WDKmY180JfM6y3TDd73YUqvlaCa9EwM=
X-Proofpoint-ORIG-GUID: GB71uEUb_aVxiIEtIp0_3arhK9lIU5c5
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a356010 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8 a=iyPUdX_cPefzozqtezIA:9 a=QEXdDO2ut3YA:10
 a=-RUQQrSqqC3Qtx740x8A:9 a=HLa-ZP_F0Ac1NzM3:21 a=lqcHg5cX4UMA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190146
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Jun 2026 15:28:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4250

--000000000000f8a15106549cf0b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:00=E2=80=AFPM Jose Quaresma via lists.yoctoprojec=
t.org
<jose.quaresma=3Doss.qualcomm.com@lists.yoctoproject.org> wrote:

> In order to make this layer Yocto Project Compatible, the layer should no=
t
> provide
> new versions of packages by default. Because of this, the recipe provided
> in this
> layer will not be used unless the
> LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
> variable is modified.
>
> Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
> ---
>  README.md | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/README.md b/README.md
> index 16c0d8c..deeca33 100644
> --- a/README.md
> +++ b/README.md
> @@ -8,6 +8,16 @@ and officially Wrynose supports only that. This thin
> special-purpose mixin layer
>  is meant to provide a current Linux firmware for Wrynose by backporting
> the
>  linux-firmware recipe from the master branch of openembedded-core.
>
> +In order to make this layer Yocto Project Compatible, the layer should
> not provide
> +new versions of packages by default. Because of this, the recipe provide=
d
> in this
> +layer will not be used unless the
> LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
> +variable is modified. The default value is:
> +
> +```
> +# DEFAULT_PREFERENCE for linux-firmware provided by the layer
> +LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE ?=3D "-1"
> +```
> +
>

I have merged these changes but this also breaks the Yocto Project
Compatible check layer.
In reality, I think the concept of the mixin layer will always break the
Yocto Project Compatible,
because the desire of the mixin layer is to introduce a more recent version
of the one
provided by OE-core.

I'll have to revert those commits, but I'm looking for a way to do this
while maintaining
the layer Yocto Project Compatible. If anyone has any suggestions, I would
appreciate it.

Jose


>  Dependencies
>  ------------
>
> --
> 2.54.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4249):
> https://lists.yoctoproject.org/g/yocto-patches/message/4249
> Mute This Topic: https://lists.yoctoproject.org/mt/119869596/10043485
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/15218491/10043485/37=
1561030/xyzzy
> [jose.quaresma@oss.qualcomm.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000f8a15106549cf0b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 18,=
 2026 at 5:00=E2=80=AFPM Jose Quaresma via <a href=3D"http://lists.yoctopro=
ject.org">lists.yoctoproject.org</a> &lt;jose.quaresma=3D<a href=3D"mailto:=
oss.qualcomm.com@lists.yoctoproject.org">oss.qualcomm.com@lists.yoctoprojec=
t.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">In order to make this layer Yocto Project Compatible, the layer should=
 not provide<br>
new versions of packages by default. Because of this, the recipe provided i=
n this<br>
layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFEREN=
CE<br>
variable is modified.<br>
<br>
Signed-off-by: Jose Quaresma &lt;<a href=3D"mailto:jose.quaresma@oss.qualco=
mm.com" target=3D"_blank">jose.quaresma@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0README.md | 10 ++++++++++<br>
=C2=A01 file changed, 10 insertions(+)<br>
<br>
diff --git a/README.md b/README.md<br>
index 16c0d8c..deeca33 100644<br>
--- a/README.md<br>
+++ b/README.md<br>
@@ -8,6 +8,16 @@ and officially Wrynose supports only that. This thin speci=
al-purpose mixin layer<br>
=C2=A0is meant to provide a current Linux firmware for Wrynose by backporti=
ng the<br>
=C2=A0linux-firmware recipe from the master branch of openembedded-core.<br=
>
<br>
+In order to make this layer Yocto Project Compatible, the layer should not=
 provide<br>
+new versions of packages by default. Because of this, the recipe provided =
in this<br>
+layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERE=
NCE<br>
+variable is modified. The default value is:<br>
+<br>
+```<br>
+# DEFAULT_PREFERENCE for linux-firmware provided by the layer<br>
+LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE ?=3D &quot;-1&quot;<br>
+```<br>
+<br></blockquote><div><br></div><div>I have merged these changes=C2=A0but =
this also breaks=C2=A0the=C2=A0<span style=3D"background-color:transparent"=
>Yocto Project Compatible check layer.</span></div><div><span style=3D"back=
ground-color:transparent">In reality, I think the concept of the mixin laye=
r will always break the Yocto Project=C2=A0</span>Compatible<span style=3D"=
background-color:transparent">,</span></div><div>because the desire of the =
mixin layer is to introduce a more recent version of the one</div><div>prov=
ided by OE-core.<br><br>I&#39;ll have to revert those commits, but=C2=A0<sp=
an style=3D"background-color:transparent">I&#39;m looking for a way to do t=
his while maintaining</span></div><div><span style=3D"background-color:tran=
sparent">the layer Yocto Project Compatible.=C2=A0</span><span style=3D"bac=
kground-color:transparent">If anyone has any suggestions, I would appreciat=
e it.</span></div><div><br></div><div>Jose</div><div><span style=3D"backgro=
und-color:transparent">=C2=A0</span></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
=C2=A0Dependencies<br>
=C2=A0------------<br>
<br>
-- <br>
2.54.0<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4249): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4249" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/4249</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/119869596/100=
43485" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/=
mt/119869596/10043485</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/15218491/10043485/371561030/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.yoctoproject.org/g/yocto-patches/leave/15218491/10043485/37156=
1030/xyzzy</a> [<a href=3D"mailto:jose.quaresma@oss.qualcomm.com" target=3D=
"_blank">jose.quaresma@oss.qualcomm.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000f8a15106549cf0b1--

