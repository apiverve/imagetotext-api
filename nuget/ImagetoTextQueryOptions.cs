using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;

namespace APIVerve.API.ImagetoText
{
    /// <summary>
    /// Query options for the Image to Text API
    /// </summary>
    public class ImagetoTextQueryOptions
    {
        /// <summary>
        /// Upload an image file to extract text from (supported formats: JPG, PNG, GIF, max 5MB)
        /// </summary>
        [JsonProperty("image")]
        public string Image { get; set; }

        /// <summary>
        /// Language of the text, as ISO 639-1 codes; comma-separate several for mixed text (e.g. en,ja). Defaults to en
        /// </summary>
        [JsonProperty("language")]
        public string Language { get; set; }
    }
}
