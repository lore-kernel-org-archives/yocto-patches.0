Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E76D4417D
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 11:00:24 +0000 (UTC)
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10215.1765537218324609660
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 03:00:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=lyqxECYh;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=vme0I/gn;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.154, mailfrom: paul@pbarker.dev)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7206514001E3;
	Fri, 12 Dec 2025 06:00:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 12 Dec 2025 06:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765537217; x=1765623617; bh=ra3nWqppK0
	MeJ17bXySgL5n/glQ3wNV49El7DiPvKIM=; b=lyqxECYhhMB2qgQuIJmEvD17Rx
	DBIkNt1xSX4knKBr7CUUlp/KbdSm05b5mm5GTkc5Lk7nmRcXBusel37MpKZhzEtJ
	QP6AOj50cwJpTXIkkaSk9bTxM29kJcDCTolkkKoHtmFDnxZpV7aBXnoiQhZd4oK7
	H3xuLQ2pL8Opn7InyGkJRaP46Vve0Zhly4BSTs2XYQFDAMYHTG4sL27CIn6AB6WR
	PbLO54DQm+qa/Eiiqf4vRawpTRS4Cjq2tKNKa4wYYcp3wY6g0i2UvIam70Zolp7T
	Epoo7dZr8Lg5zmx99OAtCJ2DcDzojryfm48VvhC890fwRRH1kCgAFPHnhq3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765537217; x=1765623617; bh=ra3nWqppK0MeJ17bXySgL5n/glQ3wNV49El
	7DiPvKIM=; b=vme0I/gnLXKjfemuwLFNcOBn9/d3ChabP9Pi/Rqhp2eGxp97WkM
	rglQr8vZyHuhnlz0/05UnVidUf41rE1Jz0kz01vtGXTjvO+514+a0ISFuV3DVgmT
	xQEhcBoKEN1UqhLbhhzjBoOek5DKKIbU4wi/Atv0WlCNImx4H3IgDYQqeSfehyZR
	OeAJx2ILNlw6/3PEF9E0hmVUXIgHyPV3VLTkQI7vs/z0YTrr7Xw1z5QkNoMajHd/
	PcFld+fRRNv9NG8eGMIjf7h5YiVYPBxeG9hu2TP8r8sPdixzMH3xutL8M5xHWsGn
	FdVCr6qz5TRpwZZ8xs/oe3GEaVW1wQAHOjw==
X-ME-Sender: <xms:wfU7aUreiTUhvevjFiLbEgLNcr9JAp4tZWanAzwows3P83cfXL-Gzw>
    <xme:wfU7aQrBNZq45WxwY-NHuEWmnMBSEg87lr2cmrRtXDbVhlR69lG4V24R65ATMfXSM
    ajsX5ja75dq3mwDJedMyORtQLp1sHKqlpm9iRUS94oj2P--q8xGJzs>
X-ME-Received: <xmr:wfU7aW0j08nHk6SBDYmtEi4fjTVS8cmLY-uzA3NZwE981U3sIYL47Lm-pQqYnxH_EoJsybuKTmaObZRqNw06OLpNVVLTybVEPQZtFXU5Y1pT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceurghr
    khgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnhepke
    egtdffkeeigeehueekgeeftdfgheefjeekjeffjefggfeitdelgfekkefggedvnecuffho
    mhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihotg
    htohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhr
    tghpthhtohepmhhhrghlshhtvggrugeslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:wfU7aXBMEPf8ogoqn9YQQuo2NxDRYPxiFcyNuu5RAxBCOYexVIiN7g>
    <xmx:wfU7aWepo1cStCx2PEDRyAmepwAs57L-5WD2jIjHdgfUAkMm8Vm-Cg>
    <xmx:wfU7aUiWbXXCq6PYtoIcDczrO0tfFrXMrSWhb6hZfMYRwkoqbgnmIA>
    <xmx:wfU7aWpfokp6yuGabKURZyzJvRTtyi_US_7Wek6hh5QMfJzlWkYhmw>
    <xmx:wfU7aVFgw84xI2fw2AbSYQABP0ecK22UljYPdzfjhiZsUfHQCqMPWAye>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 06:00:16 -0500 (EST)
Message-ID: <dfc12c5377a796cea8d376c031d3c60b843546e9.camel@pbarker.dev>
Subject: Re: [yocto-patches] [yocto-autobuilder2] README-Guide: Add
 yocto_console_view build directions.
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org, Michael Halstead
	 <mhalstead@linuxfoundation.org>
