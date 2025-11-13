Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE819CD98C8
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 18:40:22 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56.1763059216979032979
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 10:40:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PNo0dYSp;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: skandigraun@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso650238f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 10:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763059215; x=1763664015; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ND5Fs+qG+loc7vb10nbYeLr1W8XSjasxyUOho6StlZQ=;
        b=PNo0dYSpkN4cJi626mhdnNqvrm+HRWPFU47qPVmK9pJblPoWCADW9nWtGLA/2C1Rcr
         RGAN0BnT9f0Msm7kaV9avY5FkUOxo4A6bwt0XX6DbSCvnE1EIpdDEnfnHj0o7cVAtGAx
         saZ21uQuuR4TMGBKwdBJ2WbsNMkdOendBzze9X/lp1CqpvSDRoZEA3K/7vqTh7GS9pf+
         F2pgo0a9mkSOGDBqP4JhzX2EU4uqxLZuWcWHxms1qFPoYnBTx+D+uWKFDbO8dsHaWPaO
         7s0TUgBoKZIyGAk7c8qJ3LIHy4hNBw5upiUQOtNtKQ0xCmF+0xisTje/tJy1/DaS1FRU
         Tmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059215; x=1763664015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND5Fs+qG+loc7vb10nbYeLr1W8XSjasxyUOho6StlZQ=;
        b=ax05N6+CikTT0nejr029jzRRpioT77TvfFXP1RN2oTISqIfkQng2jbFHnx97JbP4Lp
         unZUp4TbM3VFoV+/VTROZKpBSSBRgXBJctRgrZHnl3R3qYxjj1OidgGCZEtg99BjbL1h
         /ThNmoey904DZg5m/b4RSdYe4mThqB0c93egmto63T1v8zfEWKsenkrNifrp308jqVNS
         xBcRhAz6uMIixly9r4bQfxWVA7rISRG/yLd3IMVVcPygSwVdpg2dLRm1G2lZ/T31lif6
         Vse9xubRVKbH2ywAyXiC1ZiAWUZ5yInmM3QDBA/jJkzwOBg3DWQeoCzLu9L3Zw/6wGKA
         L2Vw==
X-Gm-Message-State: AOJu0Yzg/9eNRwPSIREeZ+pVUfr9ppwAbopp2SR14vhTzBYon044Ztjp
	RM8P63pQlkBvOfcIPuPCV5Dt9usWqi4HjREkAomqpTWGnUaKdK/itOJC5mmvJNg0
X-Gm-Gg: ASbGncuT8d9C76rTz7mpjDlLd9URk2aBqIfgy88wQI5DfJeoSZSxVa9+9A1a7jN3zea
	OSSPuLlJCZhjmMd+HT0TX9pBXDTORcY1NILXIS1vrMN4AkRHSTecl+TgglAut2RVmTaQMI9Mnms
	C3OJKdS1Rr89A94AiMx0sF9h83d9sKNh/HT7jbv7Xb/M/IymljBXTJ3GFmFW4sFUouQvfRums9/
	tflU2fVCBINdTX50sef9DtGgiGTJzo0xe1R5BOMu5PCQbyNFtgjc8CPy5dvlf1XT6MSkuHP4xNF
	4Gi1f41gusNmepQ+D125Eup9wkAxaRR9z619eFqd9ixeboV2VUTKZsYKub3qrynqfLps4PHB2pT
	sXljRmZK1e92gJnB33rY6+069RpkZ/OtLxBbNIgFsI8JjnyIbozkLc0a4FPUp2WGRRJJ3SNBvmF
	2HkO6omaO/
X-Google-Smtp-Source: AGHT+IFb+xvAA0jg1cgn7BZkK6IE0lZdni3ea5hM6vbJd2tAROYTFKvzcx5zBBR8VnU8Wjn7/AQE8A==
X-Received: by 2002:a05:6000:2087:b0:42b:549a:1a91 with SMTP id ffacd0b85a97d-42b595bc410mr349679f8f.61.1763059215073;
        Thu, 13 Nov 2025 10:40:15 -0800 (PST)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae2dsm5420799f8f.5.2025.11.13.10.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:40:14 -0800 (PST)
