Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2585D3B7EA
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 22:40:28 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6133.1765233627906008286
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Dec 2025 14:40:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A6jV512n;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b9728a353so69994821fa.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 14:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765233625; x=1765838425; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bhnldEazVLeDh1geaH6fDS5E54m0masMxi6ixAmVYM=;
        b=A6jV512nbX3+NJRMxCjpqSO0gHm6Y9WyhcKwjGQZam+cqfMyULNAJQRfWCg8oglKR9
         Dv+/7hc9OTSwcjLSb4mjlNB5kPvAMtbL34I7XGcaiQlaDGWXXH2lVYRdFfZiZHimiw0I
         Dx0ObAge9svf9XYPb/7ESCMZZu7vFAE64lCMfU/nx+ETBlw0Dm/Z/3hPyaxX3qCfrOzk
         OVoETl33B1XM5WUIMCYuM//plZ8sRS6lWeX1HRq3k92rd9w70PB4zWkWhMidu1VrDCcX
         aCT6GxLeNYK0a7cXRcLVqij5WnpNrnsbuEjKsasiDtEijyIAMZbS11QJ3HF6U5L++Bxz
         /2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765233625; x=1765838425;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8bhnldEazVLeDh1geaH6fDS5E54m0masMxi6ixAmVYM=;
        b=qVtlPgTaElDMFohdphv3GYFRlws23u1xSlT2/yvDljj5aBubTfH3HvRfJgXwP73wPi
         9s/s5gUvrR/jrPp2uBBfjCS2sv4fhOQGhUUbA+B89rxMG7SNlvcmcvH9jXenNLa8VcPw
         0GrlcvFlZF5Dh3Pg3PNHjnqx/CL10AI/F6dqTz2f1GLj64NPh/+fxCx6dg5UwvGAk3Cy
         D67ouQpFcc/3NdfAClsMMmLXYGy7F2Di4yVrp9qrEyROCCuvPzOOuFe/Wvugm6Vpv1iZ
         0kXWwtA0VllHSXmn8T/VSqZM8jNOxLMRqWabrSCNJKPkjL8A1PLHvWetaAkQPTbKobI/
         K7UQ==
X-Gm-Message-State: AOJu0YzgN0ro9qjZWT4BCT54dLvIGIfb2a4ywIuHs73gUJ/1uCCgXTjz
	cGhquB0N3zrJAOPGH9F41EHPx1DeyY8FVvb1chuj5qU+mcDeOnDvBoN9/e19mLgpx2iViMvJ/IL
	STZSOWU2X+dGxqTNOMcRGTuyp4rSS2u8qPQ==
X-Gm-Gg: ASbGnct2eM44P25E8Gco7NPeYF6yr+c5E+lEX08hDGMSU5BtzhEnTEUVebOIWPOBIhO
	TaYYJheUJBPXrowVo9sQ585WAmBq6N4RwEosHeoMcN9m8YGK+dMubfCd+WeKU4Xqv/xP5+sPYNH
	DHTFh3+bZ9ORhfA8/L9/HqDH1JO1wrDCK7MgB2/gLONpWU9di+7vF4NDw9tilAUqVzbIG6Elv3l
	L+uWwxDagsksvD/x5t6kGfjfIBNWK3s2vyxJKxvmJxDUUgdIvJMxIB1cuiejJ4UYAvMFQ==
X-Google-Smtp-Source: AGHT+IHuwdYLXMS8dlEgHAqJbSalE6QQqNV/SmZtrFHIXDnZr7D4TE7ZeKj9GjDOe+61k1r/IDLJpYb8Stes5ICBOIc=
X-Received: by 2002:a05:651c:f17:b0:37b:9110:21c4 with SMTP id
 38308e7fff4ca-37ed83a0997mr20275091fa.31.1765233625065; Mon, 08 Dec 2025
 14:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20251208223118.374387-2-t.f.g.geelen@gmail.com>
In-Reply-To: <20251208223118.374387-2-t.f.g.geelen@gmail.com>
From: Tom Geelen <t.f.g.geelen@gmail.com>
Date: Mon, 8 Dec 2025 23:40:14 +0100
X-Gm-Features: AQt7F2qnrUJAXJT--k7_fedfJLcepBrWtMKPBPmr1cxhLlyCWzl6TGGKBpaQCKM
Message-ID: <CAJo0Az6wHkTjxxMYTnwbdxhq0VSnnXvDwtXuuRcd=5vy2NQ0Rg@mail.gmail.com>
Subject: Re: [auh][PATCH 2/2] testimage: adjust qmp detection for testimage
To: yocto-patches@lists.yoctoproject.org, 
	Alexander Kanavin <alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 22:40:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2753

