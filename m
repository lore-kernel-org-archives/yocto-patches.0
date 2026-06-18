Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45844CD98FA
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 15:22:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21920.1781796145178693208
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 08:22:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=leucrwr4;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=JrOZo/ZP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFGx991953321
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=b+xK9zl39YoBdRT26feVyw9v
	0+KcYinndeoWWicoxCY=; b=leucrwr4pGoCNoEK2jdjwG4m3+Wvv7QIvpb0YWuf
	Wv5rrQhsbR8Zxg3q61kcekF2bn7ap/cDrOfcPcTs/JZxZE6ymFVXbmh3Y4AWwsB4
	1od+ezLE8ebGilDAgiTo9uZebONY+lTDrwKiEdx+K6/T92BM09XQDgL7r7WWaz4h
	wbif79mtzrHtPEWVaVcwuTSOAQOFP2XCc1/sCgTBgUBbA5heBNMIDw//kRJ482uH
	XXmwI57393kS9hx1AP/jsOSBs9hd7pjthL1+ykURpqonCSVsN/WqMohZ9LSU9J3Y
	kdkguN8hn67OLO6c/SXrM97SfWhXH1sJaMP5jEhAGkSp5A==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1rtuurf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:22:23 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-660e9ff05c1so1921321d50.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 08:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781796143; cv=none;
        d=google.com; s=arc-20240605;
        b=irhtJ6O/MfWlgg43zWQU/PHwR6WIC+CAK4th7U0VstiXa7j3u+dwlWSXmI6ZQNFdyE
         p09m6gtrUfEv3xbj3yzGiaUlKc8sGLqPYO1u/Rhvh6X+P1HXUK86xISW9SGwJUGyJYTV
         gzK5YdrxzQA0ol2TVsQ+iRW9GoXwFB12oW9Pe16Gllaa0hRWCi0KMdgWv23l20FP8aeP
         Rz4n+eskx2CUrcyQvcaa98VamiMRcQMC57Abey40mswmlFPtJqnQBiRjGoBqafxis4T3
         MiDnZCkMxFoPBp1SXC5g6tJ++xWffnz4rzb+CPWxBNk8dgE2vyJxT5dZ2/OPZNXtue/M
         mrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b+xK9zl39YoBdRT26feVyw9v0+KcYinndeoWWicoxCY=;
        fh=zxgxdXi5ZYqu52obbj2c4rCG513/R/jegBbZCN/+NgA=;
        b=Lhcsxlrk6Bd7BrJXASc30HzQUXyC3vvs83NfPBb/GXy2kEDkNTx1yNYf7XUZaX/h/o
         AQuZsQZxJEq4SVr5HbpwSuMQcq+ocozhsQaIdxF7y3/+gcm5Bjwkap2+quF4liXs3M+3
         WKiq+Elb7tbpGDu8dx6EUBVB7RAVLtLalvX2lf8E4SBzvLkFhxD0io/GpVuTGyv8fld7
         uHXdsBlj4Wt0IrA39uOAJr65wA0Z0naZZsd1iRW80cARjI+/dtjWPaud0IY5uzV8nQzP
         Vek2WUXQil2OVG5BZB0wRekijI3QxpNPELgMJa7gxEDRjNo0A5sz5XTq6GtDpNRhc0cR
         8/zA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781796143; x=1782400943; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b+xK9zl39YoBdRT26feVyw9v0+KcYinndeoWWicoxCY=;
        b=JrOZo/ZPfdwrHsnZbr85kqw0bIUr9HLbrXAIig9skiZUa4vBWZtJ+r/kRa7hQreyMY
         fJdvL5fsBuwU+CgH6YcpLQyDQrFeoNeSngsDGROuuc/inZBDXZbRgDHWEYg1h3VQ4bbL
         UNobgspjj8fFfqsdZ0uR9Gl7oSlpGvaa3HesSgAsB/jsdz3fZ/qA/70Fziu8yK84PrU/
         hOmdi5Pek5ijT1tv/p4WKcbd3DlWGmPVyU/rWANSgNa95tCVXCpU1uWirRTQgcTgCGqL
         FvpG5Sh0Ha8lEYRLi3CcsUc9SyCZv0CLXczbxxHpwhFzoupC8nlq7EU7glteJ8G/W+oU
         BOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796143; x=1782400943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+xK9zl39YoBdRT26feVyw9v0+KcYinndeoWWicoxCY=;
        b=jvkn6nAyOXPDYEBxugr15CcZZ6kzgeg4v28HAODJ598DOFRt0Z3hKF9pLGwLAWdCjX
         uBx+MvBk0t1yaa/Q0Swa2qGerwRcYUOSQU4JWSvFUGbGWNekyIKJiRmNQIqymfueQaSA
         sceZqbzfTrJ6/GsoHSF2kuD5OeZtE81YGeceRcIH8CLHaez1aen/KD6cdjamSq4f1kyS
         QnplwAUe7eNNaYCxOJQlp9CMtytnjtxCD9NOAWYDJHs08cAjGZKzLMLCbxUgRNKYP2mS
         Ig6dPnXZc4BinHn9D7lVaTJInts61aKdbocpWtrqLYCVwtjyDvqDr3jiSK/Yq7Z8cKRE
         Ib0A==
