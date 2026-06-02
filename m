Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12986CD6E4A
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 10:50:26 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22247.1780397422192792982
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jun 2026 03:50:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=6g9oqk4W;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=kfNw7LiK;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 57D70140026D
	for <yocto-patches@lists.yoctoproject.org>; Tue,  2 Jun 2026 06:50:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 06:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780397421; x=1780483821; bh=gEuD8x0Qg3
	ZDgGIn2hF1D1X2jpOFMOzhd4NzYfN2fMU=; b=6g9oqk4WvJ8qO8BbyOhJXH/NgU
	Chhak6ztvOhgsLm0Dib1JT49+rzDqH2Aci84U+bs4yEzRNoHtLsn6PBCltc/QAEs
	DudlmlyKJb+0mu1QIdS0BR/VyfkpeWRxoxB4a2kL+O5t7u+pzyyeg1IVlsh6+2ln
	g8niuq9fs3skPG4xYUI1G2LJJeWiWvAVu3J1gWXTEfDq6eeC5VQ8VXRBRtrS+MS5
	/gnE1SwuZQZ7VHfCk0XxiQnaZjAdQbEAGkOl1T7yK1zvMA+PMutQSXIqcBuYedXt
	81k27JHp+Pt+kFJjh5Ady77qt8jDjAqwcPu+8Q73t0EVrH9+kcFssaQG6o6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780397421; x=1780483821; bh=gEuD8x0Qg3ZDgGIn2hF1D1X2jpOFMOzhd4N
	zYfN2fMU=; b=kfNw7LiKcJAcuj7lhu+oXfJnYxTs8bhbQXxKBD9trYlfKuxJU4G
	zBDdAp2bgqNgYyICyeqAkTq6rkSkBV6QBjEGsNsXbv4HuaXV8MrbjnD2dCIcp5Tw
	wysSCDLvxcJpLk+y/Gz8IJjMagmVFd4thr334nWiynzWbjMIGMgOurFaDT8mrrOS
	b+WKq/JlVPIvbR8Ta8y9vaN9X4rvih7YxU9G4ge46RTLyL1TLVWJbo2YG72idwQM
	oo9oUXfmvgEGGgyLHFnIjUn72CCGfoJa4ca4gzmZmmbMBCWGqGeFAq22qcqaCWHZ
	FyrZ3tBtNedQLf6rgHLYr0+nIPjoqd8AddA==
X-ME-Sender: <xms:bbUeav-r-rtZEeJuNWw0amSMY9PARC4V07fEl_8X3oj1YFbZHekxIg>
    <xme:bbUeaipq9pcTOyvj8LgypJTYgG5xuwOg4mhpiTDmoNx5YtWUBYdqWJPDCcFMFvu0L
    KWtpUzI1VchGoaG1RqVZE_YxGP8fLoX3M7RXVqALb1TkZvjw6BJZPqa>
X-ME-Received: <xmr:bbUeaipbJ94MxCmtkuyRW5IIHwIc8YRhwOFXqRfU4BAjh3SH6WMTisqc6wcLRG7pwyfNUQBaTK7xRhyK1Hi_kmeMZXe2kJPSHnNFtadDkUk8UoeMkKk1LyQ4ZowRN9yp>
X-ME-Proxy-Cause: dmFkZTF7dNbvrs7v8aWmWRtymAo+hLIYU06ff2JuNeMyB6oQWSRxDQNuAg85ooeZzrATAz
    BkqfdE5qZ3wzEk05ISo8nBp8cITt+Vf8fCY0NKUV25XnAYGrTq6cH/+Gwwc4CTvvbWQHf8
    wRLcAAeew9RSe5588LWpfH9Gwp11xW1de09Seg909adrfOCAUi8V8SHU+Ee8xSgWKJSS2d
    NJaoRK06E9rfsCHGFmR2cCXR0Dtw7xGhBuOu9fWOwxPMleyxcRJPFFasECAxoawgPSgno2
    zfyquPfXDG1mZrW34Fg12pEHj/T92WRmcpbcHoQq04JXNSVYUjBcWkHD+j4VUZlEVpwOfu
    XfUi4maG/mkK04UxgA9RTJyQuTN9onLBMKaOd4yZL0KXgBV2NMmCE0SfwzQvkGfrfBNod7
    DmrqiokZiRHgFYTt5yWiW8FdhEM3sDlPuuaJHoqsp1c5IPPv6od+Kf5wV6zx6cooL+hNek
    doyfe9pagdLDmNZ0fyUR6uPmIod0O6kqTlFhUJg2gtbt+2UUp6sIr7nHl2YdblI56+gReY
    j4qtTKHlrcZqZkDIuCvjGw5qsNPCGc1HiALFOcA3m0As1DHY39to+mbuTWTYxhcBd4nPjA
    a1+KD8AT6WGP0+TcyxtuJeGbp0jTmJrPb8upNtpxIdRF2tOdyZKuDsjpshmg
