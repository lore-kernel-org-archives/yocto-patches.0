Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7429EC44508
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 19:09:27 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1684.1784142557097946811
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 12:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=PQ14wf9u;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=TqyWnfZF;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DD1321D000B0
	for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 15:09:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 15:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1784142555; x=1784228955; bh=OWNxEYtNJ0
	2jhdKldmnWOyauchZB+DJQTrn3GW7DMhs=; b=PQ14wf9u86JAOtpN7quWM/W8NQ
	i7hmhnsgLk1Zhh2kMCn/DxF8rfv5UWpYegw3kEOazXDPU9maTfAvA7EhFPifD3qk
	lpl7+Sthid4HfNYt81Jm1uHAJW32I3Kjq98VkuOF1gyQUXgMl0PEXUp1sPjy3m0Y
	K2KcftULxSlVp937YYWZ648HnVXGkRxKcZbRewMb/gX1jXqwXDWwfqfmQbyTpATs
	iYqVY1TRR43R0obppuQn/oRQ3YdQoE3aNLdBCRAR71K0lqiqEHW2VAV1Af6zXb5+
	S+nxHw5SOmaaunNS6YKLFIDQsfEIWYGwngUdoinx/7dt8+h1I84uOfWuyOlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784142555; x=1784228955; bh=OWNxEYtNJ02jhdKldmnWOyauchZB+DJQTrn
	3GW7DMhs=; b=TqyWnfZFl40p6ovnh16dNT31rt/qgfSSUCHklnrVAvOKd+20ish
	5vKj5UnKu7F8oXwSbmm6ZLU9xxGe/rBGbwPVi6GYNt8WfVBfJvEZRAKArhyjtTRE
	fGND5wNHoOLVpUa+QwF0A8iGglr3lobnV+VgMhZNWYgb+rY+gkEvlR+t+Yie8GM+
	uIx+LwKwqLjIiNn5y4lCu/rrvG4TMftYxwKeJRqNxX2P/IqZj55iYgFDF6JYjAgR
	/Iaxmazoe4scR83AOz0yTUmE9iJ2q0cpglTFvMcPhrCl6NtHWZ0wsSqnLwEOSXeU
	Uxsq3JDR73pa6PuvJFPyCuLE1FSeENum+KQ==
X-ME-Sender: <xms:29pXangRLAnq0ziibB5M4rxtXUrzgqOHoatltDJis8QfjfUoqcrDCQ>
    <xme:29pXaq9UtVC2pn8DOeZvKxfnRtpAxsIzmFawITq-o0uXGv87Uf42sV2YqCl0e9zW_
    m5p2SmYzEsR5OinNP3YmguP_K_d4RE05yvcNBrfZuSMiiXCPu8EqvY>
X-ME-Received: <xmr:29pXasuzwJYgKrndoDqY5la-y3UT1iOo_7V2XS8K-XaxaI4MdRjOJ3ihV9UMmfTXKTXPOx0OfwJuoVcx7uT9uvb88pe2rPzd3cvcu7Qo4AMz>
X-ME-Proxy-Cause: dmFkZTEYDa9ES4/WsPH+s5gREf9aPn/JH/PyxSnCd+OWwqfViB3dcKxJgUMo5yqLZgYGoY
    XvrLzjrCI9n87x4Tzkx33Hu241y/adKDac7x3fm4UdlIsOPR1dOGnkSS9AD7TX0w37teRM
    6fyqV5HIxmQJPafXvJX6J1TDILlN1a30hcNSRFvR0G/0y5klZSLYGK3K5anv7c6oBRhock
    uXYJXWps61oQq4yoXTfUn3QC9JS0VvFSY6H8u9LcWZnrXmcz+0wwRGSXQDD1lgV2xpBN3g
    OS3bVqGmHZaZUK0WY+J8ulZVw3+t9n6FTeCxr/UY6IkPvj0HZqCan3bzgvOynoDelsfdin
    qXfieSuKF4FYDclZhR7FN3kaGc+AfrE5XPEHNz90P4qhQ84xU1P6U+b6ktohm/28Lh1oL1
    NnuewoAIbhlTVDsPQ1Eq8xjxw6mV3pr9LCaeyiwyjwXswjea6qm3j2ia5C6/LIcwO5fJAr
    lHbI+fMZO60cs+hApl9OMI6d2Ac5LSsK1o2bIDS4lcRirCRCuyfTJtxIy3CY1SbWarcj7c
    5QOHMpOor4tlyrZJR7Nq51Hj6K/z9xoazciWFD8HMzfPZzg7IKzXm62ZRKGhGJF0bQ59rQ
    8dPLnzX2+nShltexiS3+a/xUUrY1TWCF0Vn1i0Owi2T1fvPrPM0jlQgr0wPQ
X-ME-Proxy: <xmx:29pXapZwLoMXHhWR9wqhZtVwi9C2yNHTOplXjcShSP1bRMpovAF6Lg>
    <xmx:29pXakqpWRMx0bVkeIab5hugKg6XGor34KziyopefPktKht3c9mdoA>
    <xmx:29pXam99KMnzbVFQVnMWi9BhcDS3TakySy9QqL52FSTLr7H8ol6RDg>
    <xmx:29pXar8rQvqV6niClHmmEURGQ9gKhzh1xQTWFF24ixbWuuV3Lnju1A>
    <xmx:29pXagwnfsHBfZt2lBQ6zW_Wp-si5dCKxYbHhGeH1KuAlNgxIHE0oK3R>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Wed,
 15 Jul 2026 15:09:15 -0400 (EDT)
