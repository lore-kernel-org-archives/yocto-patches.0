Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.355.1793036301804710739
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Oct 2026 10:38:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TycNpBgq;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91b83459526so40791236d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 10:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793036301; cv=none;
        d=google.com; s=arc-20260327;
        b=Cbt1L97IO5g16Tma+gu4MP//53nMQu6Gzzlw73cgq7M7AloaEWUer8bvpdCGsiptTt
         igKxpwPk0TWvOpbwyaGqKEiWYNxb//puBDrmxjYNEm4ZJSbcP3QRJZX8oMOdPQ6cxS0A
         V0TkrH2eJs4eFpz7u7uiwxhQ6LUF8dOirDn3yKAFGMKF3kfb4RslVMxOJa1HojaWagLm
         uGTCUgIgaNC2v4ejwvgzJmF8i1msob+OrAdAyTED6qhaWSKznxjOGlMClvyM3lei4/kU
         QV2NSX6RrPrBGdqur6RXDg/mKJodb8/5VwtioabaIQXyMSbtEPOmZXsXqy8ti1OnMwS7
         x2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rSN/+hCtIUteAeepEd66jyU1gAO3L5Q1mYU7pw1qytY=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=Q4XK9lujvZAtt4If86eEY4l3hvPu3mOsimslUGxpcg4trQQCPBHFH/XfxLEkhgGqOM
         Z/Gj2oBGn5T5vvLUWStw5otzPIYs6pFszLLmijxyUu3/cCrn1CvubSMuVsos12qIf6WX
         fiu7HJe5cLzRJumd214fT19vr0bDWSI4fyqV9TMrTP8Q4wZny4UMHEVbcjG2ZH6gnYVV
         dC8LpIA2y+fVbcL/gpVQqH9XT4k/2EXoPxEM50i9ZRPAEyNx0EuAeV8CWVoA7234MHgm
         h7u5W3ntaeT3zdTdEMP6s45ww/B80gPhwlrWyRTlOjyHJaIGTXEE5gM+DHw9370w3Iyt
         n2nA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036301; x=1793641101; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rSN/+hCtIUteAeepEd66jyU1gAO3L5Q1mYU7pw1qytY=;
        b=TycNpBgqdurLITW7xoC/cikDO6SriUfqQ7c9FWvx+wyglFh5CsyZn5ubQSjYBacdZY
         eIlDXMQpizV27BGlLh//e6ovnWtG71R562OEKeylkhe/hwypmfvM7JsDAJQRDJtyuOMD
         5B9IH10LBu5HVhZOPHvV01fJq4LB1zZrXPyNQ4dHdrd4TR3WemO3FqtUPbdyxH1afsSn
         dhb1lvv3WtGPos+14XJJASgemIwiKM++5qiNcjVtKgaYh3nhR0g6f5In1P2GQ/22PRi0
         Ie/OulWmAY0mj6NwrnieoUFcHxLJXqAoIIC1DU3tbMi6nVI28HDNffWXBpnUsryUYNOE
         djOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036301; x=1793641101;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rSN/+hCtIUteAeepEd66jyU1gAO3L5Q1mYU7pw1qytY=;
        b=UjpbAQeWe/IY7P1kzHJF+2160c88eAbUaA4/WF2cibChKsdqnQELl3gzz5GUDT2pQU
         2QHb5XSz4I0bi5J2fFYzkGo9lTB+rQ3av/k+8hc2V+V0pplovne15RpK08pQFWwW4sMu
         t9JWgCOuhjhlWwRR7pXYmqYjfWATdAuHf+nwK/jqJoECtWAVrqWDj4fFFn3NbBScNLu0
         m9dmOdw6O0CJhdqOUComPA2qEmRbTnZDHAPZYO0y8IkPbTp4Fox9dgH14Vf4nOYr8kTI
         dp3bJhY1chL7Flusew5GecvPv1o1TSqsOpd0aMMTbX3LyWAMoEc11/VO8PlVJ97spiGp
         nxKA==
X-Gm-Message-State: AFq9FYKuNo7K490Oj+mggn5Pq5Pq0S4NbsZVdjjgOCik8Z2DX9QllJt2
	Ed28YOka7e9ZU/F4xKL62YnBaIuble/rWFvezuSoVX0GErOF5X1a2sdyIolAM4XwTe6+CATsVXf
	Tl6f7z/VLdWDR4hM6CAvlXQGYDJZ24xk=