X-ME-Proxy: <xmx:bbUeagkO19E4MYCp2tgU5oeXr66VVI9sA6G8_ee_-NnkgkLLwM9GGQ>
    <xmx:bbUeakEFnu7TdjgS0eH_Ng7A9FJvXc_i6AUOxD4Dp94xkDwhCk2o2g>
    <xmx:bbUeapqPl4nkPmGKFTHkEDnimWdEYdcnorGZUgRhde-DDlO8zHD0ng>
    <xmx:bbUeag6Kg73LfZsIdLgZ1NrRX5YVUCyV3keYvkpfYY_I0dJLNSOHlA>
    <xmx:bbUeam_3CVHLSan-AMu0TUFUVv42D44hWXTIqEvVNGSM3rG4og51VZj7>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Tue,
 2 Jun 2026 06:50:20 -0400 (EDT)
Message-ID: <812d7952df41c95d21bb77f6faecd245852df3a0.camel@pbarker.dev>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 07/10]
 scripts: add run-vcontainer-tests for meta-virtualization
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Tue, 02 Jun 2026 11:50:18 +0100
In-Reply-To: <1b74cb9ed9d6f1865141964682958160f4041d44.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
	 <1b74cb9ed9d6f1865141964682958160f4041d44.1780354513.git.tim.orling@konsulko.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-oKefNiDeS2jhrptNUKoF"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 10:50:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4111


--=-oKefNiDeS2jhrptNUKoF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org
wrote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Add scripts/run-vcontainer-tests, the test runner used by the
> vcontainer test jobs. It sources the vcontainer-tarball SDK,
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
> AI-Generated: Claude Cowork Opus 4.7
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>  config.json                  |  34 ++++++++
>  scripts/run-vcontainer-tests | 164 +++++++++++++++++++++++++++++++++++
>  2 files changed, 198 insertions(+)
>  create mode 100755 scripts/run-vcontainer-tests
>=20
> diff --git a/config.json b/config.json
> index 7206c41..79a9d10 100644
> --- a/config.json
> +++ b/config.json
> @@ -1890,6 +1890,40 @@
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
> +                "NOVCONTAINER" : 1,
> +                "EXTRACMDS" : [
> +                    "VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-t=
arball-latest/vcontainer-standalone.sh RESULTS_DIR=3D${HELPERRESULTSDIR} ${=
SCRIPTSDIR}/run-vcontainer-tests vcontainer ${BUILDDIR} ${BUILDDIR}/../meta=
-virtualization"
> +                ]
> +            },
> +            "step2" : {
> +                "shortname" : "Run vdkr pytest suite",
> +                "NOBUILDTOOLS" : 1,
> +                "NOVCONTAINER" : 1,
> +                "EXTRACMDS" : [
> +                    "VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-t=
arball-latest/vcontainer-standalone.sh RESULTS_DIR=3D${HELPERRESULTSDIR} ${=
SCRIPTSDIR}/run-vcontainer-tests vdkr ${BUILDDIR} ${BUILDDIR}/../meta-virtu=
alization"
> +                ]
> +            },
> +            "step3" : {
> +                "shortname" : "Run vpdmn pytest suite",
> +                "NOBUILDTOOLS" : 1,
> +                "NOVCONTAINER" : 1,
> +                "EXTRACMDS" : [
> +                    "VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-t=
arball-latest/vcontainer-standalone.sh RESULTS_DIR=3D${HELPERRESULTSDIR} ${=
SCRIPTSDIR}/run-vcontainer-tests vpdmn ${BUILDDIR} ${BUILDDIR}/../meta-virt=
ualization"
> +                ]
> +            }
>          }
>      },
>      "repo-defaults" : {
> diff --git a/scripts/run-vcontainer-tests b/scripts/run-vcontainer-tests
> new file mode 100755
> index 0000000..1394c7c
> --- /dev/null
> +++ b/scripts/run-vcontainer-tests
> @@ -0,0 +1,164 @@
> +#!/bin/bash
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Run meta-virtualization pytest test suites against the vcontainer
> +# standalone SDK (vdkr/vpdmn) that was built in a previous bitbake
> +# step.
> +#
> +# Arguments:
> +#   $1 - suite name: one of "vcontainer", "vdkr", "vpdmn"
> +#   $2 - bitbake build directory (${BUILDDIR})
> +#   $3 - path to the meta-virtualization layer
> +#
> +# Optional environment variables:
> +#   RESULTS_DIR     - directory to copy pytest artefacts (junit xml / lo=
g) to
> +#   VCONTAINER_EXTRACT_DIR - where to extract the standalone SDK tarball
> +#                     (default: ${builddir}/vcontainer-test-extracted)
> +#   TEST_OCI_IMAGE  - path to an OCI image directory (enables vdkr/vpdmn
> +#                     import tests)
> +#   VDKR_ARCH       - target architecture for vdkr/vpdmn tests (default:=
 x86_64)