Date: Fri, 12 Dec 2025 11:00:14 +0000
In-Reply-To: <CADfgfobJCbbvjGO69kHKWu0NJtHqY11Fzx_jarXVXbbR7ezcmw@mail.gmail.com>
References: 
	<CADfgfobJCbbvjGO69kHKWu0NJtHqY11Fzx_jarXVXbbR7ezcmw@mail.gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-HPuQveBYlfj+HoSKJxsy"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 11:00:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2772


--=-HPuQveBYlfj+HoSKJxsy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-11 at 10:35 -0800, Michael Halstead via
lists.yoctoproject.org wrote:
> Adding directions we use to build for production.
>=20
> Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
> ---
>  README-Guide.md | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>=20
> diff --git a/README-Guide.md b/README-Guide.md
> index 69368b9..bee5a1f 100644
> --- a/README-Guide.md
> +++ b/README-Guide.md
> @@ -72,6 +72,78 @@ being triggered:
>  export LANG=3Den_US.UTF-8
>  ```
>=20
> +### 1.2.1) Building and Deploying the Yocto Console View
> +
> +
> +Build the Package on a Workstation
> +
> +These steps are performed on your local development machine.
> +
> +**Prerequisites:** You must have **Podman** installed.
> +
> +1.  Clone the `yocto-autobuilder2` repository and start a container,
> mounting the repository into the `/build` directory.
> +
> +    ```bash
> +    git clone https://git.yoctoproject.org/yocto-autobuilder2
> +    cd yocto-autobuilder2/
> +    podman run -ti --rm --volume .:/build:Z,U node:22 bash
> +    ```
> +
> +2.  **Inside the container**, navigate to the package directory,
> install the necessary build dependencies, and build the Python wheel
> (`.whl`) file.
> +
> +    ```bash
> +    # Run these commands inside the podman container
> +    cd /build/yocto_console_view
> +    apt update; apt install -y python3-dev python3-build
> python3-setuptools python3-pip
> +    python3 -m pip install --break-system-packages buildbot_pkg
> +    python3 -m build --no-isolation
> +    ```
> +
> +3.  A successful build will generate a wheel file in the `dist/`
> directory. You can verify this by listing the contents of the `dist/`
> directory.
> +
> +    ```bash
> +    ls dist/
> +    ```
> +
> +    You should see a file named like
> `yocto_console_view-2025.3.12-py3-none-any.whl`.
> +
> +4.  Once the build is complete, exit the container.
> +
> +    ```bash
> +    # Press Ctrl+D or type 'exit'
> +    exit
> +    ```
> +
> +-----
> +
> +Deploy the Package to the Controller
> +
> +These steps are performed on the Buildbot controller machine.
> +
> +1.  First, copy the newly created wheel file from your workstation to
> the controller. The file will be located in the
> `yocto-autobuilder2/yocto_console_view/dist/` directory on your
> workstation.
> +
> +    *Example filename:* `yocto_console_view-2025.3.12-py3-none-any.whl`
> +
> +2.  On the **controller**, switch to the `pokybuild` user, activate
> the buildbot virtual environment, install the new wheel, and restart
> the controller.
> +
> +    ```bash
> +    # Switch to the build user
> +    su - pokybuild
> +
> +    # Activate the Python virtual environment, if not already active
> +    . ~/buildbot-venv/bin/activate
> +
> +    # Install the package you copied over
> +    pip install yocto_console_view-2025.3.12-py3-none-any.whl
> +
> +    # IMPORTANT: Check that the cluster is idle before restarting at
> +    # Restart the controller instance
> +    buildbot restart ~/yocto-controller
> +    ```
> +
> +The new console view plugin is now deployed and active.
> +
> +

Thanks for documenting this!

The change looks good, but the patch has been re-wrapped when sending so
it needed a few lines to be joined together to be able to apply it.

Reviewed-by: Paul Barker <paul@pbarker.dev>

--=20
Paul Barker


--=-HPuQveBYlfj+HoSKJxsy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTv1vhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bgjNAP49sULNs0hwJa1FukFGHNPAR3p0e2/MKflW
A8cMG4nhGgEA1NpoelbbIVsb4n/+evZcuCSqXwgeSSIP8gsINDSUDQ0=
=v4Io
-----END PGP SIGNATURE-----

--=-HPuQveBYlfj+HoSKJxsy--

