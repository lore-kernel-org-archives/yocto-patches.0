Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B1CD8C89
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 03:06:08 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9591.1780715165492439182
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 20:06:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qU7lPTd/;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: ticotimo@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3967620ceabso25057531fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 20:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780715163; cv=none;
        d=google.com; s=arc-20240605;
        b=fQjG36NcSfI6a9TfmDOJkDghsxFNt+5i09tQJyVgekjY96WK++SQb9IMnkw/BkXaPy
         +Ka0Km+U2E2TZaIFW5GrkcGrxQC0IX7P28mK0DNDi/H2pVfssStNHVOh/zKs25RC4lIx
         QYkAKk/nxjSelY72KgVDF8qJtMjhhE2JoqZIEKkiB+66D3CNAnOrM/jCFJdemvbpEstF
         9m3cRKEypUAUcJDKTLcX+0NPWvDVQ6OQTssfIJLJV9hI7jp3Vl6Mt6iOolgi7su3c5mH
         fOur7mc2iWIgXzgd9Uh3vkOQeKc1V71t9GTS6poVLeBzXNIwrTzugvbN1afhjEv/teax
         pw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=TIxzpKirDb0Sce8c45kW9MAIuKaDP9iexhJThI22x/4=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=T+bH1w/d88bEen0sLn8nwGdknrVuuqk38HiU4f6Eugv4d4iAIWoWdY+k3XolCC7bYT
         RZgfIbr1QMX/JbDaflwcfkSC+aBv/nNpvPpqHoqDnAMYGFTzQqqT4NcCj7mVfOkkDTKx
         euFKSrmZ0DwCA2W7mZ7mWAHVSRqHSavxBnajfpf9vyHIelEYsVjPTqTp+bgNM6T4Ucgo
         CLX/PiHidZMb8wgejY7XFrDs0JLsbrjcLE0qcs8gzx9IsUQfYl6dOaaUgarCTN/hq2DH
         vGbWdAKdyiubR2rr69pyWBdby+gwdVNvcy58VhQ9pAFPqthTJnFHeWGIrKrxz7Y+sX+x
         8Kqw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780715163; x=1781319963; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIxzpKirDb0Sce8c45kW9MAIuKaDP9iexhJThI22x/4=;
        b=qU7lPTd/mrsURXOGKzjvcREQZoUjNV/2bjDiPRPGM3wxjLgMw9PuD18QALMUu6h0Go
         em4Y8odqwB1qn2LpefrRIJBFhDZ5MAz6MvmwTLqAlGZz/kNrHB953KejUJg+Pl+ZfWxf
         d/qc9hOvOB9iqdVz7Msoq8Ond+ZvO/8hVGro/FZ3+QLqOoWC39nxUc2ARysBD3KEDbW/
         LJioO899l66BYIedgFreXtJNDAETJBaKNB53FwTPa5KuVIvhDdEJLJEka5ILGrnXTbte
         TlRi4wTJK/cvMYpjyMbHD7Vmr9/9CPu4oEizELaHhrReoqIkJbschbDMZvOwR08ovPfs
         h/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780715163; x=1781319963;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIxzpKirDb0Sce8c45kW9MAIuKaDP9iexhJThI22x/4=;
        b=rVvmfKhVyeoyQILM61WMR1U86+HdoiRlTskqd5OXSmP//GgvdVcf6elVAXALZ/6HvE
         kGdVM6Sn8rshSxC4hU/LqsXepJqW+1/sZ7yjwPGmxoBzRp2aoUJKtLsRUJwKXPS/tuPr
         N/+vqHRmG1svFqlP5u/NW1dCdZOEQFne04V22RnClj+Tr44VD/mr7RVseNmLjDiiiQlE
         NSHTp9H8K06D1HRav7wX7VN4Cyzd4pW2ps42PaPkc0ZRWBGWl1uE5d+aktOVmKoz6LGR
         xNV/GsRDo6gA+w6+ak/4CB7544g9hq5cjOhGWK5udzg61nTC6qXr/UmZy1b3nePxue4v
         AKZg==
X-Gm-Message-State: AOJu0Yz8Wa03dUg9BtAUpVIlMKmG5ln4iOgy9DBi6ExJl0pLcRE3+3on
	nP6TaJwSD4WFvI60qXotRXYFtPBV/G8pbXEmG726IuI/QvDgT2f6YqwdgUboB12MhUijMy5zh5T
	lecJ2iaW0X9ZrIUpY/kxGElKL81Fw//HQ3V5F
X-Gm-Gg: Acq92OGFssDQTpLvAYgBNbTY2Sr4WlWSMD4L++aoKNyQsLq6y5UTryG6Jq/Sb+GyM3E
	j7UQXsMtXQT1iP9I+iCbY3RKHY509xmGGGjiyIk9Is4XdHmsvx+OlKfEzSoUQMyvMYfdzft/YcU
	u6221HufCpPIUPH3ej4V14z+fDR9z7T3DScBegWo6evauhdpitcmKv0f7iGNzniR9JLNxnkPnhI
	zSgzbijX0IyYtYhyaNj8vgTaGl9bZ05CddQGIsiNJ3xyoLgtGMeDeq/lg9L+bRNnIvsCt+tf7zs
	+gHTAv1LQNR0hSPuE5flb+v4Wacp