Taking some arguments on the command line and others via environment
variables is confusing. I wonder if should use getopts to parse arguments.

> +#
> +# The script is intentionally conservative: any pytest tests that cannot=
 run
> +# in the CI environment (those marked "slow", "network", "boot") are ski=
pped
> +# so that the autobuilder step completes without needing network access.=
 Those
> +# can be re-enabled by exporting META_VIRT_PYTEST_MARKERS before invocat=
ion.
> +#
> +# It is assumed that /dev/kvm is writable by the CI user running the tes=
ts,
> +# since the performance is significantly faster with 'memres'.
> +#
> +
> +set -e
> +set -u
> +set -o pipefail
> +set -x
> +
> +if [ $# -lt 3 ]; then
> +    echo "Usage: $0 <suite> <builddir> <meta-virtualization-dir>" >&2
> +    echo "  suite: vcontainer | vdkr | vpdmn" >&2
> +    exit 2
> +fi
> +
> +suite=3D"$1"
> +builddir=3D$(realpath "$2")
> +metavirtdir=3D$(realpath "$3")
> +
> +if [ ! -d "$metavirtdir/tests" ]; then
> +    echo "ERROR: meta-virtualization tests directory not found at $metav=
irtdir/tests" >&2
> +    exit 1
> +fi
> +
> +# Locate the vcontainer standalone SDK tarball. Prefer an externally-bui=
lt
> +# SDK passed via VCONTAINER_SDK (the autobuilder -tests jobs share the S=
DK
> +# produced by the separate vcontainer-tarball builder), and fall back to
> +# looking in the local build's deploy/sdk directory when running stand-a=
lone.
> +sdk_tarball=3D""
> +if [ -n "${VCONTAINER_SDK:-}" ]; then
> +    if [ -f "$VCONTAINER_SDK" ]; then
> +        sdk_tarball=3D"$VCONTAINER_SDK"
> +    else
> +        echo "ERROR: VCONTAINER_SDK=3D$VCONTAINER_SDK is set but not a f=
ile" >&2
> +        exit 1
> +    fi
> +fi
> +if [ -z "$sdk_tarball" ]; then
> +    sdk_tarball=3D"$builddir/tmp/deploy/sdk/vcontainer-standalone.sh"
> +    if [ ! -f "$sdk_tarball" ]; then
> +        # Try to find any matching tarball in case naming changed (e.g. =
versioned)
> +        alt=3D$(ls -1 "$builddir"/tmp/deploy/sdk/vcontainer-*.sh 2>/dev/=
null | head -n1 || true)
> +        if [ -n "$alt" ]; then
> +            sdk_tarball=3D"$alt"
> +        else
> +            echo "ERROR: vcontainer standalone SDK not found." >&2
> +            echo "       Set VCONTAINER_SDK to an existing SDK installer=
, or" >&2
> +            echo "       build vcontainer-tarball so $builddir/tmp/deplo=
y/sdk/vcontainer-standalone.sh exists." >&2
> +            exit 1
> +        fi
> +    fi
> +fi
> +
> +extract_dir=3D"${VCONTAINER_EXTRACT_DIR:-$builddir/vcontainer-test-extra=
cted}"
> +rm -rf "$extract_dir"
> +mkdir -p "$(dirname "$extract_dir")"
> +
> +# Self-extracting installer (silent, -y agrees to license, -d picks dir)
> +"$sdk_tarball" -d "$extract_dir" -y

Patch 5 in this series added support for setting up the vcontainer
tarball for a step. I think the commit message in this patch needs to
explain why we can't use that in the steps that call
run-vcontainer-tests.

