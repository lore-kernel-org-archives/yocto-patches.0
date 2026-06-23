Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACDACDB479
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 15:00:40 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23550.1782226835637832044
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 08:00:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=OpZpAqob;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3949583f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 08:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226834; cv=none;
        d=google.com; s=arc-20240605;
        b=AYqIyKHrYlqy3flzj0KjAu/WGwL345mPmuqoBReJdMpwwdVp/ZkCpLasoMpAYUh2Sd
         3X/RYY96YRxgOz5X5wYNmvJnHf0qpT1ITC854Z94Rj6KbhnHtimfeR4RNK+dU5LQtJDS
         aNZ7j+3nbyq9QLtgL5xMfazwhmg8QGM8gZ5peVqACxKkhYkymfyDm/hAZzqqU8NYRRut
         RMcn1zIMF5voBuuZqk5kQ8okL+3VwXeVCRBS5n3JfdXWbLLWc+RSmgh67m/c+wqwvwbL
         YoDSbVIW+PZ4LpugT2wlwGGCtZ7O1ji3sf6Sb4GumxmQchb/FLYJR0QMHams1hhmmQnJ
         MB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SVaeZti1l89ga+SUZIOfvdO7AZH7K5IkJVfgpXpZ+80=;
        fh=M1rTm719W3kwijwXRO5APaW6Snz4KFQQiD4FDkGMKQE=;
        b=WxifSei59XW5H4cO1rHz+nQ9vCOQ/Lm4kHpqPpac8ZhsNgpkw129Y4v6NGsX97mIAZ
         6Ah631w2cGxx99ThKCRDUw+FT0zRoISVSrABqHm64wYjl/mQJjOMF57DbSimS2FqMYqz
         ThmGXbeOJkKni/gyij/aljpBbwndHsH9/ozY82r+mD0kEx5agyV/R01dKQb9Y38KMykn
         Eoq0TvWgijzVg7uM76z2B69Mdb552xrGQlSurDqCjvegwPNsSXau0tVygmuOAgE3Qw+B
         7QPcD3QNKAlLV73IGnNoLtc7btSodv1bbeN6HA/Q0zdS1TF/dJzhotITsE7+0ygHCadl
         /Hpw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1782226834; x=1782831634; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SVaeZti1l89ga+SUZIOfvdO7AZH7K5IkJVfgpXpZ+80=;
        b=OpZpAqobB6er2MueOcybBhW5+RVSLIghW5xLb4k0ger+Nz1JnthHisMSoI2sj62iUt
         dmC3OGqOt6IGM2xD/xvPGHybkfRPtMr49bGZNyyjjVD29TjxtdxqbFOTkmbtaS2MeScE
         oyhepNcQ8CdyV2mpqPuFI1WlvX4NXtOkBlGJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226834; x=1782831634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVaeZti1l89ga+SUZIOfvdO7AZH7K5IkJVfgpXpZ+80=;
        b=G0AWOpXjCr3jmJXm+YWZzUWXyhv8rnItZHMivCyeWEsozz1z9REhnd3H3UONc8MVn0
         rn97HyShdcPmDSqTblhyjNzTmhAopq03v26WXO6UbKOIDGuenKwkcnDjIAtZ3GTx2+Vv
         fQafpLgEA3CIk/ILXF8ZHuqEmQ/byzubqekwZPu2SBUxN2vVJ8iGsS9bCafM8LofK6Pr
         Vnp/jQXUj0xi+gMLa5nGP8Kn5ZMO3w4GTXijFd42kxlMo+s7gdtu6A2bg36KOfdZzIAg
         HCJf31lNjxtcCfSluR73OdDolamzOXowWo/R+Cnc4xC/u6PRceP3fXbR4h9BpTwT9erT
         oJpg==