X-Received: by 2002:a2e:b8cd:0:b0:396:6705:d244 with SMTP id
 38308e7fff4ca-396d09fcb92mr17731011fa.28.1780715163025; Fri, 05 Jun 2026
 20:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780354513.git.tim.orling@konsulko.com> <1b74cb9ed9d6f1865141964682958160f4041d44.1780354513.git.tim.orling@konsulko.com>
 <812d7952df41c95d21bb77f6faecd245852df3a0.camel@pbarker.dev>
In-Reply-To: <812d7952df41c95d21bb77f6faecd245852df3a0.camel@pbarker.dev>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 5 Jun 2026 20:05:50 -0700
X-Gm-Features: AVVi8CfRoUVKLCVa0YeYP3rrmEaLAw3UVjOH0CGyBk3hSQn38UecBFGlp-pXkiA
Message-ID: <CANx9H-C4ju0cph4r6TJFCMMY4pnrDA=+jy8v4C7ZRu_-uHAj5g@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 07/10]
 scripts: add run-vcontainer-tests for meta-virtualization
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000bd05ad06538d0e8e"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 03:06:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4162

--000000000000bd05ad06538d0e8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 3:50=E2=80=AFAM Paul Barker via lists.yoctoproject.o=
rg <paul=3D
pbarker.dev@lists.yoctoproject.org> wrote:

> On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org
> wrote:
> > From: Tim Orling <tim.orling@konsulko.com>
> >
> > Add scripts/run-vcontainer-tests, the test runner used by the
> > vcontainer test jobs. It sources the vcontainer-tarball SDK,
> > discovers the meta-virtualization pytest suite, and runs a
> > configurable set of suites (vdkr, vpdmn, memres) against the
> > checked-out layers. Suites can be selected per-step so the
> > top-level 'vcontainer-tests' job runs the container engine
> > agnostic tests:
> >
> > - tests/test_container_cross_install.py
> > - tests/test_container_registry_script.py
> > - tests/test_vcontainer_auth_config.py
> > - tests/test_multiarch_oci.py
> > - tests/test_multilayer_oci.py
> >
> > The 'vdkr-tests' and 'vpdmn-tests' jobs run only their respective
> > suites (including memres for each container engine):
> >
> > - tests/test_vdkr.py
> > - tests/test_vdkr_registry.py
> >
> > and
> >
> > - tests/test_vpdmn.py
> >
> > AI-Generated: Claude Cowork Opus 4.7
> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> > ---
> >  config.json                  |  34 ++++++++
> >  scripts/run-vcontainer-tests | 164 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 198 insertions(+)
> >  create mode 100755 scripts/run-vcontainer-tests
> >
> > diff --git a/config.json b/config.json
> > index 7206c41..79a9d10 100644
> > --- a/config.json
> > +++ b/config.json
> > @@ -1890,6 +1890,40 @@
> >                      "install -d
> ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest && install -m 0755
> ${BUILDDIR}/tmp/deploy/sdk/vcontainer-standalone.sh
> ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/
> vcontainer-standalone.sh.new && mv -f
> ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/
> vcontainer-standalone.sh.new
> ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontainer-standalone.sh"
> >                  ]
> >              }
> > +        },
> > +        "vcontainer-tests": {
> > +            "NEEDREPOS" : ["bitbake", "meta-openembedded",
> "meta-virtualization"],
> > +            "ADDLAYER" : [
> > +                "${BUILDDIR}/../meta-openembedded/meta-oe",
> > +                "${BUILDDIR}/../meta-openembedded/meta-python",
> > +                "${BUILDDIR}/../meta-openembedded/meta-networking",
> > +                "${BUILDDIR}/../meta-openembedded/meta-filesystems",
> > +                "${BUILDDIR}/../meta-virtualization"
> > +            ],
> > +            "step1" : {
> > +                "shortname" : "Run vcontainer pytest suite",
> > +                "NOBUILDTOOLS" : 1,
> > +                "NOVCONTAINER" : 1,
> > +                "EXTRACMDS" : [
> > +
> "VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontai=
ner-standalone.sh
> RESULTS_DIR=3D${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests
> vcontainer ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
> > +                ]
> > +            },
> > +            "step2" : {
> > +                "shortname" : "Run vdkr pytest suite",
> > +                "NOBUILDTOOLS" : 1,
> > +                "NOVCONTAINER" : 1,
> > +                "EXTRACMDS" : [
> > +
> "VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontai=
ner-standalone.sh
> RESULTS_DIR=3D${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vdkr
> ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
> > +                ]
> > +            },
> > +            "step3" : {
> > +                "shortname" : "Run vpdmn pytest suite",
> > +                "NOBUILDTOOLS" : 1,
> > +                "NOVCONTAINER" : 1,
> > +                "EXTRACMDS" : [
> > +
> "VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vcontai=
ner-standalone.sh
> RESULTS_DIR=3D${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-vcontainer-tests vpdm=
n
> ${BUILDDIR} ${BUILDDIR}/../meta-virtualization"
> > +                ]
> > +            }
> >          }
> >      },
> >      "repo-defaults" : {
> > diff --git a/scripts/run-vcontainer-tests b/scripts/run-vcontainer-test=
s
> > new file mode 100755
> > index 0000000..1394c7c
> > --- /dev/null
> > +++ b/scripts/run-vcontainer-tests
> > @@ -0,0 +1,164 @@
> > +#!/bin/bash
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Run meta-virtualization pytest test suites against the vcontainer
> > +# standalone SDK (vdkr/vpdmn) that was built in a previous bitbake
> > +# step.
> > +#
> > +# Arguments:
> > +#   $1 - suite name: one of "vcontainer", "vdkr", "vpdmn"
> > +#   $2 - bitbake build directory (${BUILDDIR})
> > +#   $3 - path to the meta-virtualization layer
> > +#
> > +# Optional environment variables:
> > +#   RESULTS_DIR     - directory to copy pytest artefacts (junit xml /
> log) to
> > +#   VCONTAINER_EXTRACT_DIR - where to extract the standalone SDK tarba=
ll
> > +#                     (default: ${builddir}/vcontainer-test-extracted)
> > +#   TEST_OCI_IMAGE  - path to an OCI image directory (enables vdkr/vpd=
mn
> > +#                     import tests)
> > +#   VDKR_ARCH       - target architecture for vdkr/vpdmn tests
> (default: x86_64)
>
> Taking some arguments on the command line and others via environment
> variables is confusing. I wonder if should use getopts to parse arguments=
.
>

This is addressed in v3.


> > +#
> > +# The script is intentionally conservative: any pytest tests that
> cannot run
> > +# in the CI environment (those marked "slow", "network", "boot") are
> skipped
> > +# so that the autobuilder step completes without needing network
> access. Those
> > +# can be re-enabled by exporting META_VIRT_PYTEST_MARKERS before
> invocation.
> > +#
> > +# It is assumed that /dev/kvm is writable by the CI user running the
> tests,
> > +# since the performance is significantly faster with 'memres'.
> > +#
> > +
> > +set -e
> > +set -u
> > +set -o pipefail
> > +set -x
> > +
> > +if [ $# -lt 3 ]; then
> > +    echo "Usage: $0 <suite> <builddir> <meta-virtualization-dir>" >&2
> > +    echo "  suite: vcontainer | vdkr | vpdmn" >&2
> > +    exit 2
> > +fi
> > +
> > +suite=3D"$1"
> > +builddir=3D$(realpath "$2")
> > +metavirtdir=3D$(realpath "$3")
> > +
> > +if [ ! -d "$metavirtdir/tests" ]; then
> > +    echo "ERROR: meta-virtualization tests directory not found at
> $metavirtdir/tests" >&2
> > +    exit 1
> > +fi
> > +
> > +# Locate the vcontainer standalone SDK tarball. Prefer an
> externally-built
> > +# SDK passed via VCONTAINER_SDK (the autobuilder -tests jobs share the
> SDK
> > +# produced by the separate vcontainer-tarball builder), and fall back =
to
> > +# looking in the local build's deploy/sdk directory when running
> stand-alone.
> > +sdk_tarball=3D""
> > +if [ -n "${VCONTAINER_SDK:-}" ]; then
> > +    if [ -f "$VCONTAINER_SDK" ]; then
> > +        sdk_tarball=3D"$VCONTAINER_SDK"
> > +    else
> > +        echo "ERROR: VCONTAINER_SDK=3D$VCONTAINER_SDK is set but not a
> file" >&2
> > +        exit 1
> > +    fi
> > +fi
> > +if [ -z "$sdk_tarball" ]; then
> > +    sdk_tarball=3D"$builddir/tmp/deploy/sdk/vcontainer-standalone.sh"
> > +    if [ ! -f "$sdk_tarball" ]; then
> > +        # Try to find any matching tarball in case naming changed (e.g=
.
> versioned)
> > +        alt=3D$(ls -1 "$builddir"/tmp/deploy/sdk/vcontainer-*.sh
> 2>/dev/null | head -n1 || true)
> > +        if [ -n "$alt" ]; then
> > +            sdk_tarball=3D"$alt"
> > +        else
> > +            echo "ERROR: vcontainer standalone SDK not found." >&2
> > +            echo "       Set VCONTAINER_SDK to an existing SDK
> installer, or" >&2
> > +            echo "       build vcontainer-tarball so
> $builddir/tmp/deploy/sdk/vcontainer-standalone.sh exists." >&2
> > +            exit 1
> > +        fi
> > +    fi
> > +fi
> > +
> >
> +extract_dir=3D"${VCONTAINER_EXTRACT_DIR:-$builddir/vcontainer-test-extra=
cted}"
> > +rm -rf "$extract_dir"
> > +mkdir -p "$(dirname "$extract_dir")"
> > +
> > +# Self-extracting installer (silent, -y agrees to license, -d picks di=
r)
> > +"$sdk_tarball" -d "$extract_dir" -y
>
> Patch 5 in this series added support for setting up the vcontainer
> tarball for a step. I think the commit message in this patch needs to
> explain why we can't use that in the steps that call
> run-vcontainer-tests.
>
> Added information related to this context to v3.