Message-ID: <ddda5d51-5a61-4566-866f-58b9e232e26d@gmail.com>
Date: Thu, 13 Nov 2025 19:40:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] tensorflow-lite: package
 headers
To: yocto-patches@lists.yoctoproject.org,
 Martin Jansa <martin.jansa@gmail.com>
References: <20250913173840.3216545-1-skandigraun@gmail.com>
 <CA+chaQeaQqkjO1v+qoo308ZqH17Fk9VLiahPC3dBj_TknckhZQ@mail.gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <CA+chaQeaQqkjO1v+qoo308ZqH17Fk9VLiahPC3dBj_TknckhZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 18:40:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2543

On 11/13/25 18:18, Martin Jansa via lists.yoctoproject.org wrote:
> Why should tensorflow-lite provide header files from flatbuffers,
> cannot it use system headers from flatbuffers recipe? This breaks a
> build for recipes which depend on both tensorflow-lite and flatbuffers
> because of conflicts in RSS as in:
> ERROR: foo-1.0-r0 do_prepare_recipe_sysroot: The file
> /usr/include/flatbuffers/array.h is installed by both tensorflow-lite
> and flatbuffers, aborting
>
> I can send a patch to remove them (I have it locally).

Hmmmm... that was a very long time ago, hard to remember the details... 

If there is a flatbuffers recipe, I guess it would be usable, and most
likely you are right, it would be more appropriate instead of this.
I remember I added this for libamera-apps in meta-rpi - I can test it
tomorrow and ping back, if that would be okay for you.

> On Sat, Sep 13, 2025 at 7:38 PM Gyorgy Sarvari via
> lists.yoctoproject.org <skandigraun=gmail.com@lists.yoctoproject.org>
> wrote:
>> The headers are not packages with tensorflow-lite, making it not easy to
>> compile any applications using them.
>>
>> This patch copies the headers from the source and output folder to
>> the includedir.
>>
>> The patch was derived from the content of a pre-compiled tflite package[1],
>> and from compilation error messages that were returned by rpicam-apps
>> recipe (which uses this recipe as an optional dependency)
>>
>> [1]: https://github.com/prepkg/tensorflow-lite-raspberrypi/releases/tag/2.20.0
>>
>> Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
>> ---
>>  .../tensorflow/tensorflow-lite_2.19.0.bb      | 23 +++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
>> index 14a538a..786507e 100644
>> --- a/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
>> +++ b/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
>> @@ -114,6 +114,29 @@ do_install() {
>>          ${D}${datadir}/label_image
>>
>>
>> +    # install the headers also
>> +    cd ${S}
>> +    for header in `find ./tensorflow/lite -type f -name *.h`; do
>> +        install -D -m 0644 $header ${D}${includedir}/$header
>> +    done
>> +
>> +    for header in `find ./tensorflow/compiler/mlir -type f -name *.h`; do
>> +        install -D -m 0644 $header ${D}${includedir}/$header
>> +    done
>> +
>> +    for header in `find ./tensorflow/core/public -type f -name *.h`; do
>> +        install -D -m 0644 $header ${D}${includedir}/$header
>> +    done
>> +    cd -
>> +
>> +    cd ${WORKDIR}/bazel/output_base/external/flatbuffers/include
>> +    for header in `find ./flatbuffers -type f`; do
>> +        install -D -m 0644 $header ${D}${includedir}/$header
>> +    done
>> +    cd -
>> +
>> +    # header installation done
>> +
>>      #echo "Installing pip package"
>>      install -d ${D}/${PYTHON_SITEPACKAGES_DIR}
>>      ${STAGING_BINDIR_NATIVE}/pip3 install --disable-pip-version-check -v \
>>
>>
>>
>>
>>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2542): https://lists.yoctoproject.org/g/yocto-patches/message/2542
> Mute This Topic: https://lists.yoctoproject.org/mt/115226423/6084445
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14038302/6084445/1344600526/xyzzy [skandigraun@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>


