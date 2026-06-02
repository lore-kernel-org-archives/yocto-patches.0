Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1366DCD6E57
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 10:22:26 +0000 (UTC)
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21657.1780395740324750631
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jun 2026 03:22:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=ElNaycpS;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=KXhNgrIy;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.157, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53E981400256
	for <yocto-patches@lists.yoctoproject.org>; Tue,  2 Jun 2026 06:22:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 06:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780395739; x=1780482139; bh=o+qceiOR57
	yqENkksiN6qWKXxoqIG1xH8VxmL9iBNGk=; b=ElNaycpSC7xKsyZpHkWHe7WReM
	Ak74m6jlxIgkmwLL78JrOZVK+i9ttZtCgTyzseMkBWkht8IiJAUH1cZtVbFjOtO+
	Ysltx84iwkxTqVlteFsoUQ5jZtfzlW7MC+8NgE5CTet52ZgG0JNvnKYg76tN9igv
	mu9U1vnZQI8fj42ZIcDuQtSAi66dLi/fojpqaYDxQJNGoCYFjEYOftXkxuOq/BQ7
	Kh/wx/cHGVjwbu7G0miZc4ENjeIROIZsM+rZcUqDbLOw/VrGG3FVQIJvAb0S19R5
	/btUdS9l8tKfNWo9de0DyZK2mzhdggmYXY1v7Nc+HrugkajfbRKPtcRQ71Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780395739; x=1780482139; bh=o+qceiOR57yqENkksiN6qWKXxoqIG1xH8Vx
	mL9iBNGk=; b=KXhNgrIyqH0zZdmX9G4bhaxa8LqvazWiCF1otuYaQ6yJR21bY4i
	CtQlc6O7LHRECij6+K+h1VzeEiWO0dYJT3YwiZ9B16ZMtcd3PSQ2lbgjZoZX846S
	Xl/FjF/USfjTmg/6fzjIKRM8aE57uErMHRlU6dRullxFFfh3nvQQN7hI6yIUDjMU
	cu/OEN0oTG7gIaXzJyjaLfsm1rsnKwkeTlc5Ps+VvrMSn1AeNrnh5cP804CLZKgj
	pqANVu78Nsh7y0TY6jwu2aeYqSXainG9Sem+uar4rcq4ByZlCd0lLm74A2O6d94K
	mix4VE7AcFiWls3p8njtpQsZriMrITt+YYw==
X-ME-Sender: <xms:2q4eao6H6_C7WMhB7h-f27uzRfvVEugksAnOALMxFwQvXd9VIVv9PQ>
    <xme:2q4eag1gmvHtarLZ6fL8zS-5709zIF-fNKpm7KkVrEujVGnn4pN2VJoX_8XX8d7lq
    dqCZBKI8JoAwitS5SIe9K5HUPaApcxHgBlu9OPjJeSZ4eymmlp38zg>
X-ME-Received: <xmr:2q4eatH-JN-aQyW-XKNOxcM684fNPGlf1K6kZLVyelqs472SONb05m0vNscvAro9Sm0MWZFIrv4NmT9qd8E89rxd0IoKBZccgacz8yeuaB1SGm9c87WNjA0BowQl7wto>
X-ME-Proxy-Cause: dmFkZTEKfEH2x7JothJ2QyqS8SKnJqnZJV7nxf/dQ29y6Cvns8MezsI6Zz1/lCgZLgqznw
    obViteoGOk0bVu0ofx/DbNwxiC4sxjNlAukqgsU4xj3uNmvxR6jPbdicK8zfATr/Hq4nfo
    upzWVGDllz04+nQbOHjJ1G9awlkGYlmM48tV16X7eHvRYJJNlp/4Lt2UH/V8kKrPernSTC
    97N92lHx3U8hEec5OJXysLiaHqFQ41pCVS7dUx6xKIKVRQbNXuhlD7wJS+ZPbfqkqO7CXa
    MVAs7ITfn+akJUaeU+BWQiXM7CXxfK+AfY+HzJ/5615JiL39sF9tUgpyIAMwxe07hoMQMu
    RLs8/62Bw7kkCGBXzNMqe/vLNeB/uKixO1KLJ2xnzdBG0AfhwpCPz1XG/FauuOlwGPFMp6
    8IP52M/WXT0Gi8Kc4sb3fIyD5buUltCz//2msk8xQqR1xq9zCvjFweIn3NL8Ss0SaSLMsT
    pMIPoX/k82M2ZMEPUpseAI4rbrRwtOtwfu2vTOYWg0TCqlBAOWkRcoyPH7+uCR42+6iIBo
    34AgDsrk3cAfjkJFE4o3ZbJSybyfN/Rk1u+Eq1+Rznu3P8rZH7HSS/0g79dc8xSABhc6te
    r282kUzqvRI6mFATexNKKHa08rXbVHdbrCeiA0Y0G1ktcOdGHAQY54JJRHLA