X-Gm-Message-State: AOJu0Ywus4sfYIj+D517oWvNgokAkgXV+WEn+vcLefoDRK8VWrTXGRRN
	OwKrNcT3pjRjWly03H8iu5FmcrA2kHtpr/lBhFPV2GZtwRnB6DLZms5pnBpa5Vr1RR2QbqlGwq4
	cTzC9CyQ7O7XirCajf6Gg3sZUkp4+jd7WMeL5L/8aGyacPy1Y45pl9WXcTVZ7DJNy9SXnJ3g3y6
	MybJ8S/n4WBDeqlOEiFqFlnKm91Y65u61sYbj6NkUY0CN8wKNptBsx
X-Gm-Gg: AfdE7cl0DpP9UtGRMqMJ0qefu2BLv0QJNNDcALRuxBd7isQWwsm+VEmCzSkLV9KwjEV
	QL2ZCJE7TPfDnPRSqHIQEiMk66eXB4xDatJ/EtxUYDtgOFnZJc17nShDDPtEL+B/YtdE7SUw9hN
	MTjdLQnwyMgUFBPJ0+9+yOO2FDMgNQb5phUqrOBM0tbR8E/xidJlcS3sDkcP279yP7vnLQow==
X-Received: by 2002:a53:c704:0:b0:660:6b45:18b0 with SMTP id 956f58d0204a3-662fcba7ec5mr13567d50.30.1781796142772;
        Thu, 18 Jun 2026 08:22:22 -0700 (PDT)
X-Received: by 2002:a53:c704:0:b0:660:6b45:18b0 with SMTP id
 956f58d0204a3-662fcba7ec5mr13512d50.30.1781796141924; Thu, 18 Jun 2026
 08:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
 <20260617-fix-check-layers-v1-2-d1b60c899440@oss.qualcomm.com>
 <CADWMC-ao_--=gUSFnQnqvpN=yXOR+Cc9XuJOum39DfJrr30ZKA@mail.gmail.com> <CAO9ioeX6kqfTDyks2DVooEuvN8G08N_BkBg=LKR2N0kyF=FTBw@mail.gmail.com>