> > +
> > +# Prepare a Python venv so we don't pollute the worker's system
> packages.
> > +python3 -m venv "$builddir/meta-virt-test-venv"
> > +# shellcheck disable=3DSC1091
> > +source "$builddir/meta-virt-test-venv/bin/activate"
>
> Note that this will shadow the venv we use when running test jobs on the
> autobuilder workers. That may be ok, but we need to be careful.
>

This venv is very very specifically for only the meta-virtualization tests.
Other venvs in
autobuilder workers as far as I can tell do not have 'pip' and do not
install 'pytest' nor
the other requirements.


> > +# Avoid warnings by upgrading pip; install pytest/pexpect into the ven=
v
> via pip.
> > +python3 -m pip install --quiet --upgrade pip setuptools wheel
> > +python3 -m pip install --quiet --upgrade pytest pytest-timeout pexpect
>
> Do we want to automatically install the latest versions of these tools,
> via the network, in each build? It's better to pin versions to ensure
> that upgrades are planned rather than automagical.
>
>
In v3, I altered the pip, setuptools, wheel upgrade to
exporting  PIP_DISABLE_PIP_VERSION_CHECK=3D1
to silence the pip upgrade warning.


> Also, should we store this list of dependencies in a requirements.txt
> file somewhere? Perhaps tests/requirements.txt in meta-virtualization.
>

In v3, I changed the installation of pytest, pytest-timeout and pexpect to
be instead from a
meta-virtualization/tests/requirements.txt file (pending).


> > +
> > +# Default marker filter excludes long running / infrastructure
> dependent tests.
> > +marker_filter=3D"${META_VIRT_PYTEST_MARKERS:-not slow and not network =
and
> not boot and not incus and not k3s}"
>
> Would it be better to have a positive marker, e.g. 'autobuilder', to
> mark tests that we do want to run? That would allow us to maintain the
> filtering solely in meta-virtualization instead of needing updates here
> as well when things change.
>
>
Making CI related changes in meta-virtualization is STRONGLY rejected by
the maintainer of meta-virtualization and you will have to convince the
upstream layer maintainer.

This pattern was lifted directly from the meta-virtualization README and
existing examples.