> +
> +# Prepare a Python venv so we don't pollute the worker's system packages=
.
> +python3 -m venv "$builddir/meta-virt-test-venv"
> +# shellcheck disable=3DSC1091
> +source "$builddir/meta-virt-test-venv/bin/activate"

Note that this will shadow the venv we use when running test jobs on the
autobuilder workers. That may be ok, but we need to be careful.

> +# Avoid warnings by upgrading pip; install pytest/pexpect into the venv =
via pip.
> +python3 -m pip install --quiet --upgrade pip setuptools wheel
> +python3 -m pip install --quiet --upgrade pytest pytest-timeout pexpect

Do we want to automatically install the latest versions of these tools,
via the network, in each build? It's better to pin versions to ensure
that upgrades are planned rather than automagical.

Also, should we store this list of dependencies in a requirements.txt
file somewhere? Perhaps tests/requirements.txt in meta-virtualization.

> +
> +# Default marker filter excludes long running / infrastructure dependent=
 tests.
> +marker_filter=3D"${META_VIRT_PYTEST_MARKERS:-not slow and not network an=
d not boot and not incus and not k3s}"

Would it be better to have a positive marker, e.g. 'autobuilder', to
mark tests that we do want to run? That would allow us to maintain the
filtering solely in meta-virtualization instead of needing updates here
as well when things change.

> +
> +# Per-suite test file selection. Uses -k/-m for fine-grained filtering a=
nd
> +# keeps the CLI small for logging clarity.
> +case "$suite" in
> +    vdkr)
> +        test_files=3D(
> +            "tests/test_vdkr.py"
> +            "tests/test_vdkr_registry.py"
> +        )
> +        ;;
> +    vpdmn)
> +        test_files=3D(
> +            "tests/test_vpdmn.py"
> +        )
> +        ;;
> +    vcontainer)
> +        # Broad vcontainer/bbclass/tooling coverage that doesn't require=
 the
> +        # vdkr/vpdmn CLI harness to be running.
> +        test_files=3D(
> +            "tests/test_container_cross_install.py"
> +            "tests/test_container_registry_script.py"
> +            "tests/test_vcontainer_auth_config.py"
> +            "tests/test_multiarch_oci.py"
> +            "tests/test_multilayer_oci.py"
> +        )
> +        ;;
> +    *)
> +        echo "ERROR: unknown suite '$suite' (expected vcontainer|vdkr|vp=
dmn)" >&2
> +        exit 2
> +        ;;
> +esac
> +
> +pytest_args=3D(
> +    -v
> +    --tb=3Dshort
> +    -m "$marker_filter"
> +    --vdkr-dir "$extract_dir"
> +    --junitxml=3D"$builddir/pytest-$suite-results.xml"
> +)
> +
> +# Allow tests that consume an OCI image (import/save/load) to find one.
> +if [ -n "${TEST_OCI_IMAGE:-}" ] && [ -d "${TEST_OCI_IMAGE}" ]; then
> +    pytest_args+=3D(--oci-image "$TEST_OCI_IMAGE")
> +fi
> +
> +# Pass architecture through when set in the environment (default is x86_=
64).
> +if [ -n "${VDKR_ARCH:-}" ]; then
> +    pytest_args+=3D(--arch "$VDKR_ARCH")
> +fi
> +
> +cd "$metavirtdir"
> +# Don't let a single failing test kill the whole step - collect the juni=
t
> +# report, then surface the exit code via the junit file + exit status.
> +set +e
> +python3 -m pytest "${pytest_args[@]}" "${test_files[@]}"
> +rc=3D$?
> +set -e
> +
> +# Copy artefacts to the results dir if one was provided.
> +if [ -n "${RESULTS_DIR:-}" ]; then
> +    mkdir -p "$RESULTS_DIR"
> +    cp -f "$builddir/pytest-$suite-results.xml" "$RESULTS_DIR/" 2>/dev/n=
ull || true
> +    if [ -f /tmp/pytest-vcontainer.log ]; then
> +        cp -f /tmp/pytest-vcontainer.log "$RESULTS_DIR/pytest-$suite.log=
" || true
> +    fi
> +fi
> +
> +exit $rc

--=20
Paul Barker


--=-oKefNiDeS2jhrptNUKoF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCah61ahEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bqlLAP9yPHuDxk7jVdJYHvT/ANZwKkFC9Qa+D2gS
Bg2tiaG84wD/UXsD8QeYlsCQzyB1YRTCl3167xZdkJClB1US/b62aQk=
=MwSJ
-----END PGP SIGNATURE-----

--=-oKefNiDeS2jhrptNUKoF--