X-Gm-Gg: AYBFou1vC4mM+9RDtMQaNKJVQkTLhcTMsoUNF4YbeJ5hP++NuSwGIx+LSyOtRka6koo
	IuK3rNjzTmIW9XHqUyF+wWdOnTlSJViaxBpqOWzG0P3DEBEJmefeBFj/y5m2itm2MxgF3vsN7tH
	yfxDBybja4czPVlx7brP3Q8HBjOypJg202Ciu68BQ7JQjE4Dx+Z0AqiyqDGrD+UEjW6NQ9LH1D9
	eCzrx0FyH0o8CSzlvevCH367cnLC/yrdeZwbbKLtnscqlMQ+ZxyBl0ehX4gVULztY4I73/ExYHp
	cVn9aMXlV9T09BdkqUTZd9tPArYVfll3raWVcx1n5zUFF6C4ed0lLDeVFbvfUtySf6V0TRt62dH
	0Aa3Zs0Wf2rYsu/z1VB11re+Yfvhob5Bt09q6y22lOnOEXAzapIBOpqpFy6odMf7MgbVUHlGg6j
	/UA+lSbdot7QZi0wtO
X-Received: by 2002:a05:6214:248c:b0:915:eacb:cb94 with SMTP id
 6a1803df08f44-91c48d2ccf1mr117840206d6.6.1793036300487; Mon, 26 Oct 2026
 10:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261026135414.3796371-1-daniel.turull@ericsson.com>
In-Reply-To: <20261026135414.3796371-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 26 Oct 2026 18:38:08 +0100
X-Gm-Features: AclHuK8ZPgMLmYNax7LqpFGXs58Hwy_dQn0wFkzHGcY7nLIp6EwNquvJn_P_Uhs
Message-ID: <CANNYZj_LbDRhghETUXXVYWfLzvjOLV5GY4ZZ19tXz8J_vFoJyw@mail.gmail.com>
Subject: Re: [AUH][PATCH v3 1/2] steps: refactor _get_changelog to update pkg_ctx
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000c28f77065ec1cb16"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 17:38:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5159

--000000000000c28f77065ec1cb16
Content-Type: text/plain; charset="UTF-8"

> +def _get_changelog(pkg_ctx, workdir):
> +    """Copy the changelog generated by devtool upgrade to workdir and
> +    store the changelog data in pkg_ctx."""
> +    pn = pkg_ctx['PN']
> +    base_path = os.path.join(os.environ.get('BUILDDIR', ''),
> +                             'workspace', 'changelogs', pn)
> +    changelog_path = base_path + '.txt'
>      if os.path.isfile(changelog_path):
>          try:
>              with open(changelog_path, 'r', encoding='utf-8',
> errors='replace') as f:
>                  text = f.read()
>              shutil.copy2(changelog_path, os.path.join(workdir,
> '{}-changelog.txt'.format(pn)))
> -            return text
>          except OSError as e:
>              W('Failed to copy changelog for {}: {}'.format(pn, e))
> -    return None
> +            return
> +        if text:
> +            pkg_ctx['changelog_text'] = text
>
>
Apologies, that's not quite what I had in mind. The intended suggestion was
to read the json once, and assign all of its fields as a property of
pkg_ctx. Then when the actual changelog content is needed, it would be
obtained through fields of that property, since it already contains the
filename of the actual text.

Alex

--000000000000c28f77065ec1cb16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"></div><div dir=3D"ltr"><=
div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">+def _get_changelog(pkg_ctx, workdir):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Copy the changelog generated by devtool up=
grade to workdir and<br>
+=C2=A0 =C2=A0 store the changelog data in pkg_ctx.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 pn =3D pkg_ctx[&#39;PN&#39;]<br>
+=C2=A0 =C2=A0 base_path =3D os.path.join(os.environ.get(&#39;BUILDDIR&#39;=
, &#39;&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;workspace&#39;, &#39;changelogs&#39;, p=
n)<br>
+=C2=A0 =C2=A0 changelog_path =3D base_path + &#39;.txt&#39;<br>
=C2=A0 =C2=A0 =C2=A0if os.path.isfile(changelog_path):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(changelog_path, &=
#39;r&#39;, encoding=3D&#39;utf-8&#39;, errors=3D&#39;replace&#39;) as f:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0text =3D f.re=
ad()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutil.copy2(changelog_path=
, os.path.join(workdir, &#39;{}-changelog.txt&#39;.format(pn)))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return text<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except OSError as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0W(&#39;Failed to copy chang=
elog for {}: {}&#39;.format(pn, e))<br>
-=C2=A0 =C2=A0 return None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if text:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkg_ctx[&#39;changelog_text&#39;=
] =3D text<br><br></blockquote><div><br></div><div>Apologies, that&#39;s no=
t quite what I had in mind. The intended suggestion was to read the json on=
ce, and assign all of its fields as a property of pkg_ctx. Then when the ac=
tual changelog content is needed, it would be obtained through fields of th=
at property, since it already contains the filename of the actual text.</di=
v><div><br></div><div>Alex=C2=A0</div></div></div>
</div>
</div>
</div>

--000000000000c28f77065ec1cb16--