> > +
> > +# Per-suite test file selection. Uses -k/-m for fine-grained filtering
> and
> > +# keeps the CLI small for logging clarity.
> > +case "$suite" in
> > +    vdkr)
> > +        test_files=3D(
> > +            "tests/test_vdkr.py"
> > +            "tests/test_vdkr_registry.py"
> > +        )
> > +        ;;
> > +    vpdmn)
> > +        test_files=3D(
> > +            "tests/test_vpdmn.py"
> > +        )
> > +        ;;
> > +    vcontainer)
> > +        # Broad vcontainer/bbclass/tooling coverage that doesn't
> require the
> > +        # vdkr/vpdmn CLI harness to be running.
> > +        test_files=3D(
> > +            "tests/test_container_cross_install.py"
> > +            "tests/test_container_registry_script.py"
> > +            "tests/test_vcontainer_auth_config.py"
> > +            "tests/test_multiarch_oci.py"
> > +            "tests/test_multilayer_oci.py"
> > +        )
> > +        ;;
> > +    *)
> > +        echo "ERROR: unknown suite '$suite' (expected
> vcontainer|vdkr|vpdmn)" >&2
> > +        exit 2
> > +        ;;
> > +esac
> > +
> > +pytest_args=3D(
> > +    -v
> > +    --tb=3Dshort
> > +    -m "$marker_filter"
> > +    --vdkr-dir "$extract_dir"
> > +    --junitxml=3D"$builddir/pytest-$suite-results.xml"
> > +)
> > +
> > +# Allow tests that consume an OCI image (import/save/load) to find one=
.
> > +if [ -n "${TEST_OCI_IMAGE:-}" ] && [ -d "${TEST_OCI_IMAGE}" ]; then
> > +    pytest_args+=3D(--oci-image "$TEST_OCI_IMAGE")
> > +fi
> > +
> > +# Pass architecture through when set in the environment (default is
> x86_64).
> > +if [ -n "${VDKR_ARCH:-}" ]; then
> > +    pytest_args+=3D(--arch "$VDKR_ARCH")
> > +fi
> > +
> > +cd "$metavirtdir"
> > +# Don't let a single failing test kill the whole step - collect the
> junit
> > +# report, then surface the exit code via the junit file + exit status.
> > +set +e
> > +python3 -m pytest "${pytest_args[@]}" "${test_files[@]}"
> > +rc=3D$?
> > +set -e
> > +
> > +# Copy artefacts to the results dir if one was provided.
> > +if [ -n "${RESULTS_DIR:-}" ]; then
> > +    mkdir -p "$RESULTS_DIR"
> > +    cp -f "$builddir/pytest-$suite-results.xml" "$RESULTS_DIR/"
> 2>/dev/null || true
> > +    if [ -f /tmp/pytest-vcontainer.log ]; then
> > +        cp -f /tmp/pytest-vcontainer.log
> "$RESULTS_DIR/pytest-$suite.log" || true
> > +    fi
> > +fi
> > +
> > +exit $rc
>
> --
> Paul Barker
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4111):
> https://lists.yoctoproject.org/g/yocto-patches/message/4111
> Mute This Topic: https://lists.yoctoproject.org/mt/119603246/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000bd05ad06538d0e8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 2, 2026 at 3:50=
=E2=80=AFAM Paul Barker via <a href=3D"http://lists.yoctoproject.org">lists=
.yoctoproject.org</a> &lt;paul=3D<a href=3D"mailto:pbarker.dev@lists.yoctop=
roject.org">pbarker.dev@lists.yoctoproject.org</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2026-06-01 at 16:18 -=
0700, Tim Orling via <a href=3D"http://lists.yoctoproject.org" rel=3D"noref=
errer" target=3D"_blank">lists.yoctoproject.org</a><br>
wrote:<br>
&gt; From: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" target=
=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; <br>
&gt; Add scripts/run-vcontainer-tests, the test runner used by the<br>
&gt; vcontainer test jobs. It sources the vcontainer-tarball SDK,<br>
&gt; discovers the meta-virtualization pytest suite, and runs a<br>
&gt; configurable set of suites (vdkr, vpdmn, memres) against the<br>
&gt; checked-out layers. Suites can be selected per-step so the<br>
&gt; top-level &#39;vcontainer-tests&#39; job runs the container engine<br>
&gt; agnostic tests:<br>
&gt; <br>
&gt; - tests/test_container_cross_install.py<br>
&gt; - tests/test_container_registry_script.py<br>
&gt; - tests/test_vcontainer_auth_config.py<br>
&gt; - tests/test_multiarch_oci.py<br>
&gt; - tests/test_multilayer_oci.py<br>
&gt; <br>
&gt; The &#39;vdkr-tests&#39; and &#39;vpdmn-tests&#39; jobs run only their=
 respective<br>