Hi Alex,

This one I would like your opinion on. I have enabled a testimage in
my local AUH configuration but when upgrading something the message is
always that 'qmp' cannot be found. I adjusted auh now such that this
is detected from the image passed via 'testimage' in the conf file.
However it could also be that I'm overlooking something, in that case apolo=
gies.

Kind regards,

Tom

On Mon, Dec 8, 2025 at 11:31=E2=80=AFPM Tom Geelen <t.f.g.geelen@gmail.com>=
 wrote:
>
> When defining a testimage it will try to run an image via Qemu and need q=
mp. QMP is assumed to be provided. However this throws an error. Use the RE=
CIPE_SYSROOT_NATIVE of the testimage and set up the paths using this.
>
> Signed-off-by: Tom Geelen <t.f.g.geelen@gmail.com>
> ---
>  modules/testimage.py | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/modules/testimage.py b/modules/testimage.py
> index 849a9f1..0a0f924 100644
> --- a/modules/testimage.py
> +++ b/modules/testimage.py
> @@ -73,10 +73,46 @@ class TestImage():
>          return ' '.join(pkgs_out)
>
>      def testimage(self, groups, machine, image):
> +        # Minimal: derive native sysroot from the image's environment an=
d expose it via PYTHONPATH.
> +        try:
> +            # Use the image-specific environment; this matches what succ=
eeds outside AUH
> +            bb_env =3D self.bb.env(image)
> +            rsn =3D bb_env.get('RECIPE_SYSROOT_NATIVE')
> +            if rsn:
> +                I(f"AUH: RECIPE_SYSROOT_NATIVE (image)=3D{rsn}")
> +                pythonpaths =3D []
> +                libdir =3D os.path.join(rsn, 'usr', 'lib')
> +                if os.path.isdir(libdir):
> +                    for entry in os.listdir(libdir):
> +                        if entry.startswith('python'):
> +                            sp =3D os.path.join(libdir, entry, 'site-pac=
kages')
> +                            if os.path.isdir(sp):
> +                                pythonpaths.append(sp)
> +                    qp =3D os.path.join(libdir, 'qemu-python')
> +                    if os.path.isdir(qp):
> +                        pythonpaths.append(qp)
> +
> +                if pythonpaths:
> +                    new_py =3D os.pathsep.join(pythonpaths)
> +                    os.environ['OEQA_PYTHONPATH_NATIVE'] =3D new_py
> +                    os.environ['PYTHONPATH'] =3D new_py + os.pathsep + o=
s.environ.get('PYTHONPATH', '')
> +                    os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] =3D os.en=
viron.get('BB_ENV_PASSTHROUGH_ADDITIONS', '') + ' OEQA_PYTHONPATH_NATIVE PY=
THONPATH'
> +                    # Ensure oeqa picks up changes during task execution
> +                    os.environ['TESTIMAGE_UPDATE_VARS'] =3D (os.environ.=
get('TESTIMAGE_UPDATE_VARS', '') + ' OEQA_PYTHONPATH_NATIVE PYTHONPATH').st=
rip()
> +                    I(f"AUH: OEQA_PYTHONPATH_NATIVE set to: {new_py}")
> +                else:
> +                    W('Native sysroot found but no python paths; qmp imp=
ort may fail')
> +            else:
> +                W('RECIPE_SYSROOT_NATIVE not present; ensure qemu-native=
/qemu-system-native are available')
> +        except Exception as ex:
> +            W('Failed to configure PYTHONPATH for qmp: {}'.format(ex))
> +
>          os.environ['CORE_IMAGE_EXTRA_INSTALL'] =3D \
>              self._get_pkgs_to_install(groups)
>          os.environ['TEST_LOG_DIR'] =3D self.logdir
> -        os.environ['TESTIMAGE_UPDATE_VARS'] =3D 'TEST_LOG_DIR'
> +        # Keep TEST_LOG_DIR propagating alongside any previously set var=
s
> +        prev_update =3D os.environ.get('TESTIMAGE_UPDATE_VARS', '')
> +        os.environ['TESTIMAGE_UPDATE_VARS'] =3D (prev_update + ' TEST_LO=
G_DIR').strip()
>          I( " Installing additional packages to the image: {}".format(os.=
environ['CORE_IMAGE_EXTRA_INSTALL']))
>
>          I( "   building %s for %s ..." % (image, machine))
> --
> 2.43.0
>