In-Reply-To: <CAO9ioeX6kqfTDyks2DVooEuvN8G08N_BkBg=LKR2N0kyF=FTBw@mail.gmail.com>
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:22:10 +0100
X-Gm-Features: AVVi8Cf_QWnNAPOlhkyafN8oM20AdtYYAogk85a_EYzItyF7_IFN4ra-Ol2BZ84
Message-ID: <CADWMC-Yd0=mb0bfMh2LqmzXgHJE+KCpNiWSR2r3qaQAyf8tT8w@mail.gmail.com>
Subject: Re: [meta-lts-mixins][wrynose/linux-firmware][PATCH 2/3]
 linux-firmware: set DEFAULT_PREFERENCE to "-1"
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: yocto-patches@lists.yoctoproject.org,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="0000000000001c68fb065488becd"
X-Authority-Analysis: v=2.4 cv=MNpQXsZl c=1 sm=1 tr=0 ts=6a340d2f cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-fW8gjcklFZlZc3AO3gA:9 a=QEXdDO2ut3YA:10 a=gsB7tEvTAAAA:8
 a=jdhz5oimLmThTTFTkW8A:9 a=damgO5p0eNm9Wisb:21 a=lqcHg5cX4UMA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=IXsN1-T0KV0ZAiTuZHq4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0MSBTYWx0ZWRfX6bs+PxVm9tr1
 15wH07jXTRUX//QuzKU7MM8mkOsaztB0ub/T3jSqrvn8hdZaDhO4pYkqIJLTASISz1PFcrHPUsp
 ujSYr6E4IgFpX1PhvaGMcdPEkp4WbXKpt+mWMUEVteGWc9sxV5u14zEtWggJ2QcRDIkHA76MdeC
 YV6qNufgukzlkhbvbo5DDTwO22quIdJW6I0iwvZR0pPBtpI7Bd7s9bysvizu4UQ5b0ioVBvR11L
 iNJ5+RokCPR2qRrqOzd0RPCVxb8LhBWcm2wGxDqytDTPpwNdTcKiQDlvJWhYyhy2jKV6SUDi0fu
 xnb5whHUyN62ROQ7eRywDa01sSNQka4xOK0RmdttX2ABzMJLxdK7RJ5h5tQfmuCJ0ZdxKhUfEWE
 XwSKC0en1zY8ygdAsfuwS2K5wZxA7Qc4S4XFr5Jv/y2bVXqg4ywFmXkyXBLnMfVKunzuwnb6hcE
 0CDLeQVPcKC3HyoDABQ==
X-Proofpoint-ORIG-GUID: A5YZVoSxJA8Apn-lfLUCF317Ve8IUln7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0MSBTYWx0ZWRfX9xVu53GaoAo3
 zKRJkYzzMCbsNJAW5YBfE1YCXD57xtp6YCe5eIcR2mBxrsXmpYp9lUHoSDQJm9nULxxo2lE/bDN
 865MW0Tw0srSHqkiDj1cJuEfVn0cbPY=
X-Proofpoint-GUID: A5YZVoSxJA8Apn-lfLUCF317Ve8IUln7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180141
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:22:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4242

--0000000000001c68fb065488becd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 11:31=E2=80=AFAM Dmitry Baryshkov <
dmitry.baryshkov@oss.qualcomm.com> wrote:

> On Thu, 18 Jun 2026 at 13:29, Jose Quaresma
> <jose.quaresma@oss.qualcomm.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Wed, Jun 17, 2026 at 8:21=E2=80=AFPM Dmitry Baryshkov <
> dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>
> >> In order to make this layer Yocto Project Compatible, the layer should
> >> not provide new versions of packages by default. The easiest way to
> >> achieve it is to set DEFAULT_PREFERENCE to "-1" for the new versions o=
f
> >> the recipes.
> >>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >> ---
> >>  recipes-kernel/linux-firmware/linux-firmware_20260519.bb | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
> b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
> >> index 7eb9bf35fbe3..f2cd8737f253 100644
> >> --- a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
> >> +++ b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
> >> @@ -3692,3 +3692,6 @@ INSANE_SKIP:${PN} =3D "already-stripped"
> >>
> >>  # No need to put firmware into the sysroot
> >>  SYSROOT_DIRS_IGNORE +=3D "${firmwaredir}"
> >> +
> >> +# Don't prefer it by default
> >> +DEFAULT_PREFERENCE =3D "-1"
> >
> >
> > With this change this recipe will no longer be used by layer users.
> > Until now, to use the provided linux-firmware recipe, all you had to do
> was add the layer.
> >
> > I would prefer to continue having something similar where no additional
> configuration
> > is needed to use this layer.
>
> This exactly contradicts with the Yocto Project Compatibility
> requirements. The layer should not be changing the default
> configuration.
>

After several tests, I couldn't find another way to do this.
I'm going to introduce a new variable to control the choice of
linux-firmware.