Message-ID: <e645c8e9df3e28a87b9daa07f220f023ee6287ca.camel@pbarker.dev>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v4 03/11]
 scripts: add run-vcontainer-tests for meta-virtualization
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Wed, 15 Jul 2026 20:09:08 +0100
In-Reply-To: <33fd6cf552070e50949e104771ed72746ff5921b.1783371914.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com>
	 <cover.1783371914.git.tim.orling@konsulko.com>
	 <33fd6cf552070e50949e104771ed72746ff5921b.1783371914.git.tim.orling@konsulko.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-SqA9jyDofHnsaJXPzxrB"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 19:09:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4481


--=-SqA9jyDofHnsaJXPzxrB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-07-06 at 15:05 -0700, Tim Orling via lists.yoctoproject.org
wrote:
> Add scripts/run-vcontainer-tests, the test runner used by the
> vcontainers-test job. It sources the vcontainer-tarball SDK,
> discovers the meta-virtualization pytest suite, and runs a
> configurable set of suites (vdkr, vpdmn, memres) against the
> checked-out layers. Suites can be selected per-step so the
> top-level 'vcontainer-tests' job runs the container engine
> agnostic tests:
>=20
> - tests/test_container_cross_install.py
> - tests/test_container_registry_script.py
> - tests/test_vcontainer_auth_config.py
> - tests/test_multiarch_oci.py
> - tests/test_multilayer_oci.py
>=20
> The 'vdkr-tests' and 'vpdmn-tests' jobs run only their respective
> suites (including memres for each container engine):
>=20
> - tests/test_vdkr.py
> - tests/test_vdkr_registry.py
>=20
> and
>=20
> - tests/test_vpdmn.py
>=20
> The purpose of this script is to test the just built vcontainer-tarball,
> so that it can be considered "known-good" and be published for use by
> container building jobs that need the vcontainer-tarball installed.
>=20
> AI-Generated: Claude Cowork Opus 4.7
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>  config.json                  |  31 +++++
>  scripts/run-vcontainer-tests | 212 +++++++++++++++++++++++++++++++++++
>  2 files changed, 243 insertions(+)
>  create mode 100755 scripts/run-vcontainer-tests
>=20
> diff --git a/config.json b/config.json
> index 972682d..ae13c5b 100644
> --- a/config.json
> +++ b/config.json
> @@ -1855,6 +1855,37 @@
>                      "install -d ${BASE_SHAREDDIR}/pub/vcontainer-tarball=
-latest && install -m 0755 ${BUILDDIR}/tmp/deploy/sdk/vcontainer-standalone=
.sh ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.s=
h.new && mv -f ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-s=
tandalone.sh.new ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer=
-standalone.sh"
>                  ]
>              }
> +        },
> +        "vcontainer-tests": {
> +            "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-virtual=
ization"],
> +            "ADDLAYER" : [
> +                "${BUILDDIR}/../meta-openembedded/meta-oe",
> +                "${BUILDDIR}/../meta-openembedded/meta-python",
> +                "${BUILDDIR}/../meta-openembedded/meta-networking",
> +                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
> +                "${BUILDDIR}/../meta-virtualization"
> +            ],
> +            "step1" : {
> +                "shortname" : "Run vcontainer pytest suite",
> +                "NOBUILDTOOLS" : 1,
> +                "EXTRACMDS" : [
> +                    "${SCRIPTSDIR}/run-vcontainer-tests -s vcontainer -b=
 ${BUILDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub=
/vcontainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
> +                ]
> +            },
> +            "step2" : {
> +                "shortname" : "Run vdkr pytest suite",
> +                "NOBUILDTOOLS" : 1,
> +                "EXTRACMDS" : [
> +                    "${SCRIPTSDIR}/run-vcontainer-tests -s vdkr -b ${BUI=
LDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub/vcont=
ainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
> +                ]
> +            },
> +            "step3" : {
> +                "shortname" : "Run vpdmn pytest suite",
> +                "NOBUILDTOOLS" : 1,
> +                "EXTRACMDS" : [
> +                    "${SCRIPTSDIR}/run-vcontainer-tests -s vpdmn -b ${BU=
ILDDIR} -m ${BUILDDIR}/../meta-virtualization -S ${BASE_SHAREDDIR}/pub/vcon=
tainer-tarball-latest/vcontainer-standalone.sh -r ${HELPERRESULTSDIR}"
> +                ]
> +            }
>          }
>      },

Hi Tim,

Would it make sense to merge the vcontainer-tests steps in to the
vcontainer-tarball job defined in patch 2 of this series? Essentially,
build the tarball (step 1), test it (steps 2-4, merged from this patch),
then publish it (step 5) only if it has passed the tests.

Best regards,

--=20
Paul Barker


--=-SqA9jyDofHnsaJXPzxrB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCalfa1BEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0boo6AP9UxNdxi08EG8bWZbenx4tU7IbHXmInkRg9
1abI4iK7LgD7BeLIfbdbeCFnQ2R49yd+HZbgoINvwWDEkD3EJxLdsQI=
=AQkS
-----END PGP SIGNATURE-----

--=-SqA9jyDofHnsaJXPzxrB--