X-Gm-Message-State: AOJu0YyJl6DpT0rLW1PdL6KvTtW6RTdk9tO+LyV+UkovUeW2BTCf9KA1
	+59vlV0KsVYCy242HnNGafopvuiKq1u0inj7uaG5q/2cD7Pdt1D54Kz5d+mP/xkfT0TO8QVYmof
	z5LrJnm6tQ9mAMQp6WcbMM6PfVSxi2kLtPbv2uwR46M6WwtdtSsb7z94=
X-Gm-Gg: AfdE7cl4za0+QGaXxNNSnImry1LGv+GUz9LPvoQGcyB7P8q174qYCMkv0wRJ3zLU32k
	YoPe2kkTKQTGCJyN+C1VM+CTN4uTxLwoywR6dIw5zbSv98ItSwp5AwTQmd1lRHVCc0rt++wr+ZZ
	fwNh4v8c1M32zZ7HXyqR9EtfztiiSleiE/cFsfkbztEKeNOyq8xsFlioPTXinTjBd24SaB0Qc5t
	ZvreTO3CnrqdwjWh5ff2IDkA/dMQDNPwNTL4uiBJGQR2yAhnGo84vwTeJ3tdWURTLefhKd0NwjW
	m2RyA9qiTpAEo7EI6kqNrk9SpblOqeQ=
X-Received: by 2002:adf:f48e:0:b0:43c:f90b:5668 with SMTP id
 ffacd0b85a97d-46508afb01cmr25155955f8f.23.1782226832668; Tue, 23 Jun 2026
 08:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-mathieu-meta-lts-mixin-v1-1-0c552b4f6d28@bootlin.com>
In-Reply-To: <20260623-mathieu-meta-lts-mixin-v1-1-0c552b4f6d28@bootlin.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 23 Jun 2026 17:00:06 +0200
X-Gm-Features: AVVi8CcQ37HV3RdY-VwZ0sTnvDPs8y6m0eUirgZbc3YkyLYaH-sXxz9PUaalmUI
Message-ID: <CAMSfU+6ugN=eC4KkmkRfKOPFezUDrkeWaSnYDhRapmwfSO6gjA@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2] config.py: Add
 meta-lts-mixin layer
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Paul Barker <paul@pbarker.dev>
Content-Type: multipart/alternative; boundary="00000000000045603f0654ed05f7"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 15:00:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4285

--00000000000045603f0654ed05f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 23 juin 2026 =C3=A0 16:46, Mathieu Dubois-Briand via
lists.yoctoproject.org <mathieu.dubois-briand=3D
bootlin.com@lists.yoctoproject.org> a =C3=A9crit :

> meta-qcom wrynose branch has a dependency on meta-lts-mixin: we will
> need to clone it during some builds.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>

I reported that to meta-qcom:
https://github.com/qualcomm-linux/meta-qcom/issues/2457

I'm not sure the consensus is to keep the dependency (due to transitive
compatible status).

Paul, I think we need to discuss this with the meta-qcom maintainers.