Jose


>
> --
> With best wishes
> Dmitry
>

--0000000000001c68fb065488becd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 18,=
 2026 at 11:31=E2=80=AFAM Dmitry Baryshkov &lt;<a href=3D"mailto:dmitry.bar=
yshkov@oss.qualcomm.com">dmitry.baryshkov@oss.qualcomm.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 18 Jun 20=
26 at 13:29, Jose Quaresma<br>
&lt;<a href=3D"mailto:jose.quaresma@oss.qualcomm.com" target=3D"_blank">jos=
e.quaresma@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Dmitry,<br>
&gt;<br>
&gt; On Wed, Jun 17, 2026 at 8:21=E2=80=AFPM Dmitry Baryshkov &lt;<a href=
=3D"mailto:dmitry.baryshkov@oss.qualcomm.com" target=3D"_blank">dmitry.bary=
shkov@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; In order to make this layer Yocto Project Compatible, the layer sh=
ould<br>
&gt;&gt; not provide new versions of packages by default. The easiest way t=
o<br>
&gt;&gt; achieve it is to set DEFAULT_PREFERENCE to &quot;-1&quot; for the =
new versions of<br>
&gt;&gt; the recipes.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Dmitry Baryshkov &lt;<a href=3D"mailto:dmitry.barys=
hkov@oss.qualcomm.com" target=3D"_blank">dmitry.baryshkov@oss.qualcomm.com<=
/a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 recipes-kernel/linux-firmware/<a href=3D"http://linux-firmwa=
re_20260519.bb" rel=3D"noreferrer" target=3D"_blank">linux-firmware_2026051=
9.bb</a> | 3 +++<br>
&gt;&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/recipes-kernel/linux-firmware/<a href=3D"http://linux=
-firmware_20260519.bb" rel=3D"noreferrer" target=3D"_blank">linux-firmware_=
20260519.bb</a> b/recipes-kernel/linux-firmware/<a href=3D"http://linux-fir=
mware_20260519.bb" rel=3D"noreferrer" target=3D"_blank">linux-firmware_2026=
0519.bb</a><br>
&gt;&gt; index 7eb9bf35fbe3..f2cd8737f253 100644<br>
&gt;&gt; --- a/recipes-kernel/linux-firmware/<a href=3D"http://linux-firmwa=
re_20260519.bb" rel=3D"noreferrer" target=3D"_blank">linux-firmware_2026051=
9.bb</a><br>
&gt;&gt; +++ b/recipes-kernel/linux-firmware/<a href=3D"http://linux-firmwa=
re_20260519.bb" rel=3D"noreferrer" target=3D"_blank">linux-firmware_2026051=
9.bb</a><br>
&gt;&gt; @@ -3692,3 +3692,6 @@ INSANE_SKIP:${PN} =3D &quot;already-stripped=
&quot;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 # No need to put firmware into the sysroot<br>
&gt;&gt;=C2=A0 SYSROOT_DIRS_IGNORE +=3D &quot;${firmwaredir}&quot;<br>
&gt;&gt; +<br>
&gt;&gt; +# Don&#39;t prefer it by default<br>
&gt;&gt; +DEFAULT_PREFERENCE =3D &quot;-1&quot;<br>
&gt;<br>
&gt;<br>
&gt; With this change this recipe will no longer be used by layer users.<br=
>
&gt; Until now, to use the provided linux-firmware recipe, all you had to d=
o was add the layer.<br>
&gt;<br>
&gt; I would prefer to continue having something similar where no additiona=
l configuration<br>
&gt; is needed to use this layer.<br>
<br>
This exactly contradicts with the Yocto Project Compatibility<br>
requirements. The layer should not be changing the default<br>
configuration.<br></blockquote><div><br></div><div>After several tests, I c=
ouldn&#39;t find another way to do this.<br>I&#39;m going to introduce a ne=
w variable to control the choice of linux-firmware.</div><div><br></div><di=
v>Jose</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
-- <br>
With best wishes<br>
Dmitry<br>
</blockquote></div></div>

--0000000000001c68fb065488becd--

