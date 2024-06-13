# LunaStream API Encoded Track
LunaStream use the different format with Lavalink, Nodelink and FrequenC due to luvit doen't have `readBigInt64BE` function. This document will document the track format, allowing easy decoding and encoding of tracks.

## Table of Contents

- [LunaStream API Encoded Track](#lunastream-api-encoded-track)
  
> [!IMPORTANT]
> This is a beta version of the API.

## Encoded format

The encoded track format is different from Lavalink, aim to have an easy way to decode. It is a string containing the following information:

| Name               | Value type       | Description                      |
| ------------------ | ---------------- | -------------------------------- |
| Version            | Number           | The version of the encoded.      |
| Title              | Base64 (UTF-8)   | The title of the track.          |
| Author             | Base64 (UTF-8)   | The author of the track.         |
| Length             | Number           | The length of the track.         |
| Identifier         | Base64 (UTF-8)   | The identifier of the track.     |
| Is stream          | Boolean (0 or 1) | If the track is a stream.        |
| URI                | Base64 (UTF-8)   | The URI of the track.            |
| Artwork URL        | Boolean (0 or 1) | If the track has an artwork URL. |
| Artwork URL        | Base64 (UTF-8)   | The artwork URL of the track.    |
| ISRC               | Boolean (0 or 1) | If the track has an ISRC.        |
| ISRC               | Base64 (UTF-8)   | The ISRC of the track.           |
| Source name        | Base64 (UTF-8)   | The source name of the track.    |

The fields must strictly follow the order and length, or else LunaStream will not be able to decode the track and will reject the client's request.

> [!NOTE]
> Current supported version for this encoded track is 1. If the version is different, the client MUST reject the track.