X-ME-Proxy: <xmx:2q4eaiTG0c4fV4yX9BBMRtqyS4T0m5XwEHEREMe6OGShM4Hz7wHBJA>
    <xmx:264easCqqglk_O-6Zm-og8U77phoO3i_nRjzqrNomdvrOqq5TaPMbA>
    <xmx:264eaq0gvh2kCQ_D0BJRmeqI_p8A7RABQtgkRn7b-Vn4gM829e_FMQ>
    <xmx:264eaiVhyq_5xMOH4cH_GeyKJVWz0Jrbqya3e6fat-G9fP6Pju0-Xg>
    <xmx:264eavp-L01BYVB9zey7_rGRJ9f4weTraYRyqAlTXRPYkXWH3k3HTnz->
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Tue,
 2 Jun 2026 06:22:18 -0400 (EDT)
Message-ID: <02f0c35f16a8a51bbe0e89145353008f67180a84.camel@pbarker.dev>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 01/10]
 scripts/utils: fix stale extraction dir when tarball is updated
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Tue, 02 Jun 2026 11:22:14 +0100
In-Reply-To: <ee99d892018112109ab1b0e6f3ec8899918bdc52.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
	 <ee99d892018112109ab1b0e6f3ec8899918bdc52.1780354513.git.tim.orling@konsulko.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-IZ80TxJP/PDl/1n/P4NN"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 10:22:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4110


--=-IZ80TxJP/PDl/1n/P4NN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org
wrote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Previously the entire download/cache-validation block in
> setup_tools_tarball() was guarded by `if not os.path.exists(btdir)`.
> Once the extraction directory existed from a prior build, every
> subsequent call was a no-op: the cached tarball was never re-validated,
> so a freshly-published SDK (e.g. vcontainer-tarball-latest) was silently
> ignored and the stale btdir kept being used.
>=20
> Fix by moving the lock/download block outside the btdir existence guard
> so cache validation always runs. Track tarball_updated to know when the
> cached download was actually replaced, then remove the stale btdir when
> True so the fresh tarball is re-extracted.
>=20
> Also add an mtime-based staleness check for local-path (cp) sources so
> that a newer source file automatically invalidates the cached copy.
>=20
> AI-Generated: Claude Cowork Sonnet 4.6
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>  scripts/utils.py | 64 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
>=20
> diff --git a/scripts/utils.py b/scripts/utils.py
> index 88842f0..87acad6 100644
> --- a/scripts/utils.py
> +++ b/scripts/utils.py
> @@ -481,31 +481,49 @@ def setup_tools_tarball(ourconfig, btdir, bttarball=
, name=3D"buildtools"):
>          if ";" in bttarball:
>              bttarball, sha256 =3D bttarball.split(";")
>          btdir =3D os.path.abspath(btdir)
> +        btdlpath =3D getconfig("BASE_SHAREDDIR", ourconfig) + "/cluster-=
downloads-cache/" + os.path.basename(bttarball)
> +        btlock =3D btdlpath + ".lock"
> +        if not os.path.exists(os.path.dirname(btdlpath)):
> +            os.makedirs(os.path.dirname(btdlpath), exist_ok=3DTrue)
> +        # Always run the cache-validation / download step so that a fres=
hly
> +        # published tarball is detected even when btdir already exists f=
rom a
> +        # previous build.  tarball_updated is set to True whenever the c=
ached
> +        # download is replaced, which triggers removal of the stale btdi=
r.
> +        tarball_updated =3D False
> +        while True:
> +            try:
> +                with open(btlock, 'a+') as lf:
> +                    fileno =3D lf.fileno()
> +                    fcntl.flock(fileno, fcntl.LOCK_EX)
> +                    if sha256 and os.path.exists(btdlpath):
> +                        dl_sha256 =3D sha256_file(btdlpath)
> +                        if dl_sha256 !=3D sha256:
> +                            os.unlink(btdlpath)
> +                    elif bttarball.startswith("/") and os.path.exists(bt=
dlpath):
> +                        # For local-path sources (e.g. vcontainer-tarbal=
l-latest)
> +                        # invalidate the cached copy when the source is =
newer so
> +                        # that a freshly-published tarball is always pic=
ked up.
> +                        if os.path.getmtime(bttarball) > os.path.getmtim=
e(btdlpath):
> +                            os.unlink(btdlpath)
> +                        os.unlink(btdlpath)
> +                    if not os.path.exists(btdlpath):
> +                        if bttarball.startswith("/"):
> +                            subprocess.check_call(["cp", bttarball, btdl=
path])
> +                        else:
> +                            subprocess.check_call(["wget", "-O", btdlpat=
h, bttarball])
> +                        os.chmod(btdlpath, 0o775)
> +                        tarball_updated =3D True
> +                break
> +            except OSError:
> +                # We raced with someone else, try again
> +                pass