>  config.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.py b/config.py
> index 63e8b5627ae2..438753395da1 100644
> --- a/config.py
> +++ b/config.py
> @@ -70,6 +70,7 @@ repos =3D {
>      "meta-webosose": ["https://github.com/webosose/meta-webosose.git",
> "master"],
>      "meta-qcom": ["https://github.com/qualcomm-linux/meta-qcom",
> "master"],
>      "meta-riscv": ["https://github.com/riscv/meta-riscv.git", "master"],
> +    "meta-lts-mixins": ["ssh://git@push.yoctoproject.org/meta-lts-mixins=
",
> "master"],
>  }
>
>  trigger_builders_wait_shared =3D [
>
> ---
> base-commit: 007f5ad32b586f52a4fe53e3069b7ff7f0461372
> change-id: 20260623-mathieu-meta-lts-mixin-56519ac98317
>
> Best regards,
> --
> Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4283):
> https://lists.yoctoproject.org/g/yocto-patches/message/4283
> Mute This Topic: https://lists.yoctoproject.org/mt/119941950/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/929=
767106/xyzzy
> [yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--=20
Yoann Congal
Smile ECS

--00000000000045603f0654ed05f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">Le=C2=A0mar. 23 juin 2026 =C3=A0=C2=A016:46, Mathie=
u Dubois-Briand via <a href=3D"http://lists.yoctoproject.org" target=3D"_bl=
ank">lists.yoctoproject.org</a> &lt;mathieu.dubois-briand=3D<a href=3D"mail=
to:bootlin.com@lists.yoctoproject.org" target=3D"_blank">bootlin.com@lists.=
yoctoproject.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">meta-qcom wrynose branch has a dependency on m=
eta-lts-mixin: we will<br>
need to clone it during some builds.<br>
<br>
Signed-off-by: Mathieu Dubois-Briand &lt;<a href=3D"mailto:mathieu.dubois-b=
riand@bootlin.com" target=3D"_blank">mathieu.dubois-briand@bootlin.com</a>&=
gt;<br>
---<br></blockquote><div><br></div><div>I reported that to meta-qcom:</div>=
<div><a href=3D"https://github.com/qualcomm-linux/meta-qcom/issues/2457">ht=
tps://github.com/qualcomm-linux/meta-qcom/issues/2457</a></div><div><br></d=
iv><div>I&#39;m not sure the consensus=C2=A0is to keep the dependency (due =
to transitive compatible status).</div><div><br></div><div>Paul, I think we=
 need to discuss this with the meta-qcom maintainers.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0config.py | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/config.py b/config.py<br>
index 63e8b5627ae2..438753395da1 100644<br>
--- a/config.py<br>
+++ b/config.py<br>
@@ -70,6 +70,7 @@ repos =3D {<br>
=C2=A0 =C2=A0 =C2=A0&quot;meta-webosose&quot;: [&quot;<a href=3D"https://gi=
thub.com/webosose/meta-webosose.git" rel=3D"noreferrer" target=3D"_blank">h=
ttps://github.com/webosose/meta-webosose.git</a>&quot;, &quot;master&quot;]=
,<br>
=C2=A0 =C2=A0 =C2=A0&quot;meta-qcom&quot;: [&quot;<a href=3D"https://github=
.com/qualcomm-linux/meta-qcom" rel=3D"noreferrer" target=3D"_blank">https:/=
/github.com/qualcomm-linux/meta-qcom</a>&quot;, &quot;master&quot;],<br>
=C2=A0 =C2=A0 =C2=A0&quot;meta-riscv&quot;: [&quot;<a href=3D"https://githu=
b.com/riscv/meta-riscv.git" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/riscv/meta-riscv.git</a>&quot;, &quot;master&quot;],<br>
+=C2=A0 =C2=A0 &quot;meta-lts-mixins&quot;: [&quot;ssh://<a href=3D"http://=
git@push.yoctoproject.org/meta-lts-mixins" rel=3D"noreferrer" target=3D"_bl=
ank">git@push.yoctoproject.org/meta-lts-mixins</a>&quot;, &quot;master&quot=
;],<br>
=C2=A0}<br>
<br>
=C2=A0trigger_builders_wait_shared =3D [<br>
<br>
---<br>
base-commit: 007f5ad32b586f52a4fe53e3069b7ff7f0461372<br>
change-id: 20260623-mathieu-meta-lts-mixin-56519ac98317<br>
<br>
Best regards,<br>
-- <br>
Mathieu Dubois-Briand &lt;<a href=3D"mailto:mathieu.dubois-briand@bootlin.c=
om" target=3D"_blank">mathieu.dubois-briand@bootlin.com</a>&gt;<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4283): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4283" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/4283</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/119941950/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/119941950/4316185</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13179410/4316185/929767106/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/9297671=
06/xyzzy</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_blank">yo=
ann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>
</div>

--00000000000045603f0654ed05f7--