&gt; suites (including memres for each container engine):<br>
&gt; <br>
&gt; - tests/test_vdkr.py<br>
&gt; - tests/test_vdkr_registry.py<br>
&gt; <br>
&gt; and<br>
&gt; <br>
&gt; - tests/test_vpdmn.py<br>
&gt; <br>
&gt; AI-Generated: Claude Cowork Opus 4.7<br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.co=
m" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 config.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 34 ++++++++<br>
&gt;=C2=A0 scripts/run-vcontainer-tests | 164 +++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 2 files changed, 198 insertions(+)<br>
&gt;=C2=A0 create mode 100755 scripts/run-vcontainer-tests<br>
&gt; <br>
&gt; diff --git a/config.json b/config.json<br>
&gt; index 7206c41..79a9d10 100644<br>
&gt; --- a/config.json<br>
&gt; +++ b/config.json<br>
&gt; @@ -1890,6 +1890,40 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;install -d ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest &am=
p;&amp; install -m 0755 ${BUILDDIR}/tmp/deploy/sdk/vcontainer-standalone.sh=
 ${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/<a href=3D"http://vcontain=
er-standalone.sh.new" rel=3D"noreferrer" target=3D"_blank">vcontainer-stand=
alone.sh.new</a> &amp;&amp; mv -f ${BASE_SHAREDDIR}/pub/vcontainer-tarball-=
latest/<a href=3D"http://vcontainer-standalone.sh.new" rel=3D"noreferrer" t=
arget=3D"_blank">vcontainer-standalone.sh.new</a> ${BASE_SHAREDDIR}/pub/vco=
ntainer-tarball-latest/vcontainer-standalone.sh&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vcontainer-tests&quot;: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NEEDREPOS&quot; : [&q=
uot;bitbake&quot;, &quot;meta-openembedded&quot;, &quot;meta-virtualization=
&quot;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ADDLAYER&quot; : [<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-openembedded/meta-oe&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-openembedded/meta-python&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-openembedded/meta-networking&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-openembedded/meta-filesystems&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${BUILD=
DIR}/../meta-virtualization&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;step1&quot; : {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;shortna=
me&quot; : &quot;Run vcontainer pytest suite&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NOBUILD=
TOOLS&quot; : 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NOVCONT=
AINER&quot; : 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;EXTRACM=
DS&quot; : [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vco=
ntainer-standalone.sh RESULTS_DIR=3D${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-v=
container-tests vcontainer ${BUILDDIR} ${BUILDDIR}/../meta-virtualization&q=
uot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;step2&quot; : {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;shortna=
me&quot; : &quot;Run vdkr pytest suite&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NOBUILD=
TOOLS&quot; : 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NOVCONT=
AINER&quot; : 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;EXTRACM=
DS&quot; : [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vco=
ntainer-standalone.sh RESULTS_DIR=3D${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-v=
container-tests vdkr ${BUILDDIR} ${BUILDDIR}/../meta-virtualization&quot;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;step3&quot; : {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;shortna=
me&quot; : &quot;Run vpdmn pytest suite&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NOBUILD=
TOOLS&quot; : 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;NOVCONT=
AINER&quot; : 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;EXTRACM=
DS&quot; : [<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;VCONTAINER_SDK=3D${BASE_SHAREDDIR}/pub/vcontainer-tarball-latest/vco=
ntainer-standalone.sh RESULTS_DIR=3D${HELPERRESULTSDIR} ${SCRIPTSDIR}/run-v=
container-tests vpdmn ${BUILDDIR} ${BUILDDIR}/../meta-virtualization&quot;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;repo-defaults&quot; : {<br>
&gt; diff --git a/scripts/run-vcontainer-tests b/scripts/run-vcontainer-tes=
ts<br>
&gt; new file mode 100755<br>
&gt; index 0000000..1394c7c<br>
&gt; --- /dev/null<br>
&gt; +++ b/scripts/run-vcontainer-tests<br>
&gt; @@ -0,0 +1,164 @@<br>
&gt; +#!/bin/bash<br>
&gt; +#<br>
&gt; +# SPDX-License-Identifier: GPL-2.0-only<br>
&gt; +#<br>
&gt; +# Run meta-virtualization pytest test suites against the vcontainer<b=
r>
&gt; +# standalone SDK (vdkr/vpdmn) that was built in a previous bitbake<br=
>
&gt; +# step.<br>
&gt; +#<br>
&gt; +# Arguments:<br>
&gt; +#=C2=A0 =C2=A0$1 - suite name: one of &quot;vcontainer&quot;, &quot;v=
dkr&quot;, &quot;vpdmn&quot;<br>
&gt; +#=C2=A0 =C2=A0$2 - bitbake build directory (${BUILDDIR})<br>
&gt; +#=C2=A0 =C2=A0$3 - path to the meta-virtualization layer<br>
&gt; +#<br>
&gt; +# Optional environment variables:<br>
&gt; +#=C2=A0 =C2=A0RESULTS_DIR=C2=A0 =C2=A0 =C2=A0- directory to copy pyte=
st artefacts (junit xml / log) to<br>
&gt; +#=C2=A0 =C2=A0VCONTAINER_EXTRACT_DIR - where to extract the standalon=
e SDK tarball<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(default: ${builddir}/vcontainer-test-extracted)<br>
&gt; +#=C2=A0 =C2=A0TEST_OCI_IMAGE=C2=A0 - path to an OCI image directory (=
enables vdkr/vpdmn<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0import tests)<br>
&gt; +#=C2=A0 =C2=A0VDKR_ARCH=C2=A0 =C2=A0 =C2=A0 =C2=A0- target architectu=
re for vdkr/vpdmn tests (default: x86_64)<br>
<br>
Taking some arguments on the command line and others via environment<br>
variables is confusing. I wonder if should use getopts to parse arguments.<=
br></blockquote><div><br></div><div>This is addressed in v3.</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +#<br>
&gt; +# The script is intentionally conservative: any pytest tests that can=
not run<br>
&gt; +# in the CI environment (those marked &quot;slow&quot;, &quot;network=
&quot;, &quot;boot&quot;) are skipped<br>
&gt; +# so that the autobuilder step completes without needing network acce=
ss. Those<br>
&gt; +# can be re-enabled by exporting META_VIRT_PYTEST_MARKERS before invo=
cation.<br>
&gt; +#<br>
&gt; +# It is assumed that /dev/kvm is writable by the CI user running the =
tests,<br>
&gt; +# since the performance is significantly faster with &#39;memres&#39;=
.<br>
&gt; +#<br>
&gt; +<br>
&gt; +set -e<br>
&gt; +set -u<br>
&gt; +set -o pipefail<br>
&gt; +set -x<br>
&gt; +<br>
&gt; +if [ $# -lt 3 ]; then<br>
&gt; +=C2=A0 =C2=A0 echo &quot;Usage: $0 &lt;suite&gt; &lt;builddir&gt; &lt=
;meta-virtualization-dir&gt;&quot; &gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 echo &quot;=C2=A0 suite: vcontainer | vdkr | vpdmn&quot=
; &gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 exit 2<br>
&gt; +fi<br>
&gt; +<br>
&gt; +suite=3D&quot;$1&quot;<br>
&gt; +builddir=3D$(realpath &quot;$2&quot;)<br>
&gt; +metavirtdir=3D$(realpath &quot;$3&quot;)<br>
&gt; +<br>
&gt; +if [ ! -d &quot;$metavirtdir/tests&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 echo &quot;ERROR: meta-virtualization tests directory n=
ot found at $metavirtdir/tests&quot; &gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 exit 1<br>
&gt; +fi<br>
&gt; +<br>
&gt; +# Locate the vcontainer standalone SDK tarball. Prefer an externally-=
built<br>
&gt; +# SDK passed via VCONTAINER_SDK (the autobuilder -tests jobs share th=
e SDK<br>
&gt; +# produced by the separate vcontainer-tarball builder), and fall back=
 to<br>
&gt; +# looking in the local build&#39;s deploy/sdk directory when running =
stand-alone.<br>
&gt; +sdk_tarball=3D&quot;&quot;<br>
&gt; +if [ -n &quot;${VCONTAINER_SDK:-}&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 if [ -f &quot;$VCONTAINER_SDK&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sdk_tarball=3D&quot;$VCONTAINER_SDK&quot;=
<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;ERROR: VCONTAINER_SDK=3D$VCONT=
AINER_SDK is set but not a file&quot; &gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +fi<br>
&gt; +if [ -z &quot;$sdk_tarball&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 sdk_tarball=3D&quot;$builddir/tmp/deploy/sdk/vcontainer=
-standalone.sh&quot;<br>
&gt; +=C2=A0 =C2=A0 if [ ! -f &quot;$sdk_tarball&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Try to find any matching tarball in cas=
e naming changed (e.g. versioned)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 alt=3D$(ls -1 &quot;$builddir&quot;/tmp/d=
eploy/sdk/vcontainer-*.sh 2&gt;/dev/null | head -n1 || true)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -n &quot;$alt&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdk_tarball=3D&quot;$alt&qu=
ot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;ERROR: vcontaine=
r standalone SDK not found.&quot; &gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0Set VCONTAINER_SDK to an existing SDK installer, or&quot; &gt;=
&amp;2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0build vcontainer-tarball so $builddir/tmp/deploy/sdk/vcontaine=
r-standalone.sh exists.&quot; &gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +fi<br>
&gt; +<br>
&gt; +extract_dir=3D&quot;${VCONTAINER_EXTRACT_DIR:-$builddir/vcontainer-te=
st-extracted}&quot;<br>
&gt; +rm -rf &quot;$extract_dir&quot;<br>
&gt; +mkdir -p &quot;$(dirname &quot;$extract_dir&quot;)&quot;<br>
&gt; +<br>
&gt; +# Self-extracting installer (silent, -y agrees to license, -d picks d=
ir)<br>
&gt; +&quot;$sdk_tarball&quot; -d &quot;$extract_dir&quot; -y<br>
<br>
Patch 5 in this series added support for setting up the vcontainer<br>
tarball for a step. I think the commit message in this patch needs to<br>
explain why we can&#39;t use that in the steps that call<br>
run-vcontainer-tests.<br>
<br></blockquote><div>Added information related to this context to v3.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +# Prepare a Python venv so we don&#39;t pollute the worker&#39;s syst=
em packages.<br>
&gt; +python3 -m venv &quot;$builddir/meta-virt-test-venv&quot;<br>
&gt; +# shellcheck disable=3DSC1091<br>
&gt; +source &quot;$builddir/meta-virt-test-venv/bin/activate&quot;<br>
<br>
Note that this will shadow the venv we use when running test jobs on the<br=
>
autobuilder workers. That may be ok, but we need to be careful.<br></blockq=
uote><div><br></div><div>This venv is very very specifically for only the m=
eta-virtualization tests. Other venvs in</div><div>autobuilder workers as f=
ar as I can tell do not have &#39;pip&#39; and do not install &#39;pytest&#=
39; nor</div><div>the other requirements.</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt; +# Avoid warnings by upgrading pip; install pytest/pexpect into the ve=
nv via pip.<br>
&gt; +python3 -m pip install --quiet --upgrade pip setuptools wheel<br>
&gt; +python3 -m pip install --quiet --upgrade pytest pytest-timeout pexpec=
t<br>
<br>
Do we want to automatically install the latest versions of these tools,<br>
via the network, in each build? It&#39;s better to pin versions to ensure<b=
r>
that upgrades are planned rather than automagical.<br>
<br></blockquote><div><br></div><div>In v3, I altered the pip, setuptools, =
wheel upgrade to exporting=C2=A0=C2=A0PIP_DISABLE_PIP_VERSION_CHECK=3D1</di=
v><div>to silence the pip upgrade warning.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
Also, should we store this list of dependencies in a requirements.txt<br>
file somewhere? Perhaps tests/requirements.txt in meta-virtualization.<br><=
/blockquote><div><br></div><div>In v3, I changed the installation of pytest=
, pytest-timeout and pexpect to be instead from a</div><div>meta-virtualiza=
tion/tests/requirements.txt file (pending).</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +# Default marker filter excludes long running / infrastructure depend=
ent tests.<br>
&gt; +marker_filter=3D&quot;${META_VIRT_PYTEST_MARKERS:-not slow and not ne=
twork and not boot and not incus and not k3s}&quot;<br>
<br>
Would it be better to have a positive marker, e.g. &#39;autobuilder&#39;, t=
o<br>
mark tests that we do want to run? That would allow us to maintain the<br>
filtering solely in meta-virtualization instead of needing updates here<br>
as well when things change.<br>
<br></blockquote><div><br></div><div>Making=C2=A0CI related changes in meta=
-virtualization is STRONGLY rejected by</div><div>the maintainer of meta-vi=
rtualization and you will have to convince the</div><div>upstream layer mai=
ntainer.</div><div><br></div><div>This pattern was lifted directly from the=
 meta-virtualization README and existing examples.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +# Per-suite test file selection. Uses -k/-m for fine-grained filterin=
g and<br>
&gt; +# keeps the CLI small for logging clarity.<br>
&gt; +case &quot;$suite&quot; in<br>
&gt; +=C2=A0 =C2=A0 vdkr)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_files=3D(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tests/test_vdkr.py&qu=
ot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tests/test_vdkr_regis=
try.py&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
&gt; +=C2=A0 =C2=A0 vpdmn)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_files=3D(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tests/test_vpdmn.py&q=
uot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
&gt; +=C2=A0 =C2=A0 vcontainer)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Broad vcontainer/bbclass/tooling covera=
ge that doesn&#39;t require the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # vdkr/vpdmn CLI harness to be running.<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_files=3D(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tests/test_container_=
cross_install.py&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tests/test_container_=
registry_script.py&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tests/test_vcontainer=
_auth_config.py&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tests/test_multiarch_=
oci.py&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;tests/test_multilayer=
_oci.py&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
&gt; +=C2=A0 =C2=A0 *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;ERROR: unknown suite &#39;$sui=
te&#39; (expected vcontainer|vdkr|vpdmn)&quot; &gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
&gt; +esac<br>
&gt; +<br>
&gt; +pytest_args=3D(<br>
&gt; +=C2=A0 =C2=A0 -v<br>
&gt; +=C2=A0 =C2=A0 --tb=3Dshort<br>
&gt; +=C2=A0 =C2=A0 -m &quot;$marker_filter&quot;<br>
&gt; +=C2=A0 =C2=A0 --vdkr-dir &quot;$extract_dir&quot;<br>
&gt; +=C2=A0 =C2=A0 --junitxml=3D&quot;$builddir/pytest-$suite-results.xml&=
quot;<br>
&gt; +)<br>
&gt; +<br>
&gt; +# Allow tests that consume an OCI image (import/save/load) to find on=
e.<br>
&gt; +if [ -n &quot;${TEST_OCI_IMAGE:-}&quot; ] &amp;&amp; [ -d &quot;${TES=
T_OCI_IMAGE}&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 pytest_args+=3D(--oci-image &quot;$TEST_OCI_IMAGE&quot;=
)<br>
&gt; +fi<br>
&gt; +<br>
&gt; +# Pass architecture through when set in the environment (default is x=
86_64).<br>
&gt; +if [ -n &quot;${VDKR_ARCH:-}&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 pytest_args+=3D(--arch &quot;$VDKR_ARCH&quot;)<br>
&gt; +fi<br>
&gt; +<br>
&gt; +cd &quot;$metavirtdir&quot;<br>
&gt; +# Don&#39;t let a single failing test kill the whole step - collect t=
he junit<br>
&gt; +# report, then surface the exit code via the junit file + exit status=
.<br>
&gt; +set +e<br>
&gt; +python3 -m pytest &quot;${pytest_args[@]}&quot; &quot;${test_files[@]=
}&quot;<br>
&gt; +rc=3D$?<br>
&gt; +set -e<br>
&gt; +<br>
&gt; +# Copy artefacts to the results dir if one was provided.<br>
&gt; +if [ -n &quot;${RESULTS_DIR:-}&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 mkdir -p &quot;$RESULTS_DIR&quot;<br>
&gt; +=C2=A0 =C2=A0 cp -f &quot;$builddir/pytest-$suite-results.xml&quot; &=
quot;$RESULTS_DIR/&quot; 2&gt;/dev/null || true<br>
&gt; +=C2=A0 =C2=A0 if [ -f /tmp/pytest-vcontainer.log ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cp -f /tmp/pytest-vcontainer.log &quot;$R=
ESULTS_DIR/pytest-$suite.log&quot; || true<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +fi<br>
&gt; +<br>
&gt; +exit $rc<br>
<br>
-- <br>
Paul Barker<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4111): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4111" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/4111</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/119603246/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/119603246/924729</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13169857/924729/1023951714/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/10239517=
14/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000bd05ad06538d0e8e--