Hi Tim,

This loop allows us to handle random OSError conditions caused by a
race, but it turns a deterministic OSError into an infinite loop. The
logic already exists, you're just moving it around, but now I have seen
it I cannot unsee it!

Should we add a timeout while we are here?

> +        # If the underlying tarball changed, remove any stale extraction
> +        # directory so it is re-extracted below.
> +        if tarball_updated and os.path.exists(btdir):
> +            print("Removing stale %s extraction at %s" % (name, btdir))
> +            subprocess.check_call(["rm", "-rf", btdir])
>          if not os.path.exists(btdir):
> -            btdlpath =3D getconfig("BASE_SHAREDDIR", ourconfig) + "/clus=
ter-downloads-cache/" + os.path.basename(bttarball)
>              print("Extracting %s %s" % (name, bttarball))
> -            btlock =3D btdlpath + ".lock"
> -            if not os.path.exists(os.path.dirname(btdlpath)):
> -                os.makedirs(os.path.dirname(btdlpath), exist_ok=3DTrue)
> -            while True:
> -                try:
> -                    with open(btlock, 'a+') as lf:
> -                        fileno =3D lf.fileno()
> -                        fcntl.flock(fileno, fcntl.LOCK_EX)
> -                        if sha256 and os.path.exists(btdlpath):
> -                            dl_sha256 =3D sha256_file(btdlpath)
> -                            if dl_sha256 !=3D sha256:
> -                                os.unlink(btdlpath)
> -                        if not os.path.exists(btdlpath):
> -                            if bttarball.startswith("/"):
> -                                subprocess.check_call(["cp", bttarball, =
btdlpath])
> -                            else:
> -                                subprocess.check_call(["wget", "-O", btd=
lpath, bttarball])
> -                            os.chmod(btdlpath, 0o775)
> -                    break
> -                except OSError:
> -                    # We raced with someone else, try again
> -                    pass
>              subprocess.check_call(["bash", btdlpath, "-d", btdir, "-y"])
>          enable_tools_tarball(btdir, name)

Best regards,

--=20
Paul Barker


--=-IZ80TxJP/PDl/1n/P4NN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCah6u1hEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0binIAP0ZdbdwF+Nnx077+l1ZU573bumo92EL+zqo
w4A3devlhwEA3dbBO3JfBnbEW+GaFkRv79J3n3HeT62HfAXx6jU9zgc=
=xBBX
-----END PGP SIGNATURE-----

--=-IZ80TxJP/PDl/1n/P4NN--

