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
        /// The URL of the image to extract text from
        /// </summary>
        [JsonProperty("url")]
        public string Url { get; set; }
    }
}